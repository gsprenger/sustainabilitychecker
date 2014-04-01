class window.IntroView
  constructor:(@el, @level, @content) ->

  render: ->
    html = """
      <div class='section' id='intro'>
        <div class='section-wrapper'>
          <h2>#{@content.text('chkr_start_title_level'+@level, 'simple')}<small>#{@content.text('chkr_start_subtitle_level'+@level, 'simple')}</small></h2>
          <div class='description'>
            <p>#{@content.text('chkr_start_desc_level'+@level)}</p>
          </div><br>
          <div class='text-center'>
            <a href='#demographics' class='nav-link'>
              <div class='btn btn-lg btn-primary'>#{@content.text('chkr_start_btn_level'+@level)}</div>
            </a>
          </div>
        </div>
      </div>
      """
    return $(html)
