<template>
  <b-field
    :label-for="fieldName"
    label="This is an open slot to leave any details, questions, comments, clarifications, or criticisms."
    custom-class="is-medium"
  >
    <b-input
      :value="value"
      :name="fieldName"
      type="textarea"
      rows="2"
    />
  </b-field>
</template>

<script>
export default {
  props: {
    fieldName: String,
    value: String,
  },
}
</script>
