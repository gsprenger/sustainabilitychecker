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
    trigger: 'hover click',
  }
  # create and init scrollTop button
  $('body').append("""
      <div id='scrolltopicon-cont'>
        <div id='scrolltopicon' title='Scroll to the top'><i class='fa fa-arrow-circle-o-up'></i></div>
      </div>
    """)
  $(window).scroll ->
    if $(this).scrollTop() > 100
      $('#scrolltopicon-cont').fadeIn()
    else
      $('#scrolltopicon-cont').fadeOut()
  $('#scrolltopicon').on 'click', ->
    $('html, body').animate({scrollTop : 0},800)
    false
