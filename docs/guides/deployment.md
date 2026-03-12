# Implantação e Produção

## Docker (Recomendado)

A implantação principal deste software recomenda-se através de Contêineres.

1. Construa e utilize os `docker-compose.prod.yml` (ou mescle os do repositório) no seu servidor de VPS/Cloud.
2. Certifique-se de preencher perfeitamente os arquivos `.env` focados em produção (`DEBUG=False`, `ALLOWED_HOSTS` estritos).
3. A imagem engloba o Backend e os Workers Celery, e necessitará que um proxy-reverso (`Nginx` ou `Traefik`) orquestre a distribuição entre eles:
    * `/static/` e `/media/` (Volumes mapeados e servidos staticamente pelo Nginx).
    * `/api/`, `/admin/` (Servidor gunicorn/uvicorn na porta 8000).
    * `/docs/` (Site MkDocs pré buildado em `site/`).

## Implantação do MkDocs

Quando as mudanças são feitas nos manuais:
```bash
mkdocs build
```
O framework gerará a pasta `site/` no nível da raiz.
Copie essa pasta inteira para seu provedor na nuvem (Netlify, Vercel, AWS S3) – ou se no mesmo servidor, vincule o Nginx para tratar a URL `/docs/` entregando arquivos a partir do volume onde `site/` estiver montado.
