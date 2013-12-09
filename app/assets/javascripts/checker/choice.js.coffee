class window.Choice	
  @initRadio: (el) ->
    card = Card.cards[$(el).closest('.card').attr('data-card-id')]
    $(el).find('[data-cv-value]').each (i, radio) ->
      # get the card they belong to and the value of the cv-value field
      value = $(radio).attr('data-cv-value')
      # check if item is selected in Progression and activate it
      for val in Progression.values
        if val.name == card.slug && val.value == value
          $(radio).addClass('active')
          break
      # attach a click event to the radio element
      $(radio).on 'click', ->
        $('#'+card.slug+' .choice-grid-radio.active').removeClass('active')
        $(radio).addClass('active')
        Progression.current = card.slug
        Progression.addToValues card.slug, value
        Progression.save()

  @initSlider: (el) ->
    card = Card.cards[$(el).closest('.card').attr('data-card-id')]
    slider = $(el).find('.slider')
    Choice.createSlider(slider)
    # save on Change
    slider.on 'slidechange', (e, ui) ->
      Progression.current = card.slug
      Progression.addToValues slider.attr('data-slider-name'), ui.value
      Progression.save()

  @initSliderGroup: (el) ->
    card = Card.cards[$(el).closest('.card').attr('data-card-id')]
    sliders = []
    $(el).find('.slider').each (i, slider) ->
      name = $(slider).attr('data-slider-name')
      Choice.createSlider($(slider))
      sliders.push(slider)
      $(slider).on 'slide', (e, ui) ->
        oth = []
        for s in sliders
          sname = $(s).attr('data-slider-name')
          unless sname == name
            oth.push(s)
        oldVal = $(this).slider('value')
        diff = ui.value - oldVal
        for s in oth
          curVal = $(s).slider('value')
          $(s).slider('value', curVal - (diff / oth.length))
        for s in oth
          if $(s).slider('value') < 0
            diff = -1 * $(s).slider('value')
            sname = $(s).attr('data-slider-name')
            for so in oth
              soname = $(so).attr('data-slider-name')
              if soname != sname
                prevVal = $(so).slider('value')
                $(so).slider('value', prevVal + (diff / (oth.length - 1)))
      $(slider).on 'slidechange', (e, ui) ->
        if Choice.lastSlider == name
          Progression.current = card.slug
          for s in sliders
            Progression.addToValues $(s).attr('data-slider-name'), $(s).slider('value')
            Progression.save()

  @createSlider: (slider) ->   
    name = slider.attr('data-slider-name')
    valueField = slider.siblings('.slidervalue')
    type = valueField.attr('data-slider-type')
    updateValueField = (value) ->
      # give visual feedback
      switch type
        when 'percent'
          valueField.text(value+'%')
        when 'lmh'
          vals = ['Low', 'Medium', 'High']
          valueField.text(vals[value])
    # init slider and remove options from DOM
    slider.slider(JSON.parse(slider.attr('data-slider-options')))
    slider.removeAttr('data-slider-options') # for clarity and protection
    # if slider value is present, set it, otherwise set its default (=0)
    found = false
    for val in Progression.values
      if val.name == name
        slider.slider('value', val.value)
        found = true
        break
    unless found
      Progression.addToValues name, slider.slider('value') 
    updateValueField(slider.slider('value'))
    # set slide and change events
    slider.on 'mouseover', (e, ui) ->
      Choice.lastSlider = name
    slider.on 'slide', (e, ui) ->
      updateValueField(ui.value)
    slider.on 'slidechange', (e, ui) ->
      updateValueField(ui.value)
