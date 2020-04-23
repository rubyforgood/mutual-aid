<template>
  <div class="buttons has-addons">
    <button :disabled="showingTiles" @click="showTiles" id="show-tiles" class="button is-small">
      Tile view
    </button>
    <button :disabled="showingList"  @click="showList"  id="show-list"  class="button is-small">
      List view
    </button>
  </div>
</template>

<script>
import ListBrowser from './ListBrowser'
import TileBrowser from './TileBrowser'

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
  },
  methods: {
    showTiles() {
      this.$emit('clicked', TileBrowser)
    },
    showList() {
      this.$emit('clicked', ListBrowser)
    },
  }
}
</script>
