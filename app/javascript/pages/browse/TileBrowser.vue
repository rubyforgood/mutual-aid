<template>
  <section class="tileBrowser">
    <h2 class="title">Tile view</h2>
    <div>
      <ul class="columns">
        <TileListItem
          v-for="listing in listings"
          :key="listing.id"
          :helper="helper"
          :listing="listing"
          class="column"
        />
      </ul>
    </div>
  </section>
</template>

<script>
import TileListItem from './TileListItem'

export default {
  components: {
    TileListItem,
  },
  props: {
    listings: Array,
    locations: Array,
    helper: Object,
  },
}
</script>
