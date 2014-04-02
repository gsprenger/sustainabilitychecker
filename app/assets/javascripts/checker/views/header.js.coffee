class window.HeaderView
  constructor:(@el, @level, @sections) ->
    @c = ContentModel

  render: ->
    html = """
      <header role='banner' data-spy='affix' id='header'>
        <nav>
          <div class='titles'>
            <div class='title demand'>#{@c.text('chkr_demand', 'simple')}</div>
            <div class='title supply'>#{@c.text('chkr_supply', 'simple')}</div>
            <div class='title check'>#{@c.text('chkr_check', 'simple')}</div>
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
    $(@el).append($(html))
