class window.Progression
  @id = 0 # ID in database
  @current = 'dem' # Current card displayed
  @values = [] # Values entered by the user

  @setup: (@id) ->
    # Load progression via API
    data = JSON.parse $.ajax({
      type:     'GET',
      dataType: 'json',
      url:      '/checker/get_experiment?id='+@id,
      async:    false
    }).responseText
    exp = JSON.parse data.json
    @current = exp.current || Card.cards[0].slug
    @values = exp.values || []
    # Init events for all choices
    $('[data-choice-type]').each (i, el) ->
      switch $(el).attr('data-choice-type')
        when 'radio'
          Choice.initRadio el
        when 'slider'
          Choice.initSlider el
        when 'slidergroup'
          Choice.initSliderGroup el

  @addToValues: (name, value) ->
    found = false
    for val in @values
      # if variable already exists: update it
      if val.name == name
        val.value = value
        found = true
        break
    # if item not found add it
    unless found 
      @values.push {'name': name, 'value': value}
    @current = name

  @save: ->
    json = {
      "current": @current
      "values":  @values
    }
    data = {
      "id": @id
      "json": JSON.stringify json
    }
    $.post '/checker/save_experiment', data
