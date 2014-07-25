class window.HelpNewModal
  constructor: ->
    @$el = $('<div class="modal fade modal-help" id="modal-helpnew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">')
    @helpSection = new HelpSectionView("helpnew_")

  render: ->
    c = App.get().content
    html = """
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">#{c.text('modal_helpnew_title')}</h4>
          </div>
          <div class="modal-body">
            #{c.text('modal_helpnew_paragraph')}
            <hr>
            <div class='helpsection'></div>            
          </div>
          <div class="modal-footer">
            #{c.text('modal_helpnew_close_text', 'fullspan')}&nbsp;
            <button type="button" class="btn btn-primary" data-dismiss="modal">#{c.text('modal_help_closeandplaybtn')}</button>
          </div>
        </div>
      </div>
      """
    @$el.html(html)
    @$el.find('.helpsection').append(@helpSection.render().$el)
    @events()
    return this

  events: ->
