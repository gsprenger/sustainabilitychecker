class window.Navigation
  @setup: ->
    # Initiate Bootstrap tooltips
    $('.btooltip').tooltip {placement: 'bottom'}
    # Set navigation click events on header icons
    $('.icon').each (i, el) ->
      $(el).parent().on 'click', ->
        Navigation.goTo Card.getCardBySlug $(el).attr('data-card-slug')
    # Set navigation on check icon
    $('.checkicon').parent().on 'click', ->
      Navigation.goToCheck()

  @goTo: (card) ->
    $('.icon, .checkicon').removeClass 'active'
    $('.icon[data-card-slug='+card.slug+']').addClass('active')
    # if check is shown transition to Cards
    if $('#cards').hasClass('hidden')
      # hide potentiel previous card and show goto card
      prevCardSlug = $('.card.active').attr('data-card-slug')
      (Card.getCardBySlug(prevCardSlug)).hide(true) if prevCardSlug
      card.show true
      Navigation.removeAndDisplay '#check', '#cards'
    else
      prevCard = Card.getCardBySlug $('.card.active').attr('data-card-slug')
      prevCard.hide()
      setTimeout ->
        card.show()
      , 800

  @goToCheck: (flag) ->
    if $('.card.active').length && !flag
      card = Card.getCardBySlug $('.card.active').attr('data-card-slug')
      card.hide()
      setTimeout ->
        Navigation.goToCheck(true)
      , 800
      return
    $('.icon, .checkicon').removeClass 'active'
    $('.checkicon').addClass 'active'
    Navigation.removeAndDisplay '#cards', '#loading'
    setTimeout ->
      App.launchCheck()
    , 1600

  @removeAndDisplay: (elA, elB, flag1, flag2) ->
    if !flag1
      $(elA).addClass 'fadeOut'
      setTimeout ->
        Navigation.removeAndDisplay elA, elB, true
      , 800
    else if !flag2
      $(elA).addClass 'hidden'
      $(elA).removeClass 'fadeOut'
      $(elB).removeClass 'hidden'
      $(elB).addClass 'fadeIn'
      setTimeout ->
        Navigation.removeAndDisplay elA, elB, true, true
      , 800
    else
      $(elB).removeClass 'fadeIn'
