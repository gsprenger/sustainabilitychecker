class window.CheckRadarView
  constructor: ->
    @$el = $("<div id='checkradar'>")
    @radar = App.get().radar

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      <canvas id='radarcanvas' width='600' height='600'></canvas>
      <div id='radarinfoS1' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i1_t', 'attr')}' data-content='#{c.text('chkr_rdr_i1_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS2' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i2_t', 'attr')}' data-content='#{c.text('chkr_rdr_i2_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS3' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i3_t', 'attr')}' data-content='#{c.text('chkr_rdr_i3_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS4' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i4_t', 'attr')}' data-content='#{c.text('chkr_rdr_i4_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS5' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i5_t', 'attr')}' data-content='#{c.text('chkr_rdr_i5_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS6' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i6_t', 'attr')}' data-content='#{c.text('chkr_rdr_i6_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS7' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i7_t', 'attr')}' data-content='#{c.text('chkr_rdr_i7_c', 'attr')}'></i>
      </div>
      <div id='radarinfoS8' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_i8_t', 'attr')}' data-content='#{c.text('chkr_rdr_i8_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG1' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G1_t', 'attr')}' data-content='#{c.text('chkr_rdr_G1_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG2' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G2_t', 'attr')}' data-content='#{c.text('chkr_rdr_G2_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG3' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G3_t', 'attr')}' data-content='#{c.text('chkr_rdr_G3_c', 'attr')}'></i>
      </div>
      <div id='radarinfoG4' class='radar-info'>
        <i class='fa fa-info-circle' data-toggle='popover' data-title='#{c.text('chkr_rdr_G4_t', 'attr')}' data-content='#{c.text('chkr_rdr_G4_c', 'attr')}'></i>
      </div>
      """
    @$el.html(html)
    canvasEl = @$el.find("#radarcanvas")
    dim = (if ($(window).height() > 1200) then $(window).height()/2 else 600)
    canvasEl.height(dim)
    canvasEl.width(dim)
    canvas = canvasEl.get(0).getContext("2d")
    margin = 50
    config = {
      animation: false,
      scaleShowLabels: false,
      scaleShowLine: true,
      scaleShowXYAxis: true,
      showLabels: true,
      scaleOverride: true,
      scaleSteps: 10,
      scaleStepWidth: 10,
      scaleStartValue: 0,
      segmentShowStroke: false,
      scaleFontSize: 10
    };
    new Chart(canvas, margin).PolarArea({}, config);
    # setTimeout =>
    new Chart(canvas, margin).PolarArea(@radar.getChartData(), config);
    # , 2000    
    @events()
    return this

  events: ->
    $('.radar-info').on 'click', ->
      $(this).popover('toggle')
