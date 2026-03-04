import json
from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.db import transaction
from .models import Pedido, PedidoVolume, VolumeItem


def search_order_view(request):
    pedido = None
    numero_pedido = request.GET.get("numero_pedido")

    if numero_pedido:
        pedido = Pedido.objects.filter(numero_pedido=numero_pedido).first()

    context = {"pedido": pedido, "search_query": numero_pedido}
    return render(request, "ticket_printer/index.html", context)


@require_POST
def process_volumes_view(request):
    try:
        data = json.loads(request.body)
        numero_pedido = data.get("numero_pedido")
        total_volumes = int(data.get("total_volumes", 1))

        if not numero_pedido or total_volumes < 1:
            return JsonResponse({"error": "Parâmetros inválidos."}, status=400)

        pedido = Pedido.objects.filter(numero_pedido=numero_pedido).first()
        if not pedido:
            return JsonResponse({"error": "Pedido não encontrado."}, status=404)

        zpl_commands = []
        endereco_completo = f"{pedido.endereco_logradouro}, {pedido.endereco_numero} - {pedido.endereco_bairro}, {pedido.endereco_cidade}/{pedido.endereco_uf} - {pedido.endereco_cep}"

        with transaction.atomic():
            # Limpar volumes antigos para regerar caso o operador processe novamente para o mesmo pedido no MVP
            PedidoVolume.objects.filter(pedido=pedido).delete()

            itens = list(pedido.itens.all())

            for i in range(1, total_volumes + 1):
                # Opcional: deletar e recriar ou apenas criar volumes incrementais
                volume_obj = PedidoVolume.objects.create(
                    pedido=pedido, volume_numero=i, total_volumes=total_volumes
                )

                # Rateio simplificado para o MVP (distribuindo homogeneamente ou registrando as partes)
                for item in itens:
                    qtd_por_volume = max(1, item.quantidade // total_volumes)
                    VolumeItem.objects.create(
                        volume=volume_obj,
                        item=item,
                        quantidade_neste_volume=qtd_por_volume,
                    )

                # Geração do código ZPL com UTF-8
                zpl = f"""^XA
                    ^CI28
                    ^FO50,50^A0N,40,40^FDCliente: {pedido.cliente_nome}^FS
                    ^FO50,110^A0N,30,30^FDEndereco: {endereco_completo}^FS
                    ^FO50,160^A0N,30,30^FDRota: {pedido.rota}^FS
                    ^FO50,210^A0N,30,30^FDVolume {i} de {total_volumes}^FS
                    ^FO50,280^BCN,100,Y,N,N^FD{pedido.numero_pedido}^FS
                    ^XZ"""
                zpl_commands.append(zpl)

        return JsonResponse({"success": True, "zpl_commands": zpl_commands})

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
