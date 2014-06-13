class window.TryAgainModal
  constructor: ->
    @$el = $('<div class="modal fade" id="modal-tryagain" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">')

  render: ->
    c = App.get().content
    html = """
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">#{c.text('modal_tryagain_title', 'simple')}</h4>
          </div>
          <div class="modal-body">
            #{c.text('modal_tryagain_body')}
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">#{c.text('modal_tryagain_btnclose', 'simple')}</button>
            <button type="button" id='modal-btntryagain' class="btn btn-primary">#{c.text('modal_tryagain_btnconfirm', 'simple')}</button>
          </div>
        </div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('#modal-btntryagain').on 'click', ->
      localStorage.clear()
      window.location.href = '/level1'
