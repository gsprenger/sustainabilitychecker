class window.AppView
  constructor:(@el, @level, @content, @sections) ->
    @$el = $(@el)
    @introView = new IntroView(@el, @level, @content, )
    @headerView = new HeaderView('.intro-header', @level, @content, @sections)
    @sectionViews = []
    for s in @sections
      @sectionViews.push(new SectionView(@el, @content, @section))
    @checkView = new CheckView(@el, @content)

  render: ->
    @introView.render()
    @headerView.render()
    for sv in @sectionViews
      sv.render()
    @checkView.render()
