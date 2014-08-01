class window.IncompatibleView
  constructor:(@isPermalink) ->
    @$el      = $('#app')
    @$loading = $('#app-loading')
    @$app     = $('#app-main')

  render: ->
    html = """
        <div id='incompatible' class='text-center'>
          <p>
            The browser you are currently using to view this website is too old...
            <br>Please consider upgrading your browser or switching to one that integrates latest web technologies if it's already up-to-date! 
            <br>We're sorry for the inconvenience.
          </p>
        </div>
      """
    @$app.html(html)
    setTimeout =>
      @$loading.fadeOut()
      setTimeout =>
        $('body').removeClass('inapploading')
      , 400
    , 500
