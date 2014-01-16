class window.App
  @launch: ->
    # Setup prog , nav and choices
    Progression.setup()
    Navigation.setup()
    Choice.setup()
    Check.setup()
    # Launch according to progression
    if (Progression.current != 'check')
      Navigation.goToSection(Progression.current, true)
    else
      Navigation.smoothScrollTo('#check')
