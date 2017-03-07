/**
 * Created by ansash on 24.06.16.
 */



function ordering() {
    var date = new Date($('input[name=Date]').val());
    var currentDate = new Date();
    var year = date.getFullYear();
    var currentYear = currentDate.getFullYear();
    var month = date.getMonth()+1;
    var currentMonth = currentDate.getMonth()+1;
    var days = date.getDate();
    var currentDays = currentDate.getDate();
    var rightDate=false;
    if(year>=currentYear && month>=currentMonth && days>=currentDays+3){
        rightDate=true;
    }

    var upload = $('input[id=audiosent]').val();
    var status = "sent";
    if (upload === status) {


        var date = $('input[name=Date]').val();
        if (date == 0 || !rightDate) {
            $('input[name=Date]').css('border', '2px solid #FF0026');
            $('input[name=Date]').css('border-radius', '5px');
            $('#statusErrorOrdering').html('Geben Sie das Datum des Verschickens an');
        }

        var time = $('input[name=Time]').val();
        if (time == 0) {
            $('input[name=Time]').css('border', '2px solid #FF0026');
            $('input[name=Time]').css('border-radius', '5px');
            $('#statusErrorOrdering').html('Geben Sie den Zeitpunkt des Verschickens an');
        }

        var emailTwo = $('input[name=EmailTwo]').val();
        var chbox = $( 'input[name="MethodUp"]:checked' ).val();
        if (emailTwo == 0 && chbox == 1) {

            $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
            $('input[name=EmailTwo]').css('border-radius', '5px');
            $('#statusErrorEmailTwoOrdering').html('Geben Sie E-Mail Adresse des Empfängers an oder wählen Sie eine andere Art des Verschickens aus.');
            var emailt = 0;
        }else{

            var emailTwo = 'test@test.de';
        }

        var phoneTwo = $('input[name=PhoneTwo]').val();
        if (phoneTwo == 0) {
            $('input[name=PhoneTwo]').css('border', '2px solid #FF0026');
            $('input[name=PhoneTwo]').css('border-radius', '5px');
            $('#statusErrorPhoneTwoOrdering').html('Geben Sie die Handynummer des Empfänders an');
        }

        var email = $('input[name=EmailOrdering]').val();
        if (email == 0) {
            $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
            $('input[name=EmailOrdering]').css('border-radius', '5px');
            $('#statusErrorEmailTwoOrdering').html('Geben Sie Ihre E-Mail Adresse an');
        }
        var phone = $('input[name=PhoneOrdering]').val();
        if (phone == 0) {
            $('input[name=PhoneOrdering]').css('border', '2px solid #FF0026');
            $('input[name=PhoneOrdering]').css('border-radius', '5px');
            $('#statusErrorPhoneOrdering').html('Geben Sie Ihr Handynummer an');
        }
        var nameTwo = $('input[name=NameTwo]').val();
        if (nameTwo == 0) {
            $('input[name=NameTwo]').css('border', '2px solid #FF0026');
            $('input[name=NameTwo]').css('border-radius', '5px');
            $('#statusErrorNameTwoOrdering').html('Geben Sie den Vor- und Nachname des Empfängers');
        }


        var st = 1;


    } else {

        $('#statusErrorNameOrdering').html(' ');
        var name = $('input[name=NameOrdering]').val();
        if (name == 0) {
            $('input[name=NameOrdering]').css('border', '2px solid #FF0026');
            $('input[name=NameOrdering]').css('border-radius', '5px');
            $('#statusErrorNameOrdering').html('Geben Sie Ihren Vor- und Nachnamen an');
        }

        var email = $('input[name=EmailOrdering]').val();
        if (email == 0) {
            $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
            $('input[name=EmailOrdering]').css('border-radius', '5px');
            $('#statusErrorEmailOrdering').html('Geben Sie Ihr Handynummer an');
        }
        var phone = $('input[name=PhoneOrdering]').val();
        if (phone == 0) {
            $('input[name=PhoneOrdering]').css('border', '2px solid #FF0026');
            $('input[name=PhoneOrdering]').css('border-radius', '5px');
            $('#statusErrorPhoneOrdering').html('Geben Sie Ihr Handynummer an');
        }
        var nameTwo = $('input[name=NameTwo]').val();
        if (nameTwo == 0) {
            $('input[name=NameTwo]').css('border', '2px solid #FF0026');
            $('input[name=NameTwo]').css('border-radius', '5px');
            $('#statusErrorNameTwoOrdering').html('Geben Sie den Vor- und Nachname des Empfängers');
        }
        var emailTwo = $('input[name=EmailTwo]').val();
        var chbox = $( 'input[name="MethodUp"]:checked' ).val();
        if (emailTwo == 0 && chbox == 1) {

            $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
            $('input[name=EmailTwo]').css('border-radius', '5px');
            $('#statusErrorEmailTwoOrdering').html('Geben Sie E-Mail Adresse des Empfängers an oder wählen Sie eine andere Art des Verschickens aus.');
            var emailt = 0;
        }else{

            var emailTwo = 'test@test.de';
        }

        var phoneTwo = $('input[name=PhoneTwo]').val();
        if (phoneTwo == 0) {
            $('input[name=PhoneTwo]').css('border', '2px solid #FF0026');
            $('input[name=PhoneTwo]').css('border-radius', '5px');
            $('#statusErrorPhoneTwoOrdering').html('Geben Sie die Handynummer des Empfänders an');
        }

        var event = $('input[name=Event]').val();
        if (event == 0) {
            $('input[name=Event]').css('border', '2px solid #FF0026');
            $('input[name=Event]').css('border-radius', '5px');
            $('#statusErrorEventOrdering').html('Geben Sie einen Betreff an');
        }

        var compliments = $('textarea[name=Compliments]').val();
        if (compliments == 0) {
            $('textarea[name=Compliments]').css('border', '2px solid #FF0026');
            $('textarea[name=Compliments]').css('border-radius', '5px');
            $('#statusErrorComplimentsOrdering').html('Fügen Sie den Text zu');
        }

        var date = $('input[name=Date]').val();
        if (date == 0 || !rightDate) {
            $('input[name=Date]').css('border', '2px solid #FF0026');
            $('input[name=Date]').css('border-radius', '5px');
            $('#statusErrorDateOrdering').html('Geben Sie das Datum des Verschickens an');
        }

        var time = $('input[name=Time]').val();
        if (time == 0) {
            $('input[name=Time]').css('border', '2px solid #FF0026');
            $('input[name=Time]').css('border-radius', '5px');
            $('#statusErrorTimeOrdering').html('Geben Sie den Zeitpunkt des Verschickens an');
        }


        var st = 0;
    }


    if ((rightDate && name != 0 && email != 0 && phone != 0 && compliments != 0 && phoneTwo != 0 && emailt != 0 && nameTwo != 0 && event != 0 && date != 0 && time != 0 ) | (date != 0 && time != 0 && st != 0 && email != 0 && phone != 0 && phoneTwo != 0 && emailt != 0 && rightDate)) {

        if (isValidEmailAddress(email) == true && isValidEmailAddress(emailTwo) == true) {
            var formData = $('#ordering');
            $.ajax({
                type: "POST",
                url: '/ordering-star',
                data: formData.serialize(),
                success: function (data) {

                    var id = data.replace(/\s+/g, '');
                    $('input[name=Idorder]').val(id);
                    $('input[name=item_name]').val(id);
                    $('input[name=return]').val("https://star-hills.de/successfulordering?id="+id);
                    $('input[name=user_variable_1]').val(id);

                    /*$('input[name=NameOrdering]').val('');
                     $('input[name=NameTwo]').val('');
                     $('input[name=EmailOrdering]').val('');
                     $('input[name=EmailTwo]').val('');
                     $('input[name=PhoneOrdering]').val('');
                     $('input[name=PhoneTwo]').val('');
                     $('input[name=Event]').val('');
                     $('input[name=file]').val('');
                     $('input[name=Date]').val('');
                     $('input[name=Time]').val('');
                     $('textarea[name=Compliments]').val('');*/


                    $('#statusErrorOrdering').html("Die Bestellung wurde erfolgreich verschickt! Bei Bedarf können Sie Ihre Bestellung korrigieren und noch einmal senden.");
                    window.location = "#paymentmodal";

                }

            });

        } else {
            $('#statusErrorOrdering').html('Die E-Mail Adresse wurde falsch angegeben');
        }
    }
}
    $(document).ready(function () {
        $("#EmailOrdering").keyup(function () {


            var email = $("#EmailOrdering").val();

            if (email != 0) {
               if (isValidEmailAddress(email)) {
                    $('input[name=EmailOrdering]').css('border', '1px solid #d7d7d7');
                    $('input[name=EmailOrdering]').css('border-radius', '5px');
                    $('#statusErrorEmailOrdering').html('&nbsp;');
                } else {
                    $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
                    $('input[name=EmailOrdering]').css('border-radius', '5px');
                }
            } else {
                $('input[name=EmailOrdering]').css('border', '1px solid #d7d7d7');
                $('input[name=EmailOrdering]').css('border-radius', '5px');
                $('#statusErrorEmailOrdering').html('&nbsp;');
            }

        });

    });

    $(document).ready(function () {
        $("#EmailTwo").keyup(function () {

            var email = $("#EmailTwo").val();

            if (email != 0) {
                if (isValidEmailAddress(email)) {
                    $('input[name=EmailTwo]').css('border', '1px solid #d7d7d7');
                    $('input[name=EmailTwo]').css('border-radius', '5px');
                    $('#statusErrorEmailTwoOrdering').html('&nbsp;');
                } else {
                    $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
                    $('input[name=EmailTwo]').css('border-radius', '5px');
                }
            } else {
                $('input[name=EmailTwo]').css('border', '1px solid #d7d7d7');
                $('input[name=EmailTwo]').css('border-radius', '5px');
                $('#statusErrorEmailTwoOrdering').html('&nbsp;');
            }

        });

    });

    $(document).ready(function () {

        $('input[name=PhoneTwo]').keyup(function () {

            var PhoneTwo = $('input[name=PhoneTwo]').val();
            if (PhoneTwo != 0) {
                $('input[name=PhoneTwo]').css('border', '1px solid #d7d7d7');
                $('input[name=PhoneTwo]').css('border-radius', '5px');
                $('#statusErrorPhoneTwoOrdering').html('&nbsp;');
            } else {
                $('input[name=PhoneTwo]').css('border', '2px solid #FF0026');
                $('input[name=PhoneTwo]').css('border-radius', '5px');

            }
        });
    });

    $(document).ready(function () {

        $('input[name=Event]').keyup(function () {

            var event = $('input[name=Event]').val();
            if (event != 0) {
                $('input[name=Event]').css('border', '1px solid #d7d7d7');
                $('input[name=Event]').css('border-radius', '5px');
                $('#statusErrorEventOrdering').html('&nbsp;');
            } else {
                $('input[name=Event]').css('border', '2px solid #FF0026');
                $('input[name=Event]').css('border-radius', '5px');

            }
        });
    });


    $(document).ready(function () {

        $('input[name=PhoneOrdering]').keyup(function () {

            var PhoneOrdering = $('input[name=PhoneOrdering]').val();
            if (PhoneOrdering != 0) {
                $('input[name=PhoneOrdering]').css('border', '1px solid #d7d7d7');
                $('input[name=PhoneOrdering]').css('border-radius', '5px');
                $('#statusErrorPhoneOrdering').html('&nbsp;');
            } else {
                $('input[name=PhoneOrdering]').css('border', '2px solid #FF0026');
                $('input[name=PhoneOrdering]').css('border-radius', '5px');

            }
        });
    });


    $(document).ready(function () {

        $('input[name=NameTwo]').keyup(function () {

            var NameTwo = $('input[name=NameTwo]').val();
            if (NameTwo != 0) {
                $('input[name=NameTwo]').css('border', '1px solid #d7d7d7');
                $('input[name=NameTwo]').css('border-radius', '5px');
                $('#statusErrorNameTwoOrdering').html('&nbsp;');
            } else {
                $('input[name=NameTwo]').css('border', '2px solid #FF0026');
                $('input[name=NameTwo]').css('border-radius', '5px');

            }
        });
    });

    $(document).ready(function () {

        $('input[name=NameOrdering]').keyup(function () {

            var NameOrdering = $('input[name=NameOrdering]').val();
            if (NameOrdering != 0) {
                $('input[name=NameOrdering]').css('border', '1px solid #d7d7d7');
                $('input[name=NameOrdering]').css('border-radius', '5px');
                $('#statusErrorNameOrdering').html('&nbsp;');
            } else {
                $('input[name=NameOrdering]').css('border', '2px solid #FF0026');
                $('input[name=NameOrdering]').css('border-radius', '5px');

            }
        });
    });





    $(document).ready(function () {

        $('textarea[name=Compliments]').keyup(function () {

            var Compliments = $('input[name=Compliments]').val();
            if (Compliments != 0) {
                $('textarea[name=Compliments]').css('border', '1px solid #d7d7d7');
                $('textarea[name=Compliments]').css('border-radius', '5px');
                $('#statusErrorComplimentsOrdering').html('&nbsp;');
            } else {
                $('textarea[name=Compliments]').css('border', '2px solid #FF0026');
                $('textarea[name=Compliments]').css('border-radius', '5px');

            }
        });
    });
    $(document).ready(function () {

    $('.timepicker').on('click', function () {



            var timepicker = $('.timepicker').wickedpicker('time');
        if (timepicker != 0) {
            $('input[name=Time]').css('border', '1px solid #d7d7d7');
            $('input[name=Time]').css('border-radius', '5px');
            $('#statusErrorTimeOrdering').html('&nbsp;');
        } else {
            $('input[name=Time]').css('border', '2px solid #FF0026');
            $('input[name=Time]').css('border-radius', '5px');

        }

    });


        $('.timepicker').on('change', function()  {

            var Time = $('input[name=Time]').val();
            if (Time != 0) {
                $('input[name=Time]').css('border', '1px solid #d7d7d7');
                $('input[name=Time]').css('border-radius', '5px');
                $('#statusErrorTimeOrdering').html('&nbsp;');
            } else {
                $('input[name=Time]').css('border', '2px solid #FF0026');
                $('input[name=Time]').css('border-radius', '5px');

            }
        });


        $("input:checkbox").change(function() {

            var chbox = $( 'input[name="MethodUp"]:checked' ).val();

            var email = $("#EmailTwo").val();

            if (chbox == 1 ) {
                if (isValidEmailAddress(email)) {
                    $('input[name=EmailTwo]').css('border', '1px solid #d7d7d7');
                    $('input[name=EmailTwo]').css('border-radius', '5px');
                    $('#statusErrorEmailTwoOrdering').html('&nbsp;');
                } else {
                    $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
                    $('input[name=EmailTwo]').css('border-radius', '5px');
                    $('#statusErrorEmailTwoOrdering').html('Geben Sie E-Mail Adresse des Empfängers an oder wählen Sie eine andere Art des Verschickens aus.');
                }
            } else {
                $('input[name=EmailTwo]').css('border', '1px solid #d7d7d7');
                $('input[name=EmailTwo]').css('border-radius', '5px');
                $('#statusErrorEmailTwoOrdering').html('&nbsp;');
            }




        });

});


