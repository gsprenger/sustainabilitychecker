class window.SliderGroup
  constructor:(@slug, @sliders) ->
    @type = 'SliderGroup'

  getValue: ->
    for s in @sliders
      s.getValue()

  setValue:(values) ->
    for i in [0..@sliders.length-1]
      @sliders[i].setValue(values[i])
