import Vue from 'vue_config'
import PublicListings from 'components/PublicListings'

export default function(el) {
  new Vue({
    el,
    render(h) {
      return h(PublicListings)
    }
  })
}
