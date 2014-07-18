class window.ScrollTopIconView
  constructor: ->
    @$el = $("<div id='scrolltopicon-cont' class='inlevel#{App.get().level}'>")

  render: ->
    c = App.get().content
    html = """
        <div id='scrolltopicon' title='#{c.text('chkr_scrolltop_t', 'none')}'>
          <i class='fa fa-arrow-circle-o-up'></i>
        </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    $(window).scroll ->
      if $(this).scrollTop() > 100
        $('#scrolltopicon-cont').fadeIn()
      else
        $('#scrolltopicon-cont').fadeOut()
    @$el.find('#scrolltopicon').on 'click', ->
      $('html, body').animate({scrollTop : 0},800)
      false
