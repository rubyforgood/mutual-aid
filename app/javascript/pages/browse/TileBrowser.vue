<template>
  <section class="tileBrowser">
    <ul class="columns is-multiline is-centered">
      <TileListItem
        v-for="contribution in contributions"
        :key="contribution.key"
        v-bind="contribution"
        class="column is-one-quarter"
      />
    </ul>
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
