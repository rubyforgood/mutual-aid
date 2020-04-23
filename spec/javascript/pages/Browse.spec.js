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
    describe('starts in Tile view', function() {
      it('renders the TileBrowser', function() {
        assert.isTrue(this.wrapper.contains(TileBrowser))
        assert.isFalse(this.wrapper.contains(ListBrowser))
      })

      it('disables the Tile view button', function() {
        assert.equal(this.wrapper.find('button#show-tiles').attributes('disabled'), 'disabled')
        assert.notExists(this.wrapper.find('button#show-list').attributes('disabled'))
      })
    })

    describe('when switched to the List view', function() {
      beforeEach(async function() {
        this.wrapper.find('button#show-list').trigger('click')
        await this.wrapper.vm.$nextTick()
      })

      it('renders the ListBrowser', function() {
        assert.isTrue(this.wrapper.contains(ListBrowser))
        assert.isFalse(this.wrapper.contains(TileBrowser))
      })

      it('disables the List view button', function() {
        assert.equal(this.wrapper.find('button#show-list').attributes('disabled'), 'disabled')
        assert.notExists(this.wrapper.find('button#show-tiles').attributes('disabled'))
      })
    })
  })
})
