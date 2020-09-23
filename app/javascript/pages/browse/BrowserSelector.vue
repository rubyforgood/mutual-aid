<template>
  <div class="buttons has-addons">
    <button :disabled="showingTiles" @click="showTiles" id="show-tiles" class="button is-small">
      Tile view
    </button>
    <button :disabled="showingList"  @click="showList"  id="show-list"  class="button is-small">
      List view
    </button>
    <button :disabled="showingMap"  @click="showMap"  id="show-map"  class="button is-small">
      Map view
    </button>
  </div>
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
