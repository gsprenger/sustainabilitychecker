class window.HeaderView
  constructor:(@el, @level, @content, @sections) ->
    @events = [
      ['.nav-link', 'click', (e) =>
        @smoothScrollTo(e.currentTarget.hash)
      ]
    ]

  render: ->
    #build things append to el return el
    html = """
      <header role='banner' data-spy='affix' id='header'>
        <nav>
          <div class='titles'>
            <div class='title demand'>#{@content.text('chkr_demand', 'simple')}</div>
            <div class='title supply'>#{@content.text('chkr_supply', 'simple')}</div>
            <div class='title check'>#{@content.text('chkr_check', 'simple')}</div>
          </div>
          <hr>
          <ul role='navigation'>
      """
    for section in @sections
      html += """
              <li>
                <a href='##{section.name}' class='#{section.type} nav-link' title='#{section.title}'>
                  <i class="fa #{section.headerIcon}"></i>
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
      </header>
    """
    domEl = $(html)
    for e in @events
      $(domEl).find(e[0]).on e[1], e[2]
    $(@el).append($(domEl))
    $('#header').attr('data-offset-top', $('#header').offset().top)


  smoothScrollTo: (target) ->
    $('html,body').animate({scrollTop: $(target).offset().top}, 1000)  
    return false
