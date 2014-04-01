class window.DietModel extends SectionModel
  constructor: ->
    @name = 'diet'
    @slug = 'd_die'
    @type = 'demand'
    @headerIcon = 'fa-cutlery'
    @i18nPrefix = 'chkr_die'
    @choices = []
    @choices.push(
      new RadioModel(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #
  data:
    "grains_equiv":
      "low":  200
      "med":  375
      "high": 1000

  get_grains_equiv: ->
    @data.grains_equiv[@choices[0].getValue()]
