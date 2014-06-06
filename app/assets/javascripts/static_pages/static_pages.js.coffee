class window.StaticPages
  @setup: ->
    # Init tooltips
    $('body').tooltip {
      selector: '[data-toggle=tooltip]',
      placement: 'bottom'
    }
    # init popovers
    $('body').popover {
      selector: '[data-toggle=popover]'
      placement: 'bottom',
      trigger: 'hover',
      container: 'body'
    }
    # Smooth scrolling
    $("a[href^='#']").on 'click', (e) ->
      $('html,body').animate({scrollTop: $(e.currentTarget.hash).offset().top}, 1000)  
      return false
