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
    "sec":
      "food":
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
      "energy":
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

  get_sec_food: ->
    +(@findIntervalInf(@data.sec.food[1], (@sudoku.get_DS_food() / @sudoku.get_TFOOD()))).toPrecision(1)

  get_sec_energy: ->
    +(@findIntervalInf(@data.sec.energy[1], (@sudoku.get_DS_energy() / @sudoku.get_TET()))).toPrecision(1)

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
    # Config
    separatorAngle = 10
    colors =
      green:  "#5CB85C", 
      yellow: "#ED9C28", 
      red:    "#D2322D"
    thresholds =
      low:  30,
      med:  70,
      high: 100
    data = [
      @get_sec_food(),
      @get_sec_energy(),
      @get_soc_wage(),
      @get_soc_jobs(),
      @get_env_lan(),
      @get_env_pol(),
      @get_eco_val(),
      @get_eco_dev()
    ]
    # Generate data
    chartData = []
    for i in [0..data.length-1]
      # cap min max
      value = Math.max(data[i], 30)
      value = Math.min(data[i], 100)
      # determine color
      if value >= thresholds.low
        if value >= thresholds.med
          color = if data[i].section == 'Environment' then colors.red else colors.green
        else
          color = colors.yellow
      else
        color = if data[i].section == 'Environment' then colors.green else colors.red 
      # push data
      chartData.push
        min:   0,
        value: 0,
        max:   100,
        angle: (if i%2 == 0 then separatorAngle else separatorAngle/2),
        color: "#FFFFFF"
      chartData.push
        min:   0,
        value: value,
        max:   100,
        angle: 30,
        color: color,
        name: data[i].name,
        section: data[i].section
      chartData.push
        min:   0,
        value: 0,
        max:   100,
        angle: (if i%2 == 0 then separatorAngle/2 else separatorAngle),
        color: "#FFFFFF"
    return chartData
