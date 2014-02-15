class window.Demographics
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data = 
    {
      "HA_PW": { # hours p.c.
        "low":  1314,
        "med":  876,
        "high": 631
      },
      "HA_HH": { # hours p.c.
        "low":  7446,
        "med":  7884,
        "high": 8129
      }
    }

  # Getters used by other models
  @get_HA_PW: ->
    Demographics.data.HA_PW[Demographics.value]

  @get_HA_HH: ->
    Demographics.data.HA_HH[Demographics.value]

  # Functional code
  @trigger: (value) ->
    switch (value)
      when 'low' then Demographics.value = 'low'
      when 'med' then Demographics.value = 'med'
      when 'high' then Demographics.value = 'high'
      else
        console.error('Unknown demographics value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#demographics').find('[data-choice-type]')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Demographics.trigger(value)
      
