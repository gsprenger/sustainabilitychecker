class window.Bm
  constructor: ->
    @name = 'bm'
    @slug = 's_bm'
    @type = 'supply'
    @headerIcon = 'fa-wrench'
    @i18nPrefix = 'chkr_ind'
    @choices = []
    @choices.push(new Radio(@slug, ['low', 'med', 'high']))

  # SUDOKU DATA #  
  data:
    "ET_BM": # GJ-GER p.c.
      "low":  25
      "med":  37
      "high": 148
    "EMR_BM": # MJ-GER/hr
      "low":  177
      "med":  145
      "high": 680
    "HA_BM": # hours p.c.
      "low":  141
      "med":  257
      "high": 218

  getValue: ->
    @choices[0].getValue()

  get_ET_BM: ->
    @data.ET_BM[@getValue()]

  get_EMR_BM: ->
    @data.EMR_BM[@getValue()]

  get_HA_BM: ->
    @data.HA_BM[@getValue()]
