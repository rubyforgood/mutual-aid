<template>
  <input type="hidden" name="authenticity_token" :value="authenticityToken" />
</template>

<script>
export default {
  created: function() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')
    this.authenticityToken = csrfToken ? csrfToken.content : null
  },
}
</script>
