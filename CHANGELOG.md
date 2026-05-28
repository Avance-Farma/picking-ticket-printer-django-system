# Changelog

Todo o histórico notável de alterações feitas no projeto **Picking Ticket Printer System** a partir da versão 2.0.0.

## [2.3.3] - 2026-05-28

### Adicionado
- Implementação do `ERPVolumePushService` e de validações adicionais de modal de sincronização na interface de usuário.
- Envio de dados dos volumes gerados dos pedidos diretamente para a API externa do ERP.
- Atualização e enriquecimento de serializadores de pedidos (`serializers.py`).

### Corrigido
- Tratamento e logs aprimorados no job Celery responsável por acionar o push de volumes.
- Resolução de conflitos de parâmetros na integração do serviço de volumes.

## [2.2.0] - 2026-05-20

### Adicionado
- Sistema robusto de sincronização periódica de pedidos integrado com a API do ERP via Celery Beat scheduler.
- Filtro inteligente por Branch ID (`ERP_BRANCH_IDS` lido a partir das variáveis de ambiente com fallback para a filial 27 - RJ).
- Recurso de "Resync" (sincronização manual) diretamente no painel administrativo, contendo feedback e status polling.
- Datepicker para requisição retroativa de pedidos históricos do ERP.
- Tratamento seguro na inicialização do Sentry caso o DSN esteja ausente ou corrompido.

## [2.1.0] - 2026-05-10

### Adicionado
- Middleware de Health Check customizado (`HealthCheckMiddleware`) para ignorar a validação do header `Host` nas requisições do Railway.
- Sessões em banco de dados migradas para cache estruturado no Redis para evitar inconsistência sob concorrência.
- Configuração do Redis (via `REDIS_URL`) para funcionamento do broker do Celery no Railway.

### Corrigido
- Ajuste de permissões em volumes compartilhados de uploads `/app/uploads` no container utilizando `gosu` e permissões explícitas na inicialização (`entrypoint.sh`).
- Correções de criação automática do superusuário no processo de implantação/migration.

## [2.0.0] - 2026-04-20
- Versão inicial estável com suporte completo a importação de planilhas/PDF, geração de etiquetas ZPL para Zebra e visualização em PDF.
