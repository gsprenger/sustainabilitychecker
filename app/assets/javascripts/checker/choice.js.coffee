class window.Choice
  @createRadio: (el) ->
    card = Card.cards[$(el).closest('.card').attr('data-card-id')]
    $(el).find('[data-cv-value]').each (i, radio) =>
      # get the card they belong to and the value of the cv-value field
      value = $(radio).attr('data-cv-value')
      # check if item is selected in Progression and activate it
      for val in Progression.values
        if val.name == card.slug && val.value == value
          $(radio).addClass('active')
          break
      # attach a click event to the radio element
      $(radio).on 'click', =>
        $('#'+card.slug+' .choice-grid-radio.active').removeClass('active')
        $(radio).addClass('active')
        Progression.addToValues card.slug, value
        Progression.save()

  @createSlider: (el) ->
    card = Card.cards[$(el).closest('.card').attr('data-card-id')]
    $(el).find('[data-cv-value]').each (i, radio) =>
      # get the card they belong to and the value of the cv-value field
      value = $(radio).attr('data-cv-value')
      # check if item is selected in progression and activate it
      for val in Progression.values
        if val.name == card.slug && val.value == value
          $(radio).addClass('active')
          break
      # attach a click event to the radio element
      $(radio).on 'click', =>
        $('#'+card.slug+' .choice-grid-radio.active').removeClass('active')
        $(radio).addClass('active')
        Progression.addToValues card.slug, value
        Progression.save()

  @createSliderGroup: (el) ->

