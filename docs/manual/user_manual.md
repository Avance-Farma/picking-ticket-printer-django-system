# Manual de Utilização - Administrador de Logística

Bem-vindo ao **Sistema de Romaneios**. Este guia visa orientar o operador no dia-a-dia da utilização da ferramenta.

## Acessando o Sistema

A tela principal do sistema é construída sobre o Django Unfold. Quando você realiza o login você encontra um painel (Dashboard) lateral dividindo suas operações em grupos:
- **Painel de Controle**
- **Logística**
- **Catálogo**
- **Diretório**
- **Documentação**

## Operações Cotidianas

### 1. Cadastrando e Listando Pedidos

Vá no menu **Logística** -> **Pedidos**. Aqui você verá a lista de todos os pedidos já faturados e importados.
- É possível filtrar pela data do pedido.
- É possível exportar os pedidos via planilhas de relatórios.

### 2. Importação em Massa de Documentos

Muitas vezes em vez de cadastrar pedido um-a-um via menu, utiliza-se o serviço de importação para puxar do ERP a lista do que despachar hoje.
1. Se disponível a interface de importação no Admin ou App, basta submeter o arquivo (.XLS, ou .PDF do modelo de nota).
2. Aguarde alguns segundos. O sistema utilizará processamento assíncrono para incluir as centenas/milhares de mercadorias.
3. Elas aparecerão magicamente na aba de "Pedidos" como Pendentes.

### 3. Emissão e Impressão de Etiquetas e ZPL

Ao visualizar a lista de pedidos, selecione aqueles que vão pro caminhão ou expedição:
1. No menu de visualização/listagem, você tem atalhos de "Imprimir ZPL" ou "Transformar em PDF".
2. Ao clicar, o sistema fará a tradução e gerará a saída visual. As etiquetas são projetadas por milímetros.

---
> [!NOTE]
> Para erros sobre falta de SKU do produto na linha da planilha, consulte o registro do seu ERP e corrija a planilha antes de submeter novamente, o importador recusa arquivos comprometidos pro-ativamente para higienizar o nosso banco.
