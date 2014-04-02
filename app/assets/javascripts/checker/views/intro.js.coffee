class window.IntroView
  constructor:(@el, @level) ->
    @c = ContentModel

  render: ->
    html = """
      <div class='section' id='intro'>
        <div class='section-wrapper'>
          <h2>#{@c.text('chkr_start_title_level'+@level, 'simple')}<small>#{@c.text('chkr_start_subtitle_level'+@level, 'simple')}</small></h2>
          <div class='description'>
            <p>#{@c.text('chkr_start_desc_level'+@level)}</p>
          </div><br>
          <div class='text-center'>
            <a href='#demographics' class='nav-link'>
              <div class='btn btn-lg btn-primary'>#{@c.text('chkr_start_btn_level'+@level)}</div>
            </a>
          </div>
          <hr>
          <div class='intro-header'></div>
        </div>
      </div>
      """
    $(@el).append($(html))
