import {createLocalVue, mount} from '@vue/test-utils'
import {configure} from 'vue_config'
import Offer from 'pages/Offer'

describe('Offer', () => {
  def('wrapper', () => mount(Offer, {
    localVue: configure(createLocalVue()),
    propsData: {
      contactTypes: $contactTypes,
      person: $person,
    },
  }))

  def('contactTypes', () => { return [
    {key: 'Call',  fieldName: 'phone', fieldLabel: 'Phone number'},
    {key: 'Text',  fieldName: 'phone', fieldLabel: 'Phone number'},
    {key: 'Email', fieldName: 'email', fieldLabel: 'Email address'},
  ]})

  def('person', () => { return {
    name: 'My Name',
    phone: '202 202 1234',
    email: 'me@example.com',
    preferred_contact_type: null,
  }})

  describe('contact fields', () => {
    it('generates a preferred_contact_type select field', () => {
      assert.isTrue($wrapper.exists('label[for*="preferred_contact_type"]'))
      assert.isTrue($wrapper.exists('select[name*="preferred_contact_type"]'))
    })

    it('includes all contact_types as preferred_contact_type options', () => {
      const options = $wrapper.findAll('select[name*="preferred_contact_type"] option').wrappers
      assert.sameMembers(options.map(opt => opt.attributes('value')), ['', 'Call', 'Text', 'Email'])
    })

    it('generates text input fields for all contact fields', () => {
      assert.isTrue($wrapper.exists('label[for*="phone"]+input[name*="phone"]'))
      assert.isTrue($wrapper.exists('label[for*="email"]+input[name*="email"]'))
    })

    it('does not duplicate fields for two contact types with the same field', () => {
      assert.equal($wrapper.findAll('input[name*="phone"]').length, 1)
    })

    describe('when a preffered contact type is selected', () => {
      beforeEach(async () => {
        $wrapper.get('select[name*="preferred_contact_type"]').setValue('Email')
        await $wrapper.vm.$forceUpdate()
      })

      it('updates the person object state', () => {
        assert.equal($person.preferred_contact_type, 'Email')
      })

      it('makes the corresponding field required', () => {
        assert.equal($wrapper.get('input[name*="email"]').attributes('required'), 'required')
      })
    })

    describe('when a contact field is updated', () => {
      beforeEach(async () => {
        $wrapper.get('input[name*="phone"]').setValue('202 765 4321')
        await $wrapper.vm.$nextTick()
      })

      it('updates the person object state', () => {
        assert.equal($person.phone, '202 765 4321')
      })
    })
  })
})
