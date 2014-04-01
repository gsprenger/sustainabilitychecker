class window.DensityModel extends SectionModel
  constructor: ->
    @name = 'density'
    @slug = 's_den'
    @type = 'supply'
    @headerIcon = 'fa-group'
    @i18nPrefix = 'chkr_den'
    @choices = []
    @choices.push(
      new RadioModel(@slug, ['low', 'med', 'high'], @experiment))

  # SUDOKU DATA #
