# Componentes da Aplicação (Apps)

O sistema é dividido em pequenos módulos e aplicativos visando separação de responsabilidades (Clean Architecture e Django Apps convention).

## Diretório `apps/`

### 1. `customers` (Clientes)
Gerencia os dados de cadastro de clientes. 
- **Modelos Principais**: `Customer` (Nome, Documento, etc.).

### 2. `addresses` (Endereços)
Gerencia a base de endereços associada aos clientes ou aos destinos de entrega.
- **Modelos Principais**: `Address` (Rua, Número, CEP, Cidade, etc.).

### 3. `products` (Produtos)
Catálogo base de itens do sistema que podem ser enviados nos pedidos.
- **Modelos Principais**: `Product` (SKU, Nome, Preço, etc.).

### 4. `orders` (Pedidos)
O núcleo logístico do sistema, unindo Clientes, Endereços e Produtos no formato de romaneio.
- **Modelos Principais**: `Order` (Pedido pai), `OrderItem` (Itens adquiridos em cada romaneio).

### 5. `imports` (Importação de Arquivos)
Aplicativo dedicado ao recebimento de planilhas (`.xls`, `.xlsx`) e PDFs contendo os pedidos. 
- Gerencia o status e a lógica de persistência e validação da importação antes de gerar as `Orders`.

### 6. `deliveries` (Entregas)
Controla os metadados associados à entrega física dos pedidos em rotas.

### 7. `ticket_printer` (Impressão de Romaneio)
Camada de negócio responsável por transformar objetos `Order` em sintaxe ZPL ou documentos PDF de saída para impressoras Zebra e equivalentes.

---

A modularização permite que a lógica de negócio esteja estritamente isolada e de fácil manutenção e testes (localizados em `/tests/`).
