class window.Navigation
  # Setup navigation icons click events and helpers
  @setup: ->
    # Initiate Bootstrap tooltips
    $('[title]').tooltip {placement: 'bottom'}
    # Automatic activation of active effect on scroll
    Navigation.initScrollSpy()
    # Click event for all navigation links
    $('.nav-link').click ->
      Navigation.goToSection(this.hash.substr(1))
      return false # prevent default anchor scroll

  @getNextSectionSlug: (curSlug) ->
    $('[data-section-slug='+curSlug+']').next().attr('data-section-slug') || curSlug

  @getPrevSectionSlug: (curSlug) ->
    $('[data-section-slug='+curSlug+']').previous().attr('data-section-slug') || curSlug

  @goToSection: (name, isSlug) ->
    if isSlug
      name = $('[data-section-slug='+name+']').attr('id')
    target = '[id='+name+']'
    Navigation.smoothScrollTo(target)

  @smoothScrollTo: (target) ->
    $('html,body').animate({scrollTop: $(target).offset().top}, 1000)    

  @initScrollSpy: ->
    topMenu = $("header")
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
      else 
        menuItems.map ->
          $(this).removeClass('active')    
      if (lastId != id) 
        lastId = id
        menuItems.map ->
          $(this).removeClass('active')
        $('[href=#'+id+']').addClass('active')

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
