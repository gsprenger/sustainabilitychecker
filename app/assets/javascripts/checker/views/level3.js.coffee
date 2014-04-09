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
    @events()
    return this

  events: ->
    @$el.on 'click', =>
      @$el.toggleClass('out')
      if @$el.hasClass('out')
        # dirty hack to be able to get the auto height value
        el = @$el.clone().css('height', 'auto').hide().appendTo('body')
        auto = el.height()
        percent = $(window).height()*0.6
        @$el.height(Math.min(percent, auto))
        el.remove()
        @$el.css('overflow-y', 'scroll')
        # update sudoku after animation ends
        if (!@sudokuV.isRendered)
          setTimeout =>
            @$el.find('#sudoku').remove()
            @$el.append(@sudokuV.render().$el)
          , 1000
      else
        @$el.height(100)
        @$el.css('overflow-y', 'none')
