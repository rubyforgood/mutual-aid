import {createLocalVue, shallowMount} from '@vue/test-utils'
import {configure} from 'vue_config'
import ListBrowser from 'pages/browse/ListBrowser'
import testData from '../../../../lib/contributions.json'

describe('ListBrowser', () => {
  def('contributions', testData)

  def('wrapper', () => {
    return shallowMount(ListBrowser, {
      localVue: configure(createLocalVue()),
      propsData: $contributions,
    })
  })

  def('tableHeaders', () => $wrapper.findAll('th').wrappers)

  describe('respond column', () => {
    it('shows the column with typical data', function () {
      assert.isTrue($tableHeaders.some(header => header.text() == 'View'))
    })

    describe('when contributions do not come with response urls', () => {
      def('contributions', () => {
        testData.contributions.map(contribution => {
          contribution.view_path = ''
          return contribution
        })
      })

      it('hides the respond button', function() {
        assert.isFalse($tableHeaders.some(header => header.text() == 'Respond'))
      })
    })
  })
})
