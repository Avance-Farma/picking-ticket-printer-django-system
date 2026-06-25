document.addEventListener('DOMContentLoaded', function() {
    const radioInputs = document.querySelectorAll('input[name="assignment_method"]');
    
    function toggleFields() {
        if (radioInputs.length === 0) return;
        
        let method = 'tags';
        radioInputs.forEach(r => { if(r.checked) method = r.value; });
        
        const tagsField = document.querySelector('.field-target_tags');
        const csvField = document.querySelector('.field-csv_file');
        const manualInline = document.getElementById('targets-group');
        
        if (tagsField) tagsField.style.display = 'none';
        if (csvField) csvField.style.display = 'none';
        if (manualInline) manualInline.style.display = 'none';
        
        if (method === 'tags') {
            if(tagsField) tagsField.style.display = 'block';
            if(manualInline) manualInline.style.display = 'block';
        } else if (method === 'csv') {
            if(csvField) csvField.style.display = 'block';
            if(manualInline) manualInline.style.display = 'block'; // Lista manual visível no CSV também
        }
    }
    
    if (radioInputs.length > 0) {
        radioInputs.forEach(r => r.addEventListener('change', toggleFields));
        toggleFields();
    }

    // --- LÓGICA DO BOTÃO DE SALVAR ---
    const scheduledInput = document.getElementById('id_scheduled_at_0');
    const saveBtn = document.querySelector('input[name="_save"]');
    const isEditPage = window.location.pathname.includes('/change/');
    
    function updateSaveButton() {
        if (!saveBtn) return;
        if (scheduledInput && scheduledInput.value.trim() !== '') {
            saveBtn.value = 'Salvar Agendamento';
        } else {
            if (isEditPage) {
                saveBtn.value = 'Salvar Edição'; // Edição não reenvia automaticamente
            } else {
                saveBtn.value = 'Salvar e Enviar'; // Criação envia automaticamente
            }
        }
    }
    
    if (scheduledInput) {
        scheduledInput.addEventListener('change', updateSaveButton);
        scheduledInput.addEventListener('input', updateSaveButton);
        setInterval(updateSaveButton, 500); 
    }
    updateSaveButton();

    // --- FUNÇÃO GLOBAL DE INJEÇÃO NA LISTA (ANTI-DUPLICIDADE) ---
    function injectContactsIntoList(contacts, pullButton, statusMsg) {
        let addBtn = document.querySelector('#targets-group .add-row a') || 
                     document.querySelector('#targets-group .add-row button') ||
                     document.querySelector('#targets-group a.add-row') ||
                     document.querySelector('tr.add-row td a');
        
        if(!addBtn) {
            statusMsg.textContent = 'Erro: Botão de adicionar linha não encontrado.';
            statusMsg.style.color = '#ef4444';
            pullButton.disabled = false;
            pullButton.style.opacity = '1';
            return;
        }

        // 1. Ler IDs atuais na tabela para evitar duplicatas
        const currentSelects = document.querySelectorAll('select[id^="id_targets-"][id$="-contact"]');
        const existingIds = new Set();
        currentSelects.forEach(sel => {
            if (sel.value) existingIds.add(sel.value.toString());
        });

        // 2. Filtrar contatos (remover duplicatas)
        const newContacts = contacts.filter(c => !existingIds.has(c.id.toString()));

        if (newContacts.length === 0) {
            statusMsg.textContent = 'Todos os contatos já estão presentes na lista abaixo (nenhum novo adicionado).';
            statusMsg.style.color = '#f59e0b';
            pullButton.disabled = false;
            pullButton.style.opacity = '1';
            return;
        }

        statusMsg.textContent = `Injetando ${newContacts.length} novos contatos na lista...`;
        
        let addedCount = 0;
        let currentIndex = 0;

        function insertNextContact() {
            if (currentIndex >= newContacts.length) {
                statusMsg.textContent = `${addedCount} novos alvos inseridos na lista com sucesso!`;
                statusMsg.style.color = '#10b981';
                pullButton.disabled = false;
                pullButton.style.opacity = '1';
                return;
            }

            const contact = newContacts[currentIndex];
            
            addBtn.click();
            
            setTimeout(() => {
                const totalFormsInput = document.getElementById('id_targets-TOTAL_FORMS');
                if(totalFormsInput) {
                    const newIdx = parseInt(totalFormsInput.value) - 1;
                    const select = document.getElementById(`id_targets-${newIdx}-contact`);
                    
                    if(select) {
                        const opt = new Option(contact.name + ' (' + contact.phone + ')', contact.id, true, true);
                        select.appendChild(opt);
                        
                        if(window.jQuery) {
                            window.jQuery(select).trigger('change');
                        } else {
                            select.dispatchEvent(new Event('change'));
                        }
                        addedCount++;
                    }
                }
                
                currentIndex++;
                insertNextContact();
                
            }, 20);
        }
        
        insertNextContact();
    }

    // --- LÓGICA DO BOTÃO "PUXAR PARA A LISTA" (TAGS) ---
    const targetTagsSelect = document.getElementById('id_target_tags');
    const tagsFieldContainer = document.querySelector('.field-target_tags');
    
    if (targetTagsSelect && tagsFieldContainer) {
        const actionContainer = document.createElement('div');
        actionContainer.style.marginTop = '15px';
        actionContainer.style.display = 'flex';
        actionContainer.style.alignItems = 'center';
        
        const pullButton = document.createElement('button');
        pullButton.type = 'button';
        pullButton.className = 'bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 rounded';
        pullButton.style.display = 'flex';
        pullButton.style.alignItems = 'center';
        pullButton.style.gap = '6px';
        pullButton.innerHTML = '<span class="material-symbols-outlined" style="font-size: 18px;">download</span> Puxar para a Lista';
        
        const statusMsg = document.createElement('span');
        statusMsg.style.marginLeft = '15px';
        statusMsg.style.fontSize = '13px';
        statusMsg.style.fontWeight = '500';
        statusMsg.style.color = '#6b7280';
        
        actionContainer.appendChild(pullButton);
        actionContainer.appendChild(statusMsg);
        tagsFieldContainer.appendChild(actionContainer);

        pullButton.addEventListener('click', function(e) {
            e.preventDefault();
            let selected = [];
            const tagsTo = document.getElementById('id_target_tags_to');
            if (tagsTo) {
                selected = Array.from(tagsTo.options).map(opt => opt.value);
            } else if (targetTagsSelect) {
                selected = Array.from(targetTagsSelect.selectedOptions).map(opt => opt.value);
            }

            if(selected.length === 0) {
                statusMsg.textContent = 'Selecione ao menos uma tag primeiro.';
                statusMsg.style.color = '#ef4444';
                return;
            }
            
            statusMsg.textContent = 'Buscando contatos na base...';
            statusMsg.style.color = '#4f46e5';
            pullButton.disabled = true;
            pullButton.style.opacity = '0.7';
            
            fetch(`/whatsapp/api/preview-tags/?tags=${selected.join(',')}`)
                .then(r => r.json())
                .then(data => {
                    if(!data.contacts || data.contacts.length === 0) {
                        statusMsg.textContent = 'Nenhum contato encontrado com essas tags.';
                        statusMsg.style.color = '#ef4444';
                        pullButton.disabled = false;
                        pullButton.style.opacity = '1';
                        return;
                    }
                    
                    statusMsg.textContent = `Encontrados ${data.contacts.length} contatos. Verificando duplicatas...`;
                    injectContactsIntoList(data.contacts, pullButton, statusMsg);

                }).catch(err => {
                    statusMsg.textContent = 'Erro ao conectar com o servidor.';
                    statusMsg.style.color = '#ef4444';
                    pullButton.disabled = false;
                    pullButton.style.opacity = '1';
                });
        });
    }

    // --- LÓGICA DO BOTÃO "PUXAR DO ARQUIVO" (CSV) ---
    const csvFileInput = document.querySelector('input[name="csv_file"]');
    const csvFieldContainer = document.querySelector('.field-csv_file');

    if (csvFileInput && csvFieldContainer) {
        const actionContainer = document.createElement('div');
        actionContainer.style.marginTop = '10px';
        actionContainer.style.display = 'flex';
        actionContainer.style.alignItems = 'center';
        
        const pullCsvButton = document.createElement('button');
        pullCsvButton.type = 'button';
        pullCsvButton.className = 'bg-primary-600 hover:bg-primary-700 text-white font-medium py-2 px-4 rounded';
        pullCsvButton.style.display = 'flex';
        pullCsvButton.style.alignItems = 'center';
        pullCsvButton.style.gap = '6px';
        pullCsvButton.innerHTML = '<span class="material-symbols-outlined" style="font-size: 18px;">upload_file</span> Puxar do Arquivo';
        
        const statusMsgCsv = document.createElement('span');
        statusMsgCsv.style.marginLeft = '15px';
        statusMsgCsv.style.fontSize = '13px';
        statusMsgCsv.style.fontWeight = '500';
        statusMsgCsv.style.color = '#6b7280';
        
        actionContainer.appendChild(pullCsvButton);
        actionContainer.appendChild(statusMsgCsv);
        csvFieldContainer.appendChild(actionContainer);

        pullCsvButton.addEventListener('click', function(e) {
            e.preventDefault();
            
            if (!csvFileInput.files || csvFileInput.files.length === 0) {
                statusMsgCsv.textContent = 'Selecione um arquivo CSV primeiro.';
                statusMsgCsv.style.color = '#ef4444';
                return;
            }

            const formData = new FormData();
            formData.append('csv_file', csvFileInput.files[0]);

            const csrfToken = document.querySelector('[name=csrfmiddlewaretoken]') ? document.querySelector('[name=csrfmiddlewaretoken]').value : '';

            statusMsgCsv.textContent = 'Enviando e processando planilha...';
            statusMsgCsv.style.color = '#4f46e5';
            pullCsvButton.disabled = true;
            pullCsvButton.style.opacity = '0.7';

            fetch(`/whatsapp/api/preview-csv/`, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': csrfToken
                },
                body: formData
            })
            .then(r => r.json())
            .then(data => {
                if(data.error) {
                    statusMsgCsv.textContent = data.error;
                    statusMsgCsv.style.color = '#ef4444';
                    pullCsvButton.disabled = false;
                    pullCsvButton.style.opacity = '1';
                    return;
                }
                
                if(!data.contacts || data.contacts.length === 0) {
                    statusMsgCsv.textContent = 'Nenhum número de contato válido encontrado na planilha.';
                    statusMsgCsv.style.color = '#ef4444';
                    pullCsvButton.disabled = false;
                    pullCsvButton.style.opacity = '1';
                    return;
                }
                
                statusMsgCsv.textContent = `Lidos ${data.contacts.length} contatos únicos. Verificando duplicatas na lista...`;
                injectContactsIntoList(data.contacts, pullCsvButton, statusMsgCsv);

                // Opcional: limpar o campo de arquivo para não enviar de novo no submit
                csvFileInput.value = '';

            }).catch(err => {
                statusMsgCsv.textContent = 'Erro ao processar o arquivo no servidor.';
                statusMsgCsv.style.color = '#ef4444';
                pullCsvButton.disabled = false;
                pullCsvButton.style.opacity = '1';
            });
        });
    }
});
