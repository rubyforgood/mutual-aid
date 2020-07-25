<template>
  <div>
    <b-field
      v-for="{id, name} in questions"
      :key="id"
      :label-for="fieldName(id)"
      :label="name"
      custom-class="is-medium"
    >
      <b-input :name="fieldName(id)" />
    </b-field>
  </div>
</template>

<script>
import {fieldNameWithPrefix} from 'utils/form'

export default {
  props: {
    questions: Array,
    fieldNamePrefix: String,
  },
  methods: {
    fieldName(id) {
      return fieldNameWithPrefix(this.fieldNamePrefix, id.toString())
    },
  },
}
</script>
