class window.Density
  # Data from team datasheet in CoffeeScript Object format
  @data = {}

  ###
  GETTERS
  ###

  ###
  FUNCTIONAL CODE
  ###
  @trigger: (value) ->
    switch (value)
      when 'low' then Density.value = 'low'
      when 'med' then Density.value = 'med'
      when 'high' then Density.value = 'high'
      else
        console.error('Unknown density value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#density').find('[data-choice-type]')
    slug = $(el).closest('.section').attr('data-section-slug')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Density.trigger(value)
    if (val = Progression.getVariable(slug))
      Density.trigger(val)
      
