//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require SrBuj
//= require_tree .

$(document).ready(function(){
    $("#imagen").click(function () {
        var imageLoc = prompt('Ingrese la dirección de la imágen:');
        if (imageLoc) {
            $(".caja_image_url").val(imageLoc);
        }
        return false;
    });

    tooltipsOn();
    datepickerOn();
    tokeninputOn();
});



