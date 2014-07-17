function initialize() {
  var mapOptions = {
    zoom: 8,
    center: new google.maps.LatLng(44.973, -93.275)
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  var infowindow = new google.maps.InfoWindow();
  if (typeof locations_array != 'undefined') {
    for (coordinate in locations_array) {
      var coord=locations_array[coordinate].split(',')
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(coord[0], coord[1]),
        map: map,
        title: "Tweets"
      });

      google.maps.event.addListener(marker, 'click', (function(marker, coordinate) {
        return function() {
          var coord = locations_array[coordinate].split(',')
          infowindow.setContent(coord[2]);
          infowindow.open(map, marker);
        }
      })(marker, coordinate));
    }
  }
  else if (city != 'null'){
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode( { 'address': city }, function (results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
      } else {
        console.log("Error, can't find location: " + city);
      }
    });
  } 
}

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&' +
      'callback=initialize';
  document.body.appendChild(script);
}

$(document).ready(function () {
  loadScript();
});
