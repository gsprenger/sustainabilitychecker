# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.icon').tooltip({placement: 'bottom'})
  $('.panel-toggle').on 'click', (e) ->
    if $(this).parents('.panel').children('.panel-collapse').hasClass('in')
      e.stopPropagation()
  #window.onresize = resize
  #resize()

#resize = ->
#  tabsHeight = $('.panel-heading').outerHeight() * $('.panel-heading').length
#  height = $('#accordion').innerHeight() - tabsHeight
#  console.log $('#accordion').innerHeight()
#  $('.panel-body').height(height)

$(document).ready(ready)
$(document).on('page:load', ready)
