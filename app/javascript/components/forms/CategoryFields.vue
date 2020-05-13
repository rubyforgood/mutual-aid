<template>
  <div>
    <slot />

    <b-field v-for="{id, name} in categories" :key="id">
      <b-checkbox
        v-model="selectedTags"
        :name="fieldNamePrefix"
        :native-value="name"
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
    tags: Array,
  },
  data() {
    return {
      selectedTags: this.tags || []
    }
  },
  filters: { capitalize },
}
</script>
