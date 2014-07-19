class window.SectionInfoView
  constructor:(@section) ->
    @$el = $("<div id='sectioninfo-#{@section.name}-main' class='sectioninfo'>")

  render: ->
    c = App.get().content
    l = App.get().level
    p = @section.i18nPrefix
    html = """
      <div>
      <h4>#{c.text(p+'_title_sectioninfo')}</h4>
        #{c.text(p+'_visible_sectioninfo')}<span class='sectioninfo-morelink#{if l == 2 then ' hidden' else ''}'>...Read more</span><span class='sectioninfo-more#{if l == 3 then ' hidden' else ''}'>#{c.text(p+'_more_sectioninfo')}<span class='sectioninfo-lesslink'><br>Collapse</span></span>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.sectioninfo-morelink').on 'click', =>
      @$el.find('.sectioninfo-more').removeClass('hidden')
      @$el.find('.sectioninfo-morelink').addClass('hidden')
    @$el.find('.sectioninfo-lesslink').on 'click', =>
      @$el.find('.sectioninfo-morelink').removeClass('hidden')
      @$el.find('.sectioninfo-more').addClass('hidden')
