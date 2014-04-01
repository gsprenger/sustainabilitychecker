class window.AppView
  constructor:(@el, @level, @content, @sections) ->
    @$el = $(@el)
    @headerView = new HeaderView(@el, @level, @content, @sections)
    @introView = new IntroView(@el, @level, @content)
    @sectionViews = []
    for s in @sections
      @sectionViews.push(new SectionView(@el, @content, @section))
    @checkView = new CheckView(@el, @content)

  render: ->
    @$el.append(@headerView.render())
    @$el.append(@introView.render())
    for sv in @sectionViews
      @$el.append(sv.render())
    @$el.append(@checkView.render())
