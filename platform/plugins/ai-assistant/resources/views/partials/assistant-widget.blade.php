<div id="ai-assistant-wrapper" class="ai-assistant-closed">
    <div id="ai-assistant-toggle" title="AI Assistant">
        <i class="ti ti-robot"></i>
    </div>
    <div id="ai-assistant-container">
        <div class="ai-assistant-header">
            <span>AI Assistant</span>
            <button type="button" class="btn-close-ai" id="ai-assistant-close">&times;</button>
        </div>
        <div id="ai-assistant-messages">
            <div class="ai-message ai-message-ai">مرحباً! كيف يمكنني مساعدتك في إدارة متجرك اليوم؟</div>
        </div>
        <div class="ai-assistant-footer">
            <input type="text" id="ai-assistant-input" placeholder="اسأل أي شيء...">
            <button type="button" id="ai-assistant-send"><i class="ti ti-send"></i></button>
        </div>
    </div>
</div>

<!-- AI Generation Modal -->
<div class="modal fade" id="ai-generation-modal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="ti ti-robot"></i> AI Content Generator</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">What should I generate?</label>
                    <textarea id="ai-prompt-input" class="form-control" rows="3" placeholder="e.g. Write a professional description for a high-quality leather wallet."></textarea>
                </div>
                <div id="ai-generation-preview" class="d-none">
                    <label class="form-label">Generated Content:</label>
                    <div class="p-3 border rounded bg-light" id="ai-generated-text" style="white-space: pre-wrap; min-height: 100px;"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="ai-generate-btn">
                    <i class="ti ti-wand"></i> Generate
                </button>
                <button type="button" class="btn btn-warning d-none" id="ai-copy-btn">
                    <i class="ti ti-copy"></i> Copy to Clipboard
                </button>
                <button type="button" class="btn btn-success d-none" id="ai-apply-btn">
                    <i class="ti ti-check"></i> Apply to Field
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    window.AI_ASSISTANT_ROUTES = {
        generate: "{{ route('ai-assistant.generate') }}"
    };
</script>
