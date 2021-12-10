import Vue from 'vue_config'
import Browse from 'pages/Browse'
import contributionFetcher from 'pages/browse/ContributionFetcher'

export default function(el, properties) {
  new Vue({
    el,
    render(h) {
      return h(Browse, {props: properties})
    }
  })
}

