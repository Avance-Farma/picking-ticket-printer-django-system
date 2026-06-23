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
def webhook_view(request):
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

    logger.info(f"WhatsApp Webhook [{event}] from {instance_name}")

    if event == "connection.update":
        _handle_connection_update(instance_name, data.get("data", {}))
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

def _handle_messages_upsert(instance_name, data):
    message_info = data.get("message", {})
    key = data.get("key", {})
    push_name = data.get("pushName")
    message_timestamp = data.get("messageTimestamp")

    remote_jid = key.get("remoteJid")
    from_me = key.get("fromMe", False)
    message_id = key.get("id")

    if not remote_jid or not message_id:
        return

    # Evita processar mensagens de status/stories do whatsapp
    if remote_jid == "status@broadcast":
        return

    # Extrai o número de telefone do JID
    phone_number = remote_jid.split("@")[0]

    # Garante a instância
    instance, _ = WhatsAppInstance.objects.get_or_create(name=instance_name)

    # Garante o contato
    contact, _ = WhatsAppContact.objects.get_or_create(
        remote_jid=remote_jid,
        defaults={"phone_number": phone_number}
    )
    # Atualiza push_name se recebido e o contato ainda não tem ou mudou
    if push_name and contact.push_name != push_name:
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
