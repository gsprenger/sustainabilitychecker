// site.js
function initialize() {
  var pos = new google.maps.LatLng(41.497979, 2.108362);
  var map_canvas = document.getElementById('map_canvas');
  $('#map_canvas').height($('#map_canvas').innerWidth());
  var map_options = {
    center: pos,
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(map_canvas, map_options);
  var marker = new google.maps.Marker({
    position: pos,
    map: map
  });
}
