class window.Radio
  constructor:(@slug, @values) ->
    @type = 'Radio'
    @experiment = App.get().experiment
    val = @experiment.getValue(@slug)
    if (val? && val in @values)
      @value = val

  getValue: ->
    if @value?
      @value
    else
      @values[0]

  setValue:(value) ->
    if (value in @values)
      @value = value
      @experiment.setValue(@slug, value)
    else
      @experiment.setValue(@slug, @values[0])

  isValueSet: ->
    return @value?
