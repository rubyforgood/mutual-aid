<template>
  <div>
    <section>
      <Filters />

      <BrowserSelector :browser="browser" @clicked="browser = $event" />
      <component
        :is="browser"
        :filters="filters"
        :listings="listings"
        :helper="listingDataAdapter"
      />

    </section>
  </div>
</template>

<script>
import BrowserSelector from './browse/BrowserSelector'
import Filters from './browse/Filters'
import ListBrowser from './browse/ListBrowser'
import TileBrowser from './browse/TileBrowser'
import ListingDataAdapter from './browse/ListingDataAdapter'

export default {
  components: {
    BrowserSelector,
    Filters,
    ListBrowser,
    TileBrowser,
  },
  props: {
    categories: {type: Array, default: ()=>[]},
    filters:    {type: Object},
    listings:   {type: Array},
    locations:  {type: Array, default: ()=>[]},
  },
  computed: {
    listingDataAdapter: function() {
      return new ListingDataAdapter({categories: this.categories, locations: this.locations})
    }
  },
  data() {
    return {
      browser: TileBrowser,
    }
  },
}
</script>
