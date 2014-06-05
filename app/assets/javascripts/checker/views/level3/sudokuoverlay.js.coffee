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
    if open
      @$el.addClass('out')
    else
      @$el.toggleClass('out')
    if @$el.hasClass('out')
      # dirty hack to be able to get the auto height value
      el = @$el.clone().css('height', 'auto').hide().appendTo('body')
      auto = el.height()
      wHeight = $(window).innerHeight()-31 # Why 31 ? No idea...
      @$el.height(Math.min(wHeight, auto))
      el.remove()
    else
      @$el.innerHeight('50px')
