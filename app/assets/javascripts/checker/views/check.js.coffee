class window.CheckView
  constructor: ->
    @$el = $("<div id='check'>")

  render: ->
    c = App.get().content
    html = """
      <h2>#{c.text('chkr_check_title')}</h2>
      <div>
        TODO Summary of collected data
      </div>
      <div>
        TODO Check results
      </div>
      <div class='btn-row'>
      """
    if (App.get().level != 3)
      html += """
          <a href='/level#{App.get().level+1}'><div class='btn btn-lg btn-primary'>#{c.text('chkr_res_next')}</div></a>
        """
    html += """
        <a href='#'><div class='btn btn-lg btn-default'>#{c.text('chkr_res_again')}</div></a>
      </div>
      """
    @$el.html(html)
    return this
