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
    data = @getSummaryData()
    for s in app.sections
      p = s.i18nPrefix
      # Title
      html += """
          <div class='sum-section'>
            <a href='##{s.name}' class='alert-link nav-link'>#{c.text(p+'_title', 'fullspan')}:</a><br>
        """
      if (s.slug != "s_ene")
        html += """
            <div class='sum-topo'>
              Topology: <span class='topology'>#{c.text(data[s.slug].topo, 'none')}</span>
              <span class='country'>#{c.text(data[s.slug].country, 'none')}</span><br>
          """
        # Values
        switch s.slug
          when "d_dem", "d_die", "s_lan", "s_bm", "s_agr"
            html += "Value: <span class='result'>#{s.choices[0].getValue()}</span>"
          when "d_ser"
            html += "Values: <ul>"
            for sl in s.choices
              html += "<li>#{c.text(p+'_'+sl.getShortName(), 'none')}: <span class='result'>#{sl.getValue()}</span></li>"
          when "d_hou"
            html += "Values: <ul>"
            for slg in s.choices
              for sl in slg.sliders
                html += "<li>#{c.text(p+'_'+sl.getShortName(), 'none')}: <span class='result'>#{sl.getValue()}%</span></li>"

      else
        sgSlug = ["ele", "fue"]
        sgName = ["Electricity", "Fuels"]
        for i in [0, 1]
          html += """
              #{sgName[i]}<br>
              <div class='sum-topo'>
                Topology: <span class='topology'>#{c.text(data[s.slug+sgSlug[i]].topo, 'none')}</span>
                <span class='country'>#{c.text(data[s.slug+sgSlug[i]].country, 'none')}</span><br>
                Values:
            """
          for sl in s.choices[i].sliders
            html += "<li>#{c.text(p+'_'+sl.getShortName(), 'none')}: <span class='result'>#{sl.getValue()}%</span></li>"
          html += "</div>"
      html += "</div></div>"
    html += """
        </div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->

  getSummaryData: ->
    data = {}
    for s in App.get().sections
      p = s.i18nPrefix
      topo = s.view.getTopology()
      switch s.slug
        when "d_dem", "d_die", "s_lan", "s_bm", "s_agr"
          data[s.slug] = {}
          data[s.slug].topo = "#{p}_#{topo}_t"
          data[s.slug].country = "#{p}_#{topo}_c"
        when "d_hou", "d_ser"
          data[s.slug] = {}
          data[s.slug].topo = "sligm_#{p}_#{topo}_desc"
          data[s.slug].country = "sligm_#{p}_#{topo}_descsub"
        when "s_ene"
          data[s.slug+"ele"] = {}
          data[s.slug+"fue"] = {}
          data[s.slug+"ele"].topo = "sligm_#{p}ele_#{topo[0]}_desc"
          data[s.slug+"ele"].country = "sligm_#{p}ele_#{topo[0]}_descsub"
          data[s.slug+"fue"].topo = "sligm_#{p}fue_#{topo[1]}_desc"
          data[s.slug+"fue"].country = "sligm_#{p}fue_#{topo[1]}_descsub"
    return data

