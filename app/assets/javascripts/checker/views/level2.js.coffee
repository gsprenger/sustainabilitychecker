class window.Level2View
  constructor:(@section) ->
    @$el = $("<div id='#{@section.name}-lvl2' class='section-lvl2'>")

  render: ->
    c = App.get().content
    e = App.get().experiment
    p = @section.i18nPrefix
    html = """
      <p>#{c.text(p+'_lvl2')}</p>
      """
    @$el.html(html)
    unless (e.isCompleted(@section.slug) || @section.slug == e.getCurrent())
      @$el.hide()
    return this
