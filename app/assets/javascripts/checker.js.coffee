## Application Class ##
class Checker
  loadingContainer: '#loading'
  cardsContainer:   '#cards'
  checkContainer:   '#check'

  constructor: ->
    @cards = Card.getAll()
    $(@cardsContainer).append card.html for card in @cards
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
      @navigation.goTo @getCardBySlug @progression.current
    , 1600

  showCard: (slug, flag) ->
    if $('.card.active').length 
      prevCard = @getCardBySlug $('.card.active').attr('id')
      prevCard.hide()
      # this is here to give enough time for the fadeOut animation to perform
      setTimeout =>
        @showCard slug, true
      , 800
    else
      card = @getCardBySlug(slug)
      card.show()

  getCardByName: (name) ->
    for card in @cards
      return card if card.name == name

  getCardBySlug: (slug) ->
    for card in @cards
      return card if card.slug == slug

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


## Card Class ##
class Card
  animIn: 'fadeInLeft'
  animOut: 'fadeOutRight'

  constructor: (options) ->
    {@id, @name, @slug, @html} = options

  show: ->
    $('#'+@slug).removeClass 'hidden'
    $('#'+@slug).addClass 'active ' + @animIn
    setTimeout =>
      $('#'+@slug).removeClass @animIn
    , 800

  hide: ->
    $('#'+@slug).addClass @animOut
    setTimeout =>
      $('#'+@slug).addClass 'hidden'
      $('#'+@slug).removeClass 'active ' + @animOut
    , 800

  @getAll: ->
    cardsRaw = JSON.parse $.ajax({
      type:  'GET',
      url:   '/checker/cards',
      async: false
    }).responseText
    cards = []
    cards.push(new Card(cardRaw)) for cardRaw in cardsRaw
    return cards

## Progression Class ##
class Progression
  constructor: (@app) ->
    @id = $('#uid').text()
    @load()
    @setup()

  setup: ->
    $('[data-cv-value]').each (i, el) =>
      # get the card they belong to and their value
      name = $(el).closest('.card').attr('id')
      value = $(el).attr('data-cv-value')
      # check if selected in progression and activate it
      for val in @values
        if val.name == name && val.value == value
          $(el).addClass('active')
          break
      # attach a click event to 
      $(el).on 'click', =>
        $('#'+name+' .card-choice-cell.active').removeClass('active')
        $(el).addClass('active')
        @current = name
        item = {
          "name": name
          "value": value
        }
        @addToValues item
        @next()
        @save()
        setTimeout =>
          if @current == 'check' 
            @app.navigation.goToCheck()
          else
            @app.navigation.goTo @app.getCardBySlug @current
        , 250

  next: ->
    index = parseInt(@app.getCardBySlug(@current).id)
    if @app.cards.length <= index
      @current = 'check'
    else 
      @current = @app.cards[index].slug

  addToValues: (item) ->
    for val in @values
      # if item already exists: update it
      if val.name == item.name
        val.value == item.value
        return
    # if item not found add it
    @values.push item

  load: ->
    data = JSON.parse $.ajax({
      type:  'GET',
      url:   '/checker/get_experiment?id='+@id,
      async: false
    }).responseText
    exp = JSON.parse data[0].json
    @current = exp.current || @app.cards[0].slug
    @values = exp.values

  save: ->
    json = {
      "current": @current
      "values":  @values
    }
    data = {
      "id": @id
      "json": JSON.stringify json
    }
    $.post '/checker/save_experiment', data

## Navigation Class ##
class Navigation
  navIcons: '.icon'
  checkIcon: '.checkicon'

  constructor: (@app) ->
    @setup()

  setup: ->
    # Initiate Bootstrap tooltips
    $('.icon,.checkicon').tooltip {placement: 'bottom'}
    # Set navigation click events on header icons
    $(@navIcons).each (i, el) =>
      $(el).parent().on 'click', =>
        @goTo @app.getCardByName $(el).attr('data-original-title').toLowerCase()
    # Set navigation on check icon
    $(@checkIcon).parent().on 'click', =>
      $(@navIcons).removeClass 'active'
      $(@checkIcon).addClass('active')
      @app.launchCheck()

  goTo: (card) ->
    # TODO go only if progression allows it
    $(@navIcons+','+@checkIcon).removeClass 'active'
    $(@navIcons+'[data-original-title]').filter(->
      $(this).attr('data-original-title').toLowerCase() == card.name
    ).addClass('active')
    # if check is shown hide it before
    if !$(@app.checkContainer).hasClass('hidden')
      @app.removeAndDisplay @app.checkContainer, @app.cardsContainer
    @app.showCard card.slug

  goToCheck: (flag) ->
    if $('.card.active').length && !flag
      card = @app.getCardBySlug $('.card.active').attr('id')
      card.hide()
      setTimeout =>
        @goToCheck(true)
      , 800
      return
    $(@navIcons+','+@checkIcon).removeClass 'active'
    $(@checkIcon).addClass 'active'
    @app.removeAndDisplay @app.cardsContainer, @app.checkContainer
    @app.launchCheck()

## Main execution ##
ready = ->
  app = new Checker()
  app.launch()

$(document).ready(ready)
$(document).on('page:load', ready)
