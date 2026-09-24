@php
    SeoHelper::setTitle(__('404 - Not found'));
@endphp
{{-- Error pages are rendered without the theme layout, so render the full SPA shell;
     the Vue router then shows its own translated not-found page. --}}
{!! Theme::scope('index')->render()->getContent() !!}
