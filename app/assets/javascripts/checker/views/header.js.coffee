class window.HeaderView
  constructor: ->
    @$el = $("<header role='banner' id='header'>")

  render: ->
    app = App.get()
    c = app.content
    html = """
      <nav>
        <div class='header-home'>
          <a href='/'>Home</a>
        </div>
        <div class='header-contact'>
          <a href='/#contact'>Contact us</a>
        </div>
      </nav>
      """
    @$el.html(html)
    return this
