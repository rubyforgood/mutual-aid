import {createLocalVue, shallowMount} from '@vue/test-utils'
import {configure} from 'vue_config'
import ListBrowser from 'pages/browse/ListBrowser'
import testData  from '../../../../lib/contributions.json'

describe('ListBrowser', () => {
  it('shows the respond column with typical data', function () {
    const wrapper = shallowMount(ListBrowser, {
      localVue: configure(createLocalVue()),
      propsData: testData
    })
    var respondHeaders = wrapper.findAll('th').filter( header => header.text() == 'Respond')
    assert.equal(1, respondHeaders.length)
  })
  it('hides the respond if there is no response urls', function() {
    var responselessContributions = testData.contributions.map( contribution => { contribution.respond_path = ''; return contribution})
    const wrapper = shallowMount(ListBrowser, {
      localVue: configure(createLocalVue()),
      propsData: {responselessContributions}
    })
    var respondHeaders = wrapper.findAll('th').filter( header => header.text() == 'Respond')
    assert.equal(0, respondHeaders.length)
  })
})
