var tooltipsOn = function() {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-show-tooltip="true"]').tooltip();
};

var datepickerOn = function() {
    $('.datepicker').datepicker();
};

var tokeninputOn = function(selector, url) {
    $(selector).tokenInput(url + ".json", {
        crossDomain: false
        , prePopulate: $(selector).data("pre")
        , theme: "facebook"
        , preventDuplicates: true
//        , hintText: ''
//        , noResultsText: ''
//        , searchingText: ''
    });
}