import Vue from 'our_vue'
import {HelloWorld} from '../components'

export default function(el, {message} = {}) {
  new Vue({
    el,
    render(h) {
      return h(HelloWorld, {
        props: {message},
      })
    },
  })
}
