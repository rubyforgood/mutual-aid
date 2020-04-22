import { mount, shallowMount } from '@vue/test-utils'
import Browse from '../../../app/javascript/pages/Browse.vue'
import { assert } from 'chai'

describe('Browse', ()=>{
  it('defaults to list view', ()=>{
    const wrapper = shallowMount(Browse)
    assert.isTrue(wrapper.props().showList)
    assert.isFalse(wrapper.props().showGrid)
  });
  it('renders the list view', ()=>{
    const wrapper = mount(Browse)
    assert.isTrue(wrapper.contains('div.listBrowser'))
  });
})
