import Vue from 'vue_config'
import Orientation from 'pages/Orientation'

export default function(el, {organization}='Mutual-aid') {
  new Vue({
    el,
    render(h) {
      return h(Orientation, {
        props: {organization},
      })
    }
  })
}
