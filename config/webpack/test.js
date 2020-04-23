process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
var babelLoader = environment.loaders.get('babel')
babelLoader.include.push(babelLoader.include[0].concat('../../test'))

module.exports = environment.toWebpackConfig()
