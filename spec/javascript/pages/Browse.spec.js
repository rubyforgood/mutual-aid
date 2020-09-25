import {mount, shallowMount} from '@vue/test-utils'
import Browse from 'pages/Browse.vue'
import ListBrowser from 'pages/browse/ListBrowser'
import TileBrowser from 'pages/browse/TileBrowser'
import Filters from 'pages/browse/Filters'

describe('Browse', () => {
  def('wrapper', () => mount(Browse))

  describe('browser view', () => {
    def('showTilesButton', () => $wrapper.find('a#show-tiles'))
    def('showListButton', () => $wrapper.find('a#show-list'))

    it('loads the Filters', function() {
      assert.isTrue($wrapper.contains(Filters))
    })

    describe('starts in Tile view', () => {
      it('renders the TileBrowser', () => {
        assert.isTrue($wrapper.contains(TileBrowser))
        assert.isFalse($wrapper.contains(ListBrowser))
      })

      it('activates the Tile view button', () => {
        assert.deepEqual($showTilesButton.classes(), ['navbar-item', 'is-active'])
      })
    })

    describe('when switched to the List view', () => {
      beforeEach(async () => {
        $showListButton.trigger('click')
        await $wrapper.vm.$nextTick()
      })

      it('renders the ListBrowser', () => {
        assert.isTrue($wrapper.contains(ListBrowser))
        assert.isFalse($wrapper.contains(TileBrowser))
      })

      it('activates the List view button', () => {
        assert.deepEqual($showListButton.classes(), ['navbar-item', 'is-active'])
      })
    })
  })
})
