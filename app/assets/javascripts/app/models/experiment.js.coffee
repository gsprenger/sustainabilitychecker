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
    if @progression.indexOf(slug) > @progression.indexOf(@values.current)
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

  getCurrentLevel: ->
    @values.curlevel

  setCurrentLevel:(level) ->
    @values.curlevel = level
    @save()

  getLastLevel: ->
    @values.level

  setLastLevel:(level) ->
    @values.level = level
    @save()

  loadFromCode:(code) ->
    @values = @hashToObject(code)
    if (!@values.current && !@values.level)
      @values = {current: @progression[0], level: 1}

  getLoadCode: ->
    @objectToHash(@values)

  objectToHash:(obj) ->
    str = JSON.stringify(obj)
    hash = ""
    for i in [0..str.length-1]
      hash += str.charCodeAt(i).toString(16)
    return hash

  hashToObject:(hash) ->
    sHash = hash.toString()
    str = ''
    for i in [0..sHash.length-1] by 2
      str += String.fromCharCode(parseInt(sHash.substr(i, 2), 16))
    return JSON.parse(str)
