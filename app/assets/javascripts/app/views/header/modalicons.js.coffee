class window.ModalIconsView
  constructor: ->
    @$el = $("<div id='modalicons' data-spy='affix' data-offset-top='130'>")

  render: ->
    app = App.get()
    l = app.level
    c = app.content
    html = """
        <div class='modalicon' id='modaliconshare' title='Share' data-toggle='tooltip'>
          <i class='fa fa-share-alt'></i>
        </div>
        <div class='modalicon' id='modaliconhelp' title='Help!' data-toggle='tooltip'>
          <i class='fa fa-question'></i>
        </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('#modaliconshare').on 'click', =>
      $('#modal-share').modal()
    @$el.find('#modaliconhelp').on 'click', =>
      $('#modal-help').modal()
