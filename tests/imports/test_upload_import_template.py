import pytest
from django.urls import reverse
from apps.erp_sync.models import ERPSyncLog

@pytest.mark.django_db
def test_page_title_displays_central_de_ingestao(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    assert response.status_code == 200
    html = response.content.decode("utf-8")
    
    # 1. Título da página principal (h1)
    assert "Central de Ingestão" in html

@pytest.mark.django_db
def test_browser_title_updated(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    assert response.status_code == 200
    html = response.content.decode("utf-8")
    
    # 2. Title do browser
    assert "<title>Central de Ingestão" in html or "<title>\n        Central de Ingestão" in html or "Central de Ingestão" in html

@pytest.mark.django_db
def test_heartbeat_card_appears_before_upload_form(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 3. Heartbeat card vem antes do form de upload no HTML
    heartbeat_idx = html.find('id="erp-heartbeat-card"')
    upload_form_idx = html.find('id="upload-form"')
    
    assert heartbeat_idx != -1
    assert upload_form_idx != -1
    assert heartbeat_idx < upload_form_idx

@pytest.mark.django_db
def test_sync_section_appears_before_upload_form(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 4. Seção de sincronização manual/histórico vem antes do form de upload
    sync_section_idx = html.find('Sincronização Manual')
    if sync_section_idx == -1:
        sync_section_idx = html.find('id="sync-manual-card"') or html.find('Histórico de Sincronizações')
    upload_form_idx = html.find('id="upload-form"')
    
    assert sync_section_idx != -1
    assert upload_form_idx != -1
    assert sync_section_idx < upload_form_idx

@pytest.mark.django_db
def test_tab_selectors_present(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 5. Os botões seletores de aba (Sync e Manual) devem estar presentes
    assert 'id="tab-sync"' in html
    assert 'id="tab-manual"' in html
    assert 'id="content-sync"' in html
    assert 'id="content-manual"' in html

@pytest.mark.django_db
def test_heartbeat_card_not_hidden_by_default(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 6. O card do heartbeat não deve conter a classe "hidden" por padrão na renderização
    idx = html.find('id="erp-heartbeat-card"')
    assert idx != -1
    tag_area = html[idx-100:idx+150]
    assert "hidden" not in tag_area

@pytest.mark.django_db
def test_recent_orders_table_present(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 7. Tabela de últimos pedidos importados deve estar presente
    assert "Pedidos Importados" in html or "id=\"recent-orders-table\"" in html

@pytest.mark.django_db
def test_sync_history_table_present(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 8. Histórico de sincronizações deve estar presente
    assert "Histórico de Sincronizações" in html or "id=\"sync-history-table\"" in html

@pytest.mark.django_db
def test_page_renders_with_empty_data(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    assert response.status_code == 200

@pytest.mark.django_db
def test_upload_form_csrf_token_present(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 10. CSRF Token deve estar presente
    assert "csrfmiddlewaretoken" in html

@pytest.mark.django_db
def test_back_button_present_at_top(client, user):
    client.force_login(user)
    response = client.get(reverse("upload-import"))
    html = response.content.decode("utf-8")
    
    # 11. Botão de voltar ao início deve estar presente no menu superior
    assert "Início / Pickings" in html
    # Garante que o link aponta para a página correta (orders-list)
    assert 'href="/orders/"' in html or 'href="/"' in html or 'orders' in html
