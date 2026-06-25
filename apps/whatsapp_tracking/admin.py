from django.contrib import admin
from django import forms
from django.utils.html import format_html
from django.utils.safestring import mark_safe
from django.urls import reverse, path
from django.shortcuts import render
from unfold.admin import ModelAdmin, TabularInline
from .models import WhatsAppInstance, WhatsAppContact, WhatsAppMessage, ContactTag, WhatsAppCampaign, WhatsAppCampaignTarget, Supervisor
from django.contrib import messages
from apps.customers.models import Customer
from . import services
import urllib.parse

class IsCustomerFilter(admin.SimpleListFilter):
    title = 'É Cliente?'
    parameter_name = 'is_customer'

    def lookups(self, request, model_admin):
        return (
            ('yes', 'Sim'),
            ('no', 'Não (Leads)'),
        )

    def queryset(self, request, queryset):
        customer_phones = Customer.objects.exclude(phone__isnull=True).exclude(phone='').values_list('phone', flat=True)
        if self.value() == 'yes':
            return queryset.filter(phone_number__in=customer_phones)
        if self.value() == 'no':
            return queryset.exclude(phone_number__in=customer_phones)
        return queryset

@admin.register(Supervisor)
class SupervisorAdmin(ModelAdmin):
    list_display = ("name", "created_at")
    search_fields = ("name",)

@admin.register(WhatsAppInstance)
class WhatsAppInstanceAdmin(ModelAdmin):
    list_display = ("name", "supervisor", "connection_status", "owner_number", "updated_at", "action_logout")
    list_filter = ("connection_status", "supervisor")
    search_fields = ("name", "owner_number", "supervisor__name")
    readonly_fields = ("connection_status", "owner_number", "qr_code_display", "created_at", "updated_at", "qr_code_base64")
    
    fieldsets = (
        ("Configuração", {"fields": ("name", "supervisor", "connection_status")}),
        ("Dados", {"fields": ("owner_number", "created_at", "updated_at")}),
        ("QR Code", {"fields": ("qr_code_display",)}),
    )

    def qr_code_display(self, obj):
        if not obj or not obj.pk:
            return mark_safe(
                '<div class="p-4 mb-4 text-sm text-blue-800 rounded-lg bg-blue-50 dark:bg-gray-800 dark:text-blue-400 border border-blue-200 dark:border-blue-800" role="alert">'
                '<span class="font-medium">Atenção!</span> Para gerar o QR Code de conexão, primeiro preencha o <b>Nome</b> da instância acima e clique no botão <b>Salvar e continuar editando</b> no fim da página.'
                '</div>'
            )
            
        html = ""
        if obj.connection_status == WhatsAppInstance.ConnectionStatus.CONNECTING:
            html += """
            <div style="margin-bottom: 15px; padding: 12px; background-color: #fffbeb; color: #b45309; border: 1px solid #fde68a; border-radius: 6px; display: inline-block;">
                <div style="display: flex; align-items: center; gap: 10px;">
                    <svg class="animate-spin" style="width: 20px; height: 20px;" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <div>
                        <strong style="display: block; font-size: 14px;">Aguardando Sincronização...</strong>
                        <span style="font-size: 12px; opacity: 0.8;">Esta página irá recarregar automaticamente.</span>
                    </div>
                </div>
            </div>
            <script>setTimeout(function(){ window.location.reload(); }, 5000);</script>
            <br/>
            """
            
        if obj.qr_code_base64 and obj.connection_status != WhatsAppInstance.ConnectionStatus.OPEN:
            html += f'<img src="{obj.qr_code_base64}" style="width: 250px; height: 250px; border-radius: 8px; border: 1px solid #e2e8f0;" />'
            return mark_safe(html)
            
        if obj.connection_status == WhatsAppInstance.ConnectionStatus.OPEN:
            return mark_safe('<span style="color: green; font-weight: bold;">Instância Conectada com Sucesso!</span>')
            
        if html:
            return mark_safe(html)
            
        return "Nenhum QR Code gerado ainda. Tente salvar ou atualizar a página."
    qr_code_display.short_description = "QR Code para Leitura"

    def save_model(self, request, obj, form, change):
        if not change:  # Criando
            resp = services.create_instance(obj.name)
            if resp:
                qr_code = resp.get("qrcode", {}).get("base64")
                if qr_code:
                    obj.qr_code_base64 = qr_code
                    obj.connection_status = WhatsAppInstance.ConnectionStatus.CONNECTING
        super().save_model(request, obj, form, change)

    def delete_model(self, request, obj):
        services.delete_instance(obj.name)
        super().delete_model(request, obj)

    def action_logout(self, obj):
        if obj.connection_status == WhatsAppInstance.ConnectionStatus.OPEN:
            url = reverse("admin:whatsapp_tracking_whatsappinstance_change", args=[obj.pk]) + "?logout=1"
            return format_html('<a class="text-rose-600 hover:text-rose-800 font-semibold" href="{}">Desconectar</a>', url)
        return "-"
    action_logout.short_description = "Ações"

    def change_view(self, request, object_id, form_url='', extra_context=None):
        if request.GET.get('logout') == '1':
            obj = self.get_object(request, object_id)
            if obj:
                services.logout_instance(obj.name)
                obj.connection_status = WhatsAppInstance.ConnectionStatus.CLOSED
                obj.qr_code_base64 = ''
                obj.save()
        return super().change_view(request, object_id, form_url, extra_context)

