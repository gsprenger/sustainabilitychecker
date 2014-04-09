class window.App
  instance = null

  class PrivateApp
    constructor: ->

    launchLevel:(num) ->
      # Models
      @content = Content.setup()
      @experiment = new Experiment(num)
      @demographics = new Demographics()
      @diet         = new Diet()
      @households   = new Households()
      @services     = new Services()
      @density      = new Density()
      @land         = new Land()
      @bm           = new Bm()
      @agriculture  = new Agriculture()
      @energy       = new Energy()
      @sections = [@demographics, @diet, @households, @services, @density, @land, @bm, @agriculture, @energy]
      @sudoku = new Sudoku(@demographics, @diet, @households, @services, @density, @land, @bm, @agriculture, @energy)
      # launch main view
      @level = num
      @appView = new AppView()
      @appView.render()

  @get: ->
    # singleton pattern
    instance ?= new PrivateApp()
