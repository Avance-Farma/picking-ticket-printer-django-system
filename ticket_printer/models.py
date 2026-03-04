from django.db import models


class Pedido(models.Model):
    numero_pedido = models.CharField(max_length=50, unique=True)
    cliente_nome = models.CharField(max_length=200)
    endereco_logradouro = models.CharField(max_length=200)
    endereco_numero = models.CharField(max_length=50)
    endereco_bairro = models.CharField(max_length=100)
    endereco_cidade = models.CharField(max_length=100)
    endereco_uf = models.CharField(max_length=2)
    endereco_cep = models.CharField(max_length=20)
    rota = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        db_table = "pedidos"

    def __str__(self):
        return f"Pedido {self.numero_pedido} - {self.cliente_nome}"


class PedidoItem(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name="itens")
    codigo_produto = models.CharField(max_length=50)
    descricao = models.CharField(max_length=200)
    quantidade = models.IntegerField()

    class Meta:
        db_table = "pedido_itens"

    def __str__(self):
        return f"{self.codigo_produto} - {self.descricao} ({self.quantidade})"


class PedidoVolume(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name="volumes")
    volume_numero = models.IntegerField()
    total_volumes = models.IntegerField()
    data_criacao = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "pedido_volumes"

    def __str__(self):
        return f"Volume {self.volume_numero}/{self.total_volumes} do Pedido {self.pedido.numero_pedido}"


class VolumeItem(models.Model):
    volume = models.ForeignKey(
        PedidoVolume, on_delete=models.CASCADE, related_name="itens_rateados"
    )
    item = models.ForeignKey(PedidoItem, on_delete=models.CASCADE)
    quantidade_neste_volume = models.IntegerField()

    class Meta:
        db_table = "volume_itens"

    def __str__(self):
        return f"{self.quantidade_neste_volume}x {self.item.codigo_produto} no Volume {self.volume.volume_numero}"
