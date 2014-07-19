class window.Radar
  constructor: ->
    app = App.get()
    @demographics = app.demographics
    @diet = app.diet
    @households = app.households
    @services = app.services
    @land = app.land
    @bm = app.bm
    @agriculture = app.agriculture
    @energy = app.energy
    @sudoku = app.sudoku

  # SUDOKU DATA #
  data:
    "eco":
      "val":
        "1":
          '4':  10
          '5':  20
          '6':  30
          '7':  40
          '8':  50
          '9':  60
          '10': 70
          '11': 80
          '12': 90
        "2":
          'low':  10
          'med':  50
          'high': 90
      "dev":
        "1":
          'low':  10
          'med':  50
          'high': 90
    "sov":
      "qual":
        "1":
          '4':  10
          '5':  20
          '6':  30
          '7':  40
          '8':  50
          '9':  60
          '10': 70
          '11': 80
          '12': 90
      "quan":
        "1":
          '0.1': 10
          '0.2': 20
          '0.4': 30
          '0.5': 40
          '0.6': 50
          '0.7': 60
          '0.8': 70
          '0.9': 80
          '100': 90
        "2":
          '0.1': 10
          '0.2': 20
          '0.4': 30
          '0.5': 40
          '0.6': 50
          '0.7': 60
          '0.8': 70
          '0.9': 80
          '100': 90
    "soc":
      "wage":
        "1":
          'low':  10
          'med':  50
          'high': 90
        "2":
          'low':  10
          'med':  50
          'high': 90
        "3":
          '4':  10
          '5':  20
          '6':  30
          '7':  40
          '8':  50
          '9':  60
          '10': 70
          '11': 80
          '12': 90
      "jobs":
        "1":
          'low':  90
          'med':  50
          'high': 10
        "2":
          'low':  90
          'med':  50
          'high': 10
    "env":
      "lan":
        "1":
          '0.1': 10
          '0.2': 20
          '0.4': 30
          '0.5': 40
          '0.6': 50
          '0.7': 60
          '0.8': 70
          '0.9': 80
          '100': 90
      "pol":
        "1":
          'low':  10
          'med':  50
          'high': 90

  get_eco_val: ->
    +((@data.eco.val[1][@services.getValue()] + @data.eco.val[2][@bm.getValue()]) / 2).toPrecision(1)

  get_eco_dev: ->
    +(@data.eco.dev[1][@bm.getValue()]).toPrecision(1)

  get_sov_qual: ->
    +(@data.sov.qual[1][@services.getValue()]).toPrecision(1)

  get_sov_quan: ->
    +((@findIntervalInf(@data.sov.quan[1], (@sudoku.get_DS_food() / @sudoku.get_TFOOD())) +
     @findIntervalInf(@data.sov.quan[1], (@sudoku.get_DS_energy() / @sudoku.get_TET()))) / 2).toPrecision(1)

  get_soc_wage: ->
    +((@data.soc.wage[1][@agriculture.getValue()] + 
     @data.soc.wage[2][@bm.getValue()] +
     @data.soc.wage[3][@services.getValue()]
    ) / 3).toPrecision(1)

  get_soc_jobs: ->
    +((@data.soc.jobs[1][@agriculture.getValue()] + 
     @data.soc.jobs[2][@bm.getValue()]
    ) / 2).toPrecision(1)

  get_env_lan: ->
    +(@findIntervalInf(@data.env.lan[1], (@land.get_s_lan() / @sudoku.get_TLU()))).toPrecision(1)

  get_env_pol: ->
    +(@data.env.pol[1][@agriculture.getValue()]).toPrecision(1)

  findIntervalInf: (listObj, value) ->
    keys = Object.keys(listObj)
    keys.sort()
    for key in keys
      if value <= +key
        return listObj[key]
    return listObj[listObj.length-1]

  getChartData: ->
    data = [
      {
        section: 'International trade',
        name: 'Quality',
        value: @get_sov_qual()
      },
      {
        section: 'International trade',
        name: 'Quantity',
        value: @get_sov_quan()
      },
      {
        section: 'Society',
        name: 'Wage',
        value: @get_soc_wage()
      },
      {
        section: 'Society',
        name: 'Jobs',
        value: @get_soc_jobs()
      },
      {
        section: 'Environment',
        name: 'Land use',
        value: @get_env_lan()
      },
      {
        section: 'Environment',
        name: 'Soil pollution',
        value: @get_env_pol()
      },
      {
        section: 'Economic',
        name: 'Value added',
        value: @get_eco_val()
      },
      {
        section: 'Economic',
        name: 'Currency',
        value: @get_eco_dev()
      }
    ]
    chartData = []
    colors = ["#5CB85C", "#ED9C28", "#D2322D"]
    thresholds = [100, 70, 30, 0]
    for i in [1..3]
      for j in [0..7]
        # Set proper value
        value = data[j].value
        if value >= thresholds[i-1]
          drawVal = thresholds[i-1]
        else if value < thresholds[i]
          drawVal = 0
        else 
          drawVal = value
        # Colors, reverse Env. colors
        color = colors[i-1]
        if data[j].section == 'Environment'
          color = colors[3-i]
        chartData.push({
          min:   0,
          value: drawVal,
          max:   100,
          angle: 45,
          color: color,
          name: if i == 3 then data[j].name else '',
          section: if i == 1 then data[j].section else '',
        });     
    return chartData
