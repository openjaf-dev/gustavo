var count = 2;

$(document).ready(function () {

    $('#add').on("click", function () {
        var newFieldset=document.createElement('fieldset');
        newFieldset.id = "#room"+count+""
        var html = '<legend>';
        html += "Room "+count ;

        html += "</legend><label for='Adults'>Adults</label> \
        <select name='roomGroup[room"+count+"][numberOfAdults]' id='roomGroup_room"+count+"_numberOfAdults'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select> \
        <label for='Children'>Children</label> \
        <select name='roomGroup[room"+count+"][numberOfChildren]' id='roomGroup_room"+count+"_numberOfChildren'><option value='0'>0</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>\
        <a href='#' id='remove"+count+"'>X</a>        ";
        newFieldset.innerHTML= html;
        document.getElementById('select-container').appendChild(newFieldset);
        count++;
      return false;
    });

//    $("#remove"+count--+"").on("click", function () {
//        $("#room"+count--+"").remove();
//        count--;
//      return false;
//    });
//    a todos los select que esten dentro de un fildset
//    combo1.chan
//
//    todos los combos se suscriben a la misma funcion.

    $("#roomGroup_room1_numberOfChildren").change(function() {
        if ($('#roomGroup_room1_numberOfChildren :selected').val() != 0) {

            var newDiv=document.createElement('div');
            var html = "<label for='Adults'>Age of each Children</label>"
            for(var i = 1; i <= $('#roomGroup_room1_numberOfChildren :selected').val(); i++) {
                html += "<select name='roomGroup[room1][age"+i+"]' id='test'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>"
            }
            newDiv.innerHTML= html;
            document.getElementById('room1').appendChild(newDiv)
        }
    });


    var input = document.getElementById('location_search');
    var autocomplete = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
    place = autocomplete.getPlace();
    document.getElementById("location_lat").value = place.geometry.location.lat();
    document.getElementById("location_lng").value = place.geometry.location.lng();

  });

});



