var count = 2;

$(document).ready(function () {

    $('#add').on("click", function () {
          var newFieldset=document.createElement('fieldset');
          var html = '<legend>';
          html += "Room "+count ;

          html += "</legend><label for='Adults'>Adults</label> \
          <select name='roomGroup[room"+count+"][numberOfAdults]' id='roomGroup_room"+count+"_numberOfAdults'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select> \
          <label for='Children'>Children</label> \
          <select name='roomGroup[room"+count+"][numberOfChildren]' id='roomGroup_room"+count+"_numberOfChildren'><option value='0'>0</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>";
          newFieldset.innerHTML= html;
          document.getElementById('select-container').appendChild(newFieldset);
          count++;
      return false;
    });

    $('#remove').on("click", function () {
          var newDiv=document.createElement('fieldset');
          var html = '<legend>';
          html += "room";

          newDiv.innerHTML= html;
          document.getElementById('select-container').appendChild(newDiv);
          count--;
      return false;
    });

    $("#roomGroup_room1_numberOfChildren").change(function() {
        var newDiv=document.createElement('div');
        var html = "<label for='Adults'>Age of each Children</label>"
        for(var i = 1; i <= $('#roomGroup_room1_numberOfChildren :selected').val(); i++) {
            html += "<select name='roomGroup[room1][age"+count+"]' id='test'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>"
        }
        newDiv.innerHTML= html;
        document.getElementById('room1').appendChild(newDiv)

    });

    $('#my_select').change(function() {
        	   // assign the value to a variable, so you can test to see if it is working
        	    var selectVal = $('#my_select :selected').val();
        	    alert(selectVal);
        	});

    var input = document.getElementById('location_search');
    var autocomplete = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
    place = autocomplete.getPlace();
    document.getElementById("location_lat").value = place.geometry.location.lat();
    document.getElementById("location_lng").value = place.geometry.location.lng();

  });

});



