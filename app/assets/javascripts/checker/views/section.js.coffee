class window.SectionView
  constructor:(@section) ->
    @$el = $("<div class='section in-level#{App.get().level}' id='#{@section.name}' data-slug=#{@section.slug}>")
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
    if App.get().level >= 2
      @level2View = new Level2View(@section)

  render: ->
    l = App.get().level
    c = App.get().content
    e = App.get().experiment
    p = @section.i18nPrefix
    html = """
      <div class='section-wrapper'>
        <h2>#{c.text(p+'_title', 'simple')}<small>#{c.text(p+'_subtitle', 'simple')}</small></h2>
        <div class='description'>
          #{c.text(p+'_desc')}
        </div>
        <div class='choice' id='choice-#{@section.slug}'>
        </div>
        <div id='level2-#{@section.slug}'>
        </div>
        <div class='btn-row'>
          <div class='btn btn-lg btn-primary nextbtn'>#{c.text('chkr_next')}</div>
        </div>
      </div>
      """
    @$el.html(html)
    # Append choices
    for cv in @choiceViews
      @$el.find("#choice-#{@section.slug}").append(cv.render().$el)
    # Append level 2 section
    if l >= 2
      @$el.find("#level2-#{@section.slug}").append(@level2View.render().$el)
    # Hide if not in current progression
    unless (e.isCompleted(@section.slug) || @section.slug == e.getCurrent())
      @$el.hide()
    @events()
    return this

  events: ->
    @$el.find('.nextbtn').on 'click', =>
      $(window).trigger('sectioncomplete', @section.name)
