module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader'
  },
  {
    loader: 'rails-erb-loader',
    options: {
      runner: 'ruby bin\\rails runner',
      dependenciesRoot: '../app'
    }
  }]
}