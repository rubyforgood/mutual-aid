import Vue from 'our_vue'
import {shallowMount} from '@vue/test-utils'
import ContactIcons from 'pages/browse/ContactIcons'

it('generally works', function() {
  var wrapper = shallowMount(ContactIcons, {
    propsData: { contactTypes: [{id: 1, name: "email"}, {id: 2, name: "text"},{id: 3, name: "call"}]}
  })
  assert.exists(wrapper.find('b-icon-stub[aria-label=email][icon=envelope]').text())
  assert.exists(wrapper.find('b-icon-stub[aria-label=call][icon=phone]').text())
})