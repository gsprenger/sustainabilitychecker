class window.Navigation
  navIcons: '.icon'
  checkIcon: '.checkicon'

  constructor: (@app) ->
    @setup()

  setup: ->
    # Initiate Bootstrap tooltips
    $('.btooltip').tooltip {placement: 'bottom'}
    # Set navigation click events on header icons
    $(@navIcons).each (i, el) =>
      $(el).parent().on 'click', =>
        @goTo Card.getCardByName @formatTitle($(el).attr('data-original-title'))
    # Set navigation on check icon
    $(@checkIcon).parent().on 'click', =>
      @goToCheck()

  goTo: (card) ->
    # TODO go only if progression allows it
    $(@navIcons+','+@checkIcon).removeClass 'active'
    that = @
    $(@navIcons+'[data-original-title]').filter(->
      that.formatTitle($(this).attr('data-original-title')) == card.name
    ).addClass('active')
    # if check is shown hide it before
    if !$(@app.checkContainer).hasClass('hidden')
      @app.removeAndDisplay @app.checkContainer, @app.cardsContainer
    @app.showCard card.slug

  goToCheck: (flag) ->
    if $('.card.active').length && !flag
      card = Card.getCardBySlug $('.card.active').attr('id')
      card.hide()
      setTimeout =>
        @goToCheck(true)
      , 800
      return
    $(@navIcons+','+@checkIcon).removeClass 'active'
    $(@checkIcon).addClass 'active'
    @app.removeAndDisplay @app.cardsContainer, @app.checkContainer
    @app.launchCheck()

  formatTitle: (originalTitle) ->
    if originalTitle.indexOf(' ') != -1
      originalTitle = originalTitle.substr 0, originalTitle.indexOf(' ')
    return originalTitle.toLowerCase()

