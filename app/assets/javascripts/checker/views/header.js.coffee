class window.HeaderView
  constructor:(@el, @sections) ->

  render: ->
    #build things append to el return el

    html = """
      <header role='banner'>
        <nav>
          <div class='titles'>
            <div class='title demand'>#{ContentModel.text('chkr_demand', 'simple')}</div>
            <div class='title supply'>#{ContentModel.text('chkr_supply', 'simple')}</div>
            <div class='title check'>#{ContentModel.text('chkr_check', 'simple')}</div>
          </div>
          <hr>
          <ul role='navigation'>
      """
    for section in sections
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
    return html
