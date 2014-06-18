class window.App
  instance = null

  class PrivateApp
    constructor: ->

    launchApp: ->
      # get exp model from local storage or create new
      @experiment = new Experiment()
      # check if trying to load a specific level
      requestedLvl = +window.location.pathname.slice(-1)
      # if trying to play a level without having played previous ones, redirect
      if @experiment.getLastLevel() < requestedLvl
        document.location = '/level'+@experiment.getLastLevel()
      # if trying to load an already played level or last level, allow it. 
      else
        @level = requestedLvl
        # setup Application
        @isMercury = (document.URL.indexOf('mercury') > 0)
        # Models
        @content = Content.setup()
        @demographics = new Demographics()
        @diet         = new Diet()
        @households   = new Households()
        @services     = new Services()
        @land         = new Land()
        @bm           = new Bm()
        @agriculture  = new Agriculture()
        @energy       = new Energy()
        @sections = [@demographics, @diet, @households, @services, @land, @bm, @agriculture, @energy]
        @sudoku = new Sudoku()
        @radar = new Radar()
        # Main view
        @appView = new AppView()
        @appView.render()


  @get: ->
    # singleton pattern
    instance ?= new PrivateApp()
