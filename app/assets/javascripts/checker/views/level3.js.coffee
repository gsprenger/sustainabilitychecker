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
        # dirty hack to be able to set height to auto
        el = @$el.clone().css('height', 'auto').hide().appendTo('body')
        height = el.height()
        el.remove()
        @$el.height(height)
      else
        @$el.height(100)
