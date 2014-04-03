class window.Demographics
  constructor: ->
    @name = 'demographics'
    @slug = 'd_dem'
    @type = 'demand'
    @headerIcon = 'fa-globe'
    @i18nPrefix = 'chkr_dem'
    @choices = []
    @choices.push(
      new Radio(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #
  data:
    "HA_PW": # hours p.c.
      "low":  1314
      "med":  876
      "high": 631
    "HA_HH": # hours p.c.
      "low":  7446
      "med":  7884
      "high": 8129

  get_HA_PW: ->
    @data.HA_PW[@choices[0].getValue()]

  get_HA_HH: ->
    @data.HA_HH[@choices[0].getValue()]
