# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
  $("#restaurant_category_ids").chosen();

  var restaurants = <%= Restaurant.all %>
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({address: 'Jax Beach, FL'}, function(results, status) {
      var bounds = results[0].geometry.bounds,
          center = results[0].geometry.location;
      if (bounds) {
          var ne = bounds.getNorthEast(),
              sw = bounds.getSouthWest(),
              data = { sw: [sw.lat(), sw.lng()], ne: [ne.lat(), ne.lng()]};

              // ajax call to rails service API
      }
  });
});
  

