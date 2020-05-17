<template>
  <form :action="action" method="get">
    <input type="hidden" :name="123"/><!-- # TODO get this to capture page_url window.location.href page_url=123-->
    <button class="button is-outlined">
      <slot />
    </button>
  </form>
</template>

<script>
import AuthTokenInput from './AuthTokenInput'

export default {
  components: {AuthTokenInput},
  props: {
    action: String,
  },
  computed: {
    authenticityToken() {
      return document.querySelector('meta[name="csrf-token"]').content
    },
  },
}
</script>
