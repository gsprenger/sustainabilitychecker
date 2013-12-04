class window.App
  loadingContainer: '#loading'
  cardsContainer:   '#cards'
  checkContainer:   '#check'

  constructor: ->
    Card.generateCards()
    console.log Card.cards
    @progression = new Progression(this)
    @navigation = new Navigation(this)

  launch: ->
    if (@progression.current != 'check')
      @removeAndDisplay(@loadingContainer, @cardsContainer)
      @launchCards()
    else
      @removeAndDisplay(@loadingContainer, @checkContainer)
      @navigation.goToCheck()

  launchCards: ->
    # accounts for the time it take to remove the loading screen
    setTimeout =>
      @navigation.goTo Card.getCardBySlug @progression.current
    , 1600

  showCard: (slug, flag) ->
    if $('.card.active').length
      prevCard = Card.getCardBySlug $('.card.active').attr('id')
      prevCard.hide()
      # this is here to give enough time for the fadeOut animation to perform
      setTimeout =>
        @showCard slug, true
      , 800
    else
      card = Card.getCardBySlug(slug)
      card.show()

  launchCheck: ->
    json = ''
    for val in @progression.values
      json += 'Name: ' + val.name + '\n'
      json += 'Value: ' + val.value + '\n\n'
    $('.checkvar').text(json)

  removeAndDisplay: (elA, elB, flag1, flag2) ->
    if !flag1
      $(elA).addClass 'fadeOut'
      setTimeout =>
        @removeAndDisplay elA, elB, true
      , 800
    else if !flag2
      $(elA).addClass 'hidden'
      $(elA).removeClass 'fadeOut'
      $(elB).removeClass 'hidden'
      $(elB).addClass 'fadeIn'
      setTimeout =>
        @removeAndDisplay elA, elB, true, true
      , 800
    else
      $(elB).removeClass 'fadeIn'
