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
    # real code
    Check.setup()
    Navigation.removeAndDisplay '#loading', '#check'
