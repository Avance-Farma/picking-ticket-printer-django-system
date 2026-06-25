import json
import logging
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.dateparse import parse_datetime
from datetime import datetime
from django.utils.timezone import make_aware

from .models import WhatsAppInstance, WhatsAppContact, WhatsAppMessage

logger = logging.getLogger(__name__)

@csrf_exempt
def webhook_view(request, event_type=None):
    """
    Webhook endpoint para receber eventos da Evolution API.
    A Evolution API envia POST com JSON para este endpoint.
    """
    if request.method != "POST":
        return JsonResponse({"error": "Method not allowed"}, status=405)

    try:
        data = json.loads(request.body)
    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON"}, status=400)

    event = data.get("event")
    instance_name = data.get("instance")

    if not event or not instance_name:
        return JsonResponse({"error": "Missing event or instance"}, status=400)

    print(f"WhatsApp Webhook [{event}] from {instance_name}", flush=True)
    print(f"Payload do webhook: {json.dumps(data, ensure_ascii=False)}", flush=True)

    if event == "connection.update":
        _handle_connection_update(instance_name, data.get("data", {}))
    elif event == "qrcode.updated":
        _handle_qrcode_update(instance_name, data.get("data", {}))
    elif event == "messages.upsert":
        _handle_messages_upsert(instance_name, data.get("data", {}))

    return JsonResponse({"status": "ok"})

def _handle_connection_update(instance_name, data):
    state = data.get("state")
    status_reason = data.get("statusReason")
    qr = data.get("qr")

    instance, _ = WhatsAppInstance.objects.get_or_create(name=instance_name)

    if state == "open":
        instance.connection_status = WhatsAppInstance.ConnectionStatus.OPEN
        instance.qr_code_base64 = None
    elif state == "connecting":
        instance.connection_status = WhatsAppInstance.ConnectionStatus.CONNECTING
        if qr:
            instance.qr_code_base64 = qr
    elif state == "close":
        instance.connection_status = WhatsAppInstance.ConnectionStatus.CLOSE
        if status_reason == 401: # Logged out
            instance.qr_code_base64 = None
    
    instance.save()
    logger.info(f"Instance {instance_name} state updated to {state}")

def _handle_qrcode_update(instance_name, data):
    # data costuma ser {"qrcode": {"base64": "..."}}
    qr_data = data.get("qrcode", {})
    base64_qr = qr_data.get("base64")
    if base64_qr:
        instance, _ = WhatsAppInstance.objects.get_or_create(name=instance_name)
        instance.qr_code_base64 = base64_qr
        instance.connection_status = WhatsAppInstance.ConnectionStatus.CONNECTING
        instance.save()
        logger.info(f"Instance {instance_name} QR code updated via webhook")

