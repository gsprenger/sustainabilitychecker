class window.App
  @launch: ->
    Navigation.showLoading();
    # Setup prog and nav
    Progression.setup($('#uid').text())
    Navigation.setup()
    # Launch app
    if (Progression.current != 'check')
      curHash = '#'+$('[data-section-slug='+Progression.current+']').attr('id')
      $('a[href='+curHash+']').trigger('click')
      App.launchSelection()
    else
      App.launchCheck()

  @launchSelection: ->     
    Navigation.removeLoading('section');

  @launchCheck: ->
    Check.setup()
    Navigation.removeLoading('checksection');
