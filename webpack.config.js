const webpack = require('webpack');
const path = require('path');
// const HtmlWebpackPlugin = require('html-webpack-plugin');

const outputDir = path.join(__dirname, './build/');
const isProd = false;
// const isProd = process.env.NODE_ENV === 'production';

module.exports = (env, argv) => {
  const config = {
    entry: path.join(__dirname, 'src/Index.bs.js'),
    mode: isProd ? 'production' : 'development',
    output: {
      path: outputDir,
      publicPath: outputDir,
      filename: 'js/Index.js',
    },
    plugins: [
      // new HtmlWebpackPlugin({
      //   template: 'src/index.html',
      //   minify: {
      //     removeComments:ju true,
      //     collapseWhitespace: true,
      //   },
      //   inject: true,
      // }),
      new webpack.HotModuleReplacementPlugin(),
    ],
    devServer: {
      port: 3000,
      contentBase: path.join(__dirname, 'build'),
      historyApiFallback: {
        index: 'index.html',
      },
      hot: true,
    },
    devtool: 'source-map',
  };
  return config;
};
