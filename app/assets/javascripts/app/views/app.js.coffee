class window.AppView
  constructor:(@isPermalink) ->
    @$el      = $('#app')
    @$loading = $('#app-loading')
    @$app     = $('#app-main')
    @views = []
    @views.push(new ModalIconsView())
    @views.push(new ScrollTopIconView())
    @views.push(new IntroView())
    for s in App.get().sections
      @views.push(new SectionView(s))
    @views.push(new CheckView())
    if (App.get().level >= 2)
      @views.push(new SudokuOverlayView())
    @views.push(new TryAgainModal())
    @views.push(new HelpModal())
    @views.push(new HelpNewModal())
    @views.push(new HelpPermalinkModal())
    @views.push(new ShareModal())
    # Window events go here so they arent repeated for each render
    $(window).on 'sectioncomplete', (e, data) ->
      # mark header item as completed
      if ($('[href=#'+data+']').length > 0)
        $('[href=#'+data+']').addClass('complete')
      nextSec = $('#'+data).nextAll('.section').first()
      if (nextSec.length)
        secID = nextSec.attr('id')
        nextSec.show()
        App.get().experiment.setCurrent(nextSec.data('slug'))
        if App.get().level == 1
          $('[href=#'+secID+']').addClass('active')
        $('body,html').stop(true,true).animate({scrollTop: nextSec.offset().top}, 500)
      else
        $('[href=#check]').addClass('activelevel'+App.get().level)
        App.get().experiment.setCurrent('check')
        $(window).trigger('showcheck')

  render: ->
    e = App.get().experiment
    # render all attached views
    for v in @views
      @$app.append(v.render().$el)
    @events()
    # Init tooltips
    $('body').tooltip {
      selector: '[data-toggle=tooltip]',
      placement: 'bottom'
    }
    # init popovers
    $('body').popover
      selector: '[data-toggle=popover]'
      placement: 'bottom',
      trigger: 'hover click'
    # Scroll to current section
    if App.get().level == 1
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
    if App.get().isMercury
      @setupForMercury()
    # Remove loading screen and check if modals should be triggered.
    setTimeout =>
      @$loading.fadeOut()
      setTimeout =>
        $('.site-footer').removeClass('inapploading')
        $('body').removeClass('inapploading')
        # if user is new display help modal
        if e.isNew()
          $('#modal-helpnew').modal()
        if @isPermalink
          $('#modal-helppermalink').modal()
      , 400
    , 500
    # Notify other views
    $(window).trigger('appready')

  events: ->
    # Init smooth scrolling
    @$el.find('.nav-link').on 'click', (e) ->
      $('html, body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false

  setupForMercury: ->
    $('.section, #check').show()
    App.get().experiment.save = ->
      true
