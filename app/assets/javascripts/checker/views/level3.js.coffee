class window.Level3View
  constructor: ->
    @$el = $("<div id='lvl3-main'>")
    @sudokuV = new SudokuView()

  render: ->
    c = App.get().content
    html = """
      """
    @$el.html(html)
    @$el.append(@sudokuV.render().$el)
    return this
