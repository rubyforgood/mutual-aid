import {configure} from 'vue_config'
import {createLocalVue, shallowMount} from '@vue/test-utils'
import ContactIcons from 'pages/browse/ContactIcons'

describe('ContactIcons', () => {
  it('generally works', function() {
    const wrapper = shallowMount(ContactIcons, {
      localVue: configure(createLocalVue()),
      propsData: { contactTypes: [{id: 1, name: "email"}, {id: 2, name: "text"},{id: 3, name: "phone"}]}
    })
    assert.exists(wrapper.find('b-icon-stub[aria-label=email][icon=envelope]').text())
    assert.exists(wrapper.find('b-icon-stub[aria-label=phone][icon=phone]').text())
  })
})
