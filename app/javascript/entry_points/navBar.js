import Vue from 'vue_config'
import NavBar from '../components/NavBar'

export default function(el, {loggedIn = false}) {
  new Vue({
    el,
    render(h) {
      return h(NavBar, {
        props: props,
      })
    }
  })
}
