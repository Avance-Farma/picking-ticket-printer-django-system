from django.db import models


class Pedido(models.Model):
    picking = models.CharField(max_length=20)
    numero_pedido = models.CharField(max_length=30)
    rota = models.CharField(max_length=50, blank=True, null=True)
    cliente_codigo = models.CharField(max_length=30, blank=True, null=True)
    cliente_nome = models.TextField(blank=True, null=True)
    cpf_cnpj = models.CharField(max_length=20, blank=True, null=True)
    endereco_logradouro = models.TextField(blank=True, null=True)
    endereco_numero = models.TextField(blank=True, null=True)
    endereco_bairro = models.TextField(blank=True, null=True)
    endereco_cidade = models.TextField(blank=True, null=True)
    endereco_uf = models.CharField(max_length=2, blank=True, null=True)
    endereco_cep = models.CharField(max_length=15, blank=True, null=True)
    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "pedidos"
        unique_together = [("picking", "numero_pedido")]

    def __str__(self):
        return f"Pedido {self.numero_pedido} - {self.cliente_nome}"


class PedidoItem(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name="itens")
    codigo_produto = models.CharField(max_length=50, blank=True, null=True)
    descricao = models.TextField(blank=True, null=True)
    quantidade = models.DecimalField(max_digits=18, decimal_places=3, default=0)
    unidade = models.CharField(max_length=20, blank=True, null=True)
    linha_origem = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = "pedido_itens"
        unique_together = [("pedido", "codigo_produto", "descricao", "linha_origem")]

    def __str__(self):
        return f"{self.codigo_produto} - {self.descricao} ({self.quantidade})"


class PedidoVolume(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name="volumes")
    volume_num = models.IntegerField()
    total_volumes = models.IntegerField()
    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "pedido_volumes"
        unique_together = [("pedido", "volume_num")]

    def __str__(self):
        return f"Volume {self.volume_num}/{self.total_volumes} do Pedido {self.pedido.numero_pedido}"


class VolumeItem(models.Model):
    volume = models.ForeignKey(
        PedidoVolume, on_delete=models.CASCADE, related_name="itens_rateados"
    )
    item = models.ForeignKey(PedidoItem, on_delete=models.CASCADE)
    quantidade = models.DecimalField(max_digits=18, decimal_places=3, default=0)

    class Meta:
        db_table = "volume_itens"
        unique_together = [("volume", "item")]

    def __str__(self):
        return f"{self.quantidade}x {self.item.codigo_produto} no Volume {self.volume.volume_num}"


class ImportBatch(models.Model):
    total_files = models.IntegerField(default=0)
    processed_files = models.IntegerField(default=0)
    status = models.CharField(max_length=20, default='processing') # processing, completed, error
    errors = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "import_batches"
        
    def __str__(self):
        return f"Lote {self.id} - {self.status} ({self.processed_files}/{self.total_files})"
