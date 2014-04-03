class window.SectionView
  constructor:(@section) ->
    @$el = $("<div class='section' id='#{@section.name}'>")
    @choiceViews = []
    for c in @section.choices
      switch (c.type)
        when ('Radio')
          @choiceViews.push(new RadioView(@section, c))
        when ('Slider')
          @choiceViews.push(new SliderView(@section, c))
        when ('SliderGroup')
          @choiceViews.push(new SliderGroupView(@section, c))
        else
          console.error('Unknown ChoiceView type: '+c.type)

  render: ->
    c = App.get().content
    p = @section.i18nPrefix
    html = """
      <div class='section-wrapper'>
        <h2>#{c.text(p+'_title', 'simple')}<small>#{c.text(p+'_subtitle', 'simple')}</small></h2>
        <div class='description'>
          #{c.text(p+'_desc')}
        </div>
        <div class='choice' id='choice-#{@section.slug}'>
        </div>
      </div>
      """
    @$el.html(html)
    for cv in @choiceViews
      @$el.find("#choice-#{@section.slug}").append(cv.render().$el)
    return this
