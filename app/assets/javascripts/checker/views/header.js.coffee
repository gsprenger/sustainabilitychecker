class window.HeaderView
  constructor:(@level, @sections) ->
    @$el = $("<header role='banner' data-spy='affix' id='header'>")

  render: ->
    c = App.get().content
    html = """
      <nav>
      <div class='titles'>
          <div class='title demand'>#{c.text('chkr_demand', 'simple')}</div>
          <div class='title supply'>#{c.text('chkr_supply', 'simple')}</div>
          <div class='title check'>#{c.text('chkr_check', 'simple')}</div>
        </div>
        <hr>
        <ul role='navigation'>
      """
    for s in @sections
      p = s.i18nPrefix
      html += """
            <li>
              <a href='##{s.name}' class='#{s.type} nav-link' title='#{c.text(p+'_title', 'none')}'>
                <i class="fa #{s.headerIcon}"></i>
              </a>
            </li>
        """
    html += """
          <li>
            <a href='#check' class='check nav-link' title='Check'>
              <i class="fa fa-check"></i>
            </a>
          </li>
        </ul>
      </nav>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    $(window).on 'appready', ->
      # HeaderView: set offset to header position for affix to trigger
      $('#header').attr('data-offset-top', $('#header').offset().top)
      topMenuHeight = $('#header').outerHeight()+15
      menuItems = $('#header').find("a")
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
