$(document).ready(function () {
    $('#add').on("click", function () {
          var newDiv=document.createElement('fieldset');
           var html = '<legend>';
           html += "room";

           html += "</legend><label for='Adults'>Adults</label> \
           <select name='roomGroup[][numberOfAdults]' id='roomGroup__numberOfAdults'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select> \
           <label for='Children'>Children</label> \
           <select name='roomGroup[][numberOfChildren]' id='roomGroup__numberOfChildren'><option value='0'>0</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>";
           newDiv.innerHTML= html;
           document.getElementById('select-container').appendChild(newDiv);
        return false;
    });

     $('#remove').on("click", function () {
          var newDiv=document.createElement('fieldset');
           var html = '<legend>';
           html += "room";

           newDiv.innerHTML= html;
           document.getElementById('select-container').appendChild(newDiv);

    return false;
    });

  var input = document.getElementById('location_search');
  var autocomplete = new google.maps.places.Autocomplete(input);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
  place = autocomplete.getPlace();
  document.getElementById("location_lat").value = place.geometry.location.lat();
  document.getElementById("location_lng").value = place.geometry.location.lng();

  });

});



