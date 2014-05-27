class window.AppView
  constructor: ->
    @$el = $('body')
    @views = []
    lvl = App.get().level
    @views.push(new HeaderView())
    @views.push(new IntroView())
    for s in App.get().sections
      @views.push(new SectionView(s))
      if (lvl == 2)
        @views.push(new Level2View(s))
    @views.push(new CheckSummaryView())
    @views.push(new CheckResultView())
    if (lvl == 3)
      @views.push(new Level3View())

  render: ->
    e = App.get().experiment
    # render all attached views
    for v in @views
      @$el.append(v.render().$el)
    # Notify other views
    $(window).trigger('appready')
    @events()
    # Init tooltips
    $('body').tooltip {
      selector: '[title]',
      placement: 'bottom'
    }
    # init popovers
    $('body').popover {
      selector: '[data-toggle=popover]'
      placement: 'bottom',
      trigger: 'hover'
    }
    # Scroll to current section
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
    # check if mercury is running and if yes run special method
    if (App.get().isMercury)
      @setupForMercury()

  events: ->
    # Init smooth scrolling
    @$el.find('.nav-link').on 'click', (e) ->
      $('body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false

  setupForMercury: ->
    e = App.get().experiment
    $('.btn, .nav-link, .cell, .btnnext').off('click')
    $('.section, #check').show()
    e.save = e.setValue = ->
      true
