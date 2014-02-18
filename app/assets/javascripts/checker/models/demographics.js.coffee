class window.Demographics
  # Data from team datasheet in CoffeeScript Object format
  @default = 'low'
  @data = 
    "HA_PW": # hours p.c.
      "low":  1314
      "med":  876
      "high": 631
    "HA_HH": # hours p.c.
      "low":  7446
      "med":  7884
      "high": 8129

  ###
  GETTERS
  ###
  @get_HA_PW: ->
    Demographics.data.HA_PW[Demographics.value]

  @get_HA_HH: ->
    Demographics.data.HA_HH[Demographics.value]

  ###
  FUNCTIONAL CODE
  ###
  @trigger: (value) ->
    switch (value)
      when 'low' then Demographics.value = 'low'
      when 'med' then Demographics.value = 'med'
      when 'high' then Demographics.value = 'high'
      else
        console.error('Unknown demographics value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#demographics').find('[data-choice-type]')
    slug = $(el).closest('.section').attr('data-section-slug')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Demographics.trigger(value)
    if (val = Progression.getVariable(slug))
      Demographics.trigger(val)
    else
      Demographics.trigger(Demographics.default)
      
