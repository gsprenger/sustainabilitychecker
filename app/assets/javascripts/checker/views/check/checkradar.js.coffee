class window.CheckRadarView
  constructor: ->
    @$el = $("<div id='checkradar'>")

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      RADAR
      """
    @$el.html(html)
    @events()
    return this

  events: ->
