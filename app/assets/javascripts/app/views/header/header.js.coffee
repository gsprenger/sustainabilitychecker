class window.HeaderView
  constructor: ->
    @$el = $("<div id='header-cont'>")

  render: ->
    app = App.get()
    c = app.content
    html = """
      <header role='banner' id='header'>
      </header>
      <nav>
        <div class='header-home'>
          <a href='/'>Home</a>
        </div>
        <div class='header-contact'>
          <a href='/contact'>Contact us</a>
        </div>
      </nav>
      """
    @$el.html(html)
    return this
