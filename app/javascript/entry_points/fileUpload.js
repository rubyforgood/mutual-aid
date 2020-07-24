import Vue from 'vue_config'
import FileUpload from '../components/forms/FileUpload'

export default function(el, props) {
  new Vue({
    el,
    render(h) {
      return h(FileUpload, {
        props: props,
      })
    }
  })
}
