<template>
  <!-- note: buefy requires a title to generate a closable message -->
  <b-message title=" " :type="`is-${type}`" aria-close-label="Close message">
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
