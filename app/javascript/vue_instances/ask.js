import Vue from 'vue_config'
import Ask from 'pages/Ask'

export default function(el, props) {
  new Vue({
    el,
    render(h) {
      return h(Ask, {props})
    }
  })
}
