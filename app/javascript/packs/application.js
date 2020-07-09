// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")

// Induce webpack to emit all files under app/assets/images so that
// they can be referenced in rails views via the image_pack_tag helper
require.context('images', true)

// Induce webpack to process css
import 'stylesheets/application'

// Entrypoints into JS, made available as window.EntryPoints
// See config/webpack/environment.js
export * from '../entry_points'
