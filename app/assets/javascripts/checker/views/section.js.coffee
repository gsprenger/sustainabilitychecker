class window.SectionView
  constructor:(@el, @section) ->
    @c = ContentModel

  render: ->
    p = @section.i18nPrefix
    html = """
      <div class='section' id='#{@section.name}'>
        <div class='section-wrapper'>
          <h2>#{@c.text(p+'_title', 'simple')}<small>#{@c.text(p+'_subtitle', 'simple')}</small></h2>
          <div class='description'>
            #{@c.text(p+'_desc')}
          </div>
          <div>
            TODO Choice 
          </div>
        </div>
      </div>
      """
    $(@el).append($(html))
