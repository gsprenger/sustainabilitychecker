class window.CheckRadarView
  constructor: ->
    @$el = $("<div id='checkradar'>")
    @radar = App.get().radar

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      <canvas id='radarcanvas' width='600' height='600'></canvas>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    $(window).on 'clickshowresult', =>
      canvasEl = @$el.find("#radarcanvas")
      dim = (if ($(window).height() > 1200) then $(window).height()/2 else 600)
      canvasEl.height(dim)
      canvasEl.width(dim)
      canvas = canvasEl.get(0).getContext("2d")
      margin = 50
      config = {
        scaleShowLabels: false,
        scaleShowLine: true,
        scaleShowXYAxis: true,
        showLabels: true
      };
      new Chart(canvas, margin).PolarArea({}, config);
      setTimeout =>
        new Chart(canvas, margin).PolarArea(@radar.getChartData(), config);
      , 2000
