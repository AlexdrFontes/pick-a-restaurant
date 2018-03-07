function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var placeAddress = document.getElementById('place_address');

    if (placeAddress) {
      var autocomplete = new google.maps.places.Autocomplete(placeAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(placeAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
