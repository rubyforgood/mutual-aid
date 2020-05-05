<template>
  <div>
    <section>
      <Filters :filterCategories="filterCategories"/>

      <BrowserSelector :browser="browser" @clicked="browser = $event" />
      <component :is="browser" :filters="filters" :contributions="contributions" />
    </section>
  </div>
</template>

<script>
import BrowserSelector from './browse/BrowserSelector'
import Filters from './browse/Filters'
import ListBrowser from './browse/ListBrowser'
import TileBrowser from './browse/TileBrowser'

export default {
  components: {
    BrowserSelector,
    Filters,
    ListBrowser,
    TileBrowser,
  },
  props: {
    contributions: {type: Array},
  },
  data() {
    return {
      browser: TileBrowser,
      filterCategories: [
        {
          name: 'Urgency',
          subcategories: [
            {id: 'Urgency-0', name: 'Within 1-2 days'},
            {id: 'Urgency-1', name: 'I can wait a week'},
          ],
        },
        {
          name: 'Locations',
          subcategories: [
            {id: 'Locations-0', name: 'Acme Township'},
            {id: 'Locations-1', name: 'East Bay'},
            {id: 'Locations-2', name: 'Garfield Township'},
          ],
        },
        {
          name: 'Type',
          subcategories: [
            {id: 'Type-0', name: 'Ask'},
            {id: 'Type-1', name: 'Offer'},
            {id: 'Type-2', name: 'Community Resource'},
          ],
        },
      ],
    }
  },
}
</script>
