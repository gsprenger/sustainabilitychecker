class window.SectionView
  constructor:(@section) ->
    @$el = $("<div class='section in-level#{App.get().level}' id='#{@section.name}' data-slug=#{@section.slug}>")
    @choiceViews = []
    for c in @section.choices
      switch (c.type)
        when ('Radio')
          @sectionType = 'Radio'
          @choiceViews.push(new RadioView(@section, c))
        when ('Slider')
          @sectionType = 'Slider'
          @choiceViews.push(new SliderView(@section, c))
        when ('SliderGroup')
          @sectionType = 'SliderGroup'
          @choiceViews.push(new SliderGroupView(@section, c))
        else
          console.error('Unknown ChoiceView type: '+c.type)
    if App.get().level >= 2
      @sectionInfoView = new SectionInfoView(@section)

  render: ->
    l = App.get().level
    c = App.get().content
    e = App.get().experiment
    p = @section.i18nPrefix
    html = """
      <div class='section-wrapper'>
        <h2>#{c.text(p+'_title', 'simple')}<br><small>#{c.text(p+'_subtitle', 'simple')}</small></h2>
        <div class='description'>
          #{c.text(p+'_desc')}
        </div>
        <div class='choice' id='choice-#{@section.slug}'>
        </div>
        <div id='level2-#{@section.slug}' class='sectioninfo-cont'>
        </div>
      """
    if @section.slug != 's_ene'
      html += """
          <div class='btn-row#{if l == 1 then ' needs-padding' else ''}'>
            <div class='btn btn-lg btn-primary nextbtn'>#{c.text('chkr_next')}</div>
          </div>
        </div>
        """
    else
      html += """
          <div id='ene-resulttext'>
            #{c.text('chkr_ene_resulttext')}
          </div>
          <div class='btn-row#{if l == 1 then ' needs-padding' else ''}'>
            <div class='btn btn-lg btn-primary nextbtn'>#{c.text('chkr_result')}</div>
          </div>
        </div>
        """
    @$el.html(html)
    # Append choices
    for cv in @choiceViews
      @$el.find("#choice-#{@section.slug}").append(cv.render().$el)
    # Append level 2 section
    if l >= 2
      @$el.find("#level2-#{@section.slug}").append(@sectionInfoView.render().$el)
    # Hide if not in current progression
    unless (e.isCompleted(@section.slug) || @section.slug == e.getCurrent() || l == 3)
      @$el.hide()
    @events()
    return this

  events: ->
    @$el.find('.nextbtn').on 'click', =>
      $(window).trigger('sectioncomplete', @section.name)
