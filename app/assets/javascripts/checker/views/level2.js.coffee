class window.Level2View
  constructor:(@section) ->
    @$el = $("<div class='section-lvl2' id='#{@section.name}-lvl2'>")

  render: ->
    c = App.get().content
    e = App.get().experiment
    p = @section.i18nPrefix
    html = """
      <div id='#{@section.name}-lvl2' class='section-lvl2'>
        <p>#{c.text(p+'_lvl2')}</p>
      </div>
      """
    @$el.html(html)
    unless (e.isCompleted(@section.slug) || @section.slug == e.getCurrent())
      @$el.hide()
    return this
