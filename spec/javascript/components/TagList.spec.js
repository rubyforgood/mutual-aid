import {assert} from 'chai'
import {shallowMount} from '@vue/test-utils'
import TagList from 'components/TagList'

describe('TagList', () => {
  it('has default css classes', function () {
    const wrapper = shallowMount(TagList, {
      propsData: {
        tags: [{id: 1, name: 'a'}],
      },
    })
    assert.deepEqual(wrapper.classes(), ['tagList', 'tags'])
    assert.deepEqual(wrapper.find('li').classes(), ['tagList-tag', 'tag', 'is-info', 'is-light'])
  })

  it('can override some of the default classes', function () {
    const wrapper = shallowMount(TagList, {
      propsData: {
        tags: [{id: 2, name: 'b'}, [{id: 3, name: 'c'}]],
        tagClasses: 'childClass',
      },
    })
    assert.deepEqual(wrapper.findAll('li').at(0).classes(), ['tagList-tag', 'tag', 'childClass'])
    assert.deepEqual(wrapper.findAll('li').at(1).classes(), ['tagList-tag', 'tag', 'childClass'])
  })

  it('renders empty if the tags are invalid', function () {
    const nullWrapper = shallowMount(TagList, {
      propsData: {tags: null},
    })
    const emptyWrapper = shallowMount(TagList, {propsData: {tags: []}})
    const nullEmptyWrapper = shallowMount(TagList, {propsData: {tags: [null]}})
    assert.isTrue(nullWrapper.isEmpty())
    assert.isTrue(emptyWrapper.isEmpty())
    assert.isTrue(nullEmptyWrapper.isEmpty())
  })
})
