class window.ExperimentModel
  constructor:(@current) ->
    exp = localStorage.getItem('experiment')
    if (exp != null)
      exp = JSON.parse(exp)
      @current = exp.current
      @values = exp.values
    else
      @values = {}
  
  save: ->
    localStorage.setItem('experiment', JSON.stringify(@json))

  getValue:(name) ->
    @values[name]

  setValue:(name, value) ->
    @values[name] = value
