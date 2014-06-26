class window.CheckView
  constructor: ->
    @$el = $("<div id='check' class='in-level#{App.get().level}'>")
    @graph = new CheckGraphView()
    @radar = new CheckRadarView()
    if App.get().level == 1
      @sudoku = new SudokuView()
    @summary = new CheckSummaryView()
    # events placed in constructor because they're attached to window and shouldnt be repeated with each render
    $(window).on 'showcheck', =>
      @render()
      @$el.show()
      $('body,html').stop(true,true).animate({scrollTop: $('#check').offset().top}, 500)
    $(window).on 'choicecomplete', =>
      @render()

  render: ->
    l = App.get().level
    c = App.get().content
    e = App.get().experiment
    sud = App.get().sudoku
    success = (if sud.getSuccess() then 'passed' else 'failed')
    html = """
        <div class='checkresult in-level#{App.get().level}'>
          <h2>#{c.text('check_title', 'simple')}</h2>
      """
    if !App.get().isMercury
      html += """
        <h2 class='check-result-title #{success}'>#{c.text('chkr_res_title_'+success)}</h2>
        <div class='check-result-expl'>#{c.text('chkr_res_explanation_'+success+l)}</div>
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
      <div class='checkresult in-level#{l}'>
      """
    if !App.get().isMercury
      html += """
          <div class='check-result-expl'>#{c.text('chkr_res_explanation2_'+success+l)}</div>
        """
    else
      html += """
          <h3>(Editor only) Radar info pop-up:</h3>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i1_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i1_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i2_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i2_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i3_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i3_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i4_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i4_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i5_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i5_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i6_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i6_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i7_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i7_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_i8_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_i8_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_iG1_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_iG1_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_iG2_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_iG2_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_iG3_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_iG3_c')}
            </div>
          </div>
          <div class='panel panel-default'>
            <div class='panel-heading'>
              #{c.text('chkr_rdr_iG4_t')}
            </div>
            <div class='panel-body'>
              #{c.text('chkr_rdr_iG4_c')}
            </div>
          </div>
        
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
        </div>
      """
    # Indicators panels for level 3
    if l == 3
      foodSuccess = sud.getFoodSuccess()
      energySuccess = sud.getEnergySuccess()
      HASuccess = sud.getHASuccess()
      LUSuccess = sud.getLUSuccess()
      EMRSuccess = sud.getEMRSuccess()
      html += """
        <br>
        <div class='row'>
          <div class='col-sm-6'>
            <div class='panel panel-#{if foodSuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if foodSuccess then 'check' else 'times'}'></i> #{c.text('chkr_sud_food'+(if foodSuccess then 'suc' else 'fail')+'_t', 'simple')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_food'+(if foodSuccess then 'suc' else 'fail')+'_c')}
              </div>
            </div>
          </div>
          <div class='col-sm-6'>
            <div class='panel panel-#{if energySuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if energySuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_energy'+(if energySuccess then 'suc' else 'fail')+'_t', 'simple')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_energy'+(if energySuccess then 'suc' else 'fail')+'_c')}
              </div>
            </div>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-6'>
            <div class='panel panel-#{if HASuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if HASuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_HA'+(if HASuccess then 'suc' else 'fail')+'_t', 'simple')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_HA'+(if HASuccess then 'suc' else 'fail')+'_c')}
              </div>
            </div>
          </div>
          <div class='col-sm-6'>
            <div class='panel panel-#{if LUSuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if LUSuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_LU'+(if LUSuccess then 'suc' else 'fail')+'_t', 'simple')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_LU'+(if LUSuccess then 'suc' else 'fail')+'_c')}
              </div>
            </div>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-12'>
            <div class='panel panel-#{if EMRSuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if EMRSuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_EMR'+(if EMRSuccess then 'suc' else 'fail')+'_t', 'simple')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_EMR'+(if EMRSuccess then 'suc' else 'fail')+'_c')}
              </div>
            </div>
          </div>
        </div>
      """
    html += """
        <div id='checksudokucont'></div>
        <div id='checksummarycont'></div>
        <div class='btn-row'>
          <div class='btn-again btn btn-lg btn-default'>#{c.text('chkr_res_again')}</div>
      """
    if (l != 3)
      html += """
            <div class='btnlevel btn btn-lg btn-primary'>#{c.text('chkr_res_next')}</div>
        """
    else 
      html += """
            <div class='btnshare btn btn-lg btn-primary'>#{c.text('share_btn')}</div>
        """
    html += """
        </div>
      </div>
      """
    @$el.html(html)
    @$el.find('#checkgraphcont').empty().append(@graph.render().$el)
    @$el.find('#checkradarcont').empty().append(@radar.render().$el)
    if l == 1
      @$el.find('#checksudokucont').empty().append(@sudoku.render().$el)
    @$el.find('#checksummarycont').empty().append(@summary.render().$el)
    if !App.get().isMercury && l == 1 && App.get().experiment.getCurrent() != 'check'
      @$el.hide()
    @events()
    return this

  events: ->
    @$el.find('.btn-again').on 'click', =>
      $('#modal-tryagain').modal()
    @$el.find('.btnlevel').on 'click', =>
      App.get().experiment.setLastLevel(App.get().level+1)
      window.location.href = '/level'+(App.get().level+1)
