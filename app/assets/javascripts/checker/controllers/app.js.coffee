class window.App
  @instance: null

  constructor: ->
    @experiment = new ExperimentModel('intro')
    @content = ContentModel.setup()
    @sections = []
    @instance = this

  launchLevel1: ->

  @get: ->
    @instance ?= new App()
