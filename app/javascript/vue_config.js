import Vue from 'vue'
import Buefy from 'buefy'

export function configure(vue) {
  vue.use(Buefy, {
    defaultIconPack: 'fas',
  })

  return vue
}

export default configure(Vue)
