class window.Diet
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data = 
    {
      "grains_equiv": { # kg p.c.
        "low":  200,
        "med":  375,
        "high": 1000
      }
    }

  # Getters used by other models
  @get_grains_equiv: ->
    Diet.data.grains_equiv[Diet.value]

  # Functional code
  @trigger: (value) ->
    switch (value)
      when 'low' then Diet.value = 'low'
      when 'med' then Diet.value = 'med'
      when 'high' then Diet.value = 'high'
      else
        console.error('Unknown diet value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#diet').find('[data-choice-type]')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Diet.trigger(value)
      
