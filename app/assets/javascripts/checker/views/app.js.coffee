class window.AppView
  constructor: ->
    @$el = $('body')
    @views = []
    lvl = App.get().level
    @views.push(new IntroView())
    for s in App.get().sections
      @views.push(new SectionView(s))
      if (lvl == 2)
        @views.push(new Level2View(s))
    @views.push(new CheckView())
    if (lvl == 3)
      @views.push(new Level3View())

  render: ->
    for v in @views
      @$el.append(v.render().$el)
    # Notify other views
    $(window).trigger('appready')
    @events()

  events: ->
    e = App.get().experiment
    # Init smooth scrolling
    @$el.find('.nav-link').on 'click', (e) ->
      $('body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false
    # Init tooltips
    @$el.find('[title]').tooltip()
    # Scroll to current
    cur = e.getCurrent()
    if (cur != 'intro')
      lvl = e.getValue('level')
      if (@level == lvl)
        for s in App.get().sections
          if (s.slug == cur)
            name = s.name
            break
        name ?= 'check'
        $('body').animate({scrollTop: $("##{name}").offset().top}, 1000)
