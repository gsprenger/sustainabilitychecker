# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
############
## COMMON ##
############
## Animations for cards
animIn  = 'fadeInLeft'
animOut = 'fadeOutRight'

## Navigation trees
ordered_nav = [
  'd_dem',     # Demographics
  'd_die',     # Diet
  'd_hou',     # Households
  'd_ser_edu', # Services / Education
  'd_ser_hea', # Services / Healthcare
  'd_ser_lei', # Services / Leisure
  'd_ser_oth', # Services / Others
  's_den',     # Density
  's_agr',     # Agriculture
  's_ene_ele', # Energy / Electricity
  's_ene_fue', # Energy / Fuels
  's_ind'      # Industrialization
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

## 
load_progression = ->
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
## Attach card nav events on nav elements and loads cards
load_variables_view = ->
  # Nav icons
  $('.icon').each (i, el) ->
    title = $(el).attr('data-original-title').toLowerCase()
    $(el).parent().on 'click', ->
      next_card semantic_nav[title], ->
        update_header()
  # Next btn
  $('#nextbtn').on 'click', ->
    next_card false, ->
      update_header()
  # Load cards
  $.get '/checker/cards', (data) -> 
    insert_cards JSON.parse data

## Inserts given cards in the #cards container
insert_cards = (cards) ->
  $('#cards').append card.html for card in cards

  # if progression null show first card
  remove_loading '#cards', ->
    show_card '#'+ordered_nav[0], ->
      update_header()

## Switches current card with either the next card in nav or given card  
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

## Hides a card givin its #ID
hide_card = (id, callback) ->
  $(id).addClass animOut
  setTimeout ->
    $(id).addClass 'hidden'
    $(id).removeClass 'active ' + animOut
    callback() if callback
  , 1000

## Shows a card given its #ID
show_card = (id, callback) ->
  $(id).removeClass 'hidden'
  $(id).addClass 'active ' + animIn
  setTimeout ->
    $(id).removeClass animIn 
    callback() if callback
  , 1000

## Updates
update_header = ->
  $('.icon').removeClass 'active'
  card = $('.card.active').attr 'id'
  $('.icon').each (i, el) ->
    if card[0..4] == semantic_nav[$(el).attr('data-original-title').toLowerCase()][0..4]
      $(el).addClass 'active'

###########
## CHECK ##
###########
load_check_view = ->
  
$(document).ready(ready)
$(document).on('page:load', ready)
