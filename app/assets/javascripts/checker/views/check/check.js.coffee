class window.CheckView
  constructor: ->
    @$el = $("<div id='check' class='in-level#{App.get().level}'>")
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
    $(window).on 'clickshowresult', =>
      @res.$el.show()
      $('body').animate({scrollTop: $('#checkresult').offset().top}, 500)
