# Impressão e ZPL

O aplicativo `ticket_printer` é responsável pelo pilar central da nossa aplicação: emitir os romaneios em formato utilizável pelas impressoras térmicas industriais.

## Geração de Código ZPL

**ZPL (Zebra Programming Language)** é uma linguagem de página para impressoras de etiquetas.

A nossa infraestrutura no Django:
1. Monta o layout através de coordenadas.
2. Injeta os dados do `Order` (Cliente, Endereço, Quantidade de Caixas, Itens).
3. Produz um texto puro `.zpl`.

## Funcionalidades
- **Preview em PDF**: Nós também integramos com conversores ZPL-to-PDF (ex: [Labelary API]) ou geradores de PDF literais para que o operador de logística possa obter uma prévia real da etiqueta.
- **Comunicação Web**: O front-end Unfold é preparado para acionar endpoints da API (`/printer/`) enviando requisições em background que geram essas etiquetas e as devolvem para o navegador para processamento através de bibliotecas como **QZ Tray**.

> [!TIP]
> Caso queira modificar a fisionomia visual da etiqueta, acesse o módulo de templates ZPL dentro do aplicativo `apps/ticket_printer/`. Cada mudança nas coordenadas X, Y reflete diretamente na proporção milimétrica da etiqueta física final.
