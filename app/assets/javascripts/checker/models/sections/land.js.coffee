class window.Land
  constructor: ->
    @name = 'land'
    @slug = 's_lan'
    @type = 'supply'
    @headerIcon = 'fa-picture-o'
    @i18nPrefix = 'chkr_lan'
    @choices = []
    @choices.push(
      new Radio(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #
  data:
    "s_lan": # ha p.c.
      "low":  0.08
      "med":  0.3
      "high": 0.5

  getValue: ->
    @choices[0].getValue()

  get_s_lan: ->
    @data.s_lan[@getValue()]
