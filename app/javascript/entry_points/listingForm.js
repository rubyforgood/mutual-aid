import Vue from 'vue'
import {ListingForm} from '../components'

export default function(el) {
  new Vue({
    el,
    render(h) {
      return h(ListingForm)
    }
  })
}