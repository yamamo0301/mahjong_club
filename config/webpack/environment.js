const { environment } = require('@rails/webpacker')

// ここから追加
const webpack = require('webpack')
environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: 'popper.js'
    })
)
// ここまで追加

module.exports = environment
