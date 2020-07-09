<template>
  <div>
    <slot />

    <div v-for="{id, name, description, subcategories} in normalizedCategories" :key="id">
      <b-collapse
        :id="`collapse-${id}`"
        :aria-id="`collapse-content-${id}`"
        :open="isSelected(name)"
        class="card"
        animation="slide"
      >
        <div
          :aria-controls="`collapse-content-${id}`"
          slot="trigger"
          slot-scope="collapse"
          class="card-header"
          role="button"
        >
          <p class="card-header-title has-text-weight-normal is-size-4">
          {{ name | capitalize }}
          </p>
          <a class="card-header-icon">
            <b-icon :icon="collapse.open ? 'angle-up' : 'angle-down'" />
          </a>
        </div>

        <div class="card-content">
          <p v-if="description" class="mb-1"> {{ description }} </p>

          <!-- If any subcategories are selected, add parent category to list of tags submitted -->
          <input v-if="anySelected(subcategories)" :name="fieldNamePrefix" :value="name" type="hidden" />

          <div v-for="{id: subId, name: subName, description: subDescription} in subcategories" :key="subId">
            <b-field class="pb-05" grouped>
              <b-checkbox
                v-model="selectedTags"
                :name="fieldNamePrefix"
                :native-value="subName"
                size="is-medium"
              >
                <span>{{ subName | capitalize }}</span>
                <span v-if="subDescription" class="is-size-6"> {{ "- " + subDescription }} </span>
              </b-checkbox>

            </b-field>
          </div>
        </div>
      </b-collapse>
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
      selectedTags: this.tags || [],
    }
  },
  computed: {
    normalizedCategories() {
      this.categories.forEach(({id, name, subcategories}) => {
        if (!subcategories.length) {
          subcategories.push({id, name})
        }
      })
      return this.categories
    },
  },
  methods: {
    isSelected(tag) {
      return this.selectedTags.indexOf(tag) >= 0
    },
    anySelected(subcategories) {
      return subcategories.find(({name}) => this.isSelected(name))
    },
  },
  filters: { capitalize },
}
</script>
