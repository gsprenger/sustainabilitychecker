class window.CheckView
  constructor:(@choice) ->
    @$el = $("<div>")

  render: ->
    c = App.get().content
    html = """
      """
    @$el.append($(html))
    return this
