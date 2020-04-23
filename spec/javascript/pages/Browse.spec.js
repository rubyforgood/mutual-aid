import { mount, shallowMount } from '@vue/test-utils'
import Browse from 'pages/Browse.vue'
import TileBrowser from 'pages/browse/TileBrowser'
import { assert } from 'chai'

describe('Browse', ()=>{
  it('renders the tile view by default', ()=>{
    const wrapper = shallowMount(Browse)
    assert.isTrue(wrapper.contains(TileBrowser))
  })
})
