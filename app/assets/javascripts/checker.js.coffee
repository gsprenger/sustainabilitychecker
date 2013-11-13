# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# tooltips
ready = ->
  # tooltips on header
  $('.icon').tooltip({placement: 'bottom'})
  
  # load progression
  # TODO
  prog_loaded = true;
  
  if $('#cards').length
    # Load cards
    $.get '/checker/cards', (data) -> 
      # When cards arrive, if progression is loaded, then remove loading and go
      if prog_loaded
        $('#loading').addClass('hidden')
        $('#cards').append data
    , 'html'
  else
    # Load check
    # TODO
  
  
$(document).ready(ready)
$(document).on('page:load', ready)
