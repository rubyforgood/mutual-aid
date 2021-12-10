import {createLocalVue, shallowMount} from '@vue/test-utils'
import {configure} from 'vue_config'
import TileListItem from 'pages/browse/TileListItem'

describe('TileListItem', () => {
  def('wrapper', () => {
    return shallowMount(TileListItem, {
      localVue: configure(createLocalVue()),
      propsData: $props,
    })
  })

  def('props', () => {
    return {
      created_at: Date.now(),
      person: {name: 'Zapata'}
    }
  })

  describe('contributor name', () => {
    it('shows the name when given', () => {
      assert.equal($wrapper.get('.contributor-name').text(), 'From: Zapata')
    })

    it('omits the whole line if name is not given', () => {
      $props.person.name = null
      assert.isFalse($wrapper.find('.contributor-name').exists())
    })
  })
})
