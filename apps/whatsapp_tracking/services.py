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
        "qrcode": True
    }
    
    try:
        response = requests.post(url, json=payload, headers=_get_headers())
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logger.error(f"Erro ao criar instância {instance_name}: {e}")
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
