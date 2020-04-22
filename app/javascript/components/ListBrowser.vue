<template>
  <div class="listBrowser">
    <table class='table table-hover table-curved table-condensed is-hoverable'>
      <tr>
        <th>Categories</th>
        <th>Timing</th>
        <th>Availability</th>
        <th>Location</th>
        <th>Details</th>
      </tr>
      <tr v-for="listing in listings" :key="listing.id">
        <td>{{ listing.tegories }}</td>
        <td>{{ listing.timings}}</td>
        <td>{{ listing.availability}}</td>
        <td>{{ listing.location}}</td>
        <td><!-- details component goes here --></td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  props: {
    listings: {type: Array},
    filters: {type: Object},
  }
}
</script>