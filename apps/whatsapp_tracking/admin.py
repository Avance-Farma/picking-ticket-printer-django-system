from django.contrib import admin
from unfold.admin import ModelAdmin
from .models import WhatsAppInstance, WhatsAppContact, WhatsAppMessage

@admin.register(WhatsAppInstance)
class WhatsAppInstanceAdmin(ModelAdmin):
    list_display = ("name", "connection_status", "owner_number", "updated_at")
    list_filter = ("connection_status",)
    search_fields = ("name", "owner_number")

@admin.register(WhatsAppContact)
class WhatsAppContactAdmin(ModelAdmin):
    list_display = ("push_name", "phone_number", "remote_jid", "updated_at")
    search_fields = ("push_name", "phone_number", "remote_jid")

@admin.register(WhatsAppMessage)
class WhatsAppMessageAdmin(ModelAdmin):
    list_display = ("contact", "instance", "from_me", "message_type", "content_snippet", "timestamp")
    list_filter = ("from_me", "message_type", "instance")
    search_fields = ("content", "contact__phone_number", "contact__push_name")
    
    def content_snippet(self, obj):
        if obj.content:
            return obj.content[:50] + ("..." if len(obj.content) > 50 else "")
        return "-"
    content_snippet.short_description = "Content"

