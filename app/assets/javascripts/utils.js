var tooltipsOn = function() {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-show-tooltip="true"]').tooltip();
};

var datepickerOn = function() {
    $('.datepicker').datepicker();
};

var tokeninputOn = function() {
    $("#product_type_tokens").tokenInput("/product_types.json", {
        crossDomain: false,
        prePopulate: $("#product_type_tokens").data("pre"),
        theme: "facebook"
    });
}