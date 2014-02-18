class window.Progression
  @id = 0 # user ID in database
  @current = 'intro' # section to display on startup
  @values = [] # Values entered by the user

  # Loads the experiment from DB or create it if non existent
  @setup: ->
    Progression.id = $('#uid').text()
    exp = Progression.load(Progression.id)
    Progression.current = exp.current || Progression.current
    Progression.values = exp.values || []

  @load: (id) -> 
    # Load progression via API
    data = JSON.parse $.ajax({
      type:     'GET',
      dataType: 'json',
      url:      '/checker/get_experiment?id='+id,
      async:    false
    }).responseText
    exp = JSON.parse data.json

  @save: ->
    json = {
      "current": Progression.current
      "values":  Progression.values
    }
    data = {
      "id": Progression.id
      "json": JSON.stringify json
    }
    $.post '/checker/save_experiment', data

  @setVariable: (name, value) ->
    found = false
    for val in Progression.values
      # if variable already exists: update it
      if val.name == name
        val.value = value
        found = true
        break
    # if item not found add it
    unless found 
      Progression.values.push {'name': name, 'value': value}
    # If check is displayed, reset it
    if (!$('#checksection').hasClass('hidden'))
      Navigation.removeAndDisplay('.checksection', '.precheck')
  
  @getVariable: (name) ->
    found = false
    for val in Progression.values
      if val.name == name
        found = val.value
        break
    return found 
