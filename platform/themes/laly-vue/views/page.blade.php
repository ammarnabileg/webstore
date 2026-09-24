@php 
    Theme::layout('default'); 
@endphp
<script>
    window.VisualBuilderPage = @json($page ?? null);
</script>
<div id="app">{!! $ssrHtml ?? '' !!}</div>
