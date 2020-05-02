import {assert} from 'chai'
import {mount} from '@vue/test-utils'
import ListBrowser from 'pages/browse/ListBrowser'

it('works with reasonable data', function () {
  const testData = require('../../../../lib/listings.json')
  var wrapper = mount(ListBrowser, {
    propsData: {
      contributions: testData.contributions,
    },
  })
  assert.match(wrapper.text(), /look after my kid/i)
})
