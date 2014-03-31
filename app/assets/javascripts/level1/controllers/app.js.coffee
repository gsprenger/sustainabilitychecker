class window.AppController
  constructor: ->
    # Models
    @experiment = new ExperimentModel('intro')
    @content = ContentModel.setup()
    @sections = {}

    # Views

    # Render application
    $('#app').append(HeaderView.html(@sections))
