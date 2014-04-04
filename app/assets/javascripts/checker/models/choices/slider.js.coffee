class window.Slider
  constructor:(@slug, @values, @default) ->
    @type = @constructor.name # classname
    @experiment = App.get().experiment
    val = @experiment.getValue(@slug)
    if (val? && val in @values)
      @value = val
    @sliderType = if (isNaN(@default)) then 'text' else 'number'

  getValue: ->
    if @value?
      @value
    else
      @default

  setValue:(value) ->
    if (@sliderType == 'text')
      value = @values[value]
    if (value in @values)
      @value = value
      @experiment.setValue(@slug, value)
      $(window).trigger('choicecomplete', this)
    else
      console.error(@type+' Error: trying to select unknown value '+ value)

  getShortName: ->
    @slug.substr(@slug.lastIndexOf('_'))
