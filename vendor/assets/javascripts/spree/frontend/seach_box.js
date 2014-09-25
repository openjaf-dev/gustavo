var count = 2;

$(document).ready(function () {

    $('#add').on("click", function () {
        var newFieldset=document.createElement('fieldset');
        newFieldset.id = "room"+count+""
        var html = '<legend>';
        html += "Room "+count ;

        html += "</legend><label for='Adults'>Adults</label> \
        <select name='roomGroup[room"+count+"][numberOfAdults]' id='roomGroup_room"+count+"_numberOfAdults'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select> \
        <label for='Children'>Children</label> \
        <select name='roomGroup[room"+count+"][numberOfChildren]' id='children_"+count+"' class='children_select'><option value='0'>0</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>\
        <a href='#' id='remove"+count+"'>X</a>        ";
        newFieldset.innerHTML= html;
        document.getElementById('select-container').appendChild(newFieldset);
        $("#children_" + count).change(children_changed);
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

    function children_changed(event) {
        console.log(event);
        var parts = event.target.id.split("_");
        var number = parts[parts.length - 1];
        var new_div_id = "room_" + number + "_children";
        $("#" + new_div_id).remove();
        var number_selected = $("#" + event.target.id + ' :selected').val();
        if (number_selected != 0) {
            console.log("here");
            var newDiv=document.createElement('div');
            newDiv.id = new_div_id;
            var html = "<label for='Adults'>Age of each Children</label>"
            for(var i = 1; i <= number_selected; i++) {
                html += "<select name='roomGroup[room" + number + "][age"+i+"]' id='test'><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select>"
            }
            newDiv.innerHTML= html;
            document.getElementById('room'+number).appendChild(newDiv);
        }
    }

    $(".children_select").change(children_changed);


    var input = document.getElementById('location_search');
    var autocomplete = new google.maps.places.Autocomplete(input);

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
    place = autocomplete.getPlace();
    document.getElementById("location_lat").value = place.geometry.location.lat();
    document.getElementById("location_lng").value = place.geometry.location.lng();

  });

});



