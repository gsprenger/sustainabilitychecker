class window.Experiment
  progression: ['d_dem', 'd_die', 'd_hou', 'd_ser', 's_den', 's_lan', 's_bm', 's_agr', 's_ene', 'check']
  constructor:(@current) ->
    exp = localStorage.getItem('experiment')
    if (exp?)
      @values = JSON.parse(exp)
    else
      @values = {level: 1, current: @current}
  
  save: ->
    localStorage.setItem('experiment', JSON.stringify(@values))

  getValue:(name) ->
    @values[name]

  setValue:(name, value) ->
    @values[name] = value
    @values['current'] = (if (name.lastIndexOf('_') != 1) then name.substr(0,5) else name)
    @save()

