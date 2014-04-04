class window.Density
  constructor: ->
    @name = 'density'
    @slug = 's_den'
    @type = 'supply'
    @headerIcon = 'fa-group'
    @i18nPrefix = 'chkr_den'
    @choices = []
    @choices.push(new Radio(@slug, ['low', 'med', 'high']))

  # SUDOKU DATA #
