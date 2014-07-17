class window.ShareModal
  constructor: ->
    @$el = $('<div class="modal fade" id="modal-share" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">')
    @cachedLoadCode = ''
    $(window).on 'choicecomplete', =>
      @$el.find('#saveinput').val(@getSharePermalink())

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
              <input type='text' id='saveinput' value='#{@getSharePermalink()}'>
              <p class='savetext'>#{c.text('modal_share_savetext')}</p>
            </div>
            <div class='share-social'>
              <h1>#{c.text('modal_share_socialtitle', 'simple')}</h1>
              <h2>#{c.text('modal_share_thisexperience', 'simple')}</h2>
              <p class='savetext'>#{c.text('modal_share_sthisexp_text')}</p>
              <ul>
                <li><div class="fb-share-button" data-href="#{@getSharePermalink()}" data-type="button"></div></li>
                <li><a href="https://twitter.com/share" class="twitter-share-button" data-url="#{@getSharePermalink()}" data-hashtags="thesustainabilitysudoku" data-dnt="true" data-count="none">Tweet</a></li>
                <li><div class="g-plusone" data-action="share" data-size="medium" data-annotation="none" data-href="#{@getSharePermalink()}"></div></li>
                <li>or via Email</li>
              </ul>
              <div class='clearfix'></div>
              <h2>#{c.text('modal_share_thewebsite', 'simple')}</h2>
              <p class='savetext'>#{c.text('modal_share_web_text')}</p>
              <ul>
                <li><div class="fb-share-button" data-href="#{window.location.origin}" data-type="button_count"></div></li>
                <li><a href="https://twitter.com/share" class="twitter-share-button" data-url="#{window.location.origin}" data-hashtags="thesustainabilitysudoku" data-dnt="true">Tweet</a></li>
                <li><div class="g-plusone" data-action="share" data-size="medium" data-href="#{window.location.origin}"></div></li>
                <li>or via Email</li>
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

  getSharePermalink: ->
    if (@cachedLoadCode != App.get().experiment.getLoadCode())
      @cachedLoadCode = App.get().experiment.getLoadCode()
      res = $.ajax({
          type: "GET",
          url: "/shortener/shorten",
          async: false
          data: {url: window.location.origin+"/load/"+@cachedLoadCode}
      }).responseText;
      @permalink = JSON.parse(res).shrturl
    return @permalink
    
