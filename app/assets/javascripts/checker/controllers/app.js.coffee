class window.App
  instance = null

  class PrivateApp
    constructor: ->
    setup: ->
      ContentModel.setup()
      @experiment = new ExperimentModel('intro')
      # section models
      @demographics = new DemographicsModel()
      @diet         = new DietModel()
      @households   = new HouseholdsModel()
      @services     = new ServicesModel()
      @density      = new DensityModel()
      @land         = new LandModel()
      @bm           = new BmModel()
      @agriculture  = new AgricultureModel()
      @energy       = new EnergyModel()
      @sections = [@demographics, @diet, @households, @services, @density, @land, @bm, @agriculture, @energy]

    launchLevel:(num) ->
      @appView = new AppView(num, @sections)
      @appView.render()

  @get: ->
    # singleton pattern
    instance ?= new PrivateApp()
