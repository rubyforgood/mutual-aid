import { mount } from '@vue/test-utils'
import Filters from 'pages/browse/Filters'
import filterTypes from '../../../../lib/filterCategories.json'

describe('Filters', function () {
  it('generally works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: { filterTypes: filterTypes },
      listeners: { change: clickHandler },
    })
    const checkbox = wrapper.findAll('input[type=checkbox]').at(2)
    checkbox.trigger('click')
    assert.deepEqual(result, [filterTypes[0].filters[0].id])
  })

  it('toggle-filters works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: { filterTypes: filterTypes },
      listeners: { change: clickHandler },
    })
    const checkbox = wrapper.find(`#toggle-filters-${filterTypes[0].name}`)
    checkbox.trigger('click')
    assert.deepEqual(result, filterTypes[0].filters.map(f=>f.id))
  })

  it('toggle-all-filters works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: { filterTypes: filterTypes },
      listeners: { change: clickHandler },
    })
    const checkbox = wrapper.find('#toggle-all-filters')
    checkbox.trigger('click')
    const allFilters = [].concat(
      ...filterTypes.map((fType) => fType.filters.map((filter) => filter.id))
    )
    assert.deepEqual(result.sort(), allFilters.sort())
  })
})
