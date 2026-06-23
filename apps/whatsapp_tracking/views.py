from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import WhatsAppInstance, WhatsAppContact, WhatsAppMessage
from . import services

@login_required
def dashboard_view(request):
    """
    Lista de contatos e últimas mensagens
    """
    contacts = WhatsAppContact.objects.prefetch_related('messages').all()
    # Pega a última mensagem de cada contato para exibir na lista
    contact_list = []
    for contact in contacts:
        last_message = contact.messages.first()
        contact_list.append({
            'contact': contact,
            'last_message': last_message
        })
    
    # Ordena pelos contatos com mensagens mais recentes
    contact_list.sort(key=lambda x: x['last_message'].timestamp if x['last_message'] else contact.updated_at, reverse=True)

    context = {
        'contacts': contact_list,
        'page_title': 'Rastreio de WhatsApp'
    }
    return render(request, 'whatsapp_tracking/dashboard.html', context)

@login_required
def settings_view(request):
    """
    Gerenciamento de Instâncias (Vendedores) e QR Codes
    """
    if request.method == "POST":
        action = request.POST.get("action")
        instance_name = request.POST.get("instance_name")

        if action == "create" and instance_name:
            # Chama a Evolution API
            resp = services.create_instance(instance_name)
            if resp:
                instance, _ = WhatsAppInstance.objects.get_or_create(name=instance_name)
                
                # A Evolution API v2 retorna o qrcode no dicionário resp
                qr_code = resp.get("qrcode", {}).get("base64")
                if qr_code:
                    instance.qr_code_base64 = qr_code
                    instance.connection_status = WhatsAppInstance.ConnectionStatus.CONNECTING
                    instance.save()
                    
                messages.success(request, f"Instância {instance_name} criada com sucesso. Leia o QR Code.")
            else:
                messages.error(request, "Falha ao comunicar com a Evolution API.")
        
        elif action == "delete" and instance_name:
            resp = services.delete_instance(instance_name)
            if resp:
                WhatsAppInstance.objects.filter(name=instance_name).delete()
                messages.success(request, f"Instância deletada.")
            else:
                messages.error(request, "Falha ao deletar na Evolution API.")
        
        elif action == "logout" and instance_name:
            resp = services.logout_instance(instance_name)
            if resp:
                messages.success(request, "Comando de logout enviado.")
            else:
                messages.error(request, "Falha ao deslogar na Evolution API.")

        return redirect("whatsapp_tracking:settings")

    instances = WhatsAppInstance.objects.all()
    
    context = {
        'instances': instances,
        'page_title': 'Configurações do WhatsApp'
    }
    return render(request, 'whatsapp_tracking/settings.html', context)

