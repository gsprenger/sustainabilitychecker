class window.Choice 
  @initRadio: (el) ->
    sectionSlug = $(el).closest('.section').attr('data-section-slug')
    progVal = Progression.getVariable(sectionSlug)
    $(el).find('[data-cv-value]').each (i, radio) ->
      # get the section they belong to and the value of the cv-value field
      value = $(radio).attr('data-cv-value')
      # check if item is selected in Progression and activate it
      if (progVal && progVal == value)
        $(radio).addClass('active')
        # update check summary
        $('span.'+sectionSlug).text($(radio).find('.text').text())
      # attach a click event to the radio element
      $(radio).on 'click', ->
        # activate element
        $('.section[data-section-slug='+sectionSlug+'] .active').removeClass('active')
        $(radio).addClass('active')
        # get next section, save values and scroll to next
        nextSlug = Navigation.getNextSectionSlug(sectionSlug)
        Progression.current = nextSlug
        Progression.setVariable sectionSlug, value
        Progression.save()
        setTimeout ->
          Navigation.goToSection(nextSlug, true)
        , 1000
        # update check summary
        $('span.'+sectionSlug).text($(radio).find('.text').text())

  @initSlider: (slider) ->
    sectionSlug = $(slider).closest('.section').attr('data-section-slug')
    name = $(slider).attr('data-slider-name')
    values = $(slider).slider('option', 'vals')
    defVal = $(slider).slider('option', 'default')
    type = $(slider).slider('option', 'type')
    # if slider value is present in Progression, set it
    if ((val = Progression.getVariable(name)) != null && ((values.indexOf(val) > -1) || type == 'lmh'))
      slider.slider('value', val)
    else if defVal
      slider.slider('value', defVal)
    else if !isNaN(values[0])
      slider.slider('value', values[0])
    else
      slider.slider('value', 0)
    if (type == '%')
      # on slide, prevent setting values that are out of possible values
      $(slider).on 'slide', (e, ui) ->
        diff = null
        for val in values
          newDiff = Math.abs(ui.value - val)
          if (diff == null || newDiff < diff)
            diff = newDiff
            nearest = val
        $(slider).slider('value', nearest)
        return false
    # save on Change
    $(slider).on 'slidechange', (e, ui) ->
      Progression.current = sectionSlug
      Progression.setVariable name, ui.value
      Progression.save()
      # update check summary
      $('span.'+name).text(if type == "%" then ui.value + '%' else (['Low', 'Medium', 'High'])[ui.value])
    # update check summary+
    value = $(slider).slider('value')
    $('span.'+name).text(if type == "%" then value + '%' else (['Low', 'Medium', 'High'])[value])

  @initSliderGroup: (sliders) ->
    sectionSlug = $(sliders[0]).closest('.section').attr('data-section-slug')
    $(sliders).each (i, slider) ->
      name = $(slider).attr('data-slider-name')
      values = $(slider).slider('option', 'vals')
      defVal = $(slider).slider('option', 'default')
      type = $(slider).slider('option', 'type')
      # if slider value is present in Progression, set it
      if ((val = Progression.getVariable(name)) != null && values.indexOf(val) > -1)
        slider.slider('value', val)
      else if defVal
        slider.slider('value', defVal)
      else if !isNaN(values[0])
        slider.slider('value', values[0])
      else
        slider.slider('value', 0)
      prevVal = 0
      $(slider).on 'slidestart', (e, ui) ->
        prevVal = ui.value
      $(slider).on 'slide', (e, ui) ->
        # Get nearest value
        diff = null
        for val in values
          newDiff = Math.abs(ui.value - val)
          if (diff == null || newDiff < diff)
            diff = newDiff
            nearest = val
        if (nearest != prevVal)
          prevVal = nearest
          $(slider).slider('value', nearest)
          # Check constraints 
          total = 0
          for s in sliders
            # get total value
            if $(s).attr('data-slider-name') == name
              total += nearest
            else 
              total += $(s).slider('value')
          # get difference to compensate on other sliders
          overflow = total > 100
          diff = Math.abs(100 - total)
          for s in sliders by -1
            if ($(s).attr('data-slider-name') != name)
              # for each slider except current, starting from last
              sValue = $(s).slider('value')
              sValues = $(s).slider('option', 'vals')
              valToReach = sValue + (if overflow then -diff else diff)
              # if diff can be contained in last slider and is possible
              if (sValues.indexOf(valToReach) > -1)
                $(s).slider('value', valToReach)
                diff -= diff
              else
                # we break diff into segments of 25 and try to shove it (dirty hack...)
                if (diff % 25 == 0)
                  times = diff / 25
                  console.log('iterating '+times+' tmes')
                  for i in [1..times]
                    for ts in sliders by -1
                      if ($(ts).attr('data-slider-name') != name)
                        # for each slider except current, starting from last
                        tsValue = $(ts).slider('value')
                        tsValues = $(ts).slider('option', 'vals')
                        tvalToReach = tsValue + (if overflow then -25 else 25)
                        # if diff can be contained in last slider and is possible
                        if (tsValues.indexOf(tvalToReach) > -1)
                          $(ts).slider('value', tvalToReach)
                          diff -= 25
                          break
            if (diff == 0)
              break
          if (diff != 0)
            console.error("This setup of linked sliders is probably not supported. Something must have gone wrong somewhere and the total is not 100 anymore.")
        return false
      # save on Change
      $(slider).on 'slidechange', (e, ui) -> 
        $(sliders).each (i, s) ->
          sname = $(s).attr('data-slider-name')
          svalue = $(s).slider('value')
          Progression.setVariable(sname, svalue)
          # update check summary
          $('span.'+sname).text(svalue + (if type == "%" then '%' else ''))
        Progression.current = sectionSlug
        Progression.setVariable name, ui.value
        Progression.save()
      # update check summary
      $('span.'+name).text($(slider).slider('value') + (if type == "%" then '%' else ''))

  @createSlider: (slider, type, values, defVal) ->
    # init slider
    name = slider.attr('data-slider-name')
    options = {
      "range":   "min",
      "animate": true,
      "type":    type,
      "vals":    values,
      "default": defVal
    }
    options.max = 2 if type == 'lmh'
    slider.slider(options)  
    # set up graphical marks: limits & steps
    html = ""
    if (type == '%')
      # set limits
      firstW = values[0]
      lastW = 100 - values[values.length-1]
      html += 
        """
        <div class='min-limit' style='width:#{firstW}%'></div>
        <div class='max-limit' style='width:#{lastW }%'></div>
        """
      # set steps
      for val in values
        html += 
          """
          <div class='step' style='left:#{val}%'>
            <div class='name'>#{val}%</div>
          </div>
          """
      # if there's only one possible value, hide the slider handle
      if values.length == 1
        $(slider).find('.ui-slider-handle').hide()
    else
      # set steps
      for val in [0..2]
        position = [0, 50, 100]
        html += 
          """
          <div class='step' style='left:#{position[val]}%'>
            <div class='name'>#{values[val]}</div>
          </div>
          """
    $(slider).append(html)
    return slider
