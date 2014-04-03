class window.Agriculture
  constructor: ->
    @name = 'agriculture'
    @slug = 's_agr'
    @type = 'supply'
    @headerIcon = 'fa-leaf'
    @i18nPrefix = 'chkr_agr'
    @choices = []
    @choices.push(
      new Radio(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #  
  data:
    "LAN_prod": # kg grains/ha
      "low":  1000
      "med":  3000
      "high": 8000
    "labor_density_AG": # hrs/ha
      "low":  720
      "med":  210
      "high": 12
    "EMD_AG": # GJ-EC_FUELS/ha
      "low":  6.7
      "med":  15
      "high": 29.3
    "EMR_AG": # MJ-GER/hr
      "low":  2
      "med":  70
      "high": 300

  getValue: ->
    @choices[0].getValue()

  get_LAN_prod: ->
    @data.LAN_prod[@getValue()]

  get_labor_density_AG: ->
    @data.labor_density_AG[@getValue()]

  get_EMD_AG: ->
    @data.EMD_AG[@getValue()]
    
  get_EMR_AG: ->
    @data.EMR_AG[@getValue()]
    
  get_LU_AG: ->
    (App.get().diet.get_grains_equiv() * @get_LAN_prod())
    
  get_HA_AG: ->
    (@get_LU_AG() * @get_labor_density_AG())
    
  get_ET_AG: ->
    (@get_HA_AG() * @get_EMR_AG())/1000
