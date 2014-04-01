class window.LandModel extends SectionModel
  constructor: ->
    @name = 'land'
    @slug = 's_lan'
    @type = 'supply'
    @headerIcon = 'fa-picture'
    @i18nPrefix = 'chkr_lan'
    @choices = []
    @choices.push(
      new RadioModel(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #
  data:
    "s_lan": # ha p.c.
      "low":  0.08
      "med":  0.3
      "high": 0.5

  get_s_lan: ->
    @data.s_lan[@choices[0].getValue()]

  get_land_prod: ->
    1 # MISSING DATA
