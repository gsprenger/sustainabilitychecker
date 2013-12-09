class window.Choice
  @initRadio: (el) ->
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

  @initSlider: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({orientation: 'vertical', range: 'min', min: 0, max: 100, step: 25}
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

  @initSliderGroup: (el) ->

