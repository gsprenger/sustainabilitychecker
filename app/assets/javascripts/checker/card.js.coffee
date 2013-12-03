class window.Card
  @cards: []
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

  @getCardByName: (name) ->
    for card in @cards
      return card if card.name == name

  @getCardBySlug: (slug) ->
    for card in @cards
      return card if card.slug == slug

