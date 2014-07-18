class window.RadioView
  constructor:(@section, @radio) ->
    @$el = $("<div class='radio-row'>")

  render: ->
    c = App.get().content
    p = @section.i18nPrefix
    vals = @radio.values
    html = ''
    for i in [0..vals.length-1]
      active = if @radio.isValueSet() && @radio.getValue() == vals[i] then ' active' else ''
      html += """
        <div class='cell lg-4#{active}' data-value='#{vals[i]}'>
        """
      if !App.get().isMercury
        html += """
            <img src='#{c.text(p+'_'+vals[i]+'_img', 'none')}'>
          """
      else 
        html += """
          Image URL (Editor only): #{c.text(p+'_'+vals[i]+'_img')}
        """
      html += """
          <div class='text'>#{c.text(p+'_'+vals[i]+'_t')}</div>
          <div><small>#{c.text(p+'_'+vals[i]+'_c')}</small></div>
        </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.cell').on 'click', (e) =>
      @radio.setValue($(e.currentTarget).attr('data-value'))      
      @$el.find('.cell').removeClass('active')
      $(e.currentTarget).addClass('active')
      $(window).trigger('choicecomplete')
