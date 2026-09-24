<template>
  <div style="padding: 100px; text-align: center; direction: ltr;">
    <h1>404 Not Found</h1>
    <p>Vue Router could not find a match for: {{ $route.fullPath }}</p>
    <p>Base URL used: {{ baseUrl }}</p>
    <button @click="$router.push('/')">Go to Home</button>
  </div>
</template>
<script setup>
import { useRoute } from 'vue-router';
const route = useRoute();
const baseUrl = window.BotbleData?.baseUrl ? new URL(window.BotbleData.baseUrl).pathname : '/';
</script>
