<template>
  <section class="tileBrowser">
    <h2 class="title">Tile view</h2>
    <div>
      <ul class="columns">
        <TileListItem
          v-for="contribution in contributions"
          :key="contribution.id"
          v-bind="contribution"
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
    contributions: Array,
  },
}
</script>
