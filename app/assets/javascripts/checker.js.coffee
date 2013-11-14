# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
############
## COMMON ##
############
# Nav tree
ordered_nav = [
  'd_dem',
  'd_die',
  'd_hou',
  'd_ser_edu', 
  'd_ser_hea', 
  'd_ser_lei', 
  'd_ser_oth',
  's_den',
  's_agr',
  's_ene_ele', 
  's_ene_fue',
  's_ind'
]
semantic_nav = {
  'demographics':      'd_dem',
  'diet':              'd_die',
  'households':        'd_hou',
  'services':          'd_ser_edu', 
  'density':           's_den',
  'agriculture':       's_agr',
  'energy':            's_ene_ele', 
  'industrialization': 's_ind'
}

## Main execution loop
ready = ->
  load_progression()
  # If cards exist we are in variables view
  if $('#cards').length
    load_variables_view()
  else
    load_check_view()

## Loads things necessary to keep track of progression
load_progression = ->
  # place navigation on icons
  $('.icon').each (i, el) ->
    title = $(el).attr('title').toLowerCase()
    $(el).parent().on 'click', ->
      next_card semantic_nav[title], ->
        update_progression()

  # place tooltips on header
  $('.icon').tooltip {placement: 'bottom'}


remove_loading = (main, callback) ->
  $('#loading').addClass 'fadeOut'
  setTimeout ->
    $('#loading').addClass 'hidden'
    $('#loading').removeClass 'fadeOut'
    $(main).removeClass 'hidden'
    $(main).addClass 'fadeIn'
    setTimeout ->
      $(main).removeClass 'fadeIn'
      callback() if callback
    , 800
  , 800

###############  
## VARIABLES ##
###############
load_variables_view = ->
  # Attach events
  $('#nextbtn').on 'click', ->
    next_card false, ->
      update_progression()
  # Load cards
  $.get '/checker/cards', (data) -> 
    insert_cards JSON.parse data

insert_cards = (cards) ->
  $('#cards').append card.html for card in cards

  # if progression null show first card
  remove_loading '#cards', ->
    show_card '#'+ordered_nav[0], ->
      update_progression()

  
next_card = (card, callback) ->
  current = $('.card.active').attr 'id'
  if card
    next = card
  else 
    next = ordered_nav[ordered_nav.indexOf(current)+1]
  if next != 'undefined'
    hide_card '#'+current, ->
      show_card '#'+next, ->
        callback() if callback

hide_card = (id, callback) ->
  $(id).addClass 'bounceOutRight'
  setTimeout ->
    $(id).addClass 'hidden'
    $(id).removeClass 'active bounceOutRight'
    callback() if callback
  , 1000

show_card = (id, callback) ->
  $(id).removeClass 'hidden'
  $(id).addClass 'active bounceInLeft' 
  setTimeout ->
    $(id).removeClass 'bounceInLeft' 
    callback() if callback
  , 1000

update_progression = ->
  $('.icon').removeClass 'active'
  card = $('.card.active').attr 'id'
  $('.icon').each (i, el) ->
    if card == semantic_nav[$(el).attr('data-original-title').toLowerCase()]
      $(el).addClass 'active'

###########
## CHECK ##
###########
load_check_view = ->
  
$(document).ready(ready)
$(document).on('page:load', ready)
