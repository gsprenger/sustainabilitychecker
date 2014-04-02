class window.AppView
  constructor:(@el, @level, @sections) ->
    @introView = new IntroView(@el, @level)
    @headerView = new HeaderView('.intro-header', @level, @sections)
    @sectionViews = []
    for s in @sections
      @sectionViews.push(new SectionView(@el, s))
    @checkView = new CheckView(@el, @sections)

  render: ->
    @introView.render()
    @headerView.render()
    for sv in @sectionViews
      sv.render()
    @checkView.render()
    @postRenderOps()

  postRenderOps: ->
    # HeaderView: set offset to header position for affix to trigger
    $('#header').attr('', $('#header').offset().top)
