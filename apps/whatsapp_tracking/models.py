from django.db import models
from django.utils import timezone

class Supervisor(models.Model):
    name = models.CharField(max_length=100, unique=True, help_text="Nome do supervisor")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Supervisor"
        verbose_name_plural = "Supervisores"
        ordering = ["name"]


class WhatsAppInstance(models.Model):
    class ConnectionStatus(models.TextChoices):
        OPEN = "open", "Conectado"
        CONNECTING = "connecting", "Conectando"
        CLOSE = "close", "Desconectado"

    supervisor = models.ForeignKey(Supervisor, on_delete=models.SET_NULL, null=True, blank=True, related_name="instances", help_text="Supervisor responsável por este vendedor")
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


class ContactTag(models.Model):
    name = models.CharField(max_length=50, unique=True, help_text="Ex: 'VIP', 'Black Friday', 'B2B'")
    color = models.CharField(max_length=7, default="#3B82F6", help_text="Cor em HEX (ex: #3B82F6)")
    
    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Tag de Contato"
        verbose_name_plural = "Tags de Contatos"
        ordering = ["name"]


class WhatsAppContact(models.Model):
    remote_jid = models.CharField(max_length=100, unique=True, help_text="ID único do WhatsApp (ex: 5521999999999@s.whatsapp.net)")
    push_name = models.CharField(max_length=255, blank=True, null=True, help_text="Nome definido pelo usuário no WhatsApp")
    phone_number = models.CharField(max_length=50, blank=True, null=True, help_text="Número de telefone limpo (só dígitos)")
    profile_picture_url = models.URLField(max_length=1024, blank=True, null=True)
    tags = models.ManyToManyField(ContactTag, blank=True, related_name="contacts")
    
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


class WhatsAppCampaign(models.Model):
    class CampaignStatus(models.TextChoices):
        DRAFT = "draft", "Rascunho"
        PROCESSING = "processing", "Processando (Em Envio)"
        COMPLETED = "completed", "Concluída"
        PAUSED = "paused", "Pausada"

    name = models.CharField(max_length=150, help_text="Nome interno da campanha")
    instance = models.ForeignKey(WhatsAppInstance, on_delete=models.CASCADE, related_name="campaigns", help_text="Instância que fará os disparos")
    message_template = models.TextField(help_text="Mensagem a ser enviada. Você pode usar {nome} para inserir o nome do lead dinamicamente.")
    status = models.CharField(max_length=20, choices=CampaignStatus.choices, default=CampaignStatus.DRAFT)
    
    csv_file = models.FileField(upload_to="campaigns_csv/", blank=True, null=True, help_text="Upload opcional de CSV (Apenas 1 coluna contendo os números de telefone).")
    target_tags = models.ManyToManyField(ContactTag, blank=True, help_text="Filtrar alvos automaticamente pelas Tags selecionadas.")
    
    scheduled_at = models.DateTimeField(blank=True, null=True, help_text="Deixe em branco para disparar assim que o status for alterado para Processando.")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Criado em")
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Campanha"
        verbose_name_plural = "Campanhas em Massa"
        ordering = ["-created_at"]


class WhatsAppCampaignTarget(models.Model):
    class TargetStatus(models.TextChoices):
        PENDING = "pending", "Pendente"
        SENT = "sent", "Enviada"
        FAILED = "failed", "Falhou"

    campaign = models.ForeignKey(WhatsAppCampaign, on_delete=models.CASCADE, related_name="targets")
    contact = models.ForeignKey(WhatsAppContact, on_delete=models.CASCADE, related_name="campaign_targets")
    status = models.CharField(max_length=20, choices=TargetStatus.choices, default=TargetStatus.PENDING)
    error_message = models.TextField(blank=True, null=True, help_text="Motivo em caso de falha.")
    
    scheduled_for = models.DateTimeField(blank=True, null=True, help_text="Horário em que o celery agendou/executou este disparo")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.campaign.name} -> {self.contact.phone_number} ({self.get_status_display()})"

    class Meta:
        verbose_name = "Alvo da Campanha"
        verbose_name_plural = "Alvos da Campanha"
        ordering = ["-created_at"]
        unique_together = ("campaign", "contact")

