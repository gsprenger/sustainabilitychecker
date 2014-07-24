class window.HeaderNavView
  constructor: ->
    @$el = $("<div data-spy='affix' id='headernav'>")
    $(window).on 'appready', ->
      # HeaderView: set offset to header position for affix to trigger
      $('#headernav').attr('data-offset-top', $('#headernav').offset().top)

  render: ->
    app = App.get()
    l = app.level
    c = app.content
    html = """
        <div id='headernav-cont'>
          <div class='titles'>
            <div class='title levels'>#{c.text('chkr_levels')}</div>
            <div class='title demand'>#{c.text('chkr_demand')}</div>
            <div class='title supply'>#{c.text('chkr_supply')}</div>
            <div class='title check'>#{c.text('chkr_check')}</div>
          </div>
          <hr class='hr-sec'>
          <hr class='hr-lvls'>
          <ul class='ul-levels'>
      """
    for i in [1..3]
      curr = (if (i == app.level) then ' current' else '')
      avlb = (if (i <= app.level) then ' available' else '')
      levelIcon = [null, 'fa-minus', 'fa-bars', 'fa-bars']
      html += """
                <li>
                  <a href='#{if(avlb) then '/level'+i else '#'}' class='nav-link' title='#{c.text('chkr_navtool_lvl'+i, 'none')}' data-toggle='tooltip'>
                    <span class="fa-stack fa-lg">
                      <i class="fa fa-square fa-stack-2x"></i>
                      <i class="fa #{levelIcon[i]} fa-stack-1x colorwhite"></i>
                    </span>
                  </a>
                </li>
        """
    html += """
          </ul>
          <ul class='ul-navigation' role='navigation'>
      """
    for s in app.sections
      com = (app.experiment.isCompleted(s.slug))
      p = s.i18nPrefix
      html += """
              <li>
                <a href='##{s.name}' class='nav-link #{s.type}' title='#{c.text(p+'_title', 'none')}' data-toggle='tooltip'>
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-square fa-stack-2x"></i>
                    <i class="fa #{s.headerIcon} fa-stack-1x colorwhite#{if com then ' fa-inverse' else ''}"></i>
                  </span>
                </a>
              </li>
        """
    com = (l != 1 || app.experiment.getCurrent() == 'check')
    html += """
            <li>
              <a href='#check' class='check nav-link' title='#{c.text('chkr_check_title', 'none')}' data-toggle='tooltip'>
                <span class="fa-stack fa-lg">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fa fa-check fa-stack-1x colorwhite#{if com then ' fa-inverse' else ''}"></i>
                </span>
              </a>
            </li>
          </ul>
        </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
