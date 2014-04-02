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
    @postRender()
    @events()

  events: ->
    $(@el).find('.nav-link').on 'click', (e) ->
      $('html,body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false

  postRender: ->
    # HeaderView: set offset to header position for affix to trigger
    $(@el).find('#header').attr('data-offset-top', $('#header').offset().top)
