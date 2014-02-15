class window.Land
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data = 
    {
      "s_lan": { # ha p.c.
        "low":  0.08,
        "med":  0.3,
        "high": 0.5
      }
    }

  # Getters used by other models
  @get_s_lan: ->
    Land.data.s_lan[Land.value]

  @get_land_prod: ->
    0 # MISSING DATA

  # Functional code
  @trigger: (value) ->
    switch (value)
      when 'low' then Land.value = 'low'
      when 'med' then Land.value = 'med'
      when 'high' then Land.value = 'high'
      else
        console.error('Unknown Land value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#land').find('[data-choice-type]')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Land.trigger(value)
      
