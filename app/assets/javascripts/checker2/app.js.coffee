class window.App
  @launch: ->
    Progression.setup($('#uid').text())
    Navigation.setup()
    if ($('#check').hasClass('hidden'))
      App.launchSelection()
    else
      App.launchCheck()

  @launchSelection: ->    
    curHash = '#'+$('[data-section-slug='+Progression.current+']').attr('id')
    $('html,body').animate({scrollTop: $(curHash).offset().top}, 1000)


  @launchCheck: ->
