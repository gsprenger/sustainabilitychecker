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
      @toggleOverlay()
    $(window).on 'opensudokuoverlay', =>
      @toggleOverlay(true)

  toggleOverlay: (open) ->
    if !@$el.hasClass('sliding')
      if open || !@$el.hasClass('out')
        @$el.addClass('sliding')
        # dirty hack to be able to get the auto height value
        el = @$el.clone().css('height', 'auto').hide().appendTo('body')
        auto = el.height()
        wHeight = $(window).innerHeight()-31 # Why 31 ? No idea...
        @$el.height(Math.min(wHeight, auto))
        el.remove()
        setTimeout =>
          @$el.removeClass('sliding')
          @$el.addClass('out')
        , 1000
      else
        @$el.addClass('sliding')
        @$el.innerHeight('50px')
        setTimeout =>
          @$el.removeClass('sliding')
          @$el.removeClass('out')
        , 1000
