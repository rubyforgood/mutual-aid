import Vue from 'our_vue'
import NavBar from '../components/NavBar'

export default function(el, {loggedIn = false}) {
  new Vue({
    el,
    render(h) {
      return h(NavBar, {
        props: {loggedIn},
      })
    }
  })
}
