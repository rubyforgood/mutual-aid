<template>
  <section>
    <b-collapse :open="false" id="collapse-filters">
      <span
        class="subtitle is-4"
        slot="trigger"
        slot-scope="props"
      >
        <b-icon :icon="props.open ? 'caret-down' : 'caret-right'"></b-icon>
        Filters
      </span>

      <div class="columns mt-1">
        <b-collapse
          class="column"
          v-for="(type, index) of filterTypes"
          :key="index"
          :open="initialOpenStatus(index)"
        >
          <span
            class="subtitle is-5"
            slot="trigger"
            slot-scope="props"
          >
            {{ type.name }} <a>{{ props.open ? '-' : '+' }}</a>
          </span>
          <ul class="mt-1">
            <li v-for="filter of type.filters" :key="filter.id">
              <b-checkbox
                :native-value="filter.id"
                :value="currentFilters"
                @input="$emit('change', $event)"
              >
                {{ filter.name }}
                <MappedIconList
                  :iconTypes="[{id: filter.name, name: filter.name}]"
                  v-if="showIconsForFilter(filter.name)"
                  class="is-inline"
                />
              </b-checkbox>
            </li>
          </ul>
        </b-collapse>
      </div>
    </b-collapse>
  </section>
</template>

<script>
import MappedIconList from 'components/MappedIconList'

export default {
  components: {MappedIconList},
  props: {
    filterTypes: {type: Array, default: () => []},
    currentFilters: {type: Array, default: () => []},
  },
  model: {
    prop: 'currentFilters',
    event: 'change',
  },
  methods: {
    initialOpenStatus(index) {
      // return index < 2
      return true
    },
    showIconsForFilter(filterName) {
      return !!this.hasFilterIcons[filterName]
    },
  },
  data() {
    return {
      hasFilterIcons: this.filterTypes
        .map((type) => type.filters)
        .reduce(function (memo, filters) {
          filters.map(function (filter) {
            memo[filter.name] = MappedIconList.iconNameMapping[filter.name]
          })
          return memo
        }, {}),
    }
  },
}
</script>
