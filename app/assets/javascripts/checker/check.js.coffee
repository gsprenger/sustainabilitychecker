class window.Check
  @setup: ->
    # debug
    json = ''
    for val in Progression.values
      json += val.name + ' = ' + val.value + '\n'
    $('.checkvar').text(json)
    
    $('.col-energy-local').height(80)
    $('.col-food-local').height(80)
    $('.col-energy-imported').height(100)
    $('.col-food-imported').height(130)

    Navigation.goToCheck()
