<template>
  <div>
    <div class="intro">
      <h1 class="title">Community Contributions</h1>
      <p class="subtitle is-5">Below are contributions (asks, offers, and community resources) that are available.
        <br>You can filter through them by choosing filter options on the side.
      </p>
    </div>

    <div class="madlibs">
      <p>
        <span class="madlibs-inline">I am </span>
        <b-select v-model="contributionTypeFilter">
          <option
            v-for="[id, option] in Object.entries(contributionTypes)"
            :value="id"
            :key="id"
          >
            {{ option }}
          </option>
        </b-select>
        <span class="madlibs-inline"> with </span>
        <b-select v-model="contributionCategoryFilter">
          <option
            v-for="[id, category] in Object.entries(contributionCategories)"
            :value="id"
            :key="id"
          >
            {{ category }}
          </option>
        </b-select>
        <span class="madlibs-inline">. I live near </span>
        <b-select v-model="contributionServiceAreaFilter">
          <option
            v-for="[id, serviceArea] in Object.entries(contributionServiceAreas)"
            :value="id"
            :key="id"
          >
            {{ serviceArea }}
          </option>
        </b-select>
        <span class="madlibs-inline">and I need help</span>
        <b-select v-model="contributionTimeFrameFilter">
          <option
            v-for="[id, timeFrame] in Object.entries(contributionTimeFrames)"
            :value="id"
            :key="id"
          >
            {{ timeFrame }}
          </option>
        </b-select>
      </p>
    </div>

    <section class="section columns">
      <section class="column is-one-quarter">
        <BrowserSelector :browser="browser" @clicked="browser = $event" />

        <Filters :filterTypes="filterTypes" v-model="activeFilters" />
      </section>
      <component :is="browser" :contributions="activeContributions" class="column" />
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
    filterTypes: {type: Array, default: ()=>[]},
    initialFilters: {
      type: Array,
      default: function () {
        return [].concat(
          ...this.filterTypes.map((fType) => fType.filters.map((filter) => filter.id))
        )
      },
    },
    fetcher: {
      type: Object,
      default: () => {
        return new ContributionFetcher('/contributions.json?')
      },
    },
  },
  data() {
    return {
      browser: TileBrowser,
      activeFilters: this.initialFilters,
      activeContributions: this.contributions,
      contributionCategories: {},
      contributionCategoryFilter: 'any',
      contributionServiceAreas: {},
      contributionServiceAreaFilter: 'anywhere',
      contributionTimeFrames: {},
      contributionTimeFrameFilter: 0,
      contributionTypeFilter: 'any',
      contributionTypes: this.fetcher.types()
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
        if (result.error) this.flashIfError(result.error)
      })
    },
    updateContributionFilters(contributions) {
      let categories = { any: 'any category' }
      let serviceAreas = { anywhere: '(anywhere)' }
      let urgencies = {}
      contributions.forEach(contribution => {
        serviceAreas[contribution.service_area.id] = contribution.service_area.name
        urgencies[contribution.urgency.id] = contribution.urgency.name
        contribution.category_tags.forEach(tag => {
          categories[tag.id] = tag.name
        })
      })
      this.contributionCategories = categories
      this.contributionServiceAreas = serviceAreas
      this.contributionTimeFrames = urgencies
      // this.contributionCategories = [{0: 'any category'}, ...new Set(this.activeContributions.map(contribution => contribution.category_tags).flat(1))]
    },
    flashIfError(e) {
      console.log(e)
    },
  },
  created: function() {
    this.updateContributionFilters(this.activeContributions)
  },
}
</script>

<style scoped>
.madlibs {
  padding-top: 1em;
  font-size: 18pt;
}

.madlibs-inline {
  display: inline-block;
  vertical-align: middle;
}

.control {
  display: inline-block;
  vertical-align: middle;
}
</style>