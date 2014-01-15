class window.Navigation
  # Setup navigation icons click events and helpers
  @setup: ->
    # Initiate Bootstrap tooltips
    $('[title]').tooltip {placement: 'bottom'}
    # Automatic activation of active effect on scroll
    Navigation.initScrollSpy()
    # Click event for section icons
    $('nav .demand, nav .supply').click ->
      Navigation.goToSection(this.hash.substr(1))
    # Click event for check icon
    $('nav .check').click ->
      App.launchCheck()

  @getNextSectionSlug: (curSlug) ->
    $('[data-section-slug='+curSlug+']').next().attr('data-section-slug') || curSlug

  @getPrevSectionSlug: (curSlug) ->
    $('[data-section-slug='+curSlug+']').previous().attr('data-section-slug') || curSlug

  @goToSection: (name, isSlug) ->
    if isSlug
      name = $('.section[data-section-slug='+name+']').attr('id')
    target = $('.section[id='+name+']')
    $('html,body').animate({scrollTop: target.offset().top}, 1000)

  @goToCheck: ->
    target = $('.checksection')
    $('html,body').animate({scrollTop: target.offset().top}, 1000)    

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
      if (lastId != id) 
        lastId = id
        menuItems.map ->
          $(this).removeClass('active')
        $('[href=#'+id+']').addClass('active')
