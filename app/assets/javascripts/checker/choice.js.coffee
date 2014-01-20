class window.Choice 
  # Init events for all sections choices  
  @setup: ->
    $('[data-choice-type]').each (i, el) ->
      switch $(el).attr('data-choice-type')
        when 'radio'
          Choice.initRadio el
        when 'slider'
          Choice.initSlider el
        when 'slidergroup'
          Choice.initSliderGroup el

  @initRadio: (el) ->
    sectionSlug = $(el).closest('.section').attr('data-section-slug')
    $(el).find('[data-cv-value]').each (i, radio) ->
      # get the section they belong to and the value of the cv-value field
      value = $(radio).attr('data-cv-value')
      # check if item is selected in Progression and activate it
      for val in Progression.values
        if val.name == sectionSlug && val.value == value
          $(radio).addClass('active')
          # update check summary
          $('span.'+sectionSlug).text($(radio).text())
          break
      # attach a click event to the radio element
      $(radio).on 'click', ->
        # activate element
        $('.section[data-section-slug='+sectionSlug+'] .active').removeClass('active')
        $(radio).addClass('active')
        # get next section, save values and scroll to next
        nextSlug = Navigation.getNextSectionSlug(sectionSlug)
        Progression.current = nextSlug
        Progression.addToValues sectionSlug, value
        Progression.save()
        setTimeout ->
          Navigation.goToSection(nextSlug, true)
        , 1000
        # update check summary
        $('span.'+sectionSlug).text($(radio).text())

  @initSlider: (el) ->
    sectionSlug = $(el).closest('.section').attr('data-section-slug')
    slider = $(el).find('.slider')
    Choice.createSlider(slider)
    # save on Change
    slider.on 'slidechange', (e, ui) ->
      sliderSlug = slider.attr('data-slider-name')
      Progression.current = sectionSlug
      Progression.addToValues sliderSlug, ui.value
      Progression.save()
      # update check summary
      $('span.'+sliderSlug).text(slider.siblings('.slidervalue').text())

  @initSliderGroup: (el) ->
    sectionSlug = $(el).closest('.section').attr('data-section-slug')
    sliders = []
    $(el).find('.slider').each (i, slider) ->
      name = $(slider).attr('data-slider-name')
      Choice.createSlider($(slider))
      min = $(slider).slider('option', 'min')
      max = $(slider).slider('option', 'max')
      step = $(slider).slider('option', 'step')
      sMinLimit = $(slider).find('.min-limit').attr('data-min-limit') || false
      sMaxLimit = $(slider).find('.max-limit').attr('data-max-limit') || false
      sliders.push(slider)
      $(slider).on 'slide', (e, ui) ->
        if (sMinLimit || sMaxLimit) && (ui.value < sMinLimit || ui.value > sMaxLimit)
          return false
        stepNb = (ui.value - $(slider).slider('value')) / step
        goingUp = stepNb > 0
        for [1..Math.abs(stepNb)] 
          for s in sliders
            sname = $(s).attr('data-slider-name')
            unless sname == name
              val = $(s).slider('value')
              if (goingUp && (val != min)) || (!goingUp && (val != max))
                minLimit = parseInt($(s).slider('option', 'minlimit'), 10)
                maxLimit = parseInt($(s).slider('option', 'maxlimit'), 10)
                if ((goingUp && (val != minLimit)) || (!goingUp && (val != maxLimit))) 
                  oldVal = $(s).slider('value')
                  sliderToChange = s
          $(sliderToChange).slider('value', oldVal + (if goingUp then -1 * step else step))
      $(slider).on 'slidechange', (e, ui) ->
        if Choice.lastSlider == name
          Progression.current = sectionSlug
          for s in sliders
            Progression.addToValues $(s).attr('data-slider-name'), $(s).slider('value')
            $('span.'+$(s).attr('data-slider-name')).text($(s).siblings('.slidervalue').text())
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
    minLimit = slider.find('.min-limit').attr('data-min-limit') || false
    maxLimit = slider.find('.max-limit').attr('data-max-limit') || false
    slider.slider('option', 'minlimit', minLimit)
    slider.slider('option', 'maxlimit', maxLimit)
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
    # update check summary
    $('span.'+name).text(valueField.text())
    # set slide and change events
    slider.on 'mouseover', (e, ui) ->
      Choice.lastSlider = name
    slider.on 'slide', (e, ui) ->
      if (minLimit || maxLimit) && (ui.value < minLimit || ui.value > maxLimit)
        return false
      updateValueField(ui.value)
    slider.on 'slidechange', (e, ui) ->
      updateValueField(ui.value)
