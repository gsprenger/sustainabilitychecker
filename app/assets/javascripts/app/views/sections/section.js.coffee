class window.SectionView
  constructor:(@section) ->
    @$el = $("<div class='section in-level#{App.get().level}' id='#{@section.name}' data-slug=#{@section.slug}>")
    @section.view = this
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
    if @section.slug == 'd_hou' || @section.slug == 'd_ser'
      @sliderImageView = new SliderImageView(@section)

  render: ->
    l = App.get().level
    c = App.get().content
    e = App.get().experiment
    p = @section.i18nPrefix
    cssClass = @section.slug.split('_').pop()
    html = """
      <div class='section-wrapper'>
        <h2 class='#{cssClass}'>#{c.text(p+'_yatitle')}<small>#{c.text(p+'_subtitle')}</small></h2>
        <div class='description'>
          #{c.text(p+'_desc')}
        </div>
      """
    if @section.slug == 'd_hou' || @section.slug == 'd_ser'
      html += """
          <div class='row-fluid row-equalheight'>
            <div class='col-md-7 col-equalheight'>
              <div class='choice' id='choice-#{@section.slug}'></div>
            </div>
            <div class='col-md-5 col-equalheight'>
              <div class='sliders-image-cont'></div>
            </div>
          </div>
          <div class='clearfix'></div>
        """
    else
      html += """
          <div class='choice' id='choice-#{@section.slug}'></div>
        """
    html += """
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
    # Append Slider image view
    if @section.slug == 'd_hou' || @section.slug == 'd_ser'
      @$el.find('.sliders-image-cont').append(@sliderImageView.render().$el)
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
      for c in @section.choices
        # This will ensure the field is set in experiment, using default if no choice has been made
        c.setValue(c.getValue())
      $(window).trigger('sectioncomplete', @section.name)

    # Update [grains_equiv] and [s_ene_con] fields
    if !App.get().isMercury && (@section.slug == 's_ene' || @section.slug == 's_agr')
      varID = (if @section.slug == 's_agr' then 'grains_equiv' else 's_ene_con')
      @$el.find('.description:contains("'+varID+'")').html (_, html) -> 
        regexp = new RegExp("\\[("+varID+")\\]")
        html.replace(regexp, '<span class="realtimeval">$1</span>')
      updateField = =>
        if @section.slug == 's_agr'
          @$el.find('.realtimeval').text(+(+App.get().sudoku.diet.get_grains_equiv()).toPrecision(2))
        else
          @$el.find('.realtimeval').text(+(+App.get().sudoku.energy.get_s_ene_con()).toPrecision(2))
      $(window).on 'choicecomplete', =>
        updateField()
      updateField()

  getTypology: ->
    switch @section.slug
      when "d_dem", "d_die", "s_lan", "s_bm", "s_agr"
        # Radio 1 topo
        @choiceViews[0].radio.getValue()
      when "d_ser"
        # Slider 1 topo
        @sliderImageView.getSGContextSlug()
      when "d_hou"
        # Slider group 1 topo
        @sliderImageView.getHHContextSlug()
      when "s_ene"
        # Slider group 2 topo
        [
          @choiceViews[0].sliderImageView.getElecContextSlug()
          @choiceViews[1].sliderImageView.getFuelsContextSlug()
        ]

