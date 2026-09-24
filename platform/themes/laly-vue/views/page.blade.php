@php 
    Theme::layout('default'); 
@endphp
@php
    // Live-preview data for the page builder: only for signed-in admins, and only the fields
    // the preview needs, with the same HTML sanitising as the public page API.
    $visualBuilderPage = null;
    if (isset($page) && $page && auth()->check()) {
        $visualBuilderPage = [
            'id' => $page->id,
            'name' => $page->name,
            'slug' => $page->slug ?? null,
            'content' => BaseHelper::clean((string) $page->content),
            'template' => $page->template ?? null,
        ];
    }
@endphp
<script>
    window.VisualBuilderPage = @json($visualBuilderPage);
</script>
<div id="app">{!! $ssrHtml ?? '' !!}</div>
