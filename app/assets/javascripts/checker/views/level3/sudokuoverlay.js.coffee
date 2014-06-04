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
        # dirty hack to be able to get the auto height value
        el = @$el.clone().css('height', 'auto').hide().appendTo('body')
        auto = el.height()
        wHeight = $(window).innerHeight()-31 # Why 31 ? No idea...
        @$el.height(Math.min(wHeight, auto))
        el.remove()
        # update sudoku after animation ends
        if (!@sudokuV.isRendered)
          setTimeout =>
            @$el.find('#sudoku').remove()
            @$el.append(@sudokuV.render().$el)
          , 1000
      else
        @$el.innerHeight('50px')
