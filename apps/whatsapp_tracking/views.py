from django.views.generic import TemplateView
from django.contrib.admin.views.decorators import staff_member_required
from django.utils.decorators import method_decorator
from apps.whatsapp_tracking.models import Supervisor, WhatsAppMessage, WhatsAppContact

from django.contrib import admin

@method_decorator(staff_member_required, name='dispatch')
class HierarchyView(TemplateView):
    template_name = "admin/whatsapp_tracking/hierarchy.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update(admin.site.each_context(self.request))
        
        supervisors = Supervisor.objects.prefetch_related('instances').all()
        
        # Estrutura de dados para o template:
        # [
        #    {
        #      'supervisor': <Supervisor obj>,
        #      'instances': [
        #         {
        #            'instance': <WhatsAppInstance obj>,
        #            'leads': [
        #               <WhatsAppContact obj>, ...
        #            ]
        #         }, ...
        #      ]
        #    }, ...
        # ]
        
        hierarchy = []
        for sup in supervisors:
            sup_data = {
                'supervisor': sup,
                'instances': []
            }
            for inst in sup.instances.all():
                # Encontrar contatos que possuem mensagens trocadas com essa instância
                # usando distinct() para evitar contatos duplicados
                contact_ids = WhatsAppMessage.objects.filter(instance=inst).values_list('contact_id', flat=True).distinct()
                leads = WhatsAppContact.objects.filter(id__in=contact_ids).order_by('-updated_at')
                
                sup_data['instances'].append({
                    'instance': inst,
                    'leads': leads
                })
            hierarchy.append(sup_data)
            
        context['hierarchy'] = hierarchy
        return context
