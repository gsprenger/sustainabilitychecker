class window.CheckRadarView
  constructor: ->
    @$el = $("<div id='checkradar'>")

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
        new Chart(canvas, margin).PolarArea(@chartData(), config);
      , 2000

  chartData: ->
    data = [
      {
        section: 'Security',
        name: 'Quality',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Security',
        name: 'Quantity',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Society',
        name: 'Wage',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Society',
        name: 'Jobs',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Environment',
        name: 'Soil pollution',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Environment',
        name: 'Land use',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Economics',
        name: 'Currency',
        value: '',
        unit: '',
        color: ''
      },
      {
        section: 'Economics',
        name: 'Value added',
        value: '',
        unit: '',
        color: ''
      },
    ]
    chartData = []
    for i in [0..7]
      chartData.push({
        min:   0,
        value: Math.floor(Math.random() * 70 + 20), #data[i].value,
        max:   100,
        angle: 45,
        unit:  data[i].unit,
        color: '#'+(Math.random()*0xFFFFFF<<0).toString(16), #data[i].color,
        name: data[i].name,
        section: data[i].section
      });     
    return chartData
