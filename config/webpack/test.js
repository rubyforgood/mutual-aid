process.env.NODE_ENV = process.env.NODE_ENV || 'test'

const environment = require('./environment')

const babelLoader = environment.loaders.get('babel')
babelLoader.include.push(babelLoader.include[0].concat('../../test'))

// Don't write manifest to disk in test env; it would write out pack paths that
// webpack-dev-server doesn't like.
// Alternatively, we could change the `publicPath` property so it writes somewhere else?
// Somewhat related https://github.com/rails/webpacker/issues/435
const manifestPlugin = environment.plugins.get('Manifest');
manifestPlugin.options.writeToDisk = false

module.exports = environment.toWebpackConfig()
