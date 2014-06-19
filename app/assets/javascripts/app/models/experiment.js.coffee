class window.Experiment  
  progression: ['intro', 'd_dem', 'd_die', 'd_hou', 'd_ser', 's_lan', 's_bm', 's_agr', 's_ene', 'check']

  constructor: ->
    exp = localStorage.getItem('experiment')
    if (exp?)
      @values = JSON.parse(exp)
    else
      @values = {current: @progression[0], level: 1}
  
  save: ->
    localStorage.setItem('experiment', JSON.stringify(@values))

  getValue:(slug) ->
    @values[slug]

  getCurrent: ->
    @values.current

  setValue:(slug, value) ->
    @values[slug] = value
    @values['current'] = @getNext((if (slug.lastIndexOf('_') != 1) then slug.substr(0,5) else slug))
    @save()

  setCurrent:(slug) ->
    @values.current = slug
    @save()

  getNext:(slug) ->
    @progression[@progression.indexOf(slug)+1]

  isCompleted:(slug) ->
    if App.get().level == 1
      @progression.indexOf(slug) < @progression.indexOf(@values.current)
    else
      true

  getLastLevel: ->
    @values.level

  setLastLevel:(level) ->
    @values.level = level
    @save()
