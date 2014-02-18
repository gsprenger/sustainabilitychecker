class window.Check
  @setup: ->
    # Click on 'Check' button
    $('.precheck .btn').click ->
      Check.startCheck()
    # Click on 'Try again'
    $('.checksection .btn-default').click ->
      Check.tryAgain()  
    # Click on 'Next level'
    $('.checksection .btn-primary').click ->
      alert('Not so fast! This is not ready yet!')
    # DEBUG
    $('.checksection .btn-info').click ->
      Sudoku.debug()

  @startCheck: ->
    Navigation.removeAndDisplay('.precheck', '.checksection')
    # Perform calculations
    heightUpperFood = 67
    heightUpperEnergy = 23
    heightLowerFood = 100 - heightUpperFood
    heightLowerEnergy = 100 - heightUpperEnergy

    # update title
    if (heightUpperFood == 100 && heightUpperEnergy == 100)
      $('.check-result').addClass('passed')
      $('.check-result').text('Passed!')

    # update percents
    h = $('.check-graph .cell').height() # total height
    t = 8 # height of text
    topPercentUpperFood = ((h * (heightUpperFood / 100)) / 2) - t
    topPercentUpperEnergy = ((h * (heightUpperEnergy / 100)) / 2) - t
    topPercentLowerFood = ((h * (heightLowerFood / 100)) / 2) - t
    topPercentLowerEnergy = ((h * (heightLowerEnergy / 100)) / 2) - t
    $('.bar-upper.bar-food .bar-percent').css('top', topPercentUpperFood+'px')
    $('.bar-upper.bar-energy .bar-percent').css('top', topPercentUpperEnergy+'px')
    $('.bar-lower.bar-food .bar-percent').css('top', topPercentLowerFood+'px')
    $('.bar-lower.bar-energy .bar-percent').css('top', topPercentLowerEnergy+'px')
    $('.bar-upper.bar-food .bar-percent').text(heightUpperFood+'%')
    $('.bar-upper.bar-energy .bar-percent').text(heightUpperEnergy+'%')
    $('.bar-lower.bar-food .bar-percent').text(heightLowerFood+'%')
    $('.bar-lower.bar-energy .bar-percent').text(heightLowerEnergy+'%')

    # Update bars: first top bars, then lower bars in red, then switch to original color.
    setTimeout ->
      $('.bar-upper.bar-food').css('height', heightUpperFood+'%')
      $('.bar-upper.bar-energy').css('height', heightUpperEnergy+'%')
      setTimeout ->
        $('.bar-lower.bar-food').css('height', heightLowerFood+'%')
        $('.bar-lower.bar-energy').css('height', heightLowerEnergy+'%')
        setTimeout ->
          $('.bar-upper.bar-food .bar-percent').css('opacity', 1)
          $('.bar-upper.bar-energy .bar-percent').css('opacity', 1)
          $('.bar-lower.bar-food .bar-percent').css('opacity', 1)
          $('.bar-lower.bar-energy .bar-percent').css('opacity', 1)
        , 1000
      , 1000
    , 1600
  
  @tryAgain: ->
    Navigation.removeAndDisplay('.checksection', '.precheck')
    setTimeout ->
      Navigation.smoothScrollTo('#demographics')
      # reinit check section
      $('.bar-upper, .bar-lower').css('height', '0%')
      $('.bar-percent').css('opacity', 0)
    , 1600
