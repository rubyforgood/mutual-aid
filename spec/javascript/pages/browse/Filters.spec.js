import Vue from 'our_vue'
import {mount} from '@vue/test-utils'
import Filters from 'pages/browse/Filters'

describe('smoke test', function() {
  it('generally works', function() {
    const testCategories = [
      {
        name: 'Urgency',
        subcategories: [
          {id: 'Urgency-0', name: 'Within 1-2 days'},
          {id: 'Urgency-1', name: 'I can wait a week'},
        ],
      },
      {
        name: 'Locations',
        subcategories: [
          {id: 'Locations-0', name: 'Acme Township'},
          {id: 'Locations-1', name: 'East Bay'},
          {id: 'Locations-2', name: 'Garfield Township'},
        ],
      },
      {
        name: 'Type',
        subcategories: [
          {id: 'Type-0', name: 'Ask'},
          {id: 'Type-1', name: 'Offer'},
          {id: 'Type-2', name: 'Community Resource'},
        ],
      },
    ]
    const wrapper = mount(Filters, {propsData: {filterCategories: testCategories}})
    assert.match(wrapper.text(), /Filters/i)
  })
})
