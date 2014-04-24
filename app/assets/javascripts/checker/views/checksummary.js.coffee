class window.CheckSummaryView
  constructor: ->
    @$el = $("<div id='checksummary'>")

  render: ->
    app = App.get()
    c = app.content
    html = """
      <h3>#{c.text('chkr_summ_title')}</h3>
      <div class="alert alert-info">
      """
    for s in app.sections
      p = s.i18nPrefix
      html += """
          <a href='##{s.name}' class='alert-link nav-link'>#{c.text(p+'_title', 'simple')}:</a>
          <ul>
        """
      for ch in s.choices
        html += "<li>"
        switch (ch.type)
          when ('Radio')
            html += "#{c.text(p+'_subtitle', 'simple')}: #{c.text(p+'_'+ch.getValue()+'_t', 'simple')}"
          when ('Slider')
            suf = (if ch.sliderType == 'number' then '%' else '')
            html += "#{c.text(p+'_'+ch.getShortName(), 'simple')}: #{ch.getValue()+suf}"
          when ('SliderGroup')
            html += """
                #{c.text(p+'_'+ch.slug, 'simple')}:
                <ul>
              """
            suf = (if ch.sliders[0].sliderType == 'number' then '%' else '')
            for slider in ch.sliders
              html += "<li>#{c.text(p+'_'+slider.getShortName(), 'simple')}: #{slider.getValue()+suf}</li>"
            html += "</ul>"
        html += "</li>"
      html += """
          </ul>
        """
    html += """
      </div>
      <div class='btn-row'>
        <div class='btn-showresult btn btn-lg btn-primary'>#{c.text('chkr_summ_btn')}</div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.btn-showresult').on 'click', ->
      $(window).trigger('clickshowresult')
