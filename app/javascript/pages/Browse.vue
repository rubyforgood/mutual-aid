<template>
  <div>
    <section>
      <Filters />
      <component
        :is="browser"
        :filters="filters"
        :listings="listings"
      />
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
    categories: {type: Array},
    filters:    {type: Object},
    listings:   {type: Array},
    locations:  {type: Array},
  },
  data() {
    return {
      browser: TileBrowser,
    }
  },
}
</script>
