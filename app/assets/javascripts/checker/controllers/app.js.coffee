class window.App
  instance = null

  class PrivateApp
    constructor: ->
    setup: ->
      # Instanciate models
      @experiment = new ExperimentModel('intro')
      @content = ContentModel.setup()
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
      @sections = [
        @demographics,
        @diet,
        @households,
        @services,
        @density,
        @land,
        @bm,
        @agriculture,
        @energy
      ]

    launchLevel:(num) ->
      @appView = new AppView('body', num, @content, @sections)
      @appView.render()

  @get: ->
    # singleton model
    instance ?= new PrivateApp()
