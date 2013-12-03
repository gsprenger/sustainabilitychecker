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
    $('[data-choice-type]').each (i, el) =>
      switch $(el).attr('data-choice-type')
        when 'radio' then @radioSetup el
        when 'soloslider' then @soloSliderSetup el
        when 'soloslider2' then @soloSlider2Setup el
        when 'soloslider3' then @soloSlider3Setup el
        when 'services' then @servicesSetup el
        when 'services2' then @services2Setup el

  addToValues: (item) ->
    found = false
    for val in @values
      # if item already exists: update it
      if val.name == item.name
        val.value = item.value
        found = true
        break
    # if item not found add it
    unless found 
      @values.push item

  load: ->
    data = JSON.parse $.ajax({
      type:  'GET',
      url:   '/checker/get_experiment?id='+@id,
      async: false
    }).responseText
    exp = JSON.parse data[0].json
    @current = exp.current || @app.cards[0].slug
    @values = exp.values || []

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

  # Radio is composed of as many items with the data-cv-value attribute 
  # and only one can be active at a time
  radioSetup: (el) ->
    $(el).find('[data-cv-value]').each (i, radio) =>
      # get the card they belong to and the value of the cv-value field
      name = $(radio).closest('.card').attr('id')
      value = $(radio).attr('data-cv-value')
      # check if item is selected in progression and activate it
      for val in @values
        if val.name == name && val.value == value
          $(radio).addClass('active')
          break
      # attach a click event to the radio element
      $(radio).on 'click', =>
        $('#'+name+' .choice-grid-radio.active').removeClass('active')
        $(radio).addClass('active')
        @current = name
        item = {
          "name": name
          "value": value
        }
        @addToValues item
        @save()

  soloSliderSetup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'horizontal',
        range: 'min',
        min: 0,
        max: 100,
        step: 25,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value)
        , 
        change: =>
          @current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          @addToValues item
          @save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break

  soloSlider2Setup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'horizontal',
        range: 'min',
        min: 1,
        max: 3,
        step: 1,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value)
        , 
        change: =>
          @current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          @addToValues item
          @save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break

  soloSlider3Setup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'horizontal',
        range: 'min',
        min: 0,
        max: 100,
        step: 25,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value+'%')
        , 
        change: =>
          @current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          @addToValues item
          @save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break

  servicesSetup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'vertical',
        range: 'min',
        min: 1,
        max: 3,
        step: 1,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value)
        , 
        change: =>
          #@current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          #@addToValues item
          #@save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break

  services2Setup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'vertical',
        range: 'min',
        min: 0,
        max: 100,
        step: 1,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value + '%')
        , 
        change: =>
          #@current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          #@addToValues item
          #@save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break

## Navigation Class ##
class Navigation
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
        @goTo @app.getCardByName @formatTitle($(el).attr('data-original-title'))
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

  formatTitle: (originalTitle) ->
    if originalTitle.indexOf(' ') != -1
      originalTitle = originalTitle.substr 0, originalTitle.indexOf(' ')
    return originalTitle.toLowerCase()

## Main execution ##
ready = ->
  app = new Checker()
  app.launch()

$(document).ready(ready)
$(document).on('page:load', ready)
