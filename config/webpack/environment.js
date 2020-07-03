const path = require('path')
const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())

environment.loaders.prepend('vue', {
  test: /\.vue(\.erb)?$/,
  use: [{loader: 'vue-loader'}],
})

environment.config.merge({
  output: {
    // Exposes the export from last pack (application.js) as a global var.
    // https://webpack.js.org/configuration/output/#outputlibrary
    library: ['EntryPoints'],
  },
})

module.exports = environment
