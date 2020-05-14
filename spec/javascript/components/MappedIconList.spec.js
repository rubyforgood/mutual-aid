import {configure} from 'vue_config'
import {createLocalVue, shallowMount} from '@vue/test-utils'
import MappedIconList from 'components/MappedIconList'

describe('MappedIconList', () => {
  it('generally works', function() {
    const wrapper = shallowMount(MappedIconList, {
      localVue: configure(createLocalVue()),
      propsData: { contactTypes: [{id: 1, name: "Email"}, {id: 2, name: "Text"},{id: 3, name: "Call"}]}
    })
    assert.exists(wrapper.find('b-icon-stub[aria-label=Email][icon=envelope]').text())
    assert.exists(wrapper.find('b-icon-stub[aria-label=Text][icon=mobile-alt]').text())
    assert.exists(wrapper.find('b-icon-stub[aria-label=Call][icon=phone]').text())
  })
})
