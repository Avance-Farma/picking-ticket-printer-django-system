# Celery & Backgroun Tasks

Muitas operações neste sistema – em especial as importações de arquivos pesados com milhares de linhas – devem ocorrer **assincronamente** para evitar o bloqueio (Timeout) do servidor web no navegador do usuário.

## Componentes

- **RabbitMQ ou Redis (Atualmente configurado com Redis)**: Age como *Message Broker*. O servidor web empilha a tarefa na memória do Redis, e devolve instantaneamente pro usuário que "o processo começou".
- **Celery Worker**: Fica rodando em background (na máquina local, como um serviço, ou em um contêiner no Docker) aguardando trabalho. Assim que enxerga o aviso no Redis, baixa a planilha de importação e processa cada uma das linhas e insere no Banco de Dados.

## Monitoramento

- Erros que aconteçam em background são passados para o Celery, que tenta o sistema de *Retry* dependendo das configurações.
- A biblioteca *Sentry* está engatada no Celery (`integrations=[CeleryIntegration()]`) no `settings.py` para mapeamento de falhas e travamentos durões nesses processos paralelos.

### Comandos Comuns (Dev)
Para subir o Worker isoladamente:
```bash
celery -A core worker -l info
```
