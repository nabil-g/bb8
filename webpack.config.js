const webpack = require('webpack');
const webpackMerge = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin')
const StyleLintPlugin = require('stylelint-webpack-plugin');

const modeConfig = env => require(`./webpack.${env}`)(env);
const presetConfig = require("./loadPresets");

module.exports = ({ mode, presets } = { mode: "production", presets: [] }) => {
  console.log(`Building for: ${mode}`);

  return webpackMerge(
    {
      mode,
      module: {
        noParse: /\.elm$/,
        rules: [
          {
            test: /\.(eot|ttf|woff|woff2|svg)$/,
            use: 'file-loader?publicPath=../../&name=assets/css/[hash].[ext]',
          },
        ]
      },

      plugins: [
            new HtmlWebpackPlugin({
                template: 'src/assets/index.html',
                inject: 'body',
                filename: 'index.html',
            }),
            //new StyleLintPlugin(),

            //new CopyWebpackPlugin([
              //  { from: 'src/assets/favicon.ico' }
            //]),
        ]

    },
    modeConfig(mode),
    presetConfig({ mode, presets }),
  )
};
