class window.RadioView
  constructor:(@section, @choice) ->
    @$el = $("<div class='radio-row'>")

  render: ->
    c = ContentModel
    p = @section.i18nPrefix
    vals = @choice.values
    html = ''
    for i in [0..vals.length-1]
      html += """
        <div class='cell lg-4' data-value='#{vals[i]}'>
          #{c.text('http://dummyimage.com/400x400/d1d9ff/5e5e5e.png&text=placeholder', 'image')}
          <span class='text'>#{c.text(p+'_'+vals[i]+'_t')}</span>
          <small>#{c.text(p+'_'+vals[i]+'_c')}</small>
        </div>
      """
    @$el.append($(html))
    return this
