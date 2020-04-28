import Vue from 'our_vue'
import Notice from '../components/Notice'

export default function(el, {message, type}) {
  new Vue({
    el,
    render(h) {
      return h(Notice, {
        props: {
          message,
          type,
        },
      })
    }
  })
}
