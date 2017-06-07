const path = require("path");




module.exports = {
    entry: "./src/index.js",
    module:{
        loaders:[
            {
             test: /\.css$/,
             loaders: ["style-loader", 
                       { loader:"css-loader",
                         options:{importLoaders:1}
                       },
                       "postcss-loader"] 
            },
            {
             test:/\.html$/,
             exclude: /node_modules/,
             loader:"file-loader?name=[name].[ext]"
            },
            {
             test: /\.elm$/,
             exclude: [/elm-package/,/node_modules/],
             loader:"elm-webpack-loader?verbose=true&warn=true"
            },
        ]
    },
    output: {
        filename: "bundle.js",
        path: path.resolve(`${__dirname}/dist`),
    }
};