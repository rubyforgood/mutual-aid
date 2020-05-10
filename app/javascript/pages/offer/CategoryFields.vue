<template>
  <div>
    <b-field v-for="{id, name} in categories" :key="id">
      <b-checkbox
        v-model="selectedCategories"
        :name="fieldNamePrefix"
        :native-value="id"
        size="is-medium"
      >
        {{ name | capitalize }}
      </b-checkbox>
    </b-field>
  </div>
</template>

<script>
import {capitalize} from 'utils/string'

export default {
  props: {
    fieldNamePrefix: String,
    categories: Array,
    selected_categories: Array,
  },
  data() {
    return {
      selectedCategories: this.selected_categories || []
    }
  },
  filters: { capitalize },
}
</script>
