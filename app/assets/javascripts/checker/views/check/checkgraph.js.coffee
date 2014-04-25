class window.CheckGraphView
  constructor: ->
    @$el = $("<div id='checkgraph'>")

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      GRAPH
      """
    @$el.html(html)
    @events()
    return this

  events: ->
