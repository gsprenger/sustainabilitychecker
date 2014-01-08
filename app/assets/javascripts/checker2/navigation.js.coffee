class window.Navigation
  @setup: ->
    Navigation.initSmoothScrolling()
    Navigation.initScrollSpy()

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
    topMenu = $(".menu-nav")
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
