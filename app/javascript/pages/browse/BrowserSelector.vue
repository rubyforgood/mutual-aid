<template>
  <b-navbar aria-label="contributions navigation" class="mb-3 subnav">
    <template slot="start">
      <b-navbar-item :active="showingTiles" @click="showTiles" id="show-tiles">
        <b-icon icon="th-large"></b-icon>
        <div class="ml-1">Tile View</div>
      </b-navbar-item>
      <b-navbar-item :active="showingList" @click="showList"  id="show-list">
          <b-icon icon="th-list"></b-icon>
          <div class="ml-1">List View</div>
      </b-navbar-item>
      <b-navbar-item :active="showingMap" @click="showMap"  id="show-map">
          <b-icon icon="map-marked-alt"></b-icon>
          <div class="ml-1">Map View</div>
      </b-navbar-item>
    </template>
  </b-navbar>
</template>

<script>
import ListBrowser from './ListBrowser'
import TileBrowser from './TileBrowser'
import MapBrowser from './MapBrowser'

export default {
  props: {
    browser: Object
  },
  computed: {
    showingTiles() {
      return this.browser === TileBrowser
    },
    showingList() {
      return this.browser === ListBrowser
    },
    showingMap() {
      return this.browser === MapBrowser
    }
  },
  methods: {
    showTiles() {
      this.$emit('clicked', TileBrowser)
    },
    showList() {
      this.$emit('clicked', ListBrowser)
    },
    showMap() {
      this.$emit('clicked', MapBrowser)
    }
  }
}
</script>
