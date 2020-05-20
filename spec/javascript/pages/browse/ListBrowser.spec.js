import {assert} from 'chai'
import {mount} from '@vue/test-utils'
import ListBrowser from 'pages/browse/ListBrowser'
import testData from '../../../../lib/listings.json'

describe('ListBrowser', () => {
  it('works with reasonable data', function () {
    const wrapper = mount(ListBrowser, {
      propsData: {
        contributions: testData.contributions,
      },
    })
    // TODO - get this working again!!!
    // assert.match(wrapper.text(), /look after my kid/i)
  })
})
