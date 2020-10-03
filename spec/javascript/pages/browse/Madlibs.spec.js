import {createLocalVue, mount, shallowMount} from '@vue/test-utils'
import {configure} from 'vue_config'
import Madlibs from 'pages/browse/Madlibs.vue'

describe('Madlibs', () => {
  def('wrapper', () => mount(Madlibs, {
    localVue: configure(createLocalVue()),
    // propsData: {}
  }))

  describe("displaying correct filters based on Filters column", () => {
    // Should fail
  })
})
