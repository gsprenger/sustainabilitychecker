class window.RadioModel extends ChoiceModel
  constructor:(@slug, @values) ->

  getValue: ->
    if @value?
      @value
    else
      @values[0]

  setValue:(value) ->
    if (value in @values)
      @value = value
      App.get().experiment.setValue(@slug, value)
      $(window).trigger('choicecomplete', this)
    else
      console.error('RadioModel Error: trying to select unknown value '+ value)
