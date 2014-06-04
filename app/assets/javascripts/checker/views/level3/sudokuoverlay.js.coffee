class window.SudokuOverlayView
  constructor: ->
    @$el = $("<div id='lvl3-main'>")
    @sudokuV = new SudokuView(true)

  render: ->
    c = App.get().content
    html = """
      """
    @$el.html(html)
    @$el.append(@sudokuV.render().$el)
    @events()
    return this

  events: ->
    @$el.on 'click', =>
      @$el.toggleClass('out')
      if @$el.hasClass('out')
        # update sudoku after animation ends
        if (!@sudokuV.isRendered)
          setTimeout =>
            @$el.find('#sudoku').remove()
            @$el.append(@sudokuV.render().$el)
          , 1000
