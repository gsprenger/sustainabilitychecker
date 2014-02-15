class window.Agriculture
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data = 
    {
      "labor_density": { # hrs/ha
        "low":  720,
        "med":  210,
        "high": 12
      },
      "EMD_AG": { # GJ-EC_FUELS/ha
        "low":  6.7,
        "med":  15,
        "high": 29.3
      },
      "HA_AG_IN_PW": { # %age
        "low":  0.31,
        "med":  0.13,
        "high": 0.02
      },
      "EMR_AG": { # MJ-GER/hr
        "low":  2,
        "med":  70,
        "high": 300
      }
    }

  # Getters used by other models
  @get_labor_density: ->
    Agriculture.data.labor_density[Agriculture.value]

  @get_EMD_AG: ->
    Agriculture.data.EMD_AG[Agriculture.value]

  @get_HA_AG_IN_PW: ->
    Agriculture.data.HA_AG_IN_PW[Agriculture.value]
    
  @get_EMR_AG: ->
    Agriculture.data.EMR_AG[Agriculture.value]
    
  @get_HA_AG: ->
    (Demographics.get_HA_PW() * Agriculture.get_HA_AG_IN_PW())
    
  @get_ET_AG: ->
    (Agriculture.get_HA_AG() * Agriculture.get_EMR_AG())
    
  @get_LU_AG: ->
    (Diet.get_grains_equiv() * Land.get_land_prod())
    
  @get_post_harv: ->
    0 # MISSING DATA
    
  @get_food_hyper: ->
    0 # MISSING DATA

  # Functional code
  @trigger: (value) ->
    switch (value)
      when 'low' then Agriculture.value = 'low'
      when 'med' then Agriculture.value = 'med'
      when 'high' then Agriculture.value = 'high'
      else
        console.error('Unknown Agriculture value "'+value+'". Check cannot be performed')

  @setup: ->
    el = $('#agriculture').find('[data-choice-type]')
    Choice.initRadio(el)
    $(el).find('[data-cv-value]').each (i, radio) ->
      value = $(radio).attr('data-cv-value')
      $(radio).on 'click', ->
        Agriculture.trigger(value)
      
