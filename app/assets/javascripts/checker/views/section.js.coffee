class window.SectionView
  constructor:(@section) ->
    @$el = $("<div class='section' id='#{@section.name}'>")
    @choiceViews = []
    for c in @section.choices
      switch (c.type)
        when ('RadioModel')
          @choiceViews.push(new RadioView(@section, c))
        when ('SliderModel')
          @choiceViews.push(new SliderView(@section, c))
        when ('SliderGroupModel')
          @choiceViews.push(new SliderGroupView(@section, c))
        else
          console.error('Unknown ChoiceView type: '+c.type)

  render: ->
    c = ContentModel
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
    @$el.append($(html))
    console.log("rendering #{@section.slug} with choice:")
    console.log(@choiceViews)
    for cv in @choiceViews
      # console.log("Appending #{cv.choice.slug} to #choice-#{@section.slug}")
      @$el.find("#choice-#{@section.slug}").append(cv.render().$el)
    return this
