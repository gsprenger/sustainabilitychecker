class window.Services
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data = 
    {
      "HA_SG_IN_PW": { # %age
        "4":  0.47,
        "5":  0.51,
        "6":  0.55,
        "7":  0.59,
        "8":  0.62,
        "9":  0.65,
        "10": 0.68,
        "11": 0.71,
        "12": 0.73
      },
      "EMR_SG": { # MJ-GER/hr
        "4":  1,
        "5":  5,
        "6":  10,
        "7":  15,
        "8":  20,
        "9":  30,
        "10": 60,
        "11": 90,
        "12": 120
      }
    }

  # Getters used by other models
  @get_HA_SG_IN_PW: ->
    Services.data.HA_SG_IN_PW[Services.value]

  @get_EMR_SG: ->
    Services.data.EMR_SG[Services.value]

  @get_HA_SG: ->
    (Demographics.get_HA_PW() * Services.get_HA_SG_IN_PW())

  @get_ET_SG: ->
    (Services.get_HA_SG() * Services.get_EMR_SG())

  # Functional code
  @setup: ->
    # Get sliders
    edu = $('[data-slider-name="d_ser_edu"]')
    med = $('[data-slider-name="d_ser_med"]')
    pub = $('[data-slider-name="d_ser_pub"]')
    tra = $('[data-slider-name="d_ser_tra"]')
    # Set values
    Choice.initSlider(
      Choice.createSlider(edu, 'lmh', ['Low', 'Medium', 'High'])
    )
    Choice.initSlider(
      Choice.createSlider(med, 'lmh', ['Low', 'Medium', 'High'])
    )
    Choice.initSlider(
      Choice.createSlider(pub, 'lmh', ['Low', 'Medium', 'High'])
    )
    Choice.initSlider(
      Choice.createSlider(tra, 'lmh', ['Low', 'Medium', 'High'])
    )
    # Set trigger
    trigger = ->
      val = $(edu).slider('value') + 
            $(med).slider('value') + 
            $(pub).slider('value') + 
            $(tra).slider('value') + 4 # because of index 0
      Services.trigger(val)
    $(edu).on 'slidechange', trigger
    $(med).on 'slidechange', trigger
    $(pub).on 'slidechange', trigger
    $(tra).on 'slidechange', trigger
    trigger()

  @trigger: (value) ->
    switch (value)
      when 4 then Services.value = 4
      when 5 then Services.value = 5
      when 6 then Services.value = 6
      when 7 then Services.value = 7
      when 8 then Services.value = 8
      when 9 then Services.value = 9
      when 10 then Services.value = 10
      when 11 then Services.value = 11 
      when 12 then Services.value = 12
      else
        console.error('Unknown Services value "'+value+'". Check cannot be performed')
