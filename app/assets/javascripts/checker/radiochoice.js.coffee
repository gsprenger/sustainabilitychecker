class window.RadioChoice extends Choice
  @create: (el, progression) ->
    card = Card.cards[$(el).closest('.card').attr('data-card-id')]
    $(el).find('[data-cv-value]').each (i, radio) =>
      # get the card they belong to and the value of the cv-value field
      value = $(radio).attr('data-cv-value')
      # check if item is selected in progression and activate it
      for val in progression.values
        if val.name == card.slug && val.value == value
          $(radio).addClass('active')
          break
      # attach a click event to the radio element
      $(radio).on 'click', =>
        $('#'+card.slug+' .choice-grid-radio.active').removeClass('active')
        $(radio).addClass('active')
        progression.current = card.slug
        item = {
          "name": card.slug
          "value": value
        }
        progression.addToValues item
        progression.save()

