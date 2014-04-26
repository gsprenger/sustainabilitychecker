class window.CheckView
  constructor: ->
    @$el = $(body)
    @sum = new CheckSummaryView()
    @res = new CheckResultView()

  render: ->
    @$el.append(@sum.render().$el)
    @$el.append(@res.render().$el)
    @res.$el.hide()
    if (App.get().experiment.getCurrent() != 'check')
      @$el.hide()
    @events()
    return this

  events: ->
