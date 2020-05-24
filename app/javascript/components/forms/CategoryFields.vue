<template>
  <div>
    <slot />

    <div v-for="{id, name, description, subcategories} in categories" :key="id">
      <b-checkbox
        v-model="selectedTags"
        :name="fieldNamePrefix"
        :native-value="name"
        size="is-medium"
      >
        {{ name | capitalize }}
      </b-checkbox>

      <div
        v-if="isSelected(name)"
        style="margin-left: 36px"
      >
        <p v-if="description" class="help mb-1"> {{ description }} </p>

        <CategoryFields
          :fieldNamePrefix="fieldNamePrefix"
          :categories="subcategories"
          :tags="selectedTags"
        />
      </div>
    </div>
  </div>
</template>

<script>
import {capitalize} from 'utils/string'

export default {
  name: 'CategoryFields',
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
  methods: {
    isSelected(tag) {
      return this.selectedTags.indexOf(tag) >= 0
    },
  },
  filters: { capitalize },
}
</script>
