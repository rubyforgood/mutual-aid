<template>
  <div>
    <section>
      <Filters />
    </section>
    <section v-if="showTiles">
      <TileBrowser :listings="listings" :filters="filters" />
    </section>
    <section v-else-if="showList">
      <ListBrowser :listings="listings" :filters="filters" />
    </section>
  </div>
</template>

<script>
import Filters from './browse/Filters'
import TileBrowser from './browse/TileBrowser'
import ListBrowser from './browse/ListBrowser'

export default {
  components: {Filters, TileBrowser, ListBrowser},
  props: {
    listings: {type: Array},
    categories: {type: Array},
    locations: {type: Array},
    filters: {type: Object},
    showList: {type: Boolean, default: false},
    showTiles: {type: Boolean, default: true},
  },
}
</script>
