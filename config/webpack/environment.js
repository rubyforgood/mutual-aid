const path = require('path')
const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue') // todo: flatten this

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

environment.config.merge({
  output: {
    // Exposes the export from last pack (application.js) as a global var.
    // https://webpack.js.org/configuration/output/#outputlibrary
    library: ['EntryPoints'],
  },
})

module.exports = environment
