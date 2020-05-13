<template>
  <b-field
    :label-for="fieldName"
    label="Name"
    custom-class="required-field is-medium"
    message="If you would like, please indicate pronouns"
  >
    <b-input
      :value="value"
      :name="fieldName"
      required
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
