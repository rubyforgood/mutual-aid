import {mount} from '@vue/test-utils'
import Filters from 'pages/browse/Filters'
import filterCategories from '../../../../lib/filterCategories.json'

describe('Filters', function () {
  it('generally works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: {filterCategories: filterCategories},
      listeners: {change: clickHandler},
    })
    const checkbox = wrapper.find('input[type=checkbox]')
    checkbox.trigger('click')
    assert.deepEqual(result, [filterCategories[0].filters[0].id])
  })
})
