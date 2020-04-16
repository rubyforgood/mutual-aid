<template>
  <div class='listing-body'>
    <div class='listing-grid columns'>
        <div class='listing-grid-nav-left is-pulled-left column is-3 box'>
          <div class='column'>
            <div class='column is-12'>
              <div class='listing-grid-header title is-4'>FILTERS</div>
              <div class='listing-grid-nav-block' v-for="grouping in groupingTypes" :key="grouping.name">
              <div class='listing-grid-nav-block-title title is-6'>{{ grouping.name}}</div>
              <ul class='listing-grid-nav-list' v-for="item in grouping.items" :key="item.name">
                <li class='listing-grid-nav-list-item'>
                  <input type='checkbox' /> {{ item.name }} <span class='tag is-light is-rounded'>42</span>
                </li>
              </ul>
              <br>
            </div>
            </div>
          </div>
        </div>
        <div class='listing-grid-content column'>
          <div class='control-bar box'>
            <div class='control-bar-title-row columns'>
              <div class='column is-2'>
                <div class='title is-4'>ASKS</div>
              </div>
              <div class='column is-4'>
                <div class="control has-icons-left has-icons-right">
                  <input class="input" type="search" placeholder="Search">
                  <span class="icon is-small is-left">
                    <i class="fa fa-search"></i>
                  </span>
                </div>
              </div>
              <div class='column is-4'>
                <div class='control-bar'>
                  <div class='control-bar-right-buttons buttons has-addons is-pulled-right'>
                    <div class='button icon-list' v-bind:class='{"is-selected is-outlined is-primary": showingList}'>List</div>
                    <div class='button icon-grid' v-bind:class='{"is-selected is-outlined is-primary": showingGrid}'>Grid</div>
                    <div class='button icon-map' v-bind:class='{"is-selected is-outlined is-primary": showingMap}'>Map</div>
                  </div>
                </div>
              </div>
            </div>
            <div class='control-bar-hint-row columns'>
              <div class='column is-3'>
                <em><a href='/listings/offers'>Switch to Offers</a></em>
              </div>
              <div class='column is-7 is-pull-right has-text-right'>
                <em><a href='/listings/asks'>Expand all</a></em>
              </div>
            </div>
          </div>
          <div class='table list box'>
            <table class='table table-hover table-curved table-condensed is-hoverable'>
              <tr>
                <th>Location</th>
                <th>Tags</th>
                <th>Timing</th>
                <th>Availability</th>
                <th>Owner</th>
                <th>Action</th>
                <th></th>
              </tr>
              <tr>
                <td>East Bay</td>
                <td>
                  <span class='tag is-primary is-light'>Care</span>
                  <span class='tag is-primary is-light'>Animal care</span>
                </td>
                <td>
                  <span class='tag is-warning is-light'>This week</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-building"></i></span></td>
                <td><span class=""><i class="fa fa-angle-double-right"></i> View</span></td>
                <td><span class='button icon-list is-primary'>Connect</span></td>
              </tr>
              <tr>
                <td>Traverse City</td>
                <td>
                  <span class='tag is-primary is-light'>Services</span>
                  <span class='tag is-primary is-light'>Transportation</span>
                </td>
                <td>
                  <span class='tag is-warning is-light'>Anytime</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-user-circle"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
                <td><span class=""><i class="fa fa-angle-double-right"></i> More</span></td>
              </tr>
              <tr>
                <td>Petosky</td>
                <td>
                  <span class='tag is-primary is-light'>Services</span>
                  <span class='tag is-primary is-light'>Housework</span>
                </td>
                <td>
                  <span class='tag is-warning'><i class="fa fa-warning"></i> This week</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-user"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
              </tr>
              <tr>
                <td>Benzie</td>
                <td>
                  <span class='tag is-primary is-light'>Care</span>
                  <span class='tag is-primary is-light'>Elder care</span>
                </td>
                <td>
                  <span class='tag is-warning is-light'>Anytime</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i>  AM</span></td>
                <td><span class="tag is-light"><i class="fa fa-user-circle"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
              </tr>
              <tr>
                <td>Traverse City</td>
                <td><span class='tag is-primary is-light'>Care</span></td>
                <td>
                  <span class='tag is-warning'><i class="fa fa-warning"></i> Next week</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-user"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
              </tr>
              <tr v-for="listing in listings" :key="listing.id">
                <td>{{ listing.location || "Acme" }}</td>
                <td><span class='tag is-primary is-light'>{{ listing.tags || "Errands" }}</span></td>
                <td>
                  <span class='tag is-warning is-light'>{{ listing.expiration || "Next week" }}</span>
                  <span class="">{{ listing.urgency }}</span>
                  <span class="tag is-warning is-light"><i class="fa fa-sun"></i></span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> {{ listing.availability || " AM,EVE" }}</span></td>
                <td><span class="tag is-light">{{ listing.type }}<i class="fa fa-user-circle"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
              </tr>

              <tr><td></td><td></td><td></td><td></td><td></td></tr>
              <tr><td></td><td></td><td></td><td></td><td></td></tr>

              <tr>
                <td>East Bay</td>
                <td><span class='tag is-primary is-light'>Care</span></td>
                <td>
                  <span class='tag is-warning is-light'>This week</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-building"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
                <td><span class='button icon-list is-primary is-outlined'>Match</span></td>
              </tr>
              <tr>
                <td>Traverse City</td>
                <td><span class='tag is-primary is-light'>Transportation</span></td>
                <td>
                  <span class='tag is-warning is-light'>Anytime</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-tag"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
                <td><span class='button icon-list is-primary is-outlined'>Match</span></td>
              </tr>
              <tr>
                <td>Petosky</td>
                <td><span class='tag is-primary is-light'>Services</span></td>
                <td>
                  <span class='tag is-warning'><i class="fa fa-warning"></i> This week</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-building"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
                <td><span class='button icon-list is-primary is-outlined'>Match</span></td>
              </tr>
              <tr>
                <td>Traverse City</td>
                <td><span class='tag is-primary is-light'>Transportation</span></td>
                <td>
                  <span class='tag is-warning is-light'>Anytime</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i> EVE</span></td>
                <td><span class="tag is-light"><i class="fa fa-user-circle"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
                <td><span class='button icon-list is-primary is-outlined'>Match</span></td>
              </tr>
              <tr>
                <td>Benzie</td>
                <td><span class='tag is-primary is-light'>Care</span></td>
                <td>
                  <span class='tag is-warning is-light'>Anytime</span>
                </td>
                <td><span class="tag is-light"><i class="fa fa-hourglass-start"></i>  AM</span></td>
                <td><span class="tag is-light"><i class="fa fa-tag"></i></span></td>
                <td><span class='button icon-list is-primary'>Contact</span></td>
                <td><span class='button icon-list is-primary is-outlined'>Match</span></td>
              </tr>
            </table>
          </div>
          <div class='table grid box'>
            <table class='table table-hover table-curved table-condensed is-hoverable'>
              <tr>
                <td>
                  <div class="card">
                    <header class="card-header">
                      <p class="card-header-title">
                        <span class='tag is-primary is-light'>Care</span>
                        <span class='tag is-primary is-light'>Animal care</span>
                      </p>
                      <a href="#" class="card-header-icon" aria-label="more options">
                        <span class='tag is-warning is-light'>This week</span>
                      </a>
                    </header>
                    <div class="card-content">
                      <div class="content">
                        <span class="tag">East Bay</span>
                        <span class="tag is-light"><i class="fa fa-building"></i></span>
                        <span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span>
                        <br>
                        <span class='title is-6'>Short title they entered for their ask (50 chars)</span>
                        <br>
                        Lorem ipsum Description they entered for their ask (100 chars) dolor sit amet, consectetur adipiscing elit. Asjeces nec iaculis mauris.
                         <br>
                        <span class="title is-7 is-italic has-text-grey"><time datetime="2016-1-1">April 10, 2020 @ 3:35 PM EST</time></span>
                        <span class="tag is-light"><i class="fa fa-map"></i> Near me?</span>
                        <span class="tag is-light"><i class="fa fa-phone"></i></span>
                        <span class="tag is-light"><i class="fa fa-mobile"></i></span>
                        <span class="tag is-light"><i class="fa fa-envelope"></i></span>
                        <i class="fa fa-facebook-messenger"></i>
                      </div>
                    </div>
                    <footer class="card-footer">
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>View Profile</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>Contact</span></span>
                      <!-- <span class="card-footer-item"><span class='button icon-list is-primary'>Contact</span></span> -->
                    </footer>
                  </div>
                </td>
                <td>
                <div class="card">
                    <header class="card-header">
                      <p class="card-header-title">
                        <span class='tag is-primary is-light'>Care</span>
                        <span class='tag is-primary is-light'>Animal care</span>
                      </p>
                      <a href="#" class="card-header-icon" aria-label="more options">
                        <span class='tag is-warning is-light'>This week</span>
                      </a>
                    </header>
                    <div class="card-content">
                      <div class="content">
                        <span class="tag">East Bay</span>
                        <span class="tag is-light"><i class="fa fa-building"></i></span>
                        <span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span>
                        <br>
                        <span class='title is-6'>Short title they entered for their ask (50 chars)</span>
                        <br>
                        Lorem ipsum Description they entered for their ask (100 chars) dolor sit amet, consectetur adipiscing elit. Asjeces nec iaculis mauris.
                         <br>
                        <span class="title is-7 is-italic has-text-grey"><time datetime="2016-1-1">April 10, 2020 @ 3:35 PM EST</time></span>
                        <span class="tag is-light"><i class="fa fa-map"></i> Near me?</span>
                        <span class="tag is-light"><i class="fa fa-phone"></i></span>
                        <span class="tag is-light"><i class="fa fa-mobile"></i></span>
                        <span class="tag is-light"><i class="fa fa-envelope"></i></span>
                        <i class="fa fa-facebook-messenger"></i>
                      </div>
                    </div>
                    <footer class="card-footer">
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>View Profile</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>Contact</span></span>
                      <!-- <span class="card-footer-item"><span class='button icon-list is-primary'>Contact</span></span> -->
                    </footer>
                  </div>
                </td>
                <td>
                <div class="card">
                    <header class="card-header">
                      <p class="card-header-title">
                        <span class='tag is-primary is-light'>Care</span>
                        <span class='tag is-primary is-light'>Animal care</span>
                      </p>
                      <a href="#" class="card-header-icon" aria-label="more options">
                        <span class='tag is-warning is-light'>This week</span>
                      </a>
                    </header>
                    <div class="card-content">
                      <div class="content">
                        <span class="tag">East Bay</span>
                        <span class="tag is-light"><i class="fa fa-building"></i></span>
                        <span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span>
                        <br>
                        <span class='title is-6'>Short title they entered for their ask (50 chars)</span>
                        <br>
                        Lorem ipsum Description they entered for their ask (100 chars) dolor sit amet, consectetur adipiscing elit. Asjeces nec iaculis mauris.
                         <br>
                        <span class="title is-7 is-italic has-text-grey"><time datetime="2016-1-1">April 10, 2020 @ 3:35 PM EST</time></span>
                        <span class="tag is-light"><i class="fa fa-map"></i> Near me?</span>
                        <span class="tag is-light"><i class="fa fa-phone"></i></span>
                        <span class="tag is-light"><i class="fa fa-mobile"></i></span>
                        <span class="tag is-light"><i class="fa fa-envelope"></i></span>
                        <i class="fa fa-facebook-messenger"></i>
                      </div>
                    </div>
                    <footer class="card-footer">
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>View Profile</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>Contact</span></span>
                      <!-- <span class="card-footer-item"><span class='button icon-list is-primary'>Contact</span></span> -->
                    </footer>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="card">
                    <header class="card-header">
                      <p class="card-header-title">
                        <span class='tag is-primary is-light'>Care</span>
                        <span class='tag is-primary is-light'>Animal care</span>
                      </p>
                      <a href="#" class="card-header-icon" aria-label="more options">
                        <span class='tag is-warning is-light'>This week</span>
                      </a>
                    </header>
                    <div class="card-content">
                      <div class="content">
                        <span class="tag">East Bay</span>
                        <span class="tag is-light"><i class="fa fa-building"></i></span>
                        <span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span>
                        <br>
                        <span class='title is-6'>Short title they entered for their ask (50 chars)</span>
                        <br>
                        Lorem ipsum Description they entered for their ask (100 chars) dolor sit amet, consectetur adipiscing elit. Asjeces nec iaculis mauris.
                         <br>
                        <span class="title is-7 is-italic has-text-grey"><time datetime="2016-1-1">April 10, 2020 @ 3:35 PM EST</time></span>
                        <span class="tag is-light"><i class="fa fa-map"></i> Near me?</span>
                        <span class="tag is-light"><i class="fa fa-phone"></i></span>
                        <span class="tag is-light"><i class="fa fa-mobile"></i></span>
                        <span class="tag is-light"><i class="fa fa-envelope"></i></span>
                        <i class="fa fa-facebook-messenger"></i>
                      </div>
                    </div>
                    <footer class="card-footer">
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>View Profile</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>Match</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'><i class="fa fa-edit is-outlined"></i></span></span>
                      <!-- <span class="card-footer-item"><span class='button icon-list is-primary'>Contact</span></span> -->
                    </footer>
                  </div>
                </td>
                <td>
                  <div class="card">
                    <header class="card-header">
                      <p class="card-header-title">
                        <span class='tag is-primary is-light'>Care</span>
                        <span class='tag is-primary is-light'>Animal care</span>
                      </p>
                      <a href="#" class="card-header-icon" aria-label="more options">
                        <span class='tag is-warning is-light'>This week</span>
                      </a>
                    </header>
                    <div class="card-content">
                      <div class="content">
                        <span class="tag">East Bay</span>
                        <span class="tag is-light"><i class="fa fa-building"></i></span>
                        <span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span>
                        <br>
                        <span class='title is-6'>Short title they entered for their ask (50 chars)</span>
                        <br>
                        Lorem ipsum Description they entered for their ask (100 chars) dolor sit amet, consectetur adipiscing elit. Asjeces nec iaculis mauris.
                         <br>
                        <span class="title is-7 is-italic has-text-grey"><time datetime="2016-1-1">April 10, 2020 @ 3:35 PM EST</time></span>
                        <span class="tag is-light"><i class="fa fa-map"></i> Near me?</span>
                        <span class="tag is-light"><i class="fa fa-phone"></i></span>
                        <span class="tag is-light"><i class="fa fa-mobile"></i></span>
                        <span class="tag is-light"><i class="fa fa-envelope"></i></span>
                        <i class="fa fa-facebook-messenger"></i>
                      </div>
                    </div>
                    <footer class="card-footer">
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>View Profile</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>Match</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'><i class="fa fa-edit is-outlined"></i></span></span>
                      <!-- <span class="card-footer-item"><span class='button icon-list is-primary'>Contact</span></span> -->
                    </footer>
                  </div>
                </td>
                <td>
                  <div class="card">
                    <header class="card-header">
                      <p class="card-header-title">
                        <span class='tag is-primary is-light'>Care</span>
                        <span class='tag is-primary is-light'>Animal care</span>
                      </p>
                      <a href="#" class="card-header-icon" aria-label="more options">
                        <span class='tag is-warning is-light'>This week</span>
                      </a>
                    </header>
                    <div class="card-content">
                      <div class="content">
                        <span class="tag">East Bay</span>
                        <span class="tag is-light"><i class="fa fa-building"></i></span>
                        <span class="tag is-light"><i class="fa fa-hourglass-start"></i> AM,PM,EVE</span>
                        <br>
                        <span class='title is-6'>Short title they entered for their ask (50 chars)</span>
                        <br>
                        Lorem ipsum Description they entered for their ask (100 chars) dolor sit amet, consectetur adipiscing elit. Asjeces nec iaculis mauris.
                         <br>
                        <span class="title is-7 is-italic has-text-grey"><time datetime="2016-1-1">April 10, 2020 @ 3:35 PM EST</time></span>
                        <span class="tag is-light"><i class="fa fa-map"></i> Near me?</span>
                        <span class="tag is-light"><i class="fa fa-phone"></i></span>
                        <span class="tag is-light"><i class="fa fa-mobile"></i></span>
                        <span class="tag is-light"><i class="fa fa-envelope"></i></span>
                        <i class="fa fa-facebook-messenger"></i>
                      </div>
                    </div>
                    <footer class="card-footer">
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>View Profile</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'>Match</span></span>
                      <span class="card-footer-item"><span class='button icon-list is-primary is-outlined'><i class="fa fa-edit is-outlined"></i></span></span>
                      <!-- <span class="card-footer-item"><span class='button icon-list is-primary'>Contact</span></span> -->
                    </footer>
                  </div>
                </td>
              </tr>
            </table>
          </div>
        </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    showingList: { type: Boolean, default: true},
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
        {name: 'Meals'},{name: 'Errands'}, {name: 'Care'}, {name: 'Services'}, {name: 'Housing'}, {name: 'Cash'}
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