function editPhotoss() {

      var formData =  new FormData($('#ordering')[0]);
     $.ajax({
     type: "POST",
     url: '/orderingphoto',
     enctype: "multipart/form-data",
     contentType: false,
     processData: false,
     cache: false,
     data: formData,
     success: function (data) {
         var id=data.replace(/\s+/g, '');
         if(id=='error'){
             $("#statusSuccessMessage").html("Das Foto wurde nicht erfolgreich hochgeladen!");
             window.location  = "#successUp";
         }else {
             $('input[name=Idorder]').val(id);
             $('input[name=filestatus]').val(id);
             $('input[name=item_name]').val(id);
             $('input[name=user_variable_1]').val(id);
             $("#statusSuccessMessage").html("Das Foto wurde erfolgreich hochgeladen! Laden Sie das Foto noch einmal, um ein neues Foto einzufügen.");
             window.location = "#successUp";
             $("#photoup").html("Neues Foto");
         }
     }
     });

}

$(function () {
    $(".ids").on('click', function () {

        var $box = $(this);
        var idstar = $box.attr("idstar");
        var name = $box.attr("names");
        $('#FotoS').css('opacity', '0');
        $('#FotoS').animate({opacity:1});
        $('#FotoS').html('<img src=\"/starSource/'+idstar+'/mainphoto.png\">');
        $('#NameS').html(name);
        if(idstar !=0)
        $('#ButtonN').html('<a href=\"/orderingstar?id='+idstar+'\">weiter</a>');

    });

});

