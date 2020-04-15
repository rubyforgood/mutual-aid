<template>
  <div>
    <div class='listing-body'>
      <div class='control-bar'>
        <div class='control-bar-right-buttons buttons has-addons is-pulled-right'>
          <div class='button icon-list' v-bind:class='{"is-selected is-info": showingList}'>List</div>
          <div class='button icon-grid' v-bind:class='{"is-selected is-info": showingGrid}'>Grid</div>
          <div class='button icon-map' v-bind:class='{"is-selected is-info": showingMap}'>Map</div>
        </div>
      </div>
      <div class='listing-grid'>
        <div class='listing-grid-nav-left is-pulled-left'>
          <div class='listing-grid-nav-block' v-for="grouping in groupingTypes" :key="grouping.name">
            <div class='listing-grid-nav-block-title title is-5'>{{ grouping.name}}</div>
            <ul class='listing-grid-nav-list' v-for="item in grouping.items" :key="item.name">
              <li class='listing-grid-nav-list-item'><input type='checkbox' /> {{ item.name }} </li>
            </ul>
          </div>
        </div>
        <table class='table table-hover table-curved table-condensed'>
          <tr>
            <th>Location</th>
            <th>Categories</th>
            <th>Availability</th>
            <th>Urgency</th>
            <th>Expiration Date</th>
          </tr>
          <tr v-for="listing in listings" :key="listing.id">
            <td>{{ listing.location }}</td>
            <td>{{ listing.tags }}</td>
            <td>{{ listing.availability }}</td>
            <td>{{ listing.urgency }}</td>
            <td>{{ listing.expiration }}</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    showingGrid: { type: Boolean, default: true},
    groups: { type: Object }
  },
  data() {
    let data = {}
    data.errors = ["Listings not yet fetched"]
    data.listings = []
    data.urls = {}
    data.groupingTypes = []
    return data
  },
  created() {
    var _this = this
    var itemList = [
      // Hard coded for now to test functionality
      'Acme Township',
      'Blair Township',
      'East Bay Township',
      'Fife Lake / Fife Lake Township',
      'Garfield Township',
      'Grant Township',
      'Green Lake Township',
      'Kingsley / Paradise Township',
      'Long Lake Township',
      'Mayfield Township',
      'Peninsula Township',
      'Traverse City',
      'Union Township',
      'Whitewater Township'
    ]
    itemList = itemList.map(function(value){ return {name: value}})
    _this.groupingTypes = [
      { name: 'Tags', items: [
        {name: 'meals'},{name: 'errands'}, {name: 'care'}, {name: 'services'}, {name: 'housing'}, {name: 'cash'}
      ]},
      { name: 'Neighborhoods', items: itemList}
    ]
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
