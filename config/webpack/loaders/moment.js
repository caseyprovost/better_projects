module.exports = {
  test: require.resolve('moment'),
  use: [
    {
      loader: 'expose-loader',
      options: 'moment'
    }
  ]
}
