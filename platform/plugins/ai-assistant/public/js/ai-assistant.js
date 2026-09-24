$(document).ready(function () {
    // Floating Widget Toggle
    $(document).on('click', '#ai-assistant-toggle, #ai-assistant-close', function () {
        $('#ai-assistant-wrapper').toggleClass('ai-assistant-closed');
    });

    // Chat Functionality
    $(document).on('click', '#ai-assistant-send', function () {
        sendMessage();
    });

    $(document).on('keypress', '#ai-assistant-input', function (e) {
        if (e.which == 13) sendMessage();
    });

    function sendMessage() {
        const input = $('#ai-assistant-input');
        const message = input.val().trim();
        if (!message) return;

        appendMessage('user', message);
        input.val('');

        $.ajax({
            url: window.AI_ASSISTANT_ROUTES.generate,
            method: 'POST',
            data: {
                prompt: message,
                _token: $('meta[name="csrf-token"]').attr('content')
            },
            success: function (response) {
                if (response.data && response.data.content) {
                    appendMessage('ai', response.data.content);
                } else if (response.error) {
                    appendMessage('ai', 'Error: ' + response.message);
                }
            },
            error: function (xhr) {
                appendMessage('ai', 'Error: ' + (xhr.responseJSON ? xhr.responseJSON.message : 'Failed to connect. Check API Key.'));
            }
        });
    }

    function appendMessage(role, text) {
        $('#ai-assistant-messages').append(`<div class="ai-message ai-message-${role}">${text}</div>`);
        $('#ai-assistant-messages').scrollTop($('#ai-assistant-messages')[0].scrollHeight);
    }

    function getContext() {
        const name = $('input[name="name"]').val() || '';
        const sku = $('input[name="sku"]').val() || '';
        const categories = $('select[name="categories[]"] option:selected').map(function() { return $(this).text(); }).get().join(', ');
        const isArabic = $('body').hasClass('rtl') || $('.note-info').text().includes('Arabic') || $('.note-info').text().includes('العربية');
        
        return { name, sku, categories, isArabic };
    }

    // Form Helper Integration
    function initFormHelpers() {
        const targets = $('textarea[name*="description"], textarea[name*="content"], textarea[name*="body"], .editor-ckeditor, .editor-tinymce');
        
        targets.each(function() {
            const target = $(this);
            if (target.hasClass('ai-processed') || target.attr('id') === 'ai-prompt-input') return;
            target.addClass('ai-processed');
            
            const btnGroup = $('<div class="ai-btn-group" style="margin-top:5px; margin-bottom:10px;"></div>');
            const genBtn = $(`<button type="button" class="btn btn-sm btn-info ai-helper-btn me-2" style="margin-right:5px;"><i class="ti ti-robot"></i> AI Generate Content</button>`);
            const tableBtn = $(`<button type="button" class="btn btn-sm btn-secondary ai-helper-btn"><i class="ti ti-table"></i> AI Generate Table</button>`);
            
            btnGroup.append(genBtn).append(tableBtn);

            if (target.is(':hidden') || target.css('display') === 'none') {
                target.parent().append(btnGroup);
            } else {
                target.after(btnGroup);
            }

            genBtn.on('click', function (e) {
                e.preventDefault();
                window.CURRENT_AI_TARGET = target;
                const context = getContext();
                
                if (!context.name || context.name === 'Name') {
                    alert(context.isArabic ? 'يرجى إدخال اسم المنتج أولاً للحصول على نتائج دقيقة.' : 'Please enter the product name first for accurate results.');
                    return;
                }

                const fieldName = target.attr('name') || '';
                let prompt = "";
                
                if (context.isArabic) {
                    if (fieldName.includes('description')) {
                        prompt = `اكتب وصفاً قصيراً (حوالي 100-150 كلمة) لمنتج "${context.name}". رقم القطعة (SKU): ${context.sku}. التصنيفات: ${context.categories}. يجب أن يكون الوصف احترافياً، جذاباً للعملاء، وصديقاً لمحركات البحث (SEO). ركز على المميزات الأساسية والفوائد. اكتب باللغة العربية حصراً.`;
                    } else {
                        prompt = `اكتب محتوى تفصيلياً واحترافياً لمنتج "${context.name}". رقم القطعة (SKU): ${context.sku}. التصنيفات: ${context.categories}. قم بتقسيم المحتوى إلى عناوين رئيسية (H2, H3)، واستخدم النقاط (bullet points) للمميزات. اجعل النص تسويقياً واحترافياً جداً كما في المتاجر العالمية الكبرى. اكتب باللغة العربية حصراً.`;
                    }
                } else {
                    if (fieldName.includes('description')) {
                        prompt = `Write a detailed, professional, and SEO-optimized short description (about 100-150 words) for the product "${context.name}" (SKU: ${context.sku}, Categories: ${context.categories}). Focus on the main value proposition and unique selling points. Use engaging language.`;
                    } else {
                        prompt = `Write a comprehensive, professional, and high-quality long content for "${context.name}" (SKU: ${context.sku}, Categories: ${context.categories}). Include an introduction, key features with bullet points, benefits for the user, and a conclusion. Organize it with proper headings (H2, H3).`;
                    }
                }

                $('#ai-prompt-input').val(prompt);
                $('#ai-generation-preview').addClass('d-none');
                $('#ai-apply-btn').addClass('d-none');
                $('#ai-copy-btn').addClass('d-none');
                $('#ai-generation-modal').modal('show');
            });

            tableBtn.on('click', function (e) {
                e.preventDefault();
                window.CURRENT_AI_TARGET = target;
                const context = getContext();
                
                if (!context.name || context.name === 'Name') {
                    alert(context.isArabic ? 'يرجى إدخال اسم المنتج أولاً للحصول على نتائج دقيقة.' : 'Please enter the product name first for accurate results.');
                    return;
                }

                let prompt = "";
                if (context.isArabic) {
                    prompt = `قم بتوليد جدول مواصفات تقني بنظام HTML لمنتج "${context.name}". رقم القطعة (SKU): ${context.sku}. استخدم بنية <table> نظيفة مع <thead> و <tbody>. يجب أن يحتوي الجدول على 6-8 صفوف من البيانات التقنية الحقيقية والمنطقية لهذا النوع من المنتجات. اجعل أسماء الأعمدة بالعربية (مثل: الخاصية، القيمة). أرجع كود الـ HTML فقط.`;
                } else {
                    prompt = `Generate a professional HTML specification table for "${context.name}" (SKU: ${context.sku}). The table should include common technical specifications relevant to this item. Use a clean <table> structure with <thead> and <tbody>. Include at least 6-8 rows of realistic data. Return ONLY the HTML table code.`;
                }

                $('#ai-prompt-input').val(prompt);
                $('#ai-generation-preview').addClass('d-none');
                $('#ai-apply-btn').addClass('d-none');
                $('#ai-copy-btn').addClass('d-none');
                $('#ai-generation-modal').modal('show');
            });
        });
    }

    initFormHelpers();
    $(document).ajaxComplete(function() {
        initFormHelpers();
    });

    // Modal Generate
    $(document).on('click', '#ai-generate-btn', function () {
        const prompt = $('#ai-prompt-input').val();
        if (!prompt) return;
        
        const btn = $(this);
        const originalText = btn.text();
        btn.prop('disabled', true).text('Generating...');

        $.ajax({
            url: window.AI_ASSISTANT_ROUTES.generate,
            method: 'POST',
            data: {
                prompt: prompt,
                context: $('input[name="name"]').val() || '',
                _token: $('meta[name="csrf-token"]').attr('content')
            },
            success: function (response) {
                if (response.data && response.data.content) {
                    let content = response.data.content;
                    content = content.replace(/```html/g, '').replace(/```/g, '').trim();
                    
                    $('#ai-generated-text').html(content);
                    $('#ai-generation-preview').removeClass('d-none');
                    $('#ai-apply-btn').removeClass('d-none');
                    $('#ai-copy-btn').removeClass('d-none');
                } else {
                    alert('Error: ' + (response.message || 'Unknown error'));
                }
            },
            error: function (xhr) {
                alert('Error: ' + (xhr.responseJSON ? xhr.responseJSON.message : 'Check API settings.'));
            },
            complete: function() {
                btn.prop('disabled', false).text(originalText);
            }
        });
    });

    // Modal Copy
    $(document).on('click', '#ai-copy-btn', function () {
        const content = $('#ai-generated-text').html();
        const temp = $('<textarea>');
        $('body').append(temp);
        temp.val(content).select();
        document.execCommand('copy');
        temp.remove();
        
        const btn = $(this);
        const originalText = btn.html();
        btn.html('<i class="ti ti-check"></i> Copied!').addClass('btn-success').removeClass('btn-warning');
        setTimeout(() => {
            btn.html(originalText).addClass('btn-warning').removeClass('btn-success');
        }, 2000);
    });

    // Modal Apply
    $(document).on('click', '#ai-apply-btn', function () {
        const text = $('#ai-generated-text').html();
        if (window.CURRENT_AI_TARGET) {
            const target = window.CURRENT_AI_TARGET;
            const targetId = target.attr('id');
            let applied = false;

            // 1. TinyMCE
            if (window.tinyMCE && window.tinyMCE.get(targetId)) {
                window.tinyMCE.get(targetId).setContent(text);
                applied = true;
            } 
            // 2. CKEditor 4
            else if (window.CKEDITOR && window.CKEDITOR.instances[targetId]) {
                window.CKEDITOR.instances[targetId].setData(text);
                applied = true;
            }

            // 3. CKEditor Instances Search
            if (!applied && window.CKEDITOR) {
                for (var instanceName in window.CKEDITOR.instances) {
                    var instance = window.CKEDITOR.instances[instanceName];
                    if (instance.element && instance.element.$ === target[0]) {
                        instance.setData(text);
                        applied = true;
                        break;
                    }
                }
            }

            // 4. TinyMCE Instances Search
            if (!applied && window.tinyMCE) {
                window.tinyMCE.editors.forEach(function(editor) {
                    if (editor.getElement() === target[0]) {
                        editor.setContent(text);
                        applied = true;
                    }
                });
            }

            // 5. Summernote
            if (!applied && typeof target.summernote === 'function') {
                target.summernote('code', text);
                applied = true;
            }

            // 6. CKEditor 5
            if (!applied && target[0].ckeditorInstance) {
                target[0].ckeditorInstance.setData(text);
                applied = true;
            }

            // 7. Direct DOM injection for hidden CKEditor 5
            if (!applied) {
                const ckContainer = target.next('.ck-editor');
                if (ckContainer.length) {
                    const editable = ckContainer.find('.ck-content');
                    if (editable.length) {
                        editable.html(text);
                        applied = true;
                    }
                }
            }

            if (!applied) {
                target.val(text).trigger('change');
            }
            
            $('#ai-generation-modal').modal('hide');
        }
    });
});
