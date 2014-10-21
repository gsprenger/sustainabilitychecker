class window.IntroView
  constructor: ->
    @$el = $("<div class='section in-level#{App.get().level}' id='intro'>")
    @headernav = new HeaderNavView()
    $(window).on 'appready', ->
      # HeaderView: set offset to header position for affix to trigger
      $('#headernav').attr('data-offset-top', $('#headernav').offset().top)

  render: ->
    l = App.get().level
    c = App.get().content
    html = """
      <div class='section-wrapper'>
        <h2>#{c.text('chkr_start_title_level'+l)}<small>#{c.text('chkr_start_subtitle_level'+l)}</small></h2>
        <div class='description'>
          <p>#{c.text('chkr_start_desc_level'+l)}</p>
        </div><br>
        <div id='headernav' data-spy='affix'></div>
        <div class='invisible-margin'></div>
        <div class='btn-row'>
          <div class='btn btn-lg btn-primary btnnext'>#{c.text('chkr_start_btn_level'+l)}</div>
        </div>
      </div>
      """
    @$el.html(html)
    @$el.find('#headernav').append(@headernav.render().$el)
    @events()
    return this

  events: ->
    @$el.find('.btnnext').on 'click', ->
      $(window).trigger('sectioncomplete', 'intro')
    @$el.find('.btngoback').on 'click', ->
      window.location = "/level#{(App.get().level)-1}"
