class window.Bm
  # Data from team datasheet in CoffeeScript Object format
  @data = 
    "ET_BM": # GJ-GER p.c.
      "low":  25
      "med":  37
      "high": 148
    "EMR_BM": # MJ-GER/hr
      "low":  177
      "med":  145
      "high": 680
    "HA_BM": # hours p.c.
      "low":  141
      "med":  257
      "high": 218

  ###
  GETTERS
  ###
  @get_ET_BM: ->
    Bm.data.ET_BM[Bm.value]

  @get_EMR_BM: ->
    Bm.data.EMR_BM[Bm.value]

  @get_HA_BM: ->
    Bm.data.HA_BM[Bm.value]

  ###
  FUNCTIONAL CODE
  ###
  @trigger: (value) ->
    switch (value)
      when 'low' then Bm.value = 'low'
      when 'med' then Bm.value = 'med'
      when 'high' then Bm.value = 'high'
      else
        console.error('Unknown Bm value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#bm').find('[data-choice-type]')
    slug = $(el).closest('.section').attr('data-section-slug')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Bm.trigger(value)
    if (val = Progression.getVariable(slug))
      Bm.trigger(val)
      