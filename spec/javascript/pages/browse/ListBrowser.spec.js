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

  describe('contributor name column', () => {
    it('shows the column with typical data', function () {
      assert.isTrue($tableHeaders.some(header => header.text() == 'Contributor Name'))
    })

    describe('when contributor names have been witheld based on authorization', () => {
      def('contributions', () => {
        testData.contributions.forEach((contribution) => {
          contribution.person.name = null  // FIXME: this mutates fixture data
        })
        return testData
      })

      it('hides the contributor name column', function() {
        assert.isFalse($tableHeaders.some(header => header.text() == 'Contributor Name'))
      })
    })
  })
})
