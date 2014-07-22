class window.CheckRadarView
  constructor: ->
    @$el = $("<div id='checkradar'>")
    @radar = App.get().radar
    @canDraw = false
    $(window).on 'appready', =>
      @canDraw = true
      @drawRadar()
    $(window).on 'resize', =>
      @drawRadar()

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      <canvas id='radarcanvas'></canvas>
      <div id='radarinfoS1' class='radar-info'>
        #{c.text('chkr_rdr_i1_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i1_t', 'attr')}' data-content='#{c.text('chkr_rdr_i1_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS2' class='radar-info'>
        #{c.text('chkr_rdr_i2_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i2_t', 'attr')}' data-content='#{c.text('chkr_rdr_i2_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS3' class='radar-info'>
        #{c.text('chkr_rdr_i3_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i3_t', 'attr')}' data-content='#{c.text('chkr_rdr_i3_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS4' class='radar-info'>
        #{c.text('chkr_rdr_i4_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i4_t', 'attr')}' data-content='#{c.text('chkr_rdr_i4_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS5' class='radar-info'>
        #{c.text('chkr_rdr_i5_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i5_t', 'attr')}' data-content='#{c.text('chkr_rdr_i5_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS6' class='radar-info'>
        #{c.text('chkr_rdr_i6_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i6_t', 'attr')}' data-content='#{c.text('chkr_rdr_i6_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS7' class='radar-info'>
        #{c.text('chkr_rdr_i7_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i7_t', 'attr')}' data-content='#{c.text('chkr_rdr_i7_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS8' class='radar-info'>
        #{c.text('chkr_rdr_i8_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i8_t', 'attr')}' data-content='#{c.text('chkr_rdr_i8_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG1' class='radar-info'>
        #{c.text('chkr_rdr_G1_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G1_t', 'attr')}' data-content='#{c.text('chkr_rdr_G1_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG2' class='radar-info'>
        #{c.text('chkr_rdr_G2_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G2_t', 'attr')}' data-content='#{c.text('chkr_rdr_G2_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG3' class='radar-info'>
        #{c.text('chkr_rdr_G3_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G3_t', 'attr')}' data-content='#{c.text('chkr_rdr_G3_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG4' class='radar-info'>
        #{c.text('chkr_rdr_G4_t', 'none')} <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G4_t', 'attr')}' data-content='#{c.text('chkr_rdr_G4_c', 'attr')}'></i>
      </div>
      """
    @$el.html(html)
    if @canDraw
      @drawRadar()
    @events()
    return this

  events: ->

  drawRadar: ->    
    canvasEl = @$el.find("#radarcanvas")
    dim = $('#checkradarcont').width()
    canvas = canvasEl.get(0).getContext("2d")
    canvas.canvas.height = dim
    canvas.canvas.width = dim
    $('#checkgraph').css('margin-top', ((dim/2)-150)+'px')
    margin = 10
    config = {
      animation: false,
      scaleShowLabels: false,
      scaleShowLine: true,
      scaleShowXYAxis: true,
      showLabels: false,
      scaleOverride: true,
      scaleSteps: 10,
      scaleStepWidth: 10,
      scaleStartValue: 0,
      segmentShowStroke: false,
      scaleFontSize: 10
    };
    new Chart(canvas, margin).PolarArea(@radar.getChartData(), config);
