class window.App
  instance = null

  class PrivateApp
    constructor: ->

    launchApp: ->
      # get exp model from local storage or create new
      @experiment = new Experiment()
      # check if trying to load a specific level
      permalinkUser = false
      if window.location.pathname.match(/load\/[a-zA-Z0-9]+/)
        loadCode = window.location.pathname.match(/load\/([a-zA-Z0-9]+)/)[1]
        @experiment.loadFromCode(loadCode)
        requestedLvl = @experiment.getCurrentLevel()
        permalinkUser = true
      else if window.location.pathname.match(/level[1-3]/)
        requestedLvl = +window.location.pathname.match(/level([1-3])/)[1]
      else
        requestedLvl = 1
      # if trying to play a level without having played previous ones, redirect
      if requestedLvl > @experiment.getLastLevel()
        document.location = '/level'+@experiment.getLastLevel()
      # if trying to load an already played level or last level, allow it. 
      else
        @level = requestedLvl
        @experiment.setCurrentLevel(@level)
        @isMercury = (document.URL.indexOf('mercury') > 0)
        # setup Application
        window.history.replaceState(null, null, window.location.origin+'/level'+@level)
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
        @appView = new AppView(permalinkUser)
        @appView.render()

  @get: ->
    # singleton pattern
    instance ?= new PrivateApp()
