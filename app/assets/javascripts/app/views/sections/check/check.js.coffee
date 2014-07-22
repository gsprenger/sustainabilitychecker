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
          <h2>#{c.text('check_title')}</h2>
      <h2 class='check-result-title #{success}'>#{c.text('chkr_res_title_'+success)}</h2>
      <div class='check-result-expl'>#{c.text('chkr_res_explanation_'+success+l)}</div>
      </div>
      
      <div class='row chartstitles'>
        <div class='col-md-5'>
          <h3>#{c.text('chkr_graph_maintitle')}</h3>
        </div>
        <div class='col-md-7'>
          <h3>#{c.text('chkr_radar_maintitle')}</h3>
        </div>
      </div>
      <div class='row checkcharts'>
        <div id='checkgraphcont' class='col-md-5'></div>
        <div id='checkradarcont' class='col-md-7'></div>
      </div>
      <div class='checkresult in-level#{l}'>
        <div class='check-result-expl'>#{c.text('chkr_res_explanation2_'+success+l)}</div>
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
                <i class='fa fa-#{if foodSuccess then 'check' else 'times'}'></i> #{c.text('chkr_sud_food'+(if foodSuccess then 'suc' else 'fail')+'_t', 'none')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_food'+(if foodSuccess then 'suc' else 'fail')+'_c', 'none')}
              </div>
            </div>
          </div>
          <div class='col-sm-6'>
            <div class='panel panel-#{if energySuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if energySuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_energy'+(if energySuccess then 'suc' else 'fail')+'_t', 'none')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_energy'+(if energySuccess then 'suc' else 'fail')+'_c', 'none')}
              </div>
            </div>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-6'>
            <div class='panel panel-#{if HASuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if HASuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_HA'+(if HASuccess then 'suc' else 'fail')+'_t', 'none')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_HA'+(if HASuccess then 'suc' else 'fail')+'_c', 'none')}
              </div>
            </div>
          </div>
          <div class='col-sm-6'>
            <div class='panel panel-#{if LUSuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if LUSuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_LU'+(if LUSuccess then 'suc' else 'fail')+'_t', 'none')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_LU'+(if LUSuccess then 'suc' else 'fail')+'_c', 'none')}
              </div>
            </div>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-12'>
            <div class='panel panel-#{if EMRSuccess then 'success' else 'danger'}'>
              <div class='panel-heading'>
                <i class='fa fa-#{if EMRSuccess then 'check' else 'times'}'></i>
                #{c.text('chkr_sud_EMR'+(if EMRSuccess then 'suc' else 'fail')+'_t', 'none')}
              </div>
              <div class='panel-body'>
                #{c.text('chkr_sud_EMR'+(if EMRSuccess then 'suc' else 'fail')+'_c', 'none')}
              </div>
            </div>
          </div>
        </div>
      """
    html += """
        <div id='checksudokucont'></div>
        <div class='check-result-expl'>#{c.text('chkr_res_explanation3_'+success+l)}</div>
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
    @$el.find('.btnshare').on 'click', ->
      $('#modal-share').modal()
