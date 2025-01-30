const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['ui-monospace', 'monospace',...defaultTheme.fontFamily.sans],
      },
      colors: {
        "amerma-blue": "#1366B0",
        "amerma-light-blue": "#BBCBCB",
        "amerma-dark-blue": "#1C1D21",
        "amerma-red": "#B0413E",
        "amerma-green": "#BBCBCB",
        "amerma-light-green": "#D1F5BE"
      },
      gridTemplateColumns: {
        "auto": "repeat(auto-fit, minmax(0, 1fr))",
      },
      boxShadow: {
        "flat": "4px 4px 0 black",
        "inset-flat": "inset 4px 4px 0 black"
      },
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
