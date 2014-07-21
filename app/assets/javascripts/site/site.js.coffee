# site.js

# init google maps api
window.initialize = ->
  pos = new google.maps.LatLng(41.4974744,2.1098583,17)
  map_canvas = document.getElementById('map_canvas')
  $('#map_canvas').height($('#map_canvas').innerWidth()*0.8)
  map_options = {
    center: pos,
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(map_canvas, map_options)
  marker = new google.maps.Marker({
    position: pos,
    map: map
  })

window.setup = ->
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
