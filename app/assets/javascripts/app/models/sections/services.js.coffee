class window.Services
  @values: [null, 'low', 'med', 'high']

  constructor: ->
    @name = 'services'
    @slug = 'd_ser'
    @type = 'demand'
    @headerIcon = 'fa-medkit'
    @i18nPrefix = 'chkr_ser'
    @sliders = {
      'edu': new Slider('d_ser_edu', ['low', 'med', 'high'], 'low'),
      'med': new Slider('d_ser_med', ['low', 'med', 'high'], 'low'),
      'pub': new Slider('d_ser_pub', ['low', 'med', 'high'], 'low'),
      'tra': new Slider('d_ser_tra', ['low', 'med', 'high'], 'low')
    }
    @choices = []
    @choices.push(@sliders.edu)
    @choices.push(@sliders.med)
    @choices.push(@sliders.pub)
    @choices.push(@sliders.tra)

  # SUDOKU DATA #  
  data:
    "HA_SG_IN_PW": # fraction
      "4":  0.47
      "5":  0.51
      "6":  0.55
      "7":  0.59
      "8":  0.62
      "9":  0.65
      "10": 0.68
      "11": 0.71
      "12": 0.73
    "EMR_SG": # MJ-GER/hr
      "4":  1
      "5":  5
      "6":  10
      "7":  15
      "8":  20
      "9":  30
      "10": 60
      "11": 90
      "12": 120

  getValue: ->
    value = 0
    for slider in @choices
      switch(slider.getValue())
        when 'low'
          value += 1
        when 'med'
          value += 2
        when 'high'
          value += 3
    return value

  get_HA_SG_IN_PW: ->
    @data.HA_SG_IN_PW[@getValue()]

  get_EMR_SG: ->
    @data.EMR_SG[@getValue()]

  get_HA_SG: ->
    (App.get().demographics.get_HA_PW() * @get_HA_SG_IN_PW())

  get_ET_SG: ->
    (@get_HA_SG() * @get_EMR_SG())/1000

  get_edu: ->
    Services.values.indexOf(@sliders.edu.getValue())

  get_med: ->
    Services.values.indexOf(@sliders.med.getValue())

  get_pub: ->
    Services.values.indexOf(@sliders.pub.getValue())

  get_tra: ->
    Services.values.indexOf(@sliders.tra.getValue())
