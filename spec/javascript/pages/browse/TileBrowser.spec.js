import {assert} from 'chai'
import {mount} from '@vue/test-utils'
import TileBrowser from 'pages/browse/ListBrowser'

it('works with reasonable data', function () {
  const testData = require('../../../../lib/listings.json')

  var wrapper = mount(TileBrowser, {
    propsData: {
      contributions: testData.contributions,
    },
  })
  assert.match(wrapper.text(), /look after my kid/i)
})
