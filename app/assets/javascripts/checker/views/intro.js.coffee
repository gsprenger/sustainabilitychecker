class window.IntroView
  constructor: ->
    @$el = $("<div class='section' id='intro'>")
    @header = new HeaderView()

  render: ->
    l = App.get().level
    c = App.get().content
    html = """
      <div class='section-wrapper'>
        <h2>#{c.text('chkr_start_title_level'+l)}<small>#{c.text('chkr_start_subtitle_level'+l)}</small></h2>
        <div class='description'>
          <p>#{c.text('chkr_start_desc_level'+l)}</p>
        </div><br>
        <div class='text-center'>
          <a href='#demographics' class='nav-link'>
            <div class='btn btn-lg btn-primary'>#{c.text('chkr_start_btn_level'+l)}</div>
          </a>
        </div>
        <br><br>
        <div id='intro-header'></div>
      </div>
      """
    @$el.html(html)
    @$el.find('#intro-header').append(@header.render().$el)
    return this
