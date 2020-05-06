import Vue from 'vue'
import Buefy from 'buefy'
import CompositionApi from '@vue/composition-api'

export function configure(vue) {
  Vue.use(CompositionApi)
  vue.use(Buefy, {
    defaultIconPack: 'fas',
  })
  return vue
}

export default configure(Vue)
