<template>
  <!--
    The theme-ads shortcode has no real ad source wired yet, so rendering a
    literal "Ad Banner (key)" placeholder just showed filler to shoppers.
    Render nothing until real ad content is supported.
  -->
</template>

<script setup>
defineProps({
  attributes: {
    type: Object,
    default: () => ({})
  }
});
</script>
