class window.Households
  constructor: ->
    @name = 'households'
    @slug = 'd_hou'
    @type = 'demand'
    @headerIcon = 'fa-home'
    @i18nPrefix = 'chkr_hou'
    @sliders = {
      'urb': new Slider('d_hou_urb', [20, 30, 50, 70, 85], 85),
      'rur': new Slider('d_hou_rur', [15, 30, 50, 70, 80], 15)
    }
    @addSecondSliders(@sliders.urb.getValue())
    @choices = []
    @choices.push(new SliderGroup('urbrur', [
        @sliders['urb'], @sliders['rur']
      ]))
    @choices.push(new SliderGroup('subapaslu', [
        @sliders['sub'], @sliders['apa'], @sliders['slu']
      ]))  
    @valueChanged = true
    $(window).on 'slidervalchanged', (e, name) =>
      if (name.split('_', 2).join('_') == "d_hou")
        @valueChanged = true

  addSecondSliders:(valUrb) ->
    switch (valUrb)
      when 20
        @sliders.sub = new Slider('d_hou_sub', [0], 0)
        @sliders.apa = new Slider('d_hou_apa', [50], 50)
        @sliders.slu = new Slider('d_hou_slu', [50], 50)
      when 30, 50
        @sliders.sub = new Slider('d_hou_sub', [0], 0)
        @sliders.apa = new Slider('d_hou_apa', [70], 70)
        @sliders.slu = new Slider('d_hou_slu', [30], 30)
      when 70
        @sliders.sub = new Slider('d_hou_sub', [0], 0)
        @sliders.apa = new Slider('d_hou_apa', [80], 80)
        @sliders.slu = new Slider('d_hou_slu', [20], 20)
      when 85
        @sliders.sub = new Slider('d_hou_sub', [30, 60], 30)
        @sliders.apa = new Slider('d_hou_apa', [40, 70], 70)
        @sliders.slu = new Slider('d_hou_slu', [0], 0)
      else
        console.error('Unknown Households/Urban-Rural proportion "'+valUrb+'". Check cannot be performed')

  updateSecondGroup:(valUrb) ->
    @addSecondSliders(valUrb)
    g2 = new SliderGroup('subapaslu', [@sliders.sub, @sliders.apa, @sliders.slu])
    hhView = null
    for v in App.get().appView.views
      if (v.section? && v.section.slug == 'd_hou')
        hhView = v
        break
    hhView.choiceViews[1].slidergroup = g2
    hhView.choiceViews[1].render()

  # SUDOKU DATA #  
  data:
    "EMR_HH": # MJ-GER/hr
      "30-70-0":  8.4
      "60-40-0":  10
      "0-80-20":  4
      "0-70-30l": 2
      "0-70-30h": 0.8
      "0-50-50":  0.15
    "perc_ET_ELEC": # % of PES
      "30-70-0":  30
      "60-40-0":  30
      "0-80-20":  15
      "0-70-30l": 20
      "0-70-30h": 20
      "0-50-50":  10
    "perc_ET_FUELS": # % of PES
      "30-70-0":  70
      "60-40-0":  70
      "0-80-20":  85
      "0-70-30l": 80
      "0-70-30h": 80
      "0-50-50":  90

  getValue: ->
    if @valueChanged
      rur = @sliders['rur'].getValue()
      prop = (100-rur) + '-' + rur
      value = @sliders['sub'].getValue() + '-' +
        @sliders['apa'].getValue() + '-' + 
        @sliders['slu'].getValue()
      value += 'l' if prop == '50-50'
      value += 'h' if prop == '30-70'
      @value = value
      @valueChanged = false
    return @value

  get_EMR_HH: ->
     @data.EMR_HH[@getValue()]

  get_perc_ET_ELEC: ->
     @data.perc_ET_ELEC[@getValue()]

  get_perc_ET_FUELS: ->
    (100 -  @get_perc_ET_ELEC())

  get_ET_HH: ->
    (@get_EMR_HH() * App.get().demographics.get_HA_HH())/1000
