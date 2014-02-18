class window.Diet
  # Data from team datasheet in CoffeeScript Object format
  @data = 
    "grains_equiv":
      "low":  200
      "med":  375
      "high": 1000

  ###
  GETTERS
  ###
  @get_grains_equiv: ->
    Diet.data.grains_equiv[Diet.value]

  ###
  FUNCTIONAL CODE
  ###
  @trigger: (value) ->
    switch (value)
      when 'low' then Diet.value = 'low'
      when 'med' then Diet.value = 'med'
      when 'high' then Diet.value = 'high'
      else
        console.error('Unknown diet value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#diet').find('[data-choice-type]')
    slug = $(el).closest('.section').attr('data-section-slug')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Diet.trigger(value)
    if (val = Progression.getVariable(slug))
      Diet.trigger(val)
    else
      Diet.trigger(Diet.default)
      
