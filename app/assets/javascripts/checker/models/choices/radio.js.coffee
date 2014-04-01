class window.RadioModel extends ChoiceModel
  constructor:(@slug, @values) ->
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
      $(window).trigger('choicecomplete', this)
    else
      console.error('RadioModel Error: trying to select unknown value '+ value)
