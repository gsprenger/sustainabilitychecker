class window.Card
  @cards: []
  animIn: 'fadeInLeft'
  animOut: 'fadeOutRight'

  constructor: (options) ->
    {@id, @name, @slug} = options

  show: (noTransition) ->
    cardEl = $('.card[data-card-slug='+@slug+']')
    cardEl.removeClass 'hidden'
    cardEl.addClass 'active'
    unless noTransition
      cardEl.addClass 'active ' + @animIn
      setTimeout =>
        cardEl.removeClass @animIn
      , 800

  hide: (noTransition) ->
    cardEl = $('.card[data-card-slug='+@slug+']')
    if noTransition
      cardEl.removeClass 'active'
      cardEl.addClass 'hidden'
    else
      cardEl.addClass @animOut
      setTimeout =>
        cardEl.addClass 'hidden'
        cardEl.removeClass 'active ' + @animOut
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
