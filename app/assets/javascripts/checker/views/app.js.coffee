class window.AppView
  constructor: ->
    @$el = $('body')
    @views = []
    @views.push(new HeaderView())
    @views.push(new IntroView())
    for s in App.get().sections
      @views.push(new SectionView(s))
    @views.push(new CheckSummaryView())
    @views.push(new CheckResultView())
    if (App.get().level >= 2)
      @views.push(new SudokuOverlayView())

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
      selector: '[data-toggle=tooltip]',
      placement: 'bottom'
    }
    # init popovers
    $('body').popover {
      selector: '[data-toggle=popover]'
      placement: 'bottom',
      trigger: 'hover',
      container: 'body'
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
    $(window).on 'sectioncomplete', (e, data) ->
      # mark header item as completed
      if ($('[href=#'+data+']').length > 0)
        $('[href=#'+data+']').addClass('complete')
      nextSec = $('#'+data).nextAll('.section').first()
      if (nextSec.length)
        secID = nextSec.attr('id')
        nextSec.show()
        if ($('#'+secID+'-lvl2').length)
          $('#'+secID+'-lvl2').show()
        App.get().experiment.setCurrent(nextSec.data('slug'))
        $('[href=#'+secID+']').addClass('active')
        $('body,html').stop(true,true).animate({scrollTop: nextSec.offset().top}, 500)
      else
        $('[href=#check]').addClass('activelevel'+App.get().level)
        $('#check').show()
        $('body,html').stop(true,true).animate({scrollTop: $('#check').offset().top}, 500)

  setupForMercury: ->
    e = App.get().experiment
    $('.btn, .nav-link, .cell, .btnnext').off('click')
    $('.section, #check').show()
    e.save = e.setValue = ->
      true
