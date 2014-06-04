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
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i1_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i1_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS2' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i2_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i2_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS3' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i3_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i3_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS4' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i4_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i4_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS5' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i5_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i5_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS6' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i6_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i6_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS7' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i7_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i7_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoS8' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_i8_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_i8_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoG1' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_iG1_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_iG1_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoG2' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_iG2_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_iG2_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoG3' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_iG3_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_iG3_c')}
          </div>
        </div>
      </div>
      <div id='radarinfoG4' class='radar-info'>
        <i class='fa fa-info-circle'></i>
        <div class='popover'>
          <div class='popover-title'>
            #{c.text('chkr_rdr_iG4_t')}
          </div>
          <div class='popover-content'>
            #{c.text('chkr_rdr_iG4_c')}
          </div>
        </div>
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
    $(window).on 'appready', ->
      $('.radar-info').find('.fa').popover({
        placement: 'bottom',
        trigger: 'hover',
        container: 'body'
        html: true,
        title: ->
          $(this).next('.popover').find('.popover-title').html()
        , content: ->
          $(this).next('.popover').find('.popover-content').html()
      })
    $('.radar-info').on 'click', ->
      $(this).popover('toggle')
