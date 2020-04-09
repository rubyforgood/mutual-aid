import Vue from 'vue'
import {Orientation} from '../components'

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
