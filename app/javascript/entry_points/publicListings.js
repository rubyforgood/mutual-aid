import Vue from 'our_vue'
import PublicListings from 'components/PublicListings'

export default function(el) {
  new Vue({
    el,
    render(h) {
      return h(PublicListings)
    }
  })
}
