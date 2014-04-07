class window.AppView
  constructor:(@level) ->
    @$el = $('body')
    @sections = App.get().sections
    @views = []
    @views.push(new IntroView(@level, @sections))
    for s in @sections
      @views.push(new SectionView(s))
    @views.push(new CheckView(@sections))
    @views.push(new SudokuView())

  render: ->
    for v in @views
      @$el.append(v.render().$el)
    # Notify other views
    $(window).trigger('appready')
    @events()

  events: ->
    @$el.find('.nav-link').on 'click', (e) ->
      $('html,body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false
    @$el.find('[title]').tooltip()
