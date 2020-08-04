import {configure} from 'vue_config'
import {createLocalVue, mount} from '@vue/test-utils'
import {CategoryFields} from 'components/forms'

describe('CategoryFields', () => {
  def('wrapper', () => {
    return mount(CategoryFields, {
      localVue: configure(createLocalVue()),
      propsData: $props,
    })
  })

  def('props', () => {
    return {
      fieldNamePrefix: 'listing[categories][]',
      categories: $categories,
      tags: $tags,
    }
  })

  def('categories', () => {
    return [{
      id: 'meals',   // ids should be integers; using strings to make spec selectors more obvious
      name: 'meals',
      description: 'on wheels',
      subcategories: [
        {id: 'prepare', name: 'prepare'},
        {id: 'deliver', name: 'deliver'}
      ]
    }, {
      id: 'housing',
      name: 'housing',
      description: 'is a human right',
      subcategories: [],
    }]
  })

  def('tags', () => {
    return [
      'meals',
      'prepare',
    ]
  })

  it('renders accordions for each parent category', () => {
    assert($wrapper.contains('.collapse#collapse-housing'))
    assert($wrapper.contains('.collapse#collapse-meals'))
  })

  it('opens accordions containing selected subcategories', () => {
    assert.equal($wrapper.get('#collapse-content-meals').attributes('aria-expanded'), 'true')
    assert.equal($wrapper.get('#collapse-content-housing').attributes('aria-expanded'), undefined)
  })

  it('sets a hidden input field for each parent category based on whether any subcategories are selected', () => {
    assert.isTrue($wrapper.contains('input[type="hidden"][value="meals"]'))
    assert.isFalse($wrapper.contains('input[type="hidden"][value="housing"]'))
  })

  it('renders checkboxes for each subcategory, with selected ones checked', () => {
    assert.isTrue($wrapper.get(`input[value="prepare"]`).element.checked)
    assert.isFalse($wrapper.get(`input[value="deliver"]`).element.checked)
  })

  describe('when a parent category has no subcategories', () => {
    it('renders a checkbox with the same name as the parent', () => {
      assert($wrapper.contains('input[value="housing"]'))
    })
  })
})
