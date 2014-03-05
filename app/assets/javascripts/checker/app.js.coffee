class window.App
  @launch: ->
    # Check if mercury is running
    App.isMercury = (document.URL.indexOf('mercury') > 0)
    # Setup prog & nav
    Progression.setup()
    Navigation.setup()
    # Setup choices
    Demographics.setup()
    Diet.setup()
    Households.setup()
    Services.setup()
    Density.setup()
    Land.setup()
    Bm.setup()
    Agriculture.setup()
    Energy.setup()
    # Setup check
    Check.setup()
    # Launch according to progression
    if (Progression.current != 'check')
      Navigation.goToSection(Progression.current, true)
    else
      Navigation.smoothScrollTo('#check')
    # If mercury is running, disable links, show all content and disable save
    if App.isMercury
      $('.btn, .nav-link, .cell').off('click')
      $('.checksection').removeClass('hidden')
      Progression.save = Progression.setVariable = ->
        true
