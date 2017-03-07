/**
 * Created by Admin on 26.07.2016.
 */
$(document).ready(function () {
    $("#CharityEmail").bind('input', emailvalidation);
    $('form[id="Charity"]').find('input').not('[type="submit"]').not('[type="hidden"]').each(function() {
        $(this).keyup(function () {
            $(this).css("box-shadow", "none");
            $(this).next('.span').remove();
        });
    });
    $('[name="When"]').datepicker({
        dateFormat : "yy-mm-dd",
        minDate: 3,
        onSelect: function(dateText) {
            $(this).css("box-shadow", "none");
            $(this).next('.span').remove();
        }
    });
});
var emailvalidation = function () {
    /*$('#statusErrorCabinet').html('');
    $('#emailvalid').html(' ');*/
    var email = $('input[name=Email]').val();
    if (email != 0) {
        if (isValidEmailAddress(email)) {
            $("#validEmail").css({
                "background-image": "url('images/yes.png')"
            });
        } else {
            $("#validEmail").css({
                "background-image": "url('images/no.png')"
            });
        }

    } else {
        $("#validEmail").css({
            "background-image": "none"
        });
    }
}


document.getElementsByName('Summa')[0].onkeypress = function(e) {
    e = e || event;
    if (e.ctrlKey || e.altKey || e.metaKey) return;
    var chr = getChar(e);
    if (chr == null) return;
    if (chr < '0' || chr > '9') {
        return false;
    }
}

function getChar(event) {
    if (event.which == null) {
        if (event.keyCode < 32) return null;
        return String.fromCharCode(event.keyCode) // IE
    }
    if (event.which != 0 && event.charCode != 0) {
        if (event.which < 32) return null;
        return String.fromCharCode(event.which) // остальные
    }
    return null;
}
function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
    return pattern.test(emailAddress);
}