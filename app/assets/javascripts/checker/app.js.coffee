class window.App
  @launch: ->
    # Setup prog , nav
    Progression.setup()
    Navigation.setup()
    # choices
    Demographics.setup()
    Diet.setup()
    Households.setup()
    Services.setup()
    Density.setup()
    Land.setup()
    Bm.setup()
    Agriculture.setup()
    Energy.setup()
    # check
    Check.setup()
    # Launch according to progression
    if (Progression.current != 'check')
      Navigation.goToSection(Progression.current, true)
    else
      Navigation.smoothScrollTo('#check')