$(function () {
$("#amountCharity").bind('input',function () {
    var amount = $('input[name=amountCharity]').val();
    $('input[am=AmountPayPalCharity]').val(amount);
    $('input[am=AmountSofortCharity]').val(amount);

});
});

var cf = new ContentFlow('contentFlow', {
    shownItems: 15,
    reflectionColor: "#000000",
    scaleFactor: 1.1,
    contentPosition: "bottom",
    scaleFactorPortrait: 1.0,
    scaleFactorLandscape: 1.0,
    reflectionHeight: 0.5,
    visibleItems: 5,

    scrollWheelSpeed : 0,
    onclickActiveItem: function (item) {

    },
});

function  search(id){
    var form = id;
    var idsearch = id+'Id';
    var search = $(idsearch).val();

if (search != 0) {
    var formData = $(form);
    if(idsearch == '#resultSearchHeaderId') {
        $('#Header #Searching .search .submit').css('background', 'url("./images/loading.gif") center center no-repeat');
    }else {

        $('#AllSearch #SearchingBlock .search .submit').css('background', 'url("./images/loading.gif") center center no-repeat');

    }
    $.ajax({
        global: false,
        type: "POST",
        url: '/search-star',
        data: formData.serialize(),
        success: function (data) {

            var sch = data.trim();
            $("#statussearch").html(sch);
            window.location = "#search";
            $('.submit').css('background', 'url("./images/Search.png") center center no-repeat');
        }
    });
}
}
/*------------------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------------*/
function paycharity(id){
    $('#IdCharityPayPal').val(id);
    $('#IdCharitySofort').val(id);
    $('#ReturnIdCharityPayPal').val("https://star-hills.de/charity?id="+id);
}
$(document).ready(function(){
    $("#SliderCharitable").on("click","a", function (event) {
        //отменяем стандартную обработку нажатия по ссылке
        event.preventDefault();

        //забираем идентификатор бока с атрибута href
        var id  = $(this).attr('href'),

        //узнаем высоту от начала страницы до блока на который ссылается якорь
            top = $(id).offset().top;

        //анимируем переход на расстояние - top за 1500 мс
        $('body,html').animate({scrollTop: top}, 1500);
    });
});
$(document).ready(function () {
    $('.charityclick').on('click', function () {
            var clickId = $(this).prev().attr("id");
            var h = $('#'+clickId).height();
            if(h == 250) {
                $('#' + clickId).css('height', 'auto');
            }else {
                $('#' + clickId).css('height', '250px');
            }
    });
});

