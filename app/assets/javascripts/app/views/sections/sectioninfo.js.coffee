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
        #{c.text(p+'_visible_sectioninfo')}
        <a href='##{p}_collapsiblezone' data-toggle='collapse'>#{if l == 2 then 'Hide details' else 'More details'}</a>
        <div id="#{p}_collapsiblezone" class="collapse fade#{if l == 2 then ' in' else ''}">
          #{c.text(p+'_more_sectioninfo')}
        </div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    p = @section.i18nPrefix_collapsiblezone
    @$el.find('a').on "click", (e) ->
      if $(this).text() == 'More details'
        $(this).text('Hide details')
      else
        $(this).text('More details')


