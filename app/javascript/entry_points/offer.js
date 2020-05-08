import Vue from 'vue_config'
import Offer from 'pages/Offer'

export default function(el, {offer}) {
  new Vue({
    el,
    render(h) {
      return h(Offer, {
        props: {offer},
      })
    }
  })
}
