class window.App
  @launch: ->
    # Setup prog , nav and choices
    Progression.setup()
    Navigation.setup()
    Choice.setup()
    # Launch according to progression
    if (Progression.current != 'check')
      App.launchSelection()
    else
      App.launchCheck()

  @launchSelection: -> 
    Navigation.goToSection(Progression.current, true)

  @launchCheck: ->
