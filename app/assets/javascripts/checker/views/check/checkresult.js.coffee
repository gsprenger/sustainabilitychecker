class window.CheckResultView
  constructor: ->
    @$el = $("<div id='checkresult' class='in-level#{App.get().level}'>")
    @graph = new CheckGraphView()
    @radar = new CheckRadarView()

  render: ->
    l = App.get().level
    c = App.get().content
    success = (if App.get().sudoku.getSuccess() then 'passed' else 'failed')
    html = """
      <h2 class='check-result-title #{success}'>#{c.text('chkr_res_title_'+success)}</h2>
      <p class='check-result-expl'>#{c.text('chkr_res_explanation_'+success+l)}</p>
      <div class='row'>
        <div id='checkgraphcont' class='col-md-6'></div>
        <div id='checkradarcont' class='col-md-6'></div>
      </div>
      <p class='check-result-expl'>#{c.text('chkr_res_explanation2_'+success+l)}</p>
      <div class='btn-row'>
      """
    if (l != 3)
      html += """
          <a href='/level#{l+1}'><div class='btn btn-lg btn-primary'>#{c.text('chkr_res_next')}</div></a>
        """
    html += """
        <div class='btn-again btn btn-lg btn-default'>#{c.text('chkr_res_again')}</div>
      </div>
      """
    @$el.html(html)
    @$el.find('#checkgraphcont').append(@graph.render().$el)
    @$el.find('#checkradarcont').append(@radar.render().$el)
    @$el.hide()
    @events()
    return this

  events: ->
    @$el.find('.btn-again').on 'click', =>
      @$el.hide()
      $('body').animate({scrollTop: $('.section').first().offset().top}, 1000)
    $(window).on 'clickshowresult', =>
      @$el.show()
      $('body').animate({scrollTop: $('#checkresult').offset().top}, 500)
