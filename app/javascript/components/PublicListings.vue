<template>
  <div>
    <div class='listing-body'>
      <table>
        <tr>
          <th>Created At</th>
          <th>Name</th>
          <th>Location</th>
          <th>Details</th>
        </tr>
        <tr v-for="listing in listings" :key="listing.id">
          <td>{{ listing.created_at }}</td>
          <td>{{ listing.name }}</td>
          <td></td>
          <td></td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    let data = {}
    data.errors = ["Listings not yet fetched"]
    data.listings = []
    data.urls = {}
    return data
  },
  created() {
    var _this = this
    fetch('/listings.json')
      .then( result => result.json())
      .then( json => {
        _this.listings = json.listings
        _this.urls = json.urls
        _this.errors = []
      })
      .catch( error => {
        _this.errors.push(error)
      })
  }
}
</script>
