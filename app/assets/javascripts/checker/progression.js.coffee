class window.Progression
  constructor: (@app) ->
    @id = $('#uid').text()
    @load()
    @setup()

  setup: ->
    $('[data-choice-type]').each (i, el) =>
      switch $(el).attr('data-choice-type')
        when 'radio' then @radioSetup el
        when 'soloslider' then @soloSliderSetup el
        when 'soloslider2' then @soloSlider2Setup el
        when 'soloslider3' then @soloSlider3Setup el
        when 'services' then @servicesSetup el
        when 'services2' then @services2Setup el

  addToValues: (item) ->
    found = false
    for val in @values
      # if item already exists: update it
      if val.name == item.name
        val.value = item.value
        found = true
        break
    # if item not found add it
    unless found 
      @values.push item

  load: ->
    data = JSON.parse $.ajax({
      type:     'GET',
      dataType: 'json',
      url:      '/checker/get_experiment?id='+@id,
      async:    false
    }).responseText
    exp = JSON.parse data.json
    @current = exp.current || Card.cards[0].slug
    @values = exp.values || []

  save: ->
    json = {
      "current": @current
      "values":  @values
    }
    data = {
      "id": @id
      "json": JSON.stringify json
    }
    $.post '/checker/save_experiment', data

  # Radio is composed of as many items with the data-cv-value attribute 
  # and only one can be active at a time
  radioSetup: (el) ->
    $(el).find('[data-cv-value]').each (i, radio) =>
      # get the card they belong to and the value of the cv-value field
      name = $(radio).closest('.card').attr('id')
      value = $(radio).attr('data-cv-value')
      # check if item is selected in progression and activate it
      for val in @values
        if val.name == name && val.value == value
          $(radio).addClass('active')
          break
      # attach a click event to the radio element
      $(radio).on 'click', =>
        $('#'+name+' .choice-grid-radio.active').removeClass('active')
        $(radio).addClass('active')
        @current = name
        item = {
          "name": name
          "value": value
        }
        @addToValues item
        @save()

  soloSliderSetup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'horizontal',
        range: 'min',
        min: 0,
        max: 100,
        step: 25,
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

  soloSlider2Setup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'horizontal',
        range: 'min',
        min: 1,
        max: 3,
        step: 1,
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

  soloSlider3Setup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'horizontal',
        range: 'min',
        min: 0,
        max: 100,
        step: 25,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value+'%')
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

  servicesSetup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'vertical',
        range: 'min',
        min: 1,
        max: 3,
        step: 1,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value)
        , 
        change: =>
          #@current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          #@addToValues item
          #@save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break

  services2Setup: (el) ->
    $(el).find('.choice-ss-slider').each (i, sliderEl) =>
      name = $(sliderEl).closest('.card').attr('id')
      # init the slider element for jquery
      $(sliderEl).slider({
        orientation: 'vertical',
        range: 'min',
        min: 0,
        max: 100,
        step: 1,
        slide: (e, ui) ->
          # when slider changes, update the value field
          $(sliderEl).siblings('.choice-ss-value').text(ui.value + '%')
        , 
        change: =>
          #@current = name
          item = {
            "name": name
            "value": $(sliderEl).slider('value')
          }
          #@addToValues item
          #@save()
      })
      # if slider has previsouly been set: set its value
      for val in @values
        if val.name == name
          $(sliderEl).slider('value', val.value)
          $(sliderEl).siblings('.choice-ss-value').text(val.value)
          break
