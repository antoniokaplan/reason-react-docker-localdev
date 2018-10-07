const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const outputDir = path.join(__dirname, "./build/");

const isProd = process.env.NODE_ENV === 'production';

module.exports = (env, argv) => {
  const config = {
    entry: './src/Index.bs.js',
    mode: isProd ? 'production' : 'development',
    output: {
      path: outputDir,
      publicPath: outputDir,
      filename: './src/Index.js',
    },
    plugins: [
      new HtmlWebpackPlugin({
        template: 'src/index.html',
        minify: {
          removeComments: true,
          collapseWhitespace: true,
        },
        inject: true,
      }),
      new webpack.HotModuleReplacementPlugin(),
    ],
    devServer: {
      host: '0.0.0.0',
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
