class window.Land
  # Data from team datasheet in CoffeeScript Object format
  @data = 
    "s_lan": # ha p.c.
      "low":  0.08
      "med":  0.3
      "high": 0.5

  ###
  GETTERS
  ###
  @get_s_lan: ->
    Land.data.s_lan[Land.value]

  @get_land_prod: ->
    1 # MISSING DATA

  ###
  FUNCTIONAL CODE
  ###
  @trigger: (value) ->
    switch (value)
      when 'low' then Land.value = 'low'
      when 'med' then Land.value = 'med'
      when 'high' then Land.value = 'high'
      else
        console.error('Unknown Land value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#land').find('[data-choice-type]')
    slug = $(el).closest('.section').attr('data-section-slug')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Land.trigger(value)
    if (val = Progression.getVariable(slug))
      Land.trigger(val)
      
