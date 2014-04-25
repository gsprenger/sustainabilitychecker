class window.CheckResultView
  constructor: ->
    @$el = $("<div id='checkresult' class='checksection'>")

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      <h3 class='check-result'>#{c.text('chkr_res_title')}</h3>
      <p>#{c.text('chkr_res_explanation')}</p>
      <div class='btn-row'>
      """
    if (level != 3)
      html += """
          <a href='/level#{level+1}'><div class='btn btn-lg btn-primary'>#{c.text('chkr_res_next')}</div></a>
        """
    html += """
        <div class='btn-again btn btn-lg btn-default'>#{c.text('chkr_res_again')}</div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.btn-again').on 'click', =>
      @$el.hide()
      $('body').animate({scrollTop: $('.section').first().offset().top}, 1000)
