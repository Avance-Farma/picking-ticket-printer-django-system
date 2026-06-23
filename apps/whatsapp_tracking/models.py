from django.db import models
from django.utils import timezone

class WhatsAppInstance(models.Model):
    class ConnectionStatus(models.TextChoices):
        OPEN = "open", "Conectado"
        CONNECTING = "connecting", "Conectando"
        CLOSE = "close", "Desconectado"

    name = models.CharField(max_length=100, unique=True, help_text="Nome do vendedor/instância (ex: joao-vendedor)")
    connection_status = models.CharField(
        max_length=20,
        choices=ConnectionStatus.choices,
        default=ConnectionStatus.CLOSE
    )
    qr_code_base64 = models.TextField(blank=True, null=True, help_text="Último QR Code gerado para conexão")
    owner_number = models.CharField(max_length=20, blank=True, null=True, help_text="Número de telefone do dono da instância")
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.name} ({self.get_connection_status_display()})"

    class Meta:
        verbose_name = "Instância WhatsApp"
        verbose_name_plural = "Instâncias WhatsApp"
        ordering = ["-created_at"]


class WhatsAppContact(models.Model):
    remote_jid = models.CharField(max_length=100, unique=True, help_text="ID único do WhatsApp (ex: 5521999999999@s.whatsapp.net)")
    push_name = models.CharField(max_length=255, blank=True, null=True, help_text="Nome definido pelo usuário no WhatsApp")
    phone_number = models.CharField(max_length=50, blank=True, null=True, help_text="Número de telefone limpo (só dígitos)")
    profile_picture_url = models.URLField(max_length=1024, blank=True, null=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.push_name or 'Desconhecido'} ({self.phone_number})"

    class Meta:
        verbose_name = "Contato WhatsApp"
        verbose_name_plural = "Contatos WhatsApp"
        ordering = ["-updated_at"]


class WhatsAppMessage(models.Model):
    message_id = models.CharField(max_length=255, unique=True, help_text="ID da mensagem na API do WhatsApp")
    instance = models.ForeignKey(WhatsAppInstance, on_delete=models.CASCADE, related_name="messages")
    contact = models.ForeignKey(WhatsAppContact, on_delete=models.CASCADE, related_name="messages")
    
    from_me = models.BooleanField(default=False, help_text="True se a mensagem foi enviada pelo vendedor")
    message_type = models.CharField(max_length=50, default="conversation", help_text="conversation, image, audio, etc")
    content = models.TextField(blank=True, null=True, help_text="Conteúdo em texto da mensagem")
    
    timestamp = models.DateTimeField(help_text="Data e hora exata em que a mensagem foi enviada/recebida")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        direction = "Env ->" if self.from_me else "Rec <-"
        return f"{direction} {self.contact.phone_number}: {self.content[:30]}..."

    class Meta:
        verbose_name = "Mensagem WhatsApp"
        verbose_name_plural = "Mensagens WhatsApp"
        ordering = ["-timestamp"]

