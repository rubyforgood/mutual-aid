import {assert} from 'chai'
import {mount} from '@vue/test-utils'
import ListBrowser from 'pages/browse/ListBrowser'
import ListingDataAdapter from 'pages/browse/ListingDataAdapter'

it('works with reasonable data', function () {
  const testData = require('../../../../lib/listings.json')
  var wrapper = mount(ListBrowser, {
    propsData: {
      listings: testData.contributions,
      helper: new ListingDataAdapter({
        categories: testData.categories,
        locations: testData.service_areas,
      }),
    },
  })
  assert.match(wrapper.text(), /look after my kid/i)
})
