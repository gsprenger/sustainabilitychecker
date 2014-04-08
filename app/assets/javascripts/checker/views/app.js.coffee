class window.AppView
  constructor: ->
    @$el = $('body')
    @sections = App.get().sections
    @views = []
    @views.push(new IntroView())
    for s in @sections
      @views.push(new SectionView(s))
      if (App.get().level == 2)
        @views.push(new Level2View(s))
    @views.push(new CheckView())

  render: ->
    for v in @views
      @$el.append(v.render().$el)
    # Notify other views
    $(window).trigger('appready')
    @events()

  events: ->
    # Init smooth scrolling
    @$el.find('.nav-link').on 'click', (e) ->
      $('html,body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false
    # Init tooltips
    @$el.find('[title]').tooltip()
    # Scroll to current
    lvl = App.get().experiment.getValue('level')
    if (@level == lvl)
      cur = App.get().experiment.getValue('current')
      for s in @sections
        if (s.slug == cur)
          $('html,body').animate({scrollTop: $("##{s.name}").offset().top}, 1000)  
          break;

