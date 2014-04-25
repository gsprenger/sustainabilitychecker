class window.RadioView
  constructor:(@section, @radio) ->
    @$el = $("<div class='radio-row'>")

  render: ->
    c = App.get().content
    p = @section.i18nPrefix
    vals = @radio.values
    html = ''
    for i in [0..vals.length-1]
      active = if @radio.getValue() == vals[i] then ' active' else ''
      html += """
        <div class='cell lg-4#{active}' data-value='#{vals[i]}'>
          #{c.text('http://dummyimage.com/400x400/d1d9ff/5e5e5e.png&text=placeholder', 'image')}
          <span class='text'>#{c.text(p+'_'+vals[i]+'_t')}</span>
          <small>#{c.text(p+'_'+vals[i]+'_c')}</small>
        </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.cell').on 'click', (e) =>
      $(window).one 'choicecomplete', =>
        @$el.find('.cell').removeClass('active')
        $(e.currentTarget).addClass('active')
      @radio.setValue($(e.currentTarget).attr('data-value'))
