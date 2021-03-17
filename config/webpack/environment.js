const path = require('path')
const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')

// Override sass-loader implementation from deprecated node-sass to dart sass
// https://mentalized.net/journal/2019/10/19/use-sass-modules-in-rails/
// FIXME: remove this workaround when webpacker is upgraded to 6+
environment
  .loaders
  .get('sass')
  .use
  .find(function(element) { return element.loader == 'sass-loader' })
  .options
  .implementation = require('sass')

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
