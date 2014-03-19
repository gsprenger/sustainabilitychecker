class window.Controller
  # Service methods
  render: (html, location) ->
    if (location == null)
      location = '#app'
    $(location).append(html)
