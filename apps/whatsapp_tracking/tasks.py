import logging
import random
from celery import shared_task
from django.utils import timezone
from .models import WhatsAppCampaign, WhatsAppCampaignTarget

logger = logging.getLogger(__name__)

@shared_task
def process_campaign(campaign_id):
    """
    Agenda o envio das mensagens de uma campanha.
    """
    try:
        campaign = WhatsAppCampaign.objects.get(id=campaign_id)
    except WhatsAppCampaign.DoesNotExist:
        return

    if campaign.status != WhatsAppCampaign.CampaignStatus.PROCESSING:
        return

    targets = campaign.targets.filter(status=WhatsAppCampaignTarget.TargetStatus.PENDING)
    
    # Delay base (começa agora)
    delay_seconds = 0
    
    for target in targets:
        # Espaçamento longo e aleatório (20 a 45 segundos) para máxima segurança anti-banimento
        delay_seconds += random.randint(20, 45)
        
        # Agenda o disparo individual
        send_campaign_message.apply_async(args=[target.id], countdown=delay_seconds)
        
        # Atualiza a previsão no banco
        target.scheduled_for = timezone.now() + timezone.timedelta(seconds=delay_seconds)
        target.save(update_fields=['scheduled_for'])
        
    # Agendar a checagem de conclusão
    check_campaign_completion.apply_async(args=[campaign_id], countdown=delay_seconds + 30)


@shared_task
def send_campaign_message(target_id):
    """
    Realiza o envio de fato usando a Evolution API.
    """
    try:
        target = WhatsAppCampaignTarget.objects.get(id=target_id)
        campaign = target.campaign
    except WhatsAppCampaignTarget.DoesNotExist:
        return
        
    if campaign.status != WhatsAppCampaign.CampaignStatus.PROCESSING:
        return

    # Substituição de variáveis
    message = campaign.message_template.replace("{nome}", target.contact.push_name or "")
    
    # Send via Evolution API
    import requests
    from .services import EVOLUTION_API_URL, _get_headers
    
    url = f"{EVOLUTION_API_URL}/message/sendText/{campaign.instance.name}"
    print(f"DEBUG: Trying to send message to URL: {url}")
    import re
    clean_number = re.sub(r'\D', '', target.contact.phone_number) if target.contact.phone_number else target.contact.remote_jid.replace('@s.whatsapp.net', '')
    
    payload = {
        "number": clean_number,
        "options": {
            "delay": random.randint(1200, 3000), # Digitando por 1.2s a 3.0s
            "presence": "composing"
        },
        "textMessage": {"text": message}
    }
    
    try:
        response = requests.post(url, json=payload, headers=_get_headers())
        response.raise_for_status()
        
        target.status = WhatsAppCampaignTarget.TargetStatus.SENT
        target.save(update_fields=['status'])
    except Exception as e:
        target.status = WhatsAppCampaignTarget.TargetStatus.FAILED
        error_details = ""
        if hasattr(e, 'response') and e.response is not None:
            error_details = f" - Body: {e.response.text}"
        target.error_message = str(e) + error_details
        target.save(update_fields=['status', 'error_message'])


@shared_task
def check_campaign_completion(campaign_id):
    try:
        campaign = WhatsAppCampaign.objects.get(id=campaign_id)
    except WhatsAppCampaign.DoesNotExist:
        return
        
    pending = campaign.targets.filter(status=WhatsAppCampaignTarget.TargetStatus.PENDING).count()
    if pending == 0 and campaign.status == WhatsAppCampaign.CampaignStatus.PROCESSING:
        campaign.status = WhatsAppCampaign.CampaignStatus.COMPLETED
        campaign.save(update_fields=['status'])
