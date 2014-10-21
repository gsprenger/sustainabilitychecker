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
            <h1 class="modal-title">#{c.text('modal_share_titlwee')}</h1>
          </div>
          <div class="modal-body">
            <div class='share-save'>
              <h1>#{c.text('modal_share_savetitle')}</h1>
              <input type='text' id='saveinput' value='#{@getSharePermalink()}'>
              <p class='savetext'>#{c.text('modal_share_savetext')}</p>
            </div>
            <div class='share-social'>
              <h1>#{c.text('modal_share_socialtitle')}</h1>
              <h2>#{c.text('modal_share_thisexperience')}</h2>
              <p class='savetext'>#{c.text('modal_share_sthisexp_text')}</p>
              <div class='row'>
                <div class='col-xs-3 nopadr'>
                  <a class="facebook" target="_blank" onclick="return !window.open(this.href, 'Facebook', 'width=640,height=300')" href="http://www.facebook.com/sharer/sharer.php?u=#{@getSharePermalink()}" title="Share this experiment on Facebook">
                    <div class='social facebook'>
                      <i class="fa fa-facebook"></i> Facebook
                    </div>
                  </a>                    
                </div>
                <div class='col-xs-3 nopadr nopadl'>
                  <a target='_blank' href="https://twitter.com/share?url=#{encodeURIComponent(@getSharePermalink())}&hashtags=thesustainabilitysudoku,sustainability,MuSIASEM,dataviz&text=I tried to run a society w/o fossil energy. Impossible!" title="Share this experiment on Twitter">
                    <div class='social twitter'>
                      <i class="fa fa-twitter"></i> Twitter
                    </div>
                  </a>                    
                </div>
                <div class='col-xs-3 nopadr nopadl'>
                  <a target='_blank' href="https://plus.google.com/share?url=#{@getSharePermalink()}" title="Share this experiment on Google+">
                    <div class='social google'>
                      <i class="fa fa-google-plus"></i> Google+
                    </div>
                  </a>                    
                </div>
                <div class='col-xs-3 nopadl'>
                  <a title="Share this experiment via email" href="mailto:?&subject=The%20Sustainability%20Sudoku&body=Just%20played%20the%20Sustainability%20Sudoku!%20Check%20out%20how%20sustainable%20I%20am%3A%20#{encodeURIComponent(@getSharePermalink())}">
                    <div class='social email'>
                      via Email
                    </div>
                  </a>                    
                </div>
              </div>
              <div class='clearfix'></div>
              <h2>#{c.text('modal_share_thewebsite')}</h2>
              <p class='savetext'>#{c.text('modal_share_web_text')}</p>
              <div class='row'>
                <div class='col-xs-3 nopadr'>
                  <a class="facebook" title="Share this website on Facebook" target="_blank" onclick="return !window.open(this.href, 'Facebook', 'width=640,height=300')" href="http://www.facebook.com/sharer/sharer.php?u=http://thesustainabilitysudoku.info">
                    <div class='social facebook'>
                      <i class="fa fa-facebook"></i> Facebook
                    </div>
                  </a>                    
                </div>
                <div class='col-xs-3 nopadr nopadl'>
                  <a target='_blank' href="https://twitter.com/share?url=http%3A%2F%2Fthesustainabilitysudoku.info&hashtags=thesustainabilitysudoku,sustainability,MuSIASEM,dataviz&text=The Sustainability Sudoku: " title="Share this website on Twitter">
                    <div class='social twitter'>
                      <i class="fa fa-twitter"></i> Twitter
                    </div>
                  </a>                    
                </div>
                <div class='col-xs-3 nopadr nopadl'>
                  <a target='_blank' title="Share this website on Google+" href="https://plus.google.com/share?url=http://thesustainabilitysudoku.info">
                    <div class='social google'>
                      <i class="fa fa-google-plus"></i> Google+
                    </div>
                  </a>                    
                </div>
                <div class='col-xs-3 nopadl'>
                  <a title="Share this website on via email" href="mailto:?&subject=The%20Sustainability%20Sudoku&body=Just%20played%20the%20Sustainability%20Sudoku!%20Define%20your%20society%20and%20try%20to%20get%20it%20sustainable!%20http%3A%2F%2Fthesustainabilitysudoku.info">
                    <div class='social email'>
                      via Email
                    </div>
                  </a>                    
                </div>
              </div>
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
    
