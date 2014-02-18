class window.Households
  # Data from team datasheet in CoffeeScript Object format
  @data = 
    "EMR_HH": # MJ-GER/hr
      "30-70-0":  8.4
      "60-40-0":  10
      "0-80-20":  4
      "0-70-30l": 2
      "0-70-30h": 0.8
      "0-50-50":  0.15
    "ET_ELEC": # % of PES
      "30-70-0":  30
      "60-40-0":  30
      "0-80-20":  15
      "0-70-30l": 20
      "0-70-30h": 20
      "0-50-50":  10

  ###
  GETTERS
  ###
  @get_EMR_HH: ->
    Households.data.EMR_HH[Households.value]

  @get_ET_ELEC: ->
    Households.data.ET_ELEC[Households.value]

  @get_ET_FUELS: ->
    (100 - Households.get_ET_ELEC())

  @get_ET_HH: ->
    (Households.get_EMR_HH() * Demographics.get_HA_HH())

  ###
  FUNCTIONAL CODE
  ###
  @setup: ->
    # Get sliders
    urban = $('[data-slider-name="d_hou_urb"]')
    rural = $('[data-slider-name="d_hou_rur"]')
    sub = $('[data-slider-name="d_hou_sub"]')
    apa = $('[data-slider-name="d_hou_apa"]')
    slu = $('[data-slider-name="d_hou_slu"]')
    # Set values
    Choice.initSliderGroup([
      Choice.createSlider(urban, '%', [20, 30, 50, 70, 85], 85),
      Choice.createSlider(rural, '%', [15, 30, 50, 70, 80], 15)
    ])
    # Set trigger
    prevVal = -1
    trigger = ->
      urbVal = $(urban).slider('value')
      if (urbVal != prevVal)
        prevVal = urbVal
        Households.triggerUrbanRural(urbVal)
    $(urban).on 'slidechange', trigger
    $(rural).on 'slidechange', trigger
    trigger()

  @setupWithinUrban: (proportion) ->
    # Suburban/Apartments/Slums
    sub = $('[data-slider-name="d_hou_sub"]')
    apa = $('[data-slider-name="d_hou_apa"]')
    slu = $('[data-slider-name="d_hou_slu"]')
    # Reset any previous sliders
    if ($(sub).hasClass('ui-slider'))
      $(sub).slider('destroy')
      $(apa).slider('destroy')
      $(slu).slider('destroy')
      $(sub).html('')
      $(apa).html('')
      $(slu).html('')
      $(sub).off()
      $(apa).off()
      $(slu).off()
    # Set values for each proportion
    switch (proportion)
      when '20-80'
        Choice.initSliderGroup([
          Choice.createSlider(sub, '%', [0]),
          Choice.createSlider(apa, '%', [50]),
          Choice.createSlider(slu, '%', [50])
        ])
      when '30-70', '50-50'
        Choice.initSliderGroup([
          Choice.createSlider(sub, '%', [0]),
          Choice.createSlider(apa, '%', [70]),
          Choice.createSlider(slu, '%', [30])
        ])
      when '70-30'
        Choice.initSliderGroup([
          Choice.createSlider(sub, '%', [0]),
          Choice.createSlider(apa, '%', [80]),
          Choice.createSlider(slu, '%', [20])
        ])
      when '85-15'
        Choice.initSliderGroup([
          Choice.createSlider(sub, '%', [30, 60], 30),
          Choice.createSlider(apa, '%', [40, 70], 70),
          Choice.createSlider(slu, '%', [0])
        ])
      else
        console.error('Unknown Households/Urban-Rural proportion "'+value+'". Check cannot be performed')
    # Set trigger
    trigger = ->
      value = $(sub).slider('value') + '-' +
              $(apa).slider('value') + '-' + 
              $(slu).slider('value')
      value += 'l' if proportion == '50-50'
      value += 'h' if proportion == '30-70'
      Households.triggerWithinUrban(value)
    $(sub).on 'slidechange', trigger
    $(apa).on 'slidechange', trigger
    $(slu).on 'slidechange', trigger
    trigger()

  @triggerUrbanRural: (value) ->
    switch (value)
      when 20 then urb_rur = '20-80'
      when 30 then urb_rur = '30-70'
      when 50 then urb_rur = '50-50'
      when 70 then urb_rur = '70-30'
      when 85 then urb_rur = '85-15'
      else
        console.error('Unknown Households/Urban value "'+value+'". Check cannot be performed')
    # Set variable
    Households.urb_rur = urb_rur
    # Setup next sliders with correct values
    Households.setupWithinUrban(urb_rur)

  @triggerWithinUrban: (value) -> 
    switch (value)
      when '30-70-0'  then Households.value = '30-70-0' 
      when '60-40-0'  then Households.value = '60-40-0' 
      when '0-80-20'  then Households.value = '0-80-20' 
      when '0-70-30l' then Households.value = '0-70-30l'
      when '0-70-30h' then Households.value = '0-70-30h'
      when '0-50-50'  then Households.value = '0-50-50' 
      else
        console.error('Unknown Households/Within urban proportion "'+value+'". Check cannot be performed')   
    # Set variable    
    Households.value = value
