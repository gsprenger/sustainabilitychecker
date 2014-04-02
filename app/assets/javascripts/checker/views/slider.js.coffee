class window.SliderView
  constructor:(@choice) ->
    @$el = $("<div>")

  render: ->
    html = """
      """
    @$el.append($(html))
    return this
