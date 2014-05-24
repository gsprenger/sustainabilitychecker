class window.StaticPages
  @setup: ->
    # Init tooltips
    $('body').tooltip {
      selector: '[title]',
      placement: 'bottom'
    }
    # Smooth scrolling
    $("a[href^='#']").on 'click', (e) ->
      $('html,body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false
