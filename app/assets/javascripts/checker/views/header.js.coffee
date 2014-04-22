class window.HeaderView
  constructor: ->
    @$el = $("<header role='banner' data-spy='affix' id='header'>")

  render: ->
    app = App.get()
    c = app.content
    html = """
      <nav>
        <div class='header-home'>
          <a href='/'>Home</a>
        </div>
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
      curr = (if (i == App.get().level) then ' current' else '')
      avlb = (if (i <= App.get().level) then ' available' else '')
      html += """
              <li>
                <a href='#{if(avlb) then '/level'+i else '#'}' class='nav-link#{curr}#{avlb}#{' level'+i}' title='#{c.text('chkr_navtool_lvl'+i, 'none')}'>
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
              <a href='##{s.name}' class='nav-link #{s.type}#{com}#{act}' title='#{c.text(p+'_title', 'none')}'>
                <i class="fa #{s.headerIcon}"></i>
              </a>
            </li>
        """
    act = (if (app.experiment.getCurrent() == 'check') then ' active' else '')
    html += """
          <li>
            <a href='#check' class='check nav-link#{act}' title='Check'>
              <i class="fa fa-check"></i>
            </a>
          </li>
        </ul>
        <div class='header-contact'>
          <a href='/#contact'>Contact Us</a>
        </div>
      </nav>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    $(window).on 'appready', ->
      # HeaderView: set offset to header position for affix to trigger
      $('#header').attr('data-offset-top', $('#header').offset().top)
    $(window).on 'sectioncomplete', (e, data) ->
      # mark header item as completed
      $('[href=#'+data+']').addClass('complete')
      nextSec = $('#'+data).nextAll('.section').first()
      if (nextSec.length)
        secID = nextSec.attr('id')
        nextSec.show()
        if ($('#'+secID+'-lvl2').length)
          $('#'+secID+'-lvl2').show()
        App.get().experiment.setCurrent(nextSec.data('slug'))
        $('[href=#'+secID+']').addClass('active')
        $('body').animate({scrollTop: nextSec.offset().top}, 500)
      else
        $('[href=#check]').addClass('active')
        $('#check').show()
        $('body').animate({scrollTop: $('#check').offset().top}, 500)
      
