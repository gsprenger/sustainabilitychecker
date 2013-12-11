class window.App
  @launch: ->
    Card.generateCards()
    Progression.setup $('#uid').text()
    Navigation.setup()
    if (Progression.current != 'check')
      App.launchCards()
    else
      App.launchCheck()

  @launchCards: ->
    currentCard = Card.getCardBySlug Progression.current
    $('.icon[data-card-slug='+currentCard.slug+']').addClass('active')
    currentCard.show true
    Navigation.removeAndDisplay('#loading', '#cards')


  @launchCheck: ->
    # debug
    json = ''
    for val in Progression.values
      json += 'Name: ' + val.name + '\n'
      json += 'Value: ' + val.value + '\n\n'
    $('.checkvar').text(json)
    # real code
    Check.setup()
    Navigation.removeAndDisplay '#loading', '#check'
