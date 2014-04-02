class window.HeaderView
  constructor:(@level, @sections) ->
    @$el = $("<header role='banner' data-spy='affix' id='header'>")
    $(window).on 'allcontentinserted', ->
      # HeaderView: set offset to header position for affix to trigger
      $('#header').attr('data-offset-top', $('#header').offset().top)

  render: ->
    c = ContentModel
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
      html += """
            <li>
              <a href='##{s.name}' class='#{s.type} nav-link' title='#{s.title}'>
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
    @$el.append($(html))
    return this
