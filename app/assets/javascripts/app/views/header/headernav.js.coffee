class window.HeaderNavView
  constructor: ->
    @$el = $("<div id='headernav-wrap'>")
    $(window).on 'sectioncomplete', (e, data) =>
      setTimeout =>
        @render()
      , 50

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
          <ul class='navicon-cont ul-levels'>
      """
    for i in [1..3]
      avlb = (i <= app.experiment.getLastLevel())
      html += """
                <li>
                  <#{if avlb then 'a' else 'span'} href='/level#{i}' class='navicon#{if avlb then ' available' else ''}' title='#{c.text('chkr_navtool_lvl'+i, 'none')}' data-toggle='tooltip' data-no-turbolink>
                    <span class="fa-stack fa-lg">
                      #{if !avlb then '<i class="fa fa-square fa-stack-2x whitesquare"></i>' else ''}
                      <i class="fa fa-square#{if !avlb then '-o' else ''} fa-stack-2x"></i>
        """
      for j in [1..i]
        html += "<i class='fa fa-minus fa-stack-1x bar#{j} levelbar icon#{if avlb then ' available' else ''}'></i>"
      html += """
                    </span>
                  </a>
                </li>
        """
    html += """
          </ul>
          <ul class='navicon-cont ul-navigation' role='navigation'>
      """
    for s in app.sections
      avlb = (app.experiment.isCompleted(s.slug) || app.experiment.getCurrent() == s.slug)
      p = s.i18nPrefix
      html += """
              <li>
                <a href='##{s.name}' class='nav-link navicon #{s.type}#{if avlb then ' available' else ''}' title='#{c.text(p+'_title', 'none')}' data-toggle='tooltip'>
                  <span class="fa-stack fa-lg">
                    #{if !avlb then '<i class="fa fa-square fa-stack-2x whitesquare"></i>' else ''}
                    <i class="fa fa-square#{if !avlb then '-o' else ''} fa-stack-2x"></i>
                    <i class="fa #{s.headerIcon} fa-stack-1x icon#{if avlb then ' available' else ''}"></i>
                  </span>
                </a>
              </li>
        """
    avlb = (l != 1 || app.experiment.getCurrent() == 'check')
    html += """
            <li>
              <a href='#check' class='check nav-link navicon #{s.type}#{if avlb then ' available' else ''}' title='#{c.text('chkr_check_title', 'none')}' data-toggle='tooltip'>
                <span class="fa-stack fa-lg">
                  #{if !avlb then '<i class="fa fa-square fa-stack-2x whitesquare"></i>' else ''}
                  <i class="fa fa-square#{if !avlb then '-o' else ''} fa-stack-2x"></i>
                  <i class="fa fa-check fa-stack-1x icon#{if avlb then ' available' else ''}"></i>
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
