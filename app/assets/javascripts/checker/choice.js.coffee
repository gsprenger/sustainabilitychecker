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
        $('.card[data-card-id='+card.id+'] .choice-grid-radio.active').removeClass('active')
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
      min = $(slider).slider('option', 'min')
      max = $(slider).slider('option', 'max')
      step = $(slider).slider('option', 'step')
      sliders.push(slider)
      $(slider).on 'slide', (e, ui) ->
        stepNb = (ui.value - $(slider).slider('value')) / step
        goingUp = stepNb > 0
        for [1..Math.abs(stepNb)] 
          for s in sliders
            sname = $(s).attr('data-slider-name')
            unless sname == name
              if (goingUp && $(s).slider('value') != min) || (!goingUp && $(s).slider('value') != max)
                oldVal = $(s).slider('value')
                sliderToChange = s
          $(sliderToChange).slider('value', oldVal + (if goingUp then -1 * step else step))
      $(slider).on 'slidechange', (e, ui) ->
        if Choice.lastSlider == name
          Progression.current = card.slug
          for s in sliders
            Progression.addToValues $(s).attr('data-slider-name'), $(s).slider('value')
          Progression.save()
    # Check if collective value is not overflowing/undervalued
    total = 0
    min = $(sliders[0]).slider('option', 'min')
    max = $(sliders[0]).slider('option', 'max')
    step = $(sliders[0]).slider('option', 'step')
    for s in sliders
      total += $(s).slider('value')
    if total != max
      overflow = total > max
      add = if overflow then -1*step else step
      while ((overflow && (total > max)) || (!overflow && (total < max)))
        for s in sliders
          if (overflow && ($(s).slider('value') != min)) || (!overflow && ($(s).slider('value') != max))
            $(s).slider('value', $(s).slider('value') + add)
            total += add
            if total == max
              break;
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
