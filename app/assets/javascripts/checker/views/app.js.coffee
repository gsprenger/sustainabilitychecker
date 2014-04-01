class window.AppView
  constructor:(@el, @level, @content, @sections) ->
    @$el = $(@el)
    @headerView = new HeaderView(@el, @level, @content, @sections)
    @sectionViews = []
    for s in @sections
      @sectionViews.push(new SectionView(@el, @content, @section))
    @checkView = new CheckView(@el, @content)

  render: ->
    @$el.append(@headerView.render())
    for sv in @sectionViews
      @$el.append(sv.render())
    @$el.append(@checkView.render())
