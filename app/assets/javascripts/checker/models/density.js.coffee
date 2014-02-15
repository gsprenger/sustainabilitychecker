class window.Density
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data = 
    {
    }

  # Getters used by other models

  # Functional code
  @trigger: (value) ->
    switch (value)
      when 'low' then Density.value = 'low'
      when 'med' then Density.value = 'med'
      when 'high' then Density.value = 'high'
      else
        console.error('Unknown density value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#density').find('[data-choice-type]')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Density.trigger(value)
      
