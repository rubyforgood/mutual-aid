<template>
  <form :action="action" method="post">
    <AuthTokenInput />
    <input type="hidden" name="_method" value="delete" />
    <button type="submit" class="button is-outlined">
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
