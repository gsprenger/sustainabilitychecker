class window.SliderView
  constructor:(@section, @slider, @isFromSliderGroup) ->
    @$el = $("<div class='slider-container'>")

  render: ->
    c = App.get().content
    l = App.get().level
    p = @section.i18nPrefix
    html = """
        <div class='slider-title'>#{c.text(p+'_'+@slider.getShortName(), 'none')}</div>
        <div class='slider #{@slider.getShortName()}'></div>
      """
    if @slider.slug == 's_ene_bio' || @slider.slug == 's_ene_ncf'
      html += """
          <div class='slider-descsub'>
            #{c.text(p+'_'+@slider.getShortName()+'_descsub_'+l, 'none')}
          </div>
        """
    @$el.html(html)
    @initSlider()
    @events()
    return this

  events: ->
    sliderEl = @$el.find('.slider')
    prevVal = -1
    sliderEl.on 'slide', (e, ui) =>
      if (@slider.sliderType == 'number')
        # prevent sliding on unautorized values
        diff = null
        for val in @slider.values
          newDiff = Math.abs(ui.value - val)
          if (diff == null || newDiff < diff)
            diff = newDiff
            nearest = val
        if (!@isFromSliderGroup && (nearest != prevVal))
          sliderEl.slider('value', nearest)
          $(window).trigger "updatesliderimage", {section: @section.slug, slider: @slider.slug, value: nearest}
          prevVal = nearest
        return false
      else
        val = ui.value
        if (!@isFromSliderGroup && (val != prevVal))
          $(window).trigger "updatesliderimage", {section: @section.slug, slider: @slider.slug, value: ui.value}
          prevVal = ui.value
    # save on Change
    sliderEl.on 'slidechange', (e, ui) =>
      @slider.setValue(ui.value)
      if (!@isFromSliderGroup)
        $(window).trigger('choicecomplete')
      $(window).trigger('slidervalchanged', @slider.slug)

  # This is contained in the View and not the Model because slider manipulation in JQuery is made with DOM elements
  initSlider: ->
    sliderEl = @$el.find('.slider')
    type = @slider.sliderType
    value = @slider.getValue()
    stepPos = []
    options = {
      "range":   "min",
      "animate": true,
      "value": (if type == 'text' then @slider.values.indexOf(value) else value)
    }
    if (type == 'text')
      # Slider is of lowmedhigh type
      options.max = ''+@slider.values.length-1
      sliderEl.slider(options)
      for i in [0..@slider.values.length-1]
        stepNb = @slider.values.length-1
        stepNb = 1 if stepNb == 0 # avoid divide by 0 error
        step = 100 / stepNb
        stepPos.push(i*step)
    else
      sliderEl.slider(options)
      limits = """
        <div class='min-limit' style='width:#{@slider.values[0]}%'></div>
        <div class='max-limit' style='width:#{100-@slider.values[@slider.values.length-1]}%'></div>
        """
      sliderEl.append($(limits))
      stepPos = @slider.values
    for i in [0..@slider.values.length-1]
      steps = """
        <div class='step' style='left:#{stepPos[i]}%'>
        <div class='name'>#{@formatStep(@slider.values[i])}</div>
        """
      sliderEl.append($(steps))
    if @slider.values.length == 1
      sliderEl.find('.ui-slider-handle').hide()

  formatStep:(string) ->
    if (!isNaN(string))
      return string += '%'
    else
      return string.charAt(0).toUpperCase() + string.slice(1);
