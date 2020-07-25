import {createLocalVue, mount} from '@vue/test-utils'
import {configure} from 'vue_config'
import Offer from 'pages/Offer'

// TODO: extract specs for individual form_field components and fill any missing gaps
describe('Offer', () => {
  def('wrapper', () => mount(Offer, {
    localVue: configure(createLocalVue()),
    propsData: {
      form: $form,
      submission: $submission,
      configuration: {
        categories: [],
        contact_methods: $contact_methods,
        service_areas: $service_areas,
      },
    },
  }))

  def('contact_methods', () => { return [
    {id: 'Call',  field_name: 'phone', field_label: 'Phone number'},
    {id: 'Text',  field_name: 'phone', field_label: 'Phone number'},
    {id: 'Email', field_name: 'email', field_label: 'Email address'},
  ]})

  def('service_areas', () => { return [
    {id: '1',  name: 'first service area'},
    {id: '2',  name: 'another service area'},
  ]})

  def('person', () => { return {
    name: 'My Name',
    phone: '202 202 1234',
    email: 'me@example.com',
    preferred_contact_method: null,
  }})

  def('offer', () => { return {
    person: $person,
  }})

  def('submission', () => { return {
    listing: $offer,
  }})

  def('form', () => { return {
    questions: [],
  }})

  describe('service area', () => {
    describe('when there are multiple service areas', () => {
      it('renders a select list', () => {
        const select = $wrapper.find('select[name*="service_area"]')
        assert.sameMembers(select.findAll('option').wrappers.map(opt => opt.attributes('value')), ['1', '2'])
      })
    })

    describe('when there is a single service area', () => {
      def('service_areas', () => [{id: '42', name: 'only service area'}])

      it('renders a hidden input with the value fixed', () => {
        const input = $wrapper.find('input[name*="service_area"]')
        assert.equal(input.attributes('type'), 'hidden')
        assert.equal(input.attributes('value'), '42')
      })
    })
  })

  describe('contact fields', () => {
    it('generates a preferred_contact_method select field', () => {
      assert.isTrue($wrapper.exists('label[for*="preferred_contact_method"]'))
      assert.isTrue($wrapper.exists('select[name*="preferred_contact_method"]'))
    })

    it('includes all contact_methods as preferred_contact_method options', () => {
      const options = $wrapper.findAll('select[name*="preferred_contact_method"] option').wrappers
      assert.sameMembers(options.map(opt => opt.attributes('value')), ['', 'Call', 'Text', 'Email'])
    })

    it('generates text input fields for all contact fields', () => {
      assert.isTrue($wrapper.exists('label[for*="phone"]+input[name*="phone"]'))
      assert.isTrue($wrapper.exists('label[for*="email"]+input[name*="email"]'))
    })

    it('does not duplicate fields for two contact methods with the same field', () => {
      assert.equal($wrapper.findAll('input[name*="phone"]').length, 1)
    })

    describe('when a preffered contact method is selected', () => {
      beforeEach(async () => {
        $wrapper.get('select[name*="preferred_contact_method"]').setValue('Email')
        await $wrapper.vm.$forceUpdate()
      })

      it('makes the corresponding field required', () => {
        assert.equal($wrapper.get('input[name*="email"]').attributes('required'), 'required')
      })
    })
  })
})
