<template>
  <form :action="action" method="post">
    <input type="hidden" name="_method" value="delete" />
    <input type="hidden" name="authenticity_token" :value="authenticityToken" />
    <button type="submit" class="button is-outlined">
      <slot />
    </button>
  </form>
</template>

<script>
export default {
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
