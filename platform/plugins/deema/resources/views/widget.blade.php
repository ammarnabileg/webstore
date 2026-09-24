<style>
    deema-widget { display: block !important; min-height: 60px !important; border: 2px dashed #f00 !important; }
</style>
<script>
    window.deemaWidgetConfiguration = {
        publicKey: "{{ $publicKey }}",
    };
</script>
<script src="{{ $url }}" async></script>
