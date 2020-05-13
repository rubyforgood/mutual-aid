<template>
  <b-message
    v-if="hasErrors"
    title="Please fix the problems below"
    type="is-danger"
    class="content"
    aria-close-label="Close message"
  >
    <ul>
      <li v-for="(value) in errors">
        {{ value.join(', ') }}
      </li>
    </ul>
  </b-message>
</template>

<script>
export default {
  props: {
    errors: Object
  },
  computed: {
    hasErrors() {
      return this.errors && Object.keys(this.errors).length
    },
  },
}
</script>
