const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      colors: {
        back: "#ebf0f0",
        header: "#424242",
        body: "#c29090",
        point: "#775b5b",
      },
      fontFamily: {
        kiwi: ["Kiwi Maru", "serif"],
      },
      backgroundImage: {
        ocean1: "url('/assets/ocean1.jpg')",
        ocean2: "url('/assets/ocean2.jpg')",
        writeLetter: "url('/assets/2writeLetter.png')",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
  ],
};
