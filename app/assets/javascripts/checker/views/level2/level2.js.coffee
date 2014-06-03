class window.Level2View
  constructor:(@section) ->
    @$el = $("<div id='level2-#{@section.name}-main' class='section-lvl2'>")

  render: ->
    c = App.get().content
    l = App.get().level
    p = @section.i18nPrefix
    html = """
      <div>
      <h4>#{c.text(p+'_title_lvl2')}</h4>
        #{c.text(p+'_visible_lvl2', 'simple')}<span class='lvl2-morelink#{if l == 2 then ' hidden' else ''}'>...Read more</span><span class='lvl2-more#{if l == 3 then ' hidden' else ''}'>#{c.text(p+'_more_lvl2', 'simple')}<span class='lvl2-lesslink'><br>Collapse</span></span>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.lvl2-morelink').on 'click', =>
      @$el.find('.lvl2-more').removeClass('hidden')
      @$el.find('.lvl2-morelink').addClass('hidden')
    @$el.find('.lvl2-lesslink').on 'click', =>
      @$el.find('.lvl2-morelink').removeClass('hidden')
      @$el.find('.lvl2-more').addClass('hidden')
