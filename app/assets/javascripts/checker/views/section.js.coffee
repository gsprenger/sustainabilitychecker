class window.SectionView
  constructor:(@el, @content, @section) ->

  render: ->
    p = @section.i18nPrefix
    html = """
      <div class='section' id='#{@section.name}'>
        <div class='section-wrapper'>
          <h2>#{@content.text(p+'_title', 'simple')}<small>#{@content.text(p+'_subtitle', 'simple')}</small></h2>
          <div class='description'>
            #{@content.text(p+'_desc')}
          </div>
          <div>
            TODO Choice 
          </div>
        </div>
      </div>
      """
    $(@el).append($(html))
