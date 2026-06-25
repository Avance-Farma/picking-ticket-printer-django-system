import requests
import logging
import os
from django.conf import settings

logger = logging.getLogger(__name__)

# Lê das variáveis de ambiente com fallback para local
EVOLUTION_API_URL = os.getenv("EVOLUTION_API_URL", getattr(settings, "EVOLUTION_API_URL", "http://localhost:8080"))
EVOLUTION_API_KEY = os.getenv("EVOLUTION_API_KEY", getattr(settings, "EVOLUTION_API_KEY", "minha-chave-secreta-123"))

def _get_headers():
    return {
        "apikey": EVOLUTION_API_KEY,
        "Content-Type": "application/json"
    }

def create_instance(instance_name):
    """
    Cria uma nova instância na Evolution API
    """
    url = f"{EVOLUTION_API_URL}/instance/create"
    payload = {
        "instanceName": instance_name,
        "token": instance_name,
        "qrcode": True,
        "groupsIgnore": False
    }
    
    try:
        response = requests.post(url, json=payload, headers=_get_headers())
        response.raise_for_status()
        
        # Após criar, tenta alterar os settings para permitir mensagens de grupo
        settings_url = f"{EVOLUTION_API_URL}/settings/set/{instance_name}"
        settings_payload = {
            "rejectCall": False,
            "groupsIgnore": False,
            "alwaysOnline": True,
            "readMessages": False,
            "syncFullHistory": False
        }
        try:
            requests.post(settings_url, json=settings_payload, headers=_get_headers())
        except Exception as e:
            logger.error(f"Aviso: Não foi possível configurar settings da instância {instance_name}: {e}")
            
        # Configurar Webhook para capturar mensagens e status de conexão
        webhook_url = f"{EVOLUTION_API_URL}/webhook/set/{instance_name}"
        webhook_payload = {
            "enabled": True,
            "url": "http://web:8000/whatsapp/api/webhook/",
            "webhookByEvents": False,
            "events": ["MESSAGES_UPSERT", "CONNECTION_UPDATE"]
        }
        try:
            requests.post(webhook_url, json=webhook_payload, headers=_get_headers())
        except Exception as e:
            logger.error(f"Aviso: Não foi possível configurar o webhook da instância {instance_name}: {e}")
            
        return response.json()
    except requests.RequestException as e:
        error_details = ""
        if hasattr(e, 'response') and e.response is not None:
            error_details = f" - Body: {e.response.text}"
        logger.error(f"Erro ao criar instância {instance_name}: {e}{error_details}")
        return None

def fetch_instances():
    """
    Busca todas as instâncias da Evolution API
    """
    url = f"{EVOLUTION_API_URL}/instance/fetchInstances"
    
    try:
        response = requests.get(url, headers=_get_headers())
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logger.error(f"Erro ao buscar instâncias: {e}")
        return None

def logout_instance(instance_name):
    """
    Desconecta uma instância
    """
    url = f"{EVOLUTION_API_URL}/instance/logout/{instance_name}"
    
    try:
        response = requests.delete(url, headers=_get_headers())
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logger.error(f"Erro ao deslogar instância {instance_name}: {e}")
        return None

def delete_instance(instance_name):
    """
    Deleta uma instância
    """
    url = f"{EVOLUTION_API_URL}/instance/delete/{instance_name}"
    
    try:
        response = requests.delete(url, headers=_get_headers())
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logger.error(f"Erro ao deletar instância {instance_name}: {e}")
        return None

def send_text_message(instance_name, phone_number, text):
    """
    Envia uma mensagem de texto (apenas para referência futura, pois o foco atual é rastreio)
    """
    url = f"{EVOLUTION_API_URL}/message/sendText/{instance_name}"
    payload = {
        "number": phone_number,
        "text": text
    }
    
    try:
        response = requests.post(url, json=payload, headers=_get_headers())
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logger.error(f"Erro ao enviar mensagem para {phone_number}: {e}")
        return None


def _extract_pic_hash(pic_url):
    """Extrai o hash único da foto de perfil do WhatsApp (nome do arquivo)."""
    if not pic_url:
        return None
    try:
        # URL format: .../725032936_1336384641157012_178287339543254857_n.jpg?params...
        return pic_url.split("/")[-1].split("?")[0]
    except Exception:
        return None


def _fetch_all_contacts_cached(instance_name):
    """
    Busca todos os contatos da instância na Evolution API.
    Cache simples em memória para evitar chamadas repetidas no mesmo request.
    """
    cache_key = f"_contacts_cache_{instance_name}"
    if not hasattr(_fetch_all_contacts_cached, cache_key):
        url = f"{EVOLUTION_API_URL}/chat/findContacts/{instance_name}"
        headers = _get_headers()
        resp = requests.post(url, json={"where": {}}, headers=headers)
        if resp.status_code == 200:
            setattr(_fetch_all_contacts_cached, cache_key, resp.json())
        else:
            setattr(_fetch_all_contacts_cached, cache_key, [])
    return getattr(_fetch_all_contacts_cached, cache_key)


def resolve_lid_to_phone(instance_name, lid_jid):
    """
    Tenta resolver um @lid para o número de telefone real consultando
    a lista de contatos da Evolution API.
    
    Estratégia 1: cruza pela foto de perfil (profilePictureUrl).
    Estratégia 2: cruza pelo pushName (fallback).
    
    Retorna dict {'phone': '+5524992001216', 'push_name': 'Nate'} ou None.
    """
    try:
        url = f"{EVOLUTION_API_URL}/chat/findContacts/{instance_name}"
        headers = _get_headers()
        
        # 1. Busca o contato @lid para pegar a profilePictureUrl
        resp_lid = requests.post(url, json={"where": {"id": lid_jid}}, headers=headers)
        if resp_lid.status_code != 200:
            return None
        
        lid_data = resp_lid.json()
        if not lid_data:
            return None
        
        lid_pic_hash = _extract_pic_hash(lid_data[0].get("profilePictureUrl"))
        lid_push_name = lid_data[0].get("pushName")
        
        all_contacts = _fetch_all_contacts_cached(instance_name)
        phone_contacts = [c for c in all_contacts if c.get("id", "").endswith("@s.whatsapp.net")]
        
        # 2. Tenta cruzar pela foto de perfil (mais confiável)
        if lid_pic_hash:
            for contact in phone_contacts:
                contact_pic_hash = _extract_pic_hash(contact.get("profilePictureUrl"))
                if contact_pic_hash and contact_pic_hash == lid_pic_hash:
                    phone = contact["id"].split("@")[0]
                    return {
                        "phone": f"+{phone}" if not phone.startswith("+") else phone,
                        "push_name": contact.get("pushName") or lid_push_name,
                    }
        
        # 3. Fallback: tenta cruzar pelo pushName
        if lid_push_name:
            for contact in phone_contacts:
                if contact.get("pushName") == lid_push_name:
                    phone = contact["id"].split("@")[0]
                    return {
                        "phone": f"+{phone}" if not phone.startswith("+") else phone,
                        "push_name": lid_push_name,
                    }
        
        return None
    except Exception as e:
        logger.error(f"Erro ao resolver LID {lid_jid}: {e}")
        return None


