import { assert } from 'chai'
import { mount, shallowMount } from '@vue/test-utils'
import Browse from 'pages/Browse.vue'
import ListBrowser from 'pages/browse/ListBrowser'
import TileBrowser from 'pages/browse/TileBrowser'

describe('Browse', function() {
  beforeEach(function() {
    this.wrapper = mount(Browse)
  })

  describe('browser view', function() {
    it('renders the Tile view by default', function() {
      assert.isTrue(this.wrapper.contains(TileBrowser))
    })

    it('can be switched to the List view', async function() {
      this.wrapper.find('button#show-list').trigger('click')
      await this.wrapper.vm.$nextTick()

      assert.isTrue(this.wrapper.contains(ListBrowser))
      assert.isFalse(this.wrapper.contains(TileBrowser))
    })
  })
})
