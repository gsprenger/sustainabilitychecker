class window.CheckSummaryView
  constructor: ->
    @$el = $("<div id='check-summary'>")

  render: ->
    app = App.get()
    c = app.content
    html = """
      <div id='checksum-panel' class='panel panel-info'>
        <a data-toggle="collapse" href="#checksum-panel-body">
          <div id='checksum-panel-heading' class='panel-heading'>
            <h4 class='panel-title'>#{c.text('check_sum_heading', 'fullspan')}</h4>
          </div>
        </a>
          <div id='checksum-panel-body' class='panel-body collapse'>
      """
    for s in app.sections
      p = s.i18nPrefix
      html += """
          <a href='##{s.name}' class='alert-link nav-link'>#{c.text(p+'_title', 'fullspan')}:</a>
          <ul>
        """
      for ch in s.choices
        html += "<li>"
        switch (ch.type)
          when ('Radio')
            html += "<span class='result'>#{c.text(p+'_'+ch.getValue()+'_t', 'fullspan')}</span>"
          when ('Slider')
            suf = (if ch.sliderType == 'number' then '%' else '')
            html += "#{c.text(p+'_'+ch.getShortName(), 'fullspan')}: <span class='result'>#{ch.getValue()+suf}</span>"
          when ('SliderGroup')
            html += """
                #{c.text(p+'_'+ch.slug, 'fullspan')}:
                <ul>
              """
            suf = (if ch.sliders[0].sliderType == 'number' then '%' else '')
            for slider in ch.sliders
              html += "<li>#{c.text(p+'_'+slider.getShortName(), 'fullspan')}: <span class='result'>#{slider.getValue()+suf}</span></li>"
            html += "</ul>"
        html += "</li>"
      html += """
          </ul>
        """
    html += """
        </div>
      </div>
      """
    @$el.html(html)
    if (App.get().experiment.getCurrent() != 'check')
      @$el.hide()
    @events()
    return this

  events: ->
