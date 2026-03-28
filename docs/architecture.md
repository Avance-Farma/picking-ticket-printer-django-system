# Arquitetura do Sistema

O **Picking Ticket Printer System** é uma aplicação web construída com o framework Django (Python) para orquestrar pedidos de logística e imprimir romaneios em formato ZPL e PDF.

## Visão Geral

O sistema é responsável por:
1. **Importação de Dados**: Receber planilhas ou documentos PDFs contendo informações de pedidos, produtos e clientes.
2. **Processamento Assegurado**: Utilizar tarefas em background (Celery + Redis) para processar as importações sem bloquear a interface de usuário.
3. **Autenticação Unificada**: Sistema de login centralizado assegurando que apenas administradores autorizados processem e despachem as demandas logísticas.
4. **Gerenciamento de Entidades**: Gerenciar clientes, endereços, produtos e pedidos através de uma área administrativa moderna (Django Unfold).
5. **Impressão Térmica e PDF**: Gerar etiquetas nos formatos ZPL nativo e PDF para impressoras térmicas via integração web.
6. **API RESTful**: Expor endpoints REST (via Django Rest Framework) documentados via OpenAPI estruturado no Swagger/Redoc.

## Tecnologias Principais

- **Backend**: Python 3.13+, Django 5.x, Django Rest Framework.
- **Banco de Dados**: Configurado para SQLite via `.env` por padrão, facilmente intercambiável para PostgreSQL.
- **Tarefas Assíncronas**: Celery com Redis (broker/backend).
- **Interface e Tema**: Tailwind CSS via [Django Tailwind] com Tema Administrativo [Django Unfold].
- **Gerenciamento de Dependências**: Gerenciado nativamente (`pyproject.toml` com ferramenta como `uv`).

## Interface Principal (Visão Administrativa)

<!-- INSERIR_SCREENSHOT: Dashboard Principal Unfold -->
> 🖼️ *[Captura de Tela da Interface Principal Aqui]*

## Diagrama de Arquitetura em Detalhes

```mermaid
graph TD
    classDef user fill:#f9f,stroke:#333,stroke-width:2px,color:#000;
    classDef web fill:#bbf,stroke:#333,stroke-width:2px,color:#000;
    classDef async fill:#fbb,stroke:#333,stroke-width:2px,color:#000;
    classDef print fill:#bfb,stroke:#333,stroke-width:2px,color:#000;

    User[Administrador Logístico]:::user -->|Autentica na UI Unfold| Web(Servidor Django):::web
    Web -->|Leitura / Escrita| DB[(Banco de Dados)]
    User -->|Via API / Painel Admin| Web
    User -->|Upload Planilhas/PDF| Web
    
    Web -.->|Dispara Tarefas de Validação| Redis[Message Broker Redis]:::async
    Redis -.->|Consome Fila Pendente| Celery[Workers Automáticos Celery]:::async
    Celery -->|Insere Pedidos e Produtos| DB
    
    User -->|Solicita Impressão| Web
    Web -->|Processa Templates| ZPL[ZPL / PDF Engine]:::print
    ZPL -->|Binário PDF / Texto ZPL| Printer[Impressoras Térmicas]:::print
    
    subgraph "Camada de Interface"
        Web
    end
    subgraph "Background & Filas"
        Redis
        Celery
    end
    subgraph "Persistência"
        DB
    end
```

## Fluxo de Importação

<!-- INSERIR_SCREENSHOT: Tela de Importação de Arquivos Assíncrona -->
> 🖼️ *[Captura de Tela da Tela de Importação de Pedidos Aqui]*

```mermaid
sequenceDiagram
    participant U as Operador Logístico
    participant W as WebApp Principal
    participant R as Fila Redis
    participant C as Processo Celery
    participant D as Banco Principal
    
    U->>W: Autenticação Segura (Login)
    W-->>U: Painel Administrativo liberado
    U->>W: Upload Arquivo Romaneio (Excel/PDF)
    W->>R: Empilha Tarefa `ProcessImportFile`
    W-->>U: Sucesso Imediato (Processando...)
    R->>C: Notifica nova Tarefa disponível
    C->>C: Lê e higieniza as linhas das planilhas
    C->>D: Salva `Order`, `Customer`, `Volume`
    D-->>C: Persistência Efetuada
    C->>R: Altera estado final p/ SUCESSO
```

