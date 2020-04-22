<template>
  <div>
    <section>
      <Filters />
    </section>
    <section v-if="showGrid">
      <GridBrowser :listings="listings" :filters="filters" />
    </section>
    <section v-else-if="showList">
      <ListBrowser :listings="listings" :filters="filters" />
    </section>
  </div>
</template>

<script>
import Filters from './browse/Filters'
import GridBrowser from '../components/GridBrowser'
import ListBrowser from '../components/ListBrowser'

export default {
  components: {Filters, GridBrowser, ListBrowser},
  props: {
    listings: {type: Array},
    categories: {type: Array},
    timings: {type: Array},
    locations: {type: Array},
    filters: {type: Object},
    showList: {type: Boolean, default: true},
    showGrid: {type: Boolean, default: false},
  },
}
</script>
