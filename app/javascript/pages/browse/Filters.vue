<template>
  <section>
    <h5 class="subtitle is-5">Filters</h5>

    <b-collapse v-for="(type, index) of filterTypes" :key="index" :open="initialOpenStatus(index)">
      <h4 slot="trigger" slot-scope="props">
        {{ type.name }} <a>{{ props.open ? '-' : '+' }}</a>
      </h4>
      <ul>
        <li v-for="filter of type.filters" :key="filter.id">
          <b-checkbox
            :native-value="filter.id"
            :value="currentFilters"
            @input="$emit('change', $event)"
          >
            {{ filter.name }}
            <MappedIconList :iconTypes="[{id: filter.name, name: filter.name}]" v-if="showIconsForFilter(filter.name)"  class="is-inline"/>
          </b-checkbox>
        </li>
      </ul>
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
      return index === 0
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
