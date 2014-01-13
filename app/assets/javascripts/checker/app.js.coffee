class window.App
  @launch: ->
    Navigation.showLoading();
    Progression.setup($('#uid').text())
    Navigation.setup()
    if ($('#check').hasClass('hidden'))
      App.launchSelection()
    else
      App.launchCheck()

  @launchSelection: ->     
    curHash = '#'+$('[data-section-slug='+Progression.current+']').attr('id')
    $('a[href='+curHash+']').trigger('click')
    Navigation.removeLoading('section');

  @launchCheck: ->
    Navigation.removeLoading('check');
