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
      fieldNamePrefix: 'listing[tag_list][]',
      categories: $categories,
      tags: $tags,
    }
  })

  function isChecked(value) {
    return $wrapper.find(`input[value="${value}"]`).element.checked
  }

  describe('top-level categories', () => {
    def('categories', () => {
      return [
        {name: 'meals',   description: 'on wheels'},
        {name: 'housing', description: 'is a human right'},
      ]
    })

    def('tags', () => ['meals'])

    it('renders checkboxes with selected tags checked', () => {
      assert.isTrue(isChecked('meals'))
      assert.isFalse(isChecked('housing'))
    })

    it('shows descriptions for checked categories', () => {
      assert.include($wrapper.text(), 'on wheels')
      assert.notInclude($wrapper.text(), 'is a human right')
    })
  })

  describe('with subcategories', () => {
    def('categories', () => {
      return [{
        name: 'meals',
        subcategories: [
          {name: 'prepare'},
          {name: 'deliver'},
        ],
      }]
    })

    def('tags', () => ['meals', 'prepare'])

    it('renders checkboxes for selected subcategories', () => {
      assert.isTrue(isChecked('meals'))
      assert.isTrue(isChecked('prepare'))
      assert.isFalse(isChecked('deliver'))
    })
  })
})


