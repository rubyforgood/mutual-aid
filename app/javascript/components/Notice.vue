<template>
  <!-- TODO: Remove this if we decide to use the Snackbar version -->
  <!-- Note: without a title, buefy generates a headless message, which is not closable -->
  <b-message
    :type="`is-${type}`"
    title=" "
    aria-close-label="Close message"
    has-icon
  >
    {{ message }}
  </b-message>
</template>

<script>
export default {
  props: {
    message: String,
    type: String,
  },
}
</script>
