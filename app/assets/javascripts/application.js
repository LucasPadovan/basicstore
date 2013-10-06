//= require jquery
//= require jquery.ui.all
//= require_tree .
//= require purecss-dropdown

$(document).ready(function(){
    $("#imagen").click(function () {
        var imageLoc = prompt('Ingrese la dirección de la imágen:');
        if (imageLoc) {
            $(".caja_image_url").val(imageLoc);
        }
        return false;
    });
});



