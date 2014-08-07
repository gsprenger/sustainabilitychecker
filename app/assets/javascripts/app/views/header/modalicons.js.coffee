class window.ModalIconsView
  constructor: ->
    @$el = $("<div id='modalicons' data-spy='affix' data-offset-top='130'>")

  render: ->
    app = App.get()
    l = app.level
    c = app.content
    html = """
        <span class="modalicon fa-stack fa-lg" id='modaliconshare' title='#{c.text('chkr_modal_share_t', 'none')}' data-toggle='tooltip'>
          <i class="fa fa-circle-o fa-stack-2x"></i>
          <i class="fa fa-share-alt fa-stack-1x"></i>
        </span>
        <span class="modalicon fa-stack fa-lg" id='modaliconhelp' title='#{c.text('chkr_modal_help_t', 'none')}' data-toggle='tooltip'>
          <i class="fa fa-circle-o fa-stack-2x"></i>
          <i class="fa fa-question fa-stack-1x"></i>
        </span>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('#modaliconshare').on 'click', =>
      $('#modal-share').modal()
    @$el.find('#modaliconhelp').on 'click', =>
      $('#modal-help').modal()
