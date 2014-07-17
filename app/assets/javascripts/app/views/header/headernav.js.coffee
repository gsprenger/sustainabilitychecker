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
            <div class='title levels'>#{c.text('chkr_levels', 'simple')}</div>
            <div class='title demand'>#{c.text('chkr_demand', 'simple')}</div>
            <div class='title supply'>#{c.text('chkr_supply', 'simple')}</div>
            <div class='title check'>#{c.text('chkr_check', 'simple')}</div>
          </div>
          <hr class='hr-sec'>
          <hr class='hr-lvls'>
          <ul class='ul-levels'>
      """
    for i in [1..3]
      curr = (if (i == app.level) then ' current' else '')
      avlb = (if (i <= app.level) then ' available' else '')
      html += """
                <li>
                  <a href='#{if(avlb) then '/level'+i else '#'}' class='nav-link#{curr}#{avlb}#{' level'+i}' title='#{c.text('chkr_navtool_lvl'+i, 'none')}' data-toggle='tooltip'>
                    #{i}
                  </a>
                </li>
        """
    html += """
          </ul>
          <ul class='ul-navigation' role='navigation'>
      """
    for s in app.sections
      com = (if (app.experiment.isCompleted(s.slug)) then ' complete' else '')
      act = (if (app.experiment.getCurrent() == s.slug) then ' active' else '')
      p = s.i18nPrefix
      html += """
              <li>
                <a href='##{s.name}' class='nav-link #{s.type}#{com}#{act}' title='#{c.text(p+'_title', 'none')}' data-toggle='tooltip'>
                  <i class="fa #{s.headerIcon}"></i>
                </a>
              </li>
        """
    act = (if (l != 1 || app.experiment.getCurrent() == 'check') then ' activelevel'+l else '')
    html += """
            <li>
              <a href='#check' class='check nav-link#{act}' title='#{c.text('chkr_check_title', 'none')}' data-toggle='tooltip'>
                <i class="fa fa-check"></i>
              </a>
            </li>
          </ul>
        </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
