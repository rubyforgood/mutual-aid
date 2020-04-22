import { mount, shallowMount } from '@vue/test-utils'
import Browse from 'pages/Browse.vue'
import TileBrowser from 'pages/browse/TileBrowser'
import { assert } from 'chai'

describe('Browse', ()=>{
  it('defaults to tiles view', ()=>{
    const wrapper = shallowMount(Browse)
    assert.isTrue(wrapper.props().showTiles)
    assert.isFalse(wrapper.props().showList)
  });
  it('renders the tiles view', ()=>{
    const wrapper = mount(Browse)
    assert.isTrue(wrapper.contains(TileBrowser))
  });
})
