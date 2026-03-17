# Picking Ticket Printer System 🚀

O **Picking Ticket Printer System** é uma solução robusta baseada em Django para orquestração logística, focada na importação de pedidos e geração de romaneios em formatos ZPL (para impressoras térmicas Zebra) e PDF.

## 📋 Funcionalidades Principais

- **Área Administrativa Moderna**: Interface intuitiva utilizando [Django Unfold](https://github.com/unfoldadmin/django-unfold).
- **Importação Inteligente**: Suporte para importação de dados via planilhas (Excel/Pandas) e PDFs.
- **Processamento Assíncrono**: Gerenciamento de tarefas pesadas em background com **Celery** e **Redis**.
- **Geração de Etiquetas**: Produção de etiquetas ZPL nativas e PDFs prontos para impressão.
- **API RESTful**: Integração facilitada via **Django Rest Framework** com documentação Swagger/OpenAPI.
- **Qualidade de Código**: Setup completo de linting (Ruff), tipagem (Mypy) e testes automatizados (Pytest).

## 🛠️ Stack Tecnológica

- **Backend**: Python 3.13+, Django 6.0.
- **API**: Django Rest Framework (DRF).
- **Banco de Dados**: PostgreSQL (Produção) / SQLite (Desenvolvimento).
- **Task Queue**: Celery + Redis.
- **Frontend Admin**: Tailwind CSS + Django Unfold.
- **Documentação**: MkDocs.

## 🚀 Como Começar

### Pré-requisitos

- [Python 3.13+](https://www.python.org/)
- [Docker & Docker Compose](https://www.docker.com/)
- [uv](https://github.com/astral-sh/uv) (Recomendado para gerenciamento de pacotes)

### Instalação

1. **Clone o repositório**:

```bash
git clone https://github.com/seu-usuario/picking-ticket-printer-django-system.git
cd picking-ticket-printer-django-system
```

2. **Configure o ambiente**:

```bash
cp .env.example .env
# Edite o .env com suas configurações locais
```

3. **Instale as dependências**:

```bash
uv sync
```

4. **Execute as migrações**:

```bash
python manage.py migrate
```

5. **Crie um superusuário**:

```bash
python manage.py createsuperuser
```

### Execução

Para rodar o projeto completo com Docker:

```bash
docker-compose up --build
```

Ou manualmente (em terminais separados):

```bash
python manage.py runserver      # Web Server
celery -A core worker -l info  # Worker
```

## 📖 Documentação Detalhada

Para mais informações, consulte nossa documentação técnica completa na pasta [`docs/`](./docs):

- [🏛️ Arquitetura do Sistema](./docs/architecture.md)
- [📘 Manual do Operador](./docs/manual/user_manual.md) (Em breve)
- [👨‍💻 Guia de Desenvolvimento](./docs/guides/development.md) (Em breve)

A documentação também pode ser visualizada via MkDocs:

```bash
mkdocs serve
```

## 🧪 Testes e Qualidade

O projeto utiliza ferramentas modernas para garantir a estabilidade:

- **Testes**: `pytest`
- **Linting/Formatação**: `ruff check` e `ruff format`
- **Checagem de Tipos**: `mypy .`

## 📄 Licença

Este projeto está sob a licença [MIT](LICENSE).