class ContactTagForm(forms.ModelForm):
    class Meta:
        model = ContactTag
        fields = "__all__"
        widgets = {
            "color": forms.TextInput(attrs={"type": "color", "style": "height: 42px; padding: 0; cursor: pointer;"}),
        }

@admin.register(ContactTag)
class ContactTagAdmin(ModelAdmin):
    form = ContactTagForm
    list_display = ("name", "color")
    search_fields = ("name",)


@admin.register(WhatsAppContact)
class WhatsAppContactAdmin(ModelAdmin):
    list_display = ("push_name", "phone_number", "display_tags", "updated_at", "actions_column")
    search_fields = ("push_name", "phone_number")
    list_filter = ("tags",)
    filter_horizontal = ("tags",)
    actions = ["action_add_to_campaign"]

    def display_tags(self, obj):
        tags = obj.tags.all()
        if not tags:
            return "-"
        from django.utils.html import format_html_join
        return format_html_join(
            " ",
            '<span style="background-color: {0}; color: white; padding: 2px 8px; border-radius: 12px; font-size: 11px;">{1}</span>',
            ((tag.color, tag.name) for tag in tags)
        )
    display_tags.short_description = "Tags"

    def action_add_to_campaign(self, request, queryset):
        # We need a simple way to add to campaign. Since Django admin actions without intermediate forms are limited,
        # we can just point users to use the Tag or CSV method, OR create a draft campaign and add them.
        campaign, created = WhatsAppCampaign.objects.get_or_create(
            name=f"Campanha Rápida ({timezone.now().strftime('%d/%m %H:%M')})",
            defaults={"status": WhatsAppCampaign.CampaignStatus.DRAFT, "instance": WhatsAppInstance.objects.first()}
        )
        count = 0
        for contact in queryset:
            _, t_created = WhatsAppCampaignTarget.objects.get_or_create(campaign=campaign, contact=contact)
            if t_created: count += 1
        
        self.message_user(request, f"{count} contatos adicionados à campanha '{campaign.name}'. Vá em Campanhas para revisar e disparar.", messages.SUCCESS)
    action_add_to_campaign.short_description = "Adicionar selecionados a uma nova Campanha Rápida"
    search_fields = ("push_name", "phone_number", "remote_jid")
    list_filter = (IsCustomerFilter,)

    def is_customer(self, obj):
        return Customer.objects.filter(phone=obj.phone_number).exists()
    is_customer.short_description = "Cliente Salvo?"

    def actions_column(self, obj):
        from django.utils.safestring import mark_safe
        
        chat_url = reverse("admin:whatsappcontact_chat", args=[obj.pk])
        wa_url = f"https://wa.me/{obj.phone_number}"
        
        btn_chat = f'''<a class="inline-flex items-center justify-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white shadow-sm transition-colors hover:opacity-80" style="background-color: #4f46e5;" href="{chat_url}">
            <span class="material-symbols-outlined mr-1" style="font-size: 14px;">chat</span> Histórico
        </a>'''
        
        btn_wa = f'''<a class="inline-flex items-center justify-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white shadow-sm transition-colors hover:opacity-80" style="background-color: #059669;" target="_blank" href="{wa_url}">
            <span class="material-symbols-outlined mr-1" style="font-size: 14px;">send</span> WhatsApp
        </a>'''
        
        if self.is_customer(obj):
            btn_save = '<span class="inline-flex items-center px-3 py-1.5 rounded text-xs font-medium bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400"><span class="material-symbols-outlined mr-1" style="font-size: 14px;">check_circle</span> Salvo</span>'
        else:
            add_url = reverse("admin:customers_customer_add")
            params = urllib.parse.urlencode({'phone': obj.phone_number, 'name': obj.push_name or ''})
            btn_save = f'''<a class="inline-flex items-center justify-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white shadow-sm transition-colors hover:opacity-80" style="background-color: #9333ea;" href="{add_url}?{params}">
                <span class="material-symbols-outlined mr-1" style="font-size: 14px;">person_add</span> Salvar
            </a>'''

        html = f'<div class="flex items-center gap-2">{btn_chat} {btn_wa} {btn_save}</div>'
        return mark_safe(html)
    actions_column.short_description = "Ações"

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('<path:object_id>/chat/', self.admin_site.admin_view(self.chat_view), name='whatsappcontact_chat'),
            path('<path:object_id>/chat/messages/', self.admin_site.admin_view(self.chat_messages_view), name='whatsappcontact_chat_messages'),
        ]
        return custom_urls + urls

    def chat_view(self, request, object_id, *args, **kwargs):
        contact = self.get_object(request, object_id)
        messages = contact.messages.all().order_by('timestamp')
        context = dict(
            self.admin_site.each_context(request),
            title=f"Conversa com {contact.push_name or contact.phone_number}",
            contact=contact,
            chat_messages=messages,
        )
        return render(request, "admin/whatsapp_tracking/whatsappcontact/chat.html", context)

    def chat_messages_view(self, request, object_id, *args, **kwargs):
        contact = self.get_object(request, object_id)
        messages = contact.messages.all().order_by('timestamp')
        return render(request, "admin/whatsapp_tracking/whatsappcontact/chat_messages.html", {'chat_messages': messages})


