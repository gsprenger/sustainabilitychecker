class window.Check
  @setup: ->
    $('.precheck .btn').click ->
      Navigation.removeAndDisplay('.precheck', '.checksection')
    $('.checksection .btn-default').click ->
      Navigation.removeAndDisplay('.checksection', '.precheck')
      setTimeout ->
        Navigation.smoothScrollTo('#demographics')
      , 1600
    $('.checksection .btn-primary').click ->
      alert('Not so fast! This is not ready yet!')
