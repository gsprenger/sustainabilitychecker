class window.CheckRadarView
  constructor: ->
    @$el = $("<div id='checkradar'>")

  render: ->
    level = App.get().level
    c = App.get().content
    html = """
      <div id='radarcanvas'></div>
      """
    @$el.html(html)
    #@events()
    return this

  events: ->
    $(window).on 'clickshowresult', =>
      canvas = $("#radarcanvas").getContext("2d")
      margin = 100
      config = {
        scaleShowLabels: false,
        scaleShowLine: true,
        scaleShowXYAxis: true,
        showLabels: true
      };
      new Chart(canvas, margin).PolarArea(@chartData(), config);

  chartData: ->
    chartData = []
    for i in [1..8]
      chartData.push({
        min:   0,
        value: 0,
        max:   100,
        angle: 10,
        unit:  '',
        color: '#ffffff'
      });  
      chartData.push({
        min:   0,
        value: 10*i+20,
        max:   100,
        angle: 25,
        unit:  'u.',
        color: '#666',
        name: 'name',
        section: 'section'
      });   
      chartData.push({
        min:   0,
        value: 0,
        max:   100,
        angle: 10,
        unit:  '',
        color: '#ffffff'
      });
    return chartData
