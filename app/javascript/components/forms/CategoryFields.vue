<template>
  <div>
    <p class="title is-4">What are you able to offer?</p>
    <p>
    Note: Risks and best practices will be discussed before any work is done.
    People over 50 and people with vulnerable conditions should be especially cautious in these times,
    so this option will not be right for everyone.
    </p>
    <p class="mt-1 mb-1">
    Your safety is community safety. Do what is best.
    </p>

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
