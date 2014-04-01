class window.HouseholdsModel extends SectionModel
  constructor: ->
    @name = 'households'
    @slug = 'd_hou'
    @type = 'demand'
    @headerIcon = 'fa-home'
    @i18nPrefix = 'chkr_hou'
    @sliders = {
      'urb': new SliderModel('d_hou_urb', [20, 30, 50, 70, 85], 85),
      'rur': new SliderModel('d_hou_rur', [15, 30, 50, 70, 80], 15),
      'sub': new SliderModel('d_hou_sub', [30, 60], 30),
      'apa': new SliderModel('d_hou_apa', [40, 70], 70),
      'slu': new SliderModel('d_hou_slu', [0], 0)
    }
    @choices = []
    @choices.push(new SliderGroupModel([
        @sliders['urb'], @sliders['rur']
      ]))
    @choices.push(new SliderGroupModel([
        @sliders['sub'], @sliders['apa'], @sliders['slu']
      ]))

  # SUDOKU DATA #  
  data:
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

  getValue: ->
    prop = @sliders['urb'].getValue() + '-' + @sliders['rur'].getValue()
    value = @sliders['sub'].getValue() + '-' +
      @sliders['apa'].getValue() + '-' + 
      @sliders['slu'].getValue()
    value += 'l' if prop == '50-50'
    value += 'h' if prop == '30-70'
    return value

  get_EMR_HH: ->
     @data.EMR_HH[@getValue()]

  get_ET_ELEC: ->
     @data.ET_ELEC[@getValue()]

  get_ET_FUELS: ->
    (100 -  @get_ET_ELEC())

  get_ET_HH: ->
    (@get_EMR_HH() * App.get().demographics.get_HA_HH())
