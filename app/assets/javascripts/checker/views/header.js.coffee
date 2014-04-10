class window.HeaderView
  constructor: ->
    @$el = $("<header role='banner' data-spy='affix' id='header'>")

  render: ->
    app = App.get()
    c = app.content
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
      
