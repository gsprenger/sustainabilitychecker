class window.Navigation
  @setup: ->
    # Initiate Bootstrap tooltips
    $('[title]').tooltip {placement: 'bottom'}
    Navigation.initSmoothScrolling()
    Navigation.initScrollSpy()

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

  @removeAndDisplay: (elA, elB, flag1, flag2) ->
    if !flag1
      $(elA).addClass 'fadeOut'
      setTimeout ->
        Navigation.removeAndDisplay elA, elB, true
      , 800
    else if !flag2
      $(elA).addClass 'hidden'
      $(elA).removeClass 'fadeOut'
      $(elB).removeClass 'hidden'
      $(elB).addClass 'fadeIn'
      setTimeout ->
        Navigation.removeAndDisplay elA, elB, true, true
      , 800
    else
      $(elB).removeClass 'fadeIn'
