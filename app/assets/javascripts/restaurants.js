// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http:coffeescript.org/
$(document).ready(function(){
  $("#restaurant_category_ids").chosen();

  $("#star_form").on("ajax:success", function(e, data, status, xhr){
    console.log("***********DATA*********");
    console.log(data);

    // if($("#star_form").attr('class') === 'new_star'){
      
      
    //   $("#star_form input[type='submit']").val("Star");
    // }else{
    //   $("#star_form").removeClass('edit_star').addClass('new_star');
    //   $("#star_form input[type='submit']").attr('action', data);
    //   $("#star_form input[type='submit']").val("Unstar");
    // }
  });
});

function initialize() {
  var restaurants = $("#map_canvas").data("restaurants");
  var locations = $("#map_canvas").data("locations");
  var categories = $("#map_canvas").data("categories");
  var markerIcons = $("#map_canvas").data("markerIcons");
  var restaurantsUrls = $("#map_canvas").data("restaurantsUrls");

  var mapOptions = {
    center: new google.maps.LatLng(locations[0].latitude, locations[0].longitude),
    zoom: 16,
    mapTypeId: google.maps.MapTypeId.MAP
  };

  var map = new google.maps.Map(document.getElementById('map_canvas'),
  mapOptions);

  for (var i = locations.length - 1; i >= 0; i--) {
    var latLng = new google.maps.LatLng(locations[i].latitude, locations[i].longitude);

    // Use first category for marker icon
    var image = {
      url: "assets/"+markerIcons[i],
      // This marker is 20 pixels wide by 32 pixels tall.
      size: new google.maps.Size(32, 32),
    };

    var marker = new google.maps.Marker({ 
      position: latLng, 
      map: map,
      icon: image, 
    });

    var infowindow = new google.maps.InfoWindow();
    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent(
          '<a href='+restaurantsUrls[i]+'>'+restaurants[i].name+'</a>'
        );
        infowindow.open(map, marker);
      }
    })(marker, i));
  }
}

