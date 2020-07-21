const autoprefixer = require("autoprefixer");
const purgecss = require("@fullhuman/postcss-purgecss");
const tailwindcss = require("tailwindcss")("tailwind.config.js");

const development = {
  plugins: [tailwindcss, autoprefixer],
};

const production = {
  plugins: [
    tailwindcss,
    purgecss({
      content: ["./src/**/*.elm", "index.js"],
      whitelist: ["html", "body"],
    }),
    autoprefixer,
  ],
};

if (process.env.NODE_ENV === "production") {
  module.exports = production;
} else {
  module.exports = development;
}
