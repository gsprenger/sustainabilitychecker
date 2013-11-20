# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
############
## COMMON ##
############
## Animations for cards
animIn  = 'fadeInLeft'
animOut = 'fadeOutRight'

## Progression Object and ID
exp_id = 0;
prog = {
  "current": '',
  "values": []
}

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
  # If cards exist we are in cards view
  if $('#cards').length
    load_cards_view()
  else
    load_check_view()

## Gets ID and loads prog with Ajax call
load_progression = ->
  exp_id = $('#uid').text()
  # place tooltips on header
  $('.icon').tooltip {placement: 'bottom'}
  $.get '/checker/get_experiment?id='+exp_id, (data) -> 
    exp = JSON.parse data
    json = JSON.parse exp[0].json
    prog.current = json.current
    prog.values = json.values

## Removes the loading screen and displays the given Element afterwards
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
## CARDS ##
###############
## Attach card nav events on nav elements and loads cards
load_cards_view = ->
  # Navigation icons on header
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

## Inserts given cards in the #cards container and attach click events
insert_cards = (cards) ->
  $('#cards').append card.html for card in cards
  # get all data-cv-value elements and attach click events
  $('[data-cv-value]').each (i, el) ->
    $(el).parent().on 'click', ->
      item = {
        "name": $(el).closest('.card').attr('id')
        "value": $(el).attr('data-cv-value')
      }
      update_progression item
  # if progression null show first card
  remove_loading '#cards', ->
    card = prog.current || ordered_nav[0]
    show_card '#'+card, ->
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
      false
      
##Updates the prog object and runs a save
update_progression = (item) ->
  prog.current = ordered_nav[ordered_nav.indexOf(item.name)+1]
  prog.values.push(item)
  save_progression()

## Saves the prog object in the db
save_progression = ->
  data = {
    "id": exp_id
    "json": JSON.stringify prog
  }
  save_request = $.post '/checker/save_experiment', data
  save_request.success (data) ->
    $('.header-user').append 'Saved! '


###########
## CHECK ##
###########
load_check_view = ->
  
$(document).ready(ready)
$(document).on('page:load', ready)