def _handle_messages_upsert(instance_name, data):
    message_info = data.get("message", {})
    key = data.get("key", {})
    push_name = data.get("pushName")
    message_timestamp = data.get("messageTimestamp")
    sender_jid = data.get("sender")  # JID do dono da instância (vendedor)

    remote_jid = key.get("remoteJid")
    from_me = key.get("fromMe", False)
    message_id = key.get("id")

    if not remote_jid or not message_id:
        return

    # Evita processar mensagens de status/stories do whatsapp
    if remote_jid == "status@broadcast":
        return

    if remote_jid.endswith("@g.us"):
        # Conforme solicitado, ignorar mensagens de grupos completamente
        return

    # Se foi no privado, o lead é a própria pessoa do remote_jid (mesmo se from_me=True, pois remote_jid é o destinatário)
    lead_jid = remote_jid

    # Se o lead_jid é o próprio vendedor (sender), ignoramos
    if sender_jid and lead_jid == sender_jid:
        return

    # Apenas captar o lead DEPOIS que ele responder (from_me=False).
    # Se for uma mensagem enviada pelo vendedor e o contato ainda não existe, ignoramos.
    if from_me and not WhatsAppContact.objects.filter(remote_jid=lead_jid).exists():
        return

    # Extrai o número de telefone do JID do Lead
    # Em ambientes Multi-Device, o jid pode vir como 5524992001216:2@s.whatsapp.net
    # O split(":") garante que removemos o ID do dispositivo (ex: ":2")
    extracted_id = lead_jid.split("@")[0].split(":")[0]
    
    # Se for um usuário individual com número real, formata com + (ex: +5524992001216)
    if lead_jid.endswith("@s.whatsapp.net"):
        if not extracted_id.startswith("+"):
            phone_number = f"+{extracted_id}"
        else:
            phone_number = extracted_id
    elif lead_jid.endswith("@lid"):
        # Tenta resolver o @lid para o número real via Evolution API
        from . import services
        resolved = services.resolve_lid_to_phone(instance_name, lead_jid)
        if resolved:
            phone_number = resolved["phone"]
            # Removemos a captura do push_name do resolver para garantir que
            # usaremos apenas o nome real do perfil do WhatsApp vindo do webhook
            print(f"LID {lead_jid} resolvido para {phone_number}", flush=True)
        else:
            phone_number = extracted_id
            print(f"LID {lead_jid} NAO resolvido, mantendo ID: {phone_number}", flush=True)
    else:
        phone_number = extracted_id

    # Garante a instância
    instance, _ = WhatsAppInstance.objects.get_or_create(name=instance_name)

    # Garante o contato
    contact, _ = WhatsAppContact.objects.get_or_create(
        remote_jid=lead_jid,
        defaults={"phone_number": phone_number}
    )
    
    # Se o contato já existia com LID e agora conseguimos resolver, atualiza
    if contact.phone_number != phone_number and phone_number.startswith("+"):
        contact.phone_number = phone_number
        contact.save(update_fields=["phone_number", "updated_at"])
    
    # Atualiza push_name APENAS se a mensagem veio do lead (from_me=False).
    # Se from_me=True, o pushName que vem no webhook é o do próprio vendedor, então ignoramos.
    # O webhook de recebimento (from_me=False) sempre traz o nome real configurado pelo usuário no WhatsApp.
    if not from_me and push_name and contact.push_name != push_name:
        contact.push_name = push_name
        contact.save(update_fields=["push_name", "updated_at"])

    # Extrai conteúdo (texto) dependendo de como a mensagem vem
    content = ""
    message_type = "unknown"
    if "conversation" in message_info:
        content = message_info["conversation"]
        message_type = "text"
    elif "extendedTextMessage" in message_info:
        content = message_info["extendedTextMessage"].get("text", "")
        message_type = "text"
    elif "imageMessage" in message_info:
        content = message_info["imageMessage"].get("caption", "[Imagem]")
        message_type = "image"
    elif "audioMessage" in message_info:
        content = "[Áudio]"
        message_type = "audio"
    elif "documentMessage" in message_info:
        content = f"[Documento: {message_info['documentMessage'].get('fileName', '')}]"
        message_type = "document"

    # Converte timestamp UNIX
    if message_timestamp:
        try:
            dt = datetime.fromtimestamp(int(message_timestamp))
            timestamp = make_aware(dt)
        except Exception:
            timestamp = make_aware(datetime.now())
    else:
        timestamp = make_aware(datetime.now())

    # Salva a mensagem
    WhatsAppMessage.objects.get_or_create(
        message_id=message_id,
        defaults={
            "instance": instance,
            "contact": contact,
            "from_me": from_me,
            "message_type": message_type,
            "content": content,
            "timestamp": timestamp,
        }
    )

def preview_contacts_by_tags(request):
    if not request.user.is_authenticated or not request.user.is_staff:
        return JsonResponse({'error': 'Unauthorized'}, status=403)
    
    tag_ids = request.GET.get('tags', '')
    if not tag_ids:
        return JsonResponse({'contacts': []})
        
    tag_id_list = [t for t in tag_ids.split(',') if t.isdigit()]
    contacts = WhatsAppContact.objects.filter(tags__in=tag_id_list).distinct()
    
    data = [{'id': c.id, 'name': c.push_name or c.phone_number, 'phone': c.phone_number} for c in contacts]
    return JsonResponse({'contacts': data})

import csv
from io import StringIO
from django.views.decorators.http import require_POST

@require_POST
def preview_csv(request):
    if not request.user.is_authenticated or not request.user.is_staff:
        return JsonResponse({'error': 'Unauthorized'}, status=403)
        
    csv_file = request.FILES.get('csv_file')
    if not csv_file:
        return JsonResponse({'error': 'Nenhum arquivo enviado.'}, status=400)
        
    try:
        csv_content = csv_file.read().decode('utf-8')
        reader = csv.reader(StringIO(csv_content))
        data = []
        processed_phones = set()
        
        for row in reader:
            if row and row[0]:
                phone = ''.join(filter(str.isdigit, row[0]))
                if phone and phone not in processed_phones:
                    contact, _ = WhatsAppContact.objects.get_or_create(
                        remote_jid=f"{phone}@s.whatsapp.net",
                        defaults={"phone_number": phone, "push_name": "Lead da Campanha"}
                    )
                    data.append({'id': contact.id, 'name': contact.push_name or contact.phone_number, 'phone': contact.phone_number})
                    processed_phones.add(phone)
                    
        return JsonResponse({'contacts': data})
    except Exception as e:
        return JsonResponse({'error': f"Erro ao processar arquivo: {str(e)}"}, status=400)
