class window.CheckResultView
  constructor: ->
    @$el = $("<div id='checkres-container'>")
    @graph = new CheckGraphView()
    @radar = new CheckRadarView()
    if App.get().level == 1
      @sudoku = new SudokuView()

  render: ->
    l = App.get().level
    c = App.get().content
    success = (if App.get().sudoku.getSuccess() then 'passed' else 'failed')
    html = "<div class='checkresult in-level#{App.get().level}'>"
    if !App.get().isMercury
      html += """
        <h2 class='check-result-title #{success}'>#{c.text('chkr_res_title_'+success)}</h2>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_'+success+l)}</p>
        """
    else
      html += """
        <h3>(Editor only) chkr_res_title_passed:</h3>
        <h2 class='check-result-title #{success}'>#{c.text('chkr_res_title_passed')}</h2>
        <h3>(Editor only) chkr_res_title_failed:</h3>
        <h2 class='check-result-title #{success}'>#{c.text('chkr_res_title_failed')}</h2>
        <h3>(Editor only) chkr_res_explanation_passed1:</h3>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_passed1')}</p>
        <h3>(Editor only) chkr_res_explanation_failed1:</h3>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_failed1')}</p>
        <h3>(Editor only) chkr_res_explanation_passed2:</h3>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_passed2')}</p>
        <h3>(Editor only) chkr_res_explanation_failed2:</h3>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_failed2')}</p>
        <h3>(Editor only) chkr_res_explanation_passed3:</h3>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_passed3')}</p>
        <h3>(Editor only) chkr_res_explanation_failed3:</h3>
        <p class='check-result-expl'>#{c.text('chkr_res_explanation_failed3')}</p>
        """
    # Graph and radar
    html += """
      </div>
      <div class='row checkcharts'>
        <div id='checkgraphcont' class='col-md-6'></div>
        <div id='checkradarcont' class='col-md-6'></div>
      </div>
      <div class='checkresult in-level#{App.get().level}'>
      """
    if !App.get().isMercury
      html += """
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_'+success+l)}</p>
        """
    else
      html += """
          <h3>(Editor only) chkr_res_explanation2_passed1:</h3>
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_passed1')}</p>
          <h3>(Editor only) chkr_res_explanation2_failed1:</h3>
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_failed1')}</p>
          <h3>(Editor only) chkr_res_explanation2_passed2:</h3>
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_passed2')}</p>
          <h3>(Editor only) chkr_res_explanation2_failed2:</h3>
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_failed2')}</p>
          <h3>(Editor only) chkr_res_explanation2_passed3:</h3>
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_passed3')}</p>
          <h3>(Editor only) chkr_res_explanation2_failed3:</h3>
          <p class='check-result-expl'>#{c.text('chkr_res_explanation2_failed3')}</p>
        """
    html += """
        <div id='checksudokucont'></div>
        <div class='btn-row'>
      """
    if (l != 3)
      html += """
            <a href='/level#{l+1}'><div class='btn btn-lg btn-primary'>#{c.text('chkr_res_next')}</div></a>
        """
    html += """
          <div class='btn-again btn btn-lg btn-default'>#{c.text('chkr_res_again')}</div>
        </div>
      </div>
      """
    @$el.html(html)
    @$el.find('#checkgraphcont').append(@graph.render().$el)
    @$el.find('#checkradarcont').append(@radar.render().$el)
    if l < 3
      @$el.find('#checksudokucont').append(@sudoku.render().$el)
    if !App.get().isMercury
      @$el.hide()
    @events()
    return this

  events: ->
    @$el.find('.btn-again').on 'click', =>
      @$el.hide()
      $('body').animate({scrollTop: $('.section').first().offset().top}, 1000)
    $(window).on 'clickshowresult', =>
      @$el.show()
      $('body').animate({scrollTop: $('.checkresult').first().offset().top}, 500)
