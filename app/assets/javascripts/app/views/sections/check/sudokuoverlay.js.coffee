class window.SudokuOverlayView
  constructor: ->
    @$el = $("<div id='lvl3-main'>")
    @sudokuV = new SudokuView(true)
    $(window).on 'opensudokuoverlay', =>
      @toggleOverlay(true)
    # When overlay is out, close it when user clicks outside
    $(window).on 'click', (event) =>
      if @$el.hasClass('out') && !$.contains(document.getElementById('sudoku'), event.target)
        @toggleOverlay()
    # Add CSS property to footer so that it doesnt overlap with overlay
    $("body").find('.site-footer').addClass('withoverlay')

  render: ->
    c = App.get().content
    html = """
      <div id='overlay-toggle'>
        <div id='overlay-button'><i class='fa fa-chevron-up'></i></div>
      </div>
      """
    @$el.html(html)
    @$el.append(@sudokuV.render().$el)
    console.log($(window).find('.site-footer').html())
    @events()
    return this

  events: ->
    @$el.find('#overlay-toggle').on 'click', =>
      @toggleOverlay()

  toggleOverlay: (open) ->
    if !@$el.hasClass('sliding')
      icon = @$el.find('#overlay-button').find('i')
      console.log(icon.get(0))
      if open || !@$el.hasClass('out')
        @$el.addClass('sliding')
        icon.removeClass('fa-chevron-up')
        icon.addClass('fa-chevron-down')
        # dirty hack to be able to get the auto height value
        el = @$el.clone().css('height', 'auto').hide().appendTo('body')
        auto = el.height()
        wHeight = $(window).outerHeight()-60 # Why 60 ? No idea... something with margins or overflow...
        @$el.height(Math.min(wHeight, auto))
        el.remove()
        setTimeout =>
          @$el.removeClass('sliding')
          @$el.addClass('out')
        , 1000
      else
        @$el.removeClass('out')
        @$el.addClass('sliding')
        icon.removeClass('fa-chevron-down')
        icon.addClass('fa-chevron-up')
        @$el.innerHeight('50px')
        setTimeout =>
          @$el.removeClass('sliding')
        , 1000
