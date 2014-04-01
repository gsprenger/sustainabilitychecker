class window.AgricultureModel extends SectionModel
  constructor: ->
    @name = 'agriculture'
    @slug = 's_agr'
    @type = 'supply'
    @headerIcon = 'fa-leaf'
    @i18nPrefix = 'chkr_agr'
    @choices = []
    @choices.push(
      new RadioModel(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #  
  data:
    "labor_density": # hrs/ha
      "low":  720
      "med":  210
      "high": 12
    "EMD_AG": # GJ-EC_FUELS/ha
      "low":  6.7
      "med":  15
      "high": 29.3
    "HA_AG_IN_PW": # %age
      "low":  0.31
      "med":  0.13
      "high": 0.02
    "EMR_AG": # MJ-GER/hr
      "low":  2
      "med":  70
      "high": 300

  get_labor_density: ->
    @data.labor_density[@choices[0].getValue()]

  get_EMD_AG: ->
    @data.EMD_AG[@choices[0].getValue()]

  get_HA_AG_IN_PW: ->
    @data.HA_AG_IN_PW[@choices[0].getValue()]
    
  get_EMR_AG: ->
    @data.EMR_AG[@choices[0].getValue()]
    
  get_HA_AG: ->
    (App.get().demographics.get_HA_PW() * @get_HA_AG_IN_PW())
    
  get_ET_AG: ->
    (@get_HA_AG() * @get_EMR_AG())
    
  get_LU_AG: ->
    (App.get().diet.get_grains_equiv() * App.get().land.get_land_prod())
    
  get_post_harv: ->
    1 # MISSING DATA
    
  get_food_hyper: ->
    1 # MISSING DATA
