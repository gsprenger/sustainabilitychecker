class window.CheckView
  constructor:(@choice) ->
    @$el = $("<div>")

  render: ->
    c = App.get().content
    html = """
      """
    @$el.html(html)
    return this
