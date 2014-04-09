class window.Experiment  
  progression: ['intro', 'd_dem', 'd_die', 'd_hou', 'd_ser', 's_den', 's_lan', 's_bm', 's_agr', 's_ene', 'check']

  constructor:(@level) ->
    exp = localStorage.getItem('experiment-level'+@level)
    if (exp?)
      @values = JSON.parse(exp)
    else
      @values = {current: @progression[0]}
  
  save: ->
    localStorage.setItem('experiment-level'+@level, JSON.stringify(@values))

  getValue:(slug) ->
    @values[slug]

  setValue:(slug, value) ->
    @values[slug] = value
    @values['current'] = @getNext((if (slug.lastIndexOf('_') != 1) then slug.substr(0,5) else slug))
    @save()

  getCurrent: ->
    @values.current

  setCurrent:(slug) ->
    @values.current = slug

  isCompleted:(slug) ->
    @progression.indexOf(slug) < @progression.indexOf(@values.current)

  getNext:(slug) ->
    @progression[@progression.indexOf(slug)+1]
