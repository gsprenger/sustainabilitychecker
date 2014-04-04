class window.Diet
  constructor: ->
    @name = 'diet'
    @slug = 'd_die'
    @type = 'demand'
    @headerIcon = 'fa-cutlery'
    @i18nPrefix = 'chkr_die'
    @choices = []
    @choices.push(new Radio(@slug, ['low', 'med', 'high']))

  # SUDOKU DATA #
  data:
    "grains_equiv":
      "low":  200
      "med":  375
      "high": 1000
    "HH_food":
      "low":  200
      "med":  250
      "high": 200
    "SG_food":
      "low":  0
      "med":  25
      "high": 100
    "BM_food":
      "low":  0
      "med":  50
      "high": 100
    "AG_food":
      "low":  0
      "med":  50
      "high": 600

  getValue: ->
    @choices[0].getValue()

  get_grains_equiv: ->
    @data.grains_equiv[@getValue()]

  get_HH_food: ->
    @data.HH_food[@getValue()]

  get_SG_food: ->
    @data.SG_food[@getValue()]

  get_BM_food: ->
    @data.BM_food[@getValue()]

  get_AG_food: ->
    @data.AG_food[@getValue()]
