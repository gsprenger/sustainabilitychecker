class window.HelpPermalinkModal
  constructor: ->
    @$el = $('<div class="modal fade modal-help" id="modal-helppermalink" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">')
    @helpSection = new HelpSectionView()

  render: ->
    c = App.get().content
    html = """
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">#{c.text('modal_helppermalink_title')}</h4>
          </div>
          <div class="modal-body">
            #{c.text('modal_helppermalink_paragraph')}
            <hr>
            <div class='helpsection'></div>  
            <hr>     
            #{c.text('modal_helppermalink_paragraph2')}
          </div>
          <div class="modal-footer">
            #{c.text('modal_helpperma_close_text_permalink', 'fullspan')}&nbsp;
            <button type="button" class="btn btn-default btntryagain">#{c.text('modal_help_permalinkreset')}</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="button" class="btn btn-primary" data-dismiss="modal">#{c.text('modal_help_okloadsettings')}</button>
          </div>
        </div>
      </div>
      """
    @$el.html(html)
    @$el.find('.helpsection').append(@helpSection.render().$el)
    @events()
    return this

  events: ->
    @$el.find('.btntryagain').on 'click', ->
      localStorage.clear()
      window.location.href = '/level1'

