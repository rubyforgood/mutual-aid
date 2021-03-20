import { mount } from '@vue/test-utils'
import Filters from 'pages/browse/Filters'
import filterGroups from '../../../../lib/filterCategories.json'

describe('Filters', function () {
  it('generally works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: { filterGroups: filterGroups },
      listeners: { change: clickHandler },
    })
    const checkbox = wrapper.findAll('input[type=checkbox]').at(2)
    checkbox.trigger('click')
    assert.deepEqual(result, [filterGroups[0].filter_options[0].id])
  })

  it('toggle-filters works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: { filterGroups: filterGroups },
      listeners: { change: clickHandler },
    })
    const checkbox = wrapper.find(`#toggle-filters-${filterGroups[0].name}`)
    checkbox.trigger('click')
    assert.deepEqual(result, filterGroups[0].filter_options.map(f=>f.id))
  })

  it('toggle-all-filters works', function () {
    var result = {}
    const clickHandler = function (event, trash) {
      result = event
    }
    const wrapper = mount(Filters, {
      propsData: { filterGroups: filterGroups },
      listeners: { change: clickHandler },
    })
    const checkbox = wrapper.find('#toggle-all-filters')
    checkbox.trigger('click')
    const allFilters = [].concat(
      ...filterGroups.map((fGroup) => fGroup.filter_options.map((fOption) => fOption.id))
    )
    assert.deepEqual(result.sort(), allFilters.sort())
  })
})
