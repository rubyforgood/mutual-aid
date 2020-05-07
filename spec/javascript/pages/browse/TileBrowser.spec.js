import {assert} from 'chai'
import {mount} from '@vue/test-utils'
import TileBrowser from 'pages/browse/ListBrowser'

describe('TileBrowser', () => {
  it('works with reasonable data', function () {
    const testData = require('../../../../lib/listings.json')

    const wrapper = mount(TileBrowser, {
      propsData: {
        contributions: testData.contributions,
      },
    })
    assert.match(wrapper.text(), /look after my kid/i)
  })
})
