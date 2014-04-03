class window.Experiment
  constructor:(@current) ->
    exp = localStorage.getItem('experiment')
    if (exp?)
      @values = JSON.parse(exp)
    else
      @values = {}
  
  save: ->
    localStorage.setItem('experiment', JSON.stringify(@values))

  getValue:(name) ->
    @values[name]

  setValue:(name, value) ->
    @values[name] = value
    @save()
