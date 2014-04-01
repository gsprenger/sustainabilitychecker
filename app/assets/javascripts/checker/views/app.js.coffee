class window.AppView
  constructor:(@el, @sections) ->
    @header = new HeaderView()

  render:() ->
    @experiment
    @sections
