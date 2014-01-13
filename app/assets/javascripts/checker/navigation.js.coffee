class window.Navigation
  @setup: ->
    # Initiate Bootstrap tooltips and scroll helpers
    $('[title]').tooltip {placement: 'bottom'}
    Navigation.initSmoothScrolling()
    Navigation.initScrollSpy()
    $('.checkicon').click ->
      if $('.checksection').css('display') == 'none'
        Navigation.showLoading('section')
        App.launchCheck()

  @getNextSectionSlug: (curSlug) ->
    $('[data-section-slug='+curSlug+']').next().attr('data-section-slug') || curSlug

  @getPrevSectionSlug: (curSlug) ->
    $('[data-section-slug='+curSlug+']').previous().attr('data-section-slug') || curSlug

  @goToSection: (sectionSlug) ->
    sectionID = $('.section[data-section-slug='+sectionSlug+']').attr('id')
    $('a[href=#'+sectionID+']').trigger('click')

  @initSmoothScrolling: ->
    $('a[href*=#]:not([href=#])').click ->
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) 
        if $(this.hash) 
          target = $(this.hash) 
        else 
          target = $('[name=' + this.hash.slice(1) +']')
        if (target.length)
          $('html,body').animate({scrollTop: target.offset().top}, 1000)
          return false

  @initScrollSpy: ->
    topMenu = $(".header")
    topMenuHeight = topMenu.outerHeight()+15
    menuItems = topMenu.find("a")
    scrollItems = menuItems.map ->
      item = $($(this).attr("href"))
      if (item.length) 
        return item
      
    $(window).scroll ->
      fromTop = $(this).scrollTop()+topMenuHeight;
      cur = scrollItems.map ->
        if ($(this).offset().top < fromTop)
          return this
      cur = cur[cur.length-1]
      if (cur && cur.length)
        id = cur[0].id
      if (lastId != id) 
        lastId = id
        menuItems.map ->
          $(this).find('.menu-nav-item').removeClass('active')
        $('[href=#'+id+']').find('.menu-nav-item').addClass('active')

  @showLoading: (el) ->
    if (el)
      $('.'+el).css('visibility', 'hidden')
      $('.'+el).css('opacity', '0')
      $('.'+el).css('transition-delay', '0s')
      setTimeout ->
        $('.'+el).css('display', 'none')
      , 750
    NProgress.configure({ trickleRate: 0.12, trickleSpeed: 200 });
    NProgress.start()

  @removeLoading: (el) ->
    setTimeout ->
      NProgress.done()
      $('.'+el).css('display', 'block')
      $('.header').css('display', 'block')
      setTimeout ->
        $('.'+el).css('visibility', 'visible')
        $('.header').css('visibility', 'visible')
        $('.'+el).css('opacity', '1')
        $('.header').css('opacity', '1')
        $('.'+el).css('transition-delay', '0s')
        $('.header').css('transition-delay', '0s')
      , 250
    , 2000