class WhatsAppCampaignTargetInline(TabularInline):
    model = WhatsAppCampaignTarget
    extra = 0
    autocomplete_fields = ["contact"]
    readonly_fields = ["status", "error_message", "scheduled_for"]


from django import forms
from unfold.widgets import UnfoldAdminRadioSelectWidget

class WhatsAppCampaignForm(forms.ModelForm):
    assignment_method = forms.ChoiceField(
        choices=[
            ('tags', 'Por Tags (Puxar contatos de tags)'),
            ('csv', 'Por Planilha CSV (Puxar lista de contatos)')
        ],
        initial='tags',
        widget=UnfoldAdminRadioSelectWidget,
        label="Método de Atribuição de Alvos",
        help_text="Escolha como deseja adicionar os contatos na campanha."
    )
    class Meta:
        model = WhatsAppCampaign
        exclude = ('status',)

@admin.register(WhatsAppCampaign)
class WhatsAppCampaignAdmin(ModelAdmin):
    form = WhatsAppCampaignForm
    list_display = ("name", "instance", "progress", "resend_action_button", "created_at")
    list_filter = ("status", "instance")
    search_fields = ("name",)
    filter_horizontal = ("target_tags",)
    inlines = [WhatsAppCampaignTargetInline]

    class Media:
        js = ("whatsapp_tracking/js/campaign_admin.js",)

    actions = ['action_resend_campaign']
    actions_detail = ['action_resend_campaign']  # Registra a URL sem criar o menu de 3 pontos na linha
    from unfold.decorators import action
    
    def resend_action_button(self, obj):
        from django.utils.html import format_html
        return format_html(
            '<a href="/admin/whatsapp_tracking/whatsappcampaign/{}/action_resend_campaign/" '
            'class="bg-blue-600 text-white px-3 py-1.5 rounded-md text-xs font-medium hover:bg-blue-700 transition shadow-sm inline-flex items-center gap-1">'
            '<svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path></svg>'
            'Reenviar'
            '</a>',
            obj.pk
        )
    resend_action_button.short_description = "Ações"
    
    @action(description="Reenviar Campanha")
    def action_resend_campaign(self, request, queryset=None, **kwargs):
        count = 0
        from .tasks import process_campaign
        from django.db import transaction
        from django.contrib import messages
        from django.shortcuts import redirect
        
        object_id = kwargs.get('object_id')
        is_row_action = bool(object_id)
        if is_row_action:
            campaign = self.model.objects.filter(pk=object_id).first()
            queryset = [campaign] if campaign else []
            
        if not queryset:
            if is_row_action:
                return redirect(request.META.get('HTTP_REFERER', '..'))
            return

        for campaign in queryset:
            if campaign.targets.exists():
                campaign.targets.all().update(status='pending', error_message='')
                campaign.status = campaign.CampaignStatus.PROCESSING
                campaign.save(update_fields=['status'])
                transaction.on_commit(lambda c=campaign.id: process_campaign.apply_async(args=[c]))
                count += 1
                
        if count > 0:
            self.message_user(request, f"{count} campanhas foram reenviadas para todos os alvos da lista.", messages.SUCCESS)
        else:
            self.message_user(request, "Nenhuma campanha possui alvos para reenviar.", messages.WARNING)
            
        if is_row_action:
            return redirect(request.META.get('HTTP_REFERER', '..'))

    fieldsets = (
        ("Configuração Geral", {"fields": ("name", "instance", "scheduled_at")}),
        ("Mensagem", {"fields": ("message_template",)}),
        ("Adição em Lote (Ao Salvar)", {
            "fields": ("assignment_method", "target_tags", "csv_file"),
            "description": "Selecione o método de atribuição. Ao salvar a campanha, os contatos serão adicionados ou exibidos de acordo."
        }),
    )

    def progress(self, obj):
        total = obj.targets.count()
        if total == 0:
            return "0 alvos"
        sent = obj.targets.filter(status="sent").count()
        failed = obj.targets.filter(status="failed").count()
        
        is_processing = (obj.status == obj.CampaignStatus.PROCESSING)
        
        if is_processing and total > 0 and (sent + failed) >= total:
            obj.status = obj.CampaignStatus.COMPLETED
            obj.save(update_fields=['status'])
            is_processing = False
        
        html = format_html(
            '<b>{0}/{1}</b> enviados <span class="text-xs text-rose-500">({2} falhas)</span>',
            sent, total, failed
        )
        
        if is_processing:
            from django.utils.safestring import mark_safe
            html += mark_safe("""
            <div style="margin-top: 5px; display: flex; align-items: center; gap: 5px; color: #b45309;">
                <svg class="animate-spin" style="width: 16px; height: 16px;" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                <span style="font-size: 11px;">Enviando...</span>
            </div>
            <script>setTimeout(function(){ window.location.reload(); }, 2000);</script>
            """)
        return html
    progress.short_description = "Progresso"

    def save_related(self, request, form, formsets, change):
        super().save_related(request, form, formsets, change)
        obj = form.instance
        method = form.cleaned_data.get('assignment_method', 'manual')
        
        # 1. Processar Tags (Removido: Agora as tags apenas preenchem a lista no frontend)
        
        # 2. Processar CSV (Removido: Agora o CSV apenas preenche a lista no frontend)
        
        # 3. Disparar a campanha automaticamente
        from django.utils import timezone
        from django.db import transaction
        from .tasks import process_campaign
        
        if obj.status != obj.CampaignStatus.PROCESSING:
            obj.status = obj.CampaignStatus.PROCESSING
            obj.save(update_fields=['status'])
            
            def dispatch_task():
                if obj.scheduled_at and obj.scheduled_at > timezone.now():
                    process_campaign.apply_async(args=[obj.id], eta=obj.scheduled_at)
                    # Use a custom flag to prevent duplicate success messages
                else:
                    process_campaign.apply_async(args=[obj.id])
            
            transaction.on_commit(dispatch_task)
            if obj.scheduled_at and obj.scheduled_at > timezone.now():
                self.message_user(request, f"Campanha agendada para {obj.scheduled_at.strftime('%d/%m %H:%M')}.", messages.INFO)
            else:
                self.message_user(request, "Campanha iniciada. Os disparos começaram em segundo plano.", messages.INFO)
