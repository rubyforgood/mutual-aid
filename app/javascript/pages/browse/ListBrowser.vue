<template>
  <div class="listBrowser">
    <h2 class="title">List view</h2>
    <table class="table table-hover table-curved table-condensed is-hoverable">
      <tr>
        <th>Categories</th>
        <th>Availability</th>
        <th>Location</th>
        <th>Details</th>
      </tr>
      <tr v-for="contribution in contributions" :key="contribution.id">
        <td><TagList :tags="contribution.category_tags" /></td>
        <td><TagList :tags="contribution.availability" tagClasses="is-light is-warning"/></td>
        <td><TagList :tags="[contribution.service_area]" /></td>
        <td>{{ contribution.title }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import TagList from 'components/TagList'

export default {
  props: {
    contributions: {type: Array, default: () => []},
    filters: Object,
  },
  components: {
    TagList,
  },
}
</script>
