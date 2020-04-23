import {assert} from 'chai'
import {shallowMount} from '@vue/test-utils'
import TagList from 'components/TagList'

it('has default css classes', function () {
  var wrapper = shallowMount(TagList, {
    propsData: {
      tags: [{id: 1, name: 'a'}],
    },
  })
  assert.equal(wrapper.classes(), 'tagList')
  assert.deepEqual(wrapper.find('li').classes(), ['tagList-tag', 'tag', 'is-info', 'is-light'])
})

it('can override some of the default classes', function () {
  var wrapper = shallowMount(TagList, {
    propsData: {
      tags: [{id: 2, name: 'b'}, [{id: 3, name: 'c'}]],
      listClasses: 'parentClass',
      tagClasses: 'childClass',
    },
  })
  assert.deepEqual(wrapper.classes(), ['tagList', 'parentClass'])
  assert.deepEqual(wrapper.findAll('li').at(0).classes(), ['tagList-tag', 'childClass'])
  assert.deepEqual(wrapper.findAll('li').at(1).classes(), ['tagList-tag', 'childClass'])
})
