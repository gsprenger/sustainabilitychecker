class window.Card
  @cards: []
  animIn: 'fadeInLeft'
  animOut: 'fadeOutRight'

  constructor: (options) ->
    {@id, @name, @slug} = options

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

  @generateCards: ->
    $('.card').each (i, el) =>
      card = new Card ({
        id: $(el).attr('data-card-id'),
        name: $(el).attr('data-card-name'),
        slug: $(el).attr('data-card-slug')
      })
      @cards[card.id] = card

  @getCardByName: (name) ->
    for card in Card.cards
      return card if card.name == name

  @getCardBySlug: (slug) ->
    for card in Card.cards
      return card if card.slug == slug
