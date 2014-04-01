class window.AppController
  constructor: ->
    @experiment = new ExperimentModel('intro')
    @content = ContentModel.setup()
    @sections = []

  launchLevel1: ->    
