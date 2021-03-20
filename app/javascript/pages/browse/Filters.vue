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
          v-for="(filterGroup, index) of filterGroups"
          :key="index"
          :open="initialOpenStatus(index)"
        >
          <span class="subtitle is-5" slot="trigger" slot-scope="props">
            {{ filterGroup.name }} <a>{{ props.open ? '-' : '+' }}</a>
          </span>
          <b-checkbox
            :id="`toggle-filters-${filterGroup.name}`"
            @input="toggleFilters(filterGroup.filter_options)"
            :value="filterGroupSelectAllValue(filterGroup.filter_options)"
            :indeterminate="indeterminate(filterGroup.filter_options)"
          >
            Select all
          </b-checkbox>
          <ul class="mt-1">
            <li v-for="filterOption of filterGroup.filter_options" :key="filterOption.id">
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

// TODO: consider extracting a FilterGroup component.
// see this comment: https://github.com/rubyforgood/mutual-aid/pull/799#pullrequestreview-554188100
export default {
  components: {MappedIconList},
  props: {
    filterGroups: {type: Array, default: () => []},
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
    currentFiltersOptionsForFilterGroup(filterOptionIds) {
      return this.currentFilters.filter((el) => filterOptionIds.includes(el))
    },
    filterGroupSelectAllValue(filters) {
      let filterIds = filters.map((f) => f.id)
      return this.currentFiltersOptionsForFilterGroup(filterIds).length == filterIds.length
    },
    indeterminate(filters) {
      let filterIds = filters.map((f) => f.id)
      return this.currentFiltersOptionsForFilterGroup(filterIds).length == 0
        ? false
        : this.currentFiltersOptionsForFilterGroup(filterIds).length < filterIds.length
    },
    toggleFilters(filters) {
      let filterIds = filters.map((f) => f.id)
      if (this.currentFiltersOptionsForFilterGroup(filterIds).length < filterIds.length) {
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
      hasFilterIcons: this.filterGroups
        .map((fGroup) => fGroup.filter_options)
        .reduce(function (memo, filterOptions) {
          filterOptions.map(function (fOption) {
            memo[fOption.name] = MappedIconList.iconNameMapping[fOption.name]
          })
          return memo
        }, {}),
      allFilters: [].concat(
        ...this.filterGroups.map((fGroup) => fGroup.filter_options.map((fOption) => fOption.id))
      ),
    }
  },
}
</script>
