class window.App
  instance = null

  class PrivateApp
    constructor: ->

    launchLevel:(num) ->
      # Models
      @experiment = new Experiment(num)
      @content = Content.setup()
      @Glossary = Glossary.setup()
      @demographics = new Demographics()
      @diet         = new Diet()
      @households   = new Households()
      @services     = new Services()
      @land         = new Land()
      @bm           = new Bm()
      @agriculture  = new Agriculture()
      @energy       = new Energy()
      @sections = [@demographics, @diet, @households, @services, @land, @bm, @agriculture, @energy]
      @sudoku = new Sudoku(@demographics, @diet, @households, @services, @land, @bm, @agriculture, @energy)
      # launch main view
      @level = num
      @appView = new AppView()
      @appView.render()


  @get: ->
    # singleton pattern
    instance ?= new PrivateApp()
