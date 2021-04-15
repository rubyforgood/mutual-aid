<template>
  <section>
    <b-collapse :open="false" id="collapse-filters">
      <span class="subtitle is-4" slot="trigger" slot-scope="props">
        <b-icon :icon="props.open ? 'caret-down' : 'caret-right'"></b-icon>
        Filters
      </span>
      <div class="field mt-1">
        <b-checkbox
          id='toggle-all-filters'
          @input="toggleAllFilters"
          :value="allFiltersSelected"
          :indeterminate="indeterminateAll"
          >Select all</b-checkbox
        >
      </div>
      <div class="columns">
        <b-collapse
          class="column"
          v-for="(filterGrouping, index) of filterGroupings"
          :key="index"
          :open="initialOpenStatus(index)"
        >
          <span class="subtitle is-5" slot="trigger" slot-scope="props">
            {{ filterGrouping.name }} <a>{{ props.open ? '-' : '+' }}</a>
          </span>
          <b-checkbox
            :id="`toggle-filters-${filterGrouping.name}`"
            @input="toggleFilters(filterGrouping.filter_options)"
            :value="filterGroupingSelectAllValue(filterGrouping.filter_options)"
            :indeterminate="indeterminate(filterGrouping.filter_options)"
          >
            Select all
          </b-checkbox>
          <ul class="mt-1">
            <li v-for="filterOption of filterGrouping.filter_options" :key="filterOption.id">
              <b-checkbox
                :native-value="filterOption.id"
                :value="currentFilters"
                @input="$emit('change', $event)"
              >
                {{ filterOption.name }}
                <MappedIconList
                  :iconTypes="[{id: filterOption.name, name: filterOption.name}]"
                  v-if="showIconsForFilter(filterOption.name)"
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

// TODO: consider extracting a FilterGrouping component.
// see this comment: https://github.com/rubyforgood/mutual-aid/pull/799#pullrequestreview-554188100
export default {
  components: {MappedIconList},
  props: {
    filterGroupings: {type: Array, default: () => []},
    currentFilters: {type: Array, default: () => []},
  },
  model: {
    prop: 'currentFilters',
    event: 'change',
  },
  computed: {
    allFiltersSelected: function () {
      return this.allFilters.length === this.currentFilters.length
    },
    indeterminateAll: function () {
      return this.currentFilters.length == 0
        ? false
        : this.currentFilters.length < this.allFilters.length
    },
  },
  methods: {
    initialOpenStatus(index) {
      // return index < 2
      return true
    },
    showIconsForFilter(filterName) {
      return !!this.hasFilterIcons[filterName]
    },
    currentFiltersOptionsForFilterGrouping(filterOptionIds) {
      return this.currentFilters.filter((el) => filterOptionIds.includes(el))
    },
    filterGroupingSelectAllValue(filters) {
      let filterIds = filters.map((f) => f.id)
      return this.currentFiltersOptionsForFilterGrouping(filterIds).length == filterIds.length
    },
    indeterminate(filters) {
      let filterIds = filters.map((f) => f.id)
      return this.currentFiltersOptionsForFilterGrouping(filterIds).length == 0
        ? false
        : this.currentFiltersOptionsForFilterGrouping(filterIds).length < filterIds.length
    },
    toggleFilters(filters) {
      let filterIds = filters.map((f) => f.id)
      if (this.currentFiltersOptionsForFilterGrouping(filterIds).length < filterIds.length) {
        this.$emit('change', [...new Set([...this.currentFilters, ...filterIds])])
      } else {
        this.$emit(
          'change',
          this.currentFilters.filter((el) => !filterIds.includes(el))
        )
      }
    },
    toggleAllFilters() {
      if (this.currentFilters.length < this.allFilters.length) {
        this.$emit('change', this.allFilters)
      } else {
        this.$emit('change', [])
      }
    },
  },
  data() {
    return {
      hasFilterIcons: this.filterGroupings
        .map((fGrouping) => fGrouping.filter_options)
        .reduce(function (memo, filterOptions) {
          filterOptions.map(function (fOption) {
            memo[fOption.name] = MappedIconList.iconNameMapping[fOption.name]
          })
          return memo
        }, {}),
      allFilters: [].concat(
        ...this.filterGroupings.map((fGrouping) => fGrouping.filter_options.map((fOption) => fOption.id))
      ),
    }
  },
}
</script>
