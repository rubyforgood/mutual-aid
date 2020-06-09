import Vue from 'vue_config'
import Orientation from 'pages/Orientation'

export default function(el, props = {organization: 'Mutual Aid'}) {
  new Vue({
    el,
    render(h) {
      return h(Orientation, {
        props: props,
      })
    }
  })
}
