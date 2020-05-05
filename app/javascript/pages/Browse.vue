<template>
  <div>
    <section>
      <Filters :filterCategories="filterCategories" v-model="activeFilters" />

      <BrowserSelector :browser="browser" @clicked="browser = $event" />
      <component :is="browser" :contributions="activeContributions" />
    </section>
  </div>
</template>

<script>
import BrowserSelector from './browse/BrowserSelector'
import Filters from './browse/Filters'
import ListBrowser from './browse/ListBrowser'
import TileBrowser from './browse/TileBrowser'
import ContributionFetcher from './browse/ContributionFetcher'

export default {
  components: {
    BrowserSelector,
    Filters,
    ListBrowser,
    TileBrowser,
  },
  props: {
    contributions: {type: Array},
    filterCategories: {type: Array},
    initialFilters: {type: Array, default: () => []},
    fetcher: {
      type: Object,
      default: () => {
        return new ContributionFetcher('/listings.json?')
      },
    },
  },
  data() {
    return {
      browser: TileBrowser,
      activeFilters: this.initialFilters,
      activeContributions: this.contributions,
    }
  },
  watch: {
    activeFilters: 'updateContributions',
  },
  methods: {
    updateContributions() {
      if (this.activeFilters == this.initialFilters) {
        return (this.activeContributions = this.contributions)
      }
      this.fetcher.fetch(this.activeFilters, this.activeContributions).then((result) => {
        this.activeContributions = result.data
        this.flashIfError(result.error)
      })
    },
    flashIfError(e) {
      console.log(e)
    },
  },
}
</script>
