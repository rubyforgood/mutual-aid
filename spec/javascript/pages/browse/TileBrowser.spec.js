import {assert} from 'chai'
import {mount} from '@vue/test-utils'
import TileBrowser from 'pages/browse/ListBrowser'
import ListingDataAdapter from 'pages/browse/ListingDataAdapter'

it('works with reasonable data', function () {
  const testData = require('../../../../lib/listings.json')

  var wrapper = mount(TileBrowser, {
    propsData: {
      listings: testData.listings,
      helper: new ListingDataAdapter({
        categories: testData.categories,
        locations: testData.locations,
      }),
    },
  })
  assert.match(wrapper.text(), /look after my kid/i)
})
