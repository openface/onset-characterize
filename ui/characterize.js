
$(document).ready(function() {
    $('#close').click(function(e) {
        e.preventDefault();
        CallEvent("characterize:HidePanel");
    });
    
    $('#characterize-form').submit(function(e) {
        e.preventDefault();
        CallEvent("characterize:Submit", JSON.stringify($(this).serializeArray()));
    });

    $('#body').on('input', function () {
        $('#body_value').html($(this).val());
        CallEvent("characterize:Change", 'body', bodyOptions[$(this).val() - 1]);
    });

    $('#hair').on('input', function () {
        value = $(this).val();
        if (value == 2) {
            $('#hair_color').prop("disabled", false)
        } else {
            $('#hair_color').prop("disabled", true)
        }
        $('#hair_value').html($(this).val());
        CallEvent("characterize:Change", 'hair', hairOptions[$(this).val() - 1]);
    });

    $('#hair_color').on('input', function () {
        $('#hair_color_value').html($(this).val());
        CallEvent("characterize:Change", 'hair_color', hairColorOptions[$(this).val() - 1]);
    });

    $('#shirt').on('input', function () {
        $('#shirt_value').html($(this).val());
        CallEvent("characterize:Change", 'shirt', shirtOptions[$(this).val() - 1]);
    });

    $('#pants').on('input', function () {
        $('#pants_value').html($(this).val());
        CallEvent("characterize:Change", 'pants', pantOptions[$(this).val() - 1]);
    });

    $('#shoes').on('input', function () {
        $('#shoes_value').html($(this).val());
        CallEvent("characterize:Change", 'shoes', shoeOptions[$(this).val() - 1]);
    });
});

let bodyOptions;
let hairOptions;
let hairColorOptions;
let shirtOptions;
let pantOptions;
let shoeOptions;

function SetCharacterOptions(type, options) {
    if (type == 'body') {
        bodyOptions = JSON.parse(options);
        $("#body").attr({ "max": bodyOptions.length });
    } else if (type == 'hair') {
        hairOptions = JSON.parse(options);
        $("#hair").attr({ "max": hairOptions.length });
    } else if (type == 'shirt') {
        shirtOptions = JSON.parse(options);
        $("#shirt").attr({ "max": shirtOptions.length });
    } else if (type == 'pants') {
        pantOptions = JSON.parse(options);
        $("#pants").attr({ "max": pantOptions.length });
    } else if (type == 'shoes') {
        shoeOptions = JSON.parse(options);
        $("#shoes").attr({ "max": shoeOptions.length });
    } else if (type == 'hair_color') {
        hairColorOptions = JSON.parse(options);
        $("#hair_color").attr({ "max": hairColorOptions.length });
    }
}