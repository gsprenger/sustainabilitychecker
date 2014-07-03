class window.ShareModal
  constructor: ->
    @$el = $('<div class="modal fade" id="modal-share" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">')

  render: ->
    c = App.get().content
    html = """
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">#{c.text('modal_share_title', 'simple')}</h4>
          </div>
          <div class="modal-body">
            <div class='share-save'>
              <h1>#{c.text('modal_share_savetitle', 'simple')}</h1>
              <input type='text' id='saveinput' value='http://www.sustainabilitysudoku.info/'>
              <p class='savetext'>#{c.text('modal_share_savetext')}</p>
            </div>
            <div class='share-social'>
              <h1>#{c.text('modal_share_socialtitle', 'simple')}</h1>
              <p class='savetext'>#{c.text('modal_share_socialtitle')}</p>
              <ul>
                <li>Facebook</li>
                <li>Twitter</li>
                <li>Google+</li>
                <li>via Email</li>
              </ul>
              <div class='clearfix'></div>
            </div>
          </div>
        </div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('#saveinput').on 'click', (e) ->
      this.focus()
      this.select()
