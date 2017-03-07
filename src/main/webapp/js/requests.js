
$(document).ready(function () {
    $('input[name=j_username]').keyup(function () {
        $('#statusError').html('');
        $('input[name=j_username]').css('border', '1px solid #d7d7d7');
        $('input[name=j_username]').css('border-radius', '5px');
    });
    $('input[name=j_password]').keyup(function () {
        $('#statusError').html('');
        $('input[name=j_password]').css('border', '1px solid #d7d7d7');
        $('input[name=j_password]').css('border-radius', '5px');
    });
    $('input[name=Name]').keyup(function () {
        $('#statusErrorReg').html('');
        $("#statusErrorCabinet").html(' ');
        $('input[name=Name]').css('border', '1px solid #d7d7d7');
        $('input[name=Name]').css('border-radius', '5px');
        $('input[name=Name]').attr('class', 'validform');
        $('input[name=Name]').attr('placeholder', 'geben Sie Ihr Vorname und Nachname an');
        $('#namevalid').html('');
    });

    $('input[name=Phone]').keyup(function () {
        $('#statusErrorReg').html('');
        $('input[name=Phone]').css('border', '1px solid #d7d7d7');
        $('input[name=Phone]').css('border-radius', '5px');
        $('input[name=Phone]').attr('class', 'validform');
        $('input[name=Phone]').attr('placeholder', 'geben Sie Ihr Handynummer an');
        $('#phonevalid').html('');
    });
    $('input[name=Alias]').keyup(function () {
        $('#statusErrorReg').html('');
        $("#statusErrorCabinet").html(' ');
        $('input[name=Alias]').css('border', '1px solid #d7d7d7');
        $('input[name=Alias]').css('border-radius', '5px');
        $('input[name=Alias]').attr('class', 'validform');
        $('input[name=Alias]').attr('placeholder', 'geben Sie Ihr Nickname an');
        $('#aliasvalid').html('');
    });
    $('input[name=Skype]').keyup(function () {
        $('#statusErrorReg').html('');
        $("#statusErrorCabinet").html(' ');
        $('input[name=Skype]').css('border', '1px solid #d7d7d7');
        $('input[name=Skype]').css('border-radius', '5px');
    });
    $('#SkypeSend').keyup(function () {
        $('#SkypeSend').css('border', '1px solid #d7d7d7');
        $('#SkypeSend').css('border-radius', '5px');
        $('#SkypeSend').attr('class', 'validform');
        $('#SkypeSend').attr('placeholder', 'geben Sie Ihr skype');
    });
    $('input[name=Login]').bind('input', function () {
        $('#statusErrorReg').html('');
        $("#statusErrorCabinet").html(' ');
        $('input[name=Login]').css('border', '1px solid #d7d7d7');
        $('input[name=Login]').css('border-radius', '5px');
        $('input[name=Login]').attr('class', 'validform');
        $('input[name=Login]').attr('placeholder', 'geben Sie Ihr Benutzername');
        $('#loginvalid').html('');
        var login = $('input[name=Login]').val();
        if (login == 0) {
            $('input[name=Login]').attr('class', 'invalidform');
        }
        if (login.length < 4) {
            if (login != 0) {
                $('#loginvalid').html('Benutzername hat weniger als 4 Symbole');
                $('input[name=Login]').attr('class', 'invalidform');
                $("#validLogin").css({
                    "background-image": "url('images/no.png')"
                });
            }
        }
        if (login.length > 15) {
            $("#validLogin").css({
                "background-image": "url('images/no.png')"
            });
            $('#loginvalid').html('Benutzername hat mehr als 15 Symbole');
            $('input[name=Login]').attr('class', 'invalidform');
        }
        if (login.length>3 && login.length<16 && login!=0) {
            $('input[name=Login]').css('border', '1px solid #d7d7d7');
            $('input[name=Login]').css('border-radius', '5px');
            $('input[name=Login]').attr('class', 'validform');
            $('#loginvalid').html('');
            $("#validLogin").css({
                "background-image": "url('images/yes.png')"
            });
        }else{
            $('input[name=Login]').css('border', '2px solid #FF0026');
            $('input[name=Login]').css('border-radius', '5px');
            $('input[name=Login]').attr('class', 'invalidform');
            $("#validLogin").css({
                "background-image": "url('images/no.png')"
            });
        }
    });
    $('input[name=Price]').keyup(function () {
        $('#statusErrorReg').html('');
        $("#statusErrorCabinet").html(' ');
        $('input[name=Price]').css('border', '1px solid #d7d7d7');
        $('input[name=Price]').css('border-radius', '5px');
    });

    $('input[name=Password]').bind('input', function () {
        $('#statusErrorReg').html('');
        $('input[name=Password]').css('border', '1px solid #d7d7d7');
        $('input[name=Password]').css('border-radius', '5px');
        $('input[name=Password]').attr('class', 'validform');
        $('input[name=Password]').attr('placeholder', 'geben Sie Ihr Passwört');
        $('#passvalid').html('');
        isValidPassword($(this), $('#passvalid'), $('#validPassword1'));

    });

    $('input[name=login]').keyup(function () {
        $('#statusRecoverError').html('');
        $('input[name=login]').css('border', '1px solid #d7d7d7');
        $('input[name=login]').css('border-radius', '5px');
    });
    $("#Email").bind('input', emailvalid);

    $("#PassRep").bind('input', function () {
        $('#statusErrorReg').html(' ');
        var passwordrep = $('input[name=PasswordReply]').val();
        var password = $('input[name=Password]').val();
        $('input[name=PasswordReply]').css('border', '1px solid #ccc');
        if (passwordrep != 0) {
            if (passwordrep==password) {
                $("#validPassword").css({
                    "background-image": "url('images/yes.png')"
                });
                $('input[name=PasswordReply]').css('border', '1px solid #d7d7d7');
                $('input[name=PasswordReply]').css('border-radius', '5px');
                $('#passrepvalid').html('<b style="color: green">Passwörter sind identisch</b>');
            } else {
                $("#validPassword").css({
                    "background-image": "url('images/no.png')"
                });
                $('input[name=PasswordReply]').css('border', '2px solid #FF0026');
                $('input[name=PasswordReply]').css('border-radius', '5px');
                $('#passrepvalid').html('Passwörter sind nicht identisch');
            }

        } else {
            $("#validPassword").css({
                "background-image": "none"
            });
            $('input[name=PasswordReply]').css('border', '1px solid #d7d7d7');
            $('input[name=PasswordReply]').css('border-radius', '5px');
        }
    });
    $("#CallUsEmail").bind('input', emailvalidation1);
    $('form[id="callusform"]').find('input').not('[type="submit"]').not('[type="hidden"]').each(function() {
        $(this).keyup(function () {
            $(this).css("box-shadow", "none");
            $(this).prev().children().remove();
        });
    });


    $("#EmailModal").keyup(function () {
        $('#statusErrorModal').html('');
        $('#EmailModal').css('border', '1px solid #ccc');
        var email = $("#EmailModal").val();
        if (email != 0) {
            if (isValidEmailAddress(email)) {
                $("#validEmailModal").css({
                    "background-image": "url('images/yes.png')"
                });
                $('#EmailModal').css('border', '1px solid #ccc');
            } else {
                $("#validEmailModal").css({
                    "background-image": "url('images/no.png')"
                });
            }

        } else {
            $("#validEmailModal").css({
                "background-image": "none"
            });
        }
    });
    $("#EmailFree").keyup(function () {
        $('#statusErrorFree').html('');
        $('#EmailFree').css('border', '1px solid #ccc');
        var email = $("#EmailFree").val();
        if (email != 0) {
            if (isValidEmailAddress(email)) {
                $("#validEmailFree").css({
                    "background-image": "url('images/yes.png')"
                });
                $('#EmailFree').css('border', '1px solid #ccc');
            } else {
                $("#validEmailFree").css({
                    "background-image": "url('images/no.png')"
                });
            }

        } else {
            $("#validEmailFree").css({
                "background-image": "none"
            });
        }
    });
    $(document).ajaxStart(function () {
        $(".modalWaiting").css("display", "block");
    });
    $(document).ajaxComplete(function () {

        $(".modalWaiting").css("display", "none");
    });

});
var emailvalid = function () {
    $('#statusErrorCabinet').html('');
    $('#emailvalid').html(' ');
    $('input[name=Email]').css('border', '1px solid #ccc');
    var email = $('input[name=Email]').val();
    if (email != 0) {
        if (isValidEmailAddress(email)) {
            $("#validEmail").css({
                "background-image": "url('images/yes.png')"
            });
            $('input[name=Email]').css('border', '1px solid #ccc');
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
var emailvalidation1 = function () {

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






function registration() {
    $('#statusErrorReg').html(' ');
    var name = $('input[name=Name]').val();
    if (name == 0) {
        $('input[name=Name]').attr('class', 'invalidform');
    }
    if (name.length > 50) {
        $('#namevalid').html('Ihre Vorname und Nachname sind zu lang');
        $('input[name=Name]').attr('class', 'invalidform');
    }
if (name.length<51 && name!=0) {
    $('input[name=Name]').attr('class', 'validform');
    $('input[name=Name]').css('border', '1px solid #d7d7d7');
    $('input[name=Name]').css('border-radius', '5px');
    $('#namevalid').html('');
}else{
    $('input[name=Name]').css('border', '2px solid #FF0026');
    $('input[name=Name]').css('border-radius', '5px');
    $('input[name=Name]').attr('class', 'invalidform');
}
    var email = $('input[name=Email]').val();
    if (email == 0) {
        $('input[name=Email]').css('border', '2px solid #FF0026');
        $('input[name=Email]').css('border-radius', '5px');
        $('input[name=Email]').attr('class', 'invalidform');

    }
    var login = $('input[name=Login]').val();
    if (login == 0) {
        $('input[name=Login]').attr('class', 'invalidform');
    }
    if (login.length < 4) {
        if (login != 0) {
            $('#loginvalid').html('Benutzername hat weniger als 4 Symbole');
            $('input[name=Login]').attr('class', 'invalidform');
        }
    }
    if (login.length > 15) {
        $('#loginvalid').html('Benutzername hat mehr als 15 Symbole');
        $('input[name=Login]').attr('class', 'invalidform');
    }
    if (login.length>3 && login.length<16 && login!=0) {
        $('input[name=Login]').css('border', '1px solid #d7d7d7');
        $('input[name=Login]').css('border-radius', '5px');
        $('input[name=Login]').attr('class', 'validform');
        $('#loginvalid').html('');
    }else{
        $('input[name=Login]').css('border', '2px solid #FF0026');
        $('input[name=Login]').css('border-radius', '5px');
        $('input[name=Login]').attr('class', 'invalidform');
    }
    var phone = $('input[name=Phone]').val();
    if (phone == 0) {
        $('input[name=Phone]').css('border', '2px solid #FF0026');
        $('input[name=Phone]').css('border-radius', '5px');
        $('input[name=Phone]').attr('class', 'invalidform');
    } else {
        $('input[name=Phone]').css('border', '1px solid #d7d7d7');
        $('input[name=Phone]').css('border-radius', '5px');
        $('#phonevalid').html('');
        $('input[name=Phone]').attr('class', 'validform');
    }
    var password = $('input[name=Password]').val();
    if (password == 0) {
        $('input[name=Password]').attr('class', 'invalidform');
    }
    if (isValidPassword($('input[name=Password]'), $('#passvalid'), $('#validPassword1'))) {
        $('input[name=Password]').css('border', '1px solid #d7d7d7');
        $('input[name=Password]').css('border-radius', '5px');
        $('input[name=Password]').attr('class', 'validform');
        $('#passvalid').html('');
    } else {
        $('input[name=Password]').css('border', '2px solid #FF0026');
        $('input[name=Password]').css('border-radius', '5px');
        $('input[name=Password]').attr('class', 'invalidform');

    }
    var passwordrep = $('input[name=PasswordReply]').val();
    if (passwordrep == 0) {
        $('input[name=PasswordReply]').css('border', '2px solid #FF0026');
        $('input[name=PasswordReply]').css('border-radius', '5px');
        $('input[name=PasswordReply]').attr('class', 'invalidform');

    } else {
        $('input[name=PasswordReply]').css('border', '1px solid #d7d7d7');
        $('input[name=PasswordReply]').css('border-radius', '5px');
        $('input[name=PasswordReply]').attr('class', 'validform');
        $('#passrepvalid').html('');
    }
    if (password!=passwordrep) {
        $('input[name=PasswordReply]').css('border', '2px solid #FF0026');
        $('input[name=PasswordReply]').css('border-radius', '5px');
        $('#passrepvalid').html('Passwörter sind nicht identisch');
        $('input[name=PasswordReply]').attr('class', 'invalidform');
    } else {
        $('input[name=PasswordReply]').css('border', '1px solid #d7d7d7');
        $('input[name=PasswordReply]').css('border-radius', '5px');
        $('input[name=PasswordReply]').attr('class', 'validform');
        $('#passrepvalid').html('');
    }
    var check = $("#IAgry").is(':checked');
    if (check == false) {
        $('#statusErrorReg').append('Sie haben den Teilnahmebedingungen nicht zugestimmt<br>');
    }
    if (!isValidEmailAddress(email)) {
        if (email != 0) {
            $('input[name=Email]').css('border', '2px solid #FF0026');
            $('input[name=Email]').css('border-radius', '5px');
            $('#emailvalid').html('Ihre E-Mail Adresse ist falsch');
            $('input[name=Email]').attr('class', 'invalidform');
        }
    }
    if(password!=0 && passwordrep!=0 && name!=0 && email!=0 && phone!=0 && check == true && password==passwordrep && isValidPassword($('input[name=Password]'), $('#passvalid'), $('#validPassword1'))&& name.length<51 && login.length>3 && login.length<16) {
        if (isValidEmailAddress(email)) {
            var formData = $('#formregistration');
            $.ajax({
                type: "POST",
                url: '/registration',
                data: formData.serialize(),
                success: function (data) {
                    if (data.search('Ok') !== -1) {
                        $("#regSuchess").css('display', 'block');
                        $("#ChekBlock").css('display', 'none');
                    } else {
                        $('#emailvalid').html(' ');
                        $('#loginvalid').html(' ');
                        if(data.search('E-Mail') !== -1) {
                            $('#emailvalid').html('Diese E-Mail Adresse ist schon vergeben');
                            $('input[name=Email]').css('border', '2px solid #FF0026');
                            $('input[name=Email]').css('border-radius', '5px');
                            $("#validEmail").css({
                                "background-image": "url('images/no.png')"
                            });
                        }else if(data.search('two') !== -1){
                            $('#emailvalid').html('Diese E-Mail Adresse ist schon vergeben');
                            $('input[name=Email]').css('border', '2px solid #FF0026');
                            $('input[name=Email]').css('border-radius', '5px');
                            $("#validEmail").css({
                                "background-image": "url('images/no.png')"
                            });
                            $('input[name=Login]').css('border', '2px solid #FF0026');
                            $('input[name=Login]').css('border-radius', '5px');
                            $('#loginvalid').html('Dieser Benutzername ist schon vergeben');
                            $("#validLogin").css({
                                "background-image": "url('images/no.png')"
                            });
                        }else{
                            $('input[name=Login]').css('border', '2px solid #FF0026');
                            $('input[name=Login]').css('border-radius', '5px');
                            $('#loginvalid').html('Dieser Benutzername ist schon vergeben');
                            $("#validLogin").css({
                                "background-image": "url('images/no.png')"
                            });
                        }
                    }
                }
            });
        }
    }
}
function callus(){
    var chek=true;
    var email=$('[name="Email"]').val();
    $('form[id="callusform"]').find('input').not('[type="submit"]').not('[type="hidden"]').not('[class="fileInputText"]').each(function() {
        if (this.value == 0){
            $(this).css("box-shadow", "0 0 5px red");
            $(this).prev().append('<span>Das Feld ist nicht ausgefüllt</span>');
            chek=false;
        }
    });
    if (!isValidEmailAddress(email)){
        $('[name="Email"]').prev().append('<span>Ihre E-Mail Adresse ist falsch</span>');
    }
    if (isValidEmailAddress(email) && chek==true) {
        var formData = $('#callusform');
        $.ajax({
            type: "POST",
            url: '/call-us',
            data: formData.serialize(),
            success: function (data) {
                $('form[id="callusform"]').find('input, textarea').not('[type="submit"]').not('[type="hidden"]').each(function() {
                    $(this).css("box-shadow", "none");
                    $(this).val('');
                    $(this).prev().children().remove();
                });
                $("#validEmail").css({
                    "background-image": "none"
                });
                $('#BlockKotnAll').css('display', 'none');
                $('#regSuchess').css('display', 'block');
            },
            error: function (e) {
                console.log(e);
            }
        });
    }
}
function enter() {
    $('#statusError').html(' ');
    var name = $('input[name=j_username]').val();
    if (name == 0) {
        $('input[name=j_username]').css('border', '2px solid #FF0026');
        $('input[name=j_username]').css('border-radius', '5px');
        $('#statusError').html('Benutzername ist nicht angegeben<br>');
    } else {
        $('input[name=j_username]').css('border', '1px solid #d7d7d7');
        $('input[name=j_username]').css('border-radius', '5px');
    }

    var password = $('input[name=j_password]').val();
    if (password == 0) {
        $('input[name=j_password]').css('border', '2px solid #FF0026');
        $('input[name=j_password]').css('border-radius', '5px');
        $('#statusError').append('Passwort ist nicht angegeben<br>');
    } else {
        $('input[name=j_password]').css('border', '1px solid #d7d7d7');
        $('input[name=j_password]').css('border-radius', '5px');
    }
    if(password!=0 && name!=0){
        var form=document.getElementById('enterform');
        $('input[name=j_password]').css('border', '1px solid #d7d7d7');
        $('input[name=j_password]').css('border-radius', '5px');
        $('input[name=j_username]').css('border', '1px solid #d7d7d7');
        $('input[name=j_username]').css('border-radius', '5px');
        form.submit();
    }
}
function submitskype(){
    $('#SkypeSend').css('border', '1px solid #d7d7d7');
    $('#SkypeSend').css('border-radius', '5px');
    if($('#SkypeSend').val()!=0) {
        document.getElementById('deposit').value = document.getElementById('depositonly').checked;
        document.getElementById('skype').value = document.getElementById('SkypeSend').value;
        if (document.getElementById('depositonly').checked == true) {
            var formData = $('#skypeform');
            $.ajax({
                type: "POST",
                url: '/submit-skype',
                data: formData.serialize(),
                success: function (data) {
                    $('#depositonly').attr('type', 'hidden');
                    $('#checkbox').css('display', 'block');
                    $('#BlockSkype').css('display', 'none');
                    $('#skypetext').html(data);
                }
            });
        }
    }else{
        $('#SkypeSend').css('border', '2px solid #FF0026');
        $('#SkypeSend').css('border-radius', '5px');
        $('#SkypeSend').attr('class', 'invalidform');
        $('#SkypeSend').attr('placeholder', 'Geben Sie Ihr Skype an');
    }
}
function requeststar(){
    var name = $('input[name=Name]').val();
    if (name == 0) {
        $('input[name=Name]').attr('class', 'invalidform');
        $('input[name=Name]').css('border', '2px solid #FF0026');
        $('input[name=Name]').css('border-radius', '5px');
    }
    var email = $('input[name=Email]').val();
    if (email == 0) {
        $('input[name=Email]').css('border', '2px solid #FF0026');
        $('input[name=Email]').css('border-radius', '5px');
        $('input[name=Email]').attr('class', 'invalidform');
    }
    if(name!=0 && email!=0) {
        if (isValidEmailAddress(email)) {
            var formData = $('#requestStar');
            $.ajax({
                type: "POST",
                url: '/request-star',
                data: formData.serialize(),
                success: function (data) {
                    $('input[name=Email]').val('');
                    $('input[name=Name]').val('');
                    $('#request1').css("display", "none");
                    $('#request2').css("display", "block");
                }
            });
        }
    }
}

function requeststarsrch(){
    var name = $('input[name=Namerem]').val();
    if (name == 0) {
        //$('input[name=Namerem]').attr('class', 'invalidform');
        $('input[name=Namerem]').css('border', '2px solid #FF0026');
        $('input[name=Namerem]').css('height', '39px');
        $('input[name=Namerem]').css('border-radius', '5px');
    }
    var email = $('input[name=Emailrem]').val();
    if (email == 0) {
        $('input[name=Emailrem]').css('border', '2px solid #FF0026');
        $('input[name=Emailrem]').css('height', '39px');
        $('input[name=Emailrem]').css('border-radius', '5px');
        //$('input[name=Emailrem]').attr('class', 'invalidform');
    }
    if(name!=0 && email!=0) {
        if (isValidEmailAddress(email)) {
            var formData = $('#requestStarSrch');
            $.ajax({
                type: "POST",
                url: '/request-star-srch',
                data: formData.serialize(),
                success: function (data) {
                    $('input[name=Emailrem]').val('');
                    $('input[name=Namerem]').val('');
                    $('#NameModalsrch').css("display", "none");
                    $('.srch').css("display", "none");
                    $('#NameModalsrch2').css("display", "block");
                }
            });
        }
    }
}

function statusON(){
    document.getElementById('status').value=false;
    document.getElementById('statusBut').value=false;
    var formData = $('#statusform');
    $.ajax({
        type: "POST",
        url: '/send-status',
        data: formData.serialize(),
        success: function (data) {
        }
    });
    document.getElementById('ButtonTurneOn').style.display ='none';
    document.getElementById('ButtonTurneOf').style.display ='block';
}
function statusOF(){
    document.getElementById('status').value=true;
    document.getElementById('statusBut').value=true;
    var formData = $('#statusform');
    $.ajax({
        type: "POST",
        url: '/send-status',
        data: formData.serialize(),
        success: function (data) {
        }
    });
    document.getElementById('ButtonTurneOn').style.display ='block';
    document.getElementById('ButtonTurneOf').style.display ='none';
}
function recover() {
    $('#statusRecoverError').html(' ');
    var name = $('input[name=email]').val();
    if (name == 0) {
        $('input[name=email]').css('border', '2px solid #FF0026');
        $('input[name=email]').css('border-radius', '5px');
        $('#statusRecoverError').html('Geben Sie Ihre E-Mail Adresse an');
    } else {
        var formData = $('#recoverform');
        $.ajax({
            type: "POST",
            url: '/recover-password',
            data: formData.serialize(),
            success: function (data) {
                $('input[name=email]').val('');
                $('#statusRecoverError').html(data);
                $("#statusRecoverError").css('display', 'inline-block');
            }
        });
        $('input[name=email]').css('border', '1px solid #d7d7d7');
        $('input[name=email]').css('border-radius', '5px');
        $('#statusRecoverError').html(' ');
    }

}

function editcabinet() {
    $('#statusErrorCabinet').html(' ');
    var name = $('input[name=Name]').val();
    if (name == 0) {
        $('input[name=Name]').css('border', '2px solid #FF0026');
        $('input[name=Name]').css('border-radius', '5px');
        $('#statusErrorCabinet').html('geben Sie Ihr Vorname und Nachname an');
    }
    var alias = $('input[name=Alias]').val();
    if (alias == 0) {
        $('input[name=Alias]').css('border', '2px solid #FF0026');
        $('input[name=Alias]').css('border-radius', '5px');
        $('#statusErrorCabinet').html('geben Sie Ihr Nickname an ');
    }
    var email = $('input[name=Email]').val();
    if (email == 0) {
        $('input[name=Email]').css('border', '2px solid #FF0026');
        $('input[name=Email]').css('border-radius', '5px');
        $('#statusErrorCabinet').html('Geben Sie Ihre E-Mail Adresse an');
    }
    var phone = $('input[name=Phone]').val();
    if (phone == 0) {
        $('input[name=Phone]').css('border', '2px solid #FF0026');
        $('input[name=Phone]').css('border-radius', '5px');
        $('#statusErrorCabinet').html('Geben Sie Ihr Handynummer an');
    }
    var price = $('input[name=Price]').val();
    if (price == 0) {
        $('input[name=Price]').css('border', '2px solid #FF0026');
        $('input[name=Price]').css('border-radius', '5px');
        $('#statusErrorCabinet').html('Geben Sie den Preis pro Video an');
    }
    var chekskype=$('input[name=depositonly]').is(':checked');
    var skype=$('input[name=Skype]').val();
    if (chekskype==false && skype==0){
        $('input[name=Skype]').css('border', '2px solid #FF0026');
        $('input[name=Skype]').css('border-radius', '5px');
        $('#statusErrorCabinet').html('Geben Sie Ihr Skype an');
        return;
    }
    if(name != 0 && alias!=0 && email!=0 && price!=0 && phone!=0 ) {
        if (isValidEmailAddress(email)) {
            var formData = $('#cabinetform');

            /*var ch='';
            var x = document.getElementById("MyProjects");
            var j = 0;
            alert(x);
            for (var i = 0; i < x.options.length; i++) {

                if (x.options[i].selected == true) {
                    j += 1;
                    if (i > 0 && i < x.options.length) {
                        ch += ",";
                    }
                    ch += x.options[i].value;

                }
            }
            alert(ch);
            var inputch = $("<input>")
                .attr("type", "checkbox")
                .attr("name", "MyProjects2[]").val('['+ch+']');
            formData.append(inputch);*/

            $.ajax({
                type: "POST",
                url: '/edit-star',
                data: formData.serialize(),
                success: function (data) {
                    var datacrop=data.replace(/\s+/g, '');
                    if(datacrop == 'editname'){
                        /*alert("Вы изменили логин! Войдите под новым логином.");
                        document.location.href='/#login';*/
                    }else if(datacrop == 'emailerror'){
                        $('#statusErrorCabinet').html("Diese E-Mail Adresse ist schon vorhanden");
                        $("#statusErrorCabinet").css('display', 'inline-block');
                    }else{
                        $('#statusErrorCabinet').html(data);
                        $("#statusErrorCabinet").css('display', 'inline-block');
                    }
                },
                error: function (e) {
                        console.log(e);
                }
            });
            $('input[name=Name]').css('border', '1px solid #d7d7d7');
            $('input[name=Name]').css('border-radius', '5px');
            $('input[name=Alias]').css('border', '1px solid #d7d7d7');
            $('input[name=Alias]').css('border-radius', '5px');
            $('input[name=Email]').css('border', '1px solid #d7d7d7');
            $('input[name=Email]').css('border-radius', '5px');
            $('input[name=Skype]').css('border', '1px solid #d7d7d7');
            $('input[name=Skype]').css('border-radius', '5px');
            $('input[name=Phone]').css('border', '1px solid #d7d7d7');
            $('input[name=Phone]').css('border-radius', '5px');
            $('input[name=Price]').css('border', '1px solid #d7d7d7');
            $('input[name=Price]').css('border-radius', '5px');
            $("#validPassword").css({
                "background-image": "none"
            });
        }else{
            $('#statusErrorCabinet').html('Die E-Mail Adresse wurde falsch angegeben');
        }
    }

}
function editPhoto() {
            var formData =  new FormData($('#photoform')[0]);
            $.ajax({
                type: "POST",
                url: '/cabinet',
                enctype: "multipart/form-data",
                contentType: false,
                processData: false,
                cache: false,
                data: formData,
                success: function (data) {
                    jcrop_api.setImage("/starSource/default.png"+ '?' + new Date().getTime());
                    document.location.href='#photomodal';
                },
                error: function (e) {
                    console.log(e);
                }
            });

}




function editVideo() {
    var formData =  new FormData($('#videoform')[0]);
    $.ajax({
    type: "POST",
        url: '/video-upload',
        enctype: "multipart/form-data",
        contentType: false,
        processData: false,
        cache: false,
        data: formData,
        success: function (data) {
    },
    error: function (e) {
        console.log(e);
    }
});
}
function sendOrderByName() {
    $('#statusErrorModal').html(' ');

    var name = $('input[name=NameModal]').val();
    if (name == 0) {
        $('input[name=NameModal]').css('border', '2px solid #FF0026');
        $('input[name=NameModal]').css('border-radius', '2px');
        $('#statusErrorModal').html('Nachrname ist nicht angegeben<br>');
    } else {
        $('input[name=EmailModal]').css('border', '1px solid #ccc');
        $('input[name=EmailModal]').css('border-radius', '4px');
        $("#validEmailModal").css({
            "background-image": "none"
        });
    }

    var phone = $('input[name=PhoneModal]').val();
    if (phone == 0) {
        $('input[name=PhoneModal]').css('border', '2px solid #FF0026');
        $('input[name=PhoneModal]').css('border-radius', '2px');
        $('#statusErrorModal').append('Handynummer ist nicht angegeben<br>');
    } else {
        $('input[name=EmailModal]').css('border', '1px solid #ccc');
        $('input[name=EmailModal]').css('border-radius', '4px');
        $("#validEmailModal").css({
            "background-image": "none"
        });
    }

    var email = $('input[name=EmailModal]').val();
    if (email == 0) {
        $('input[name=EmailModal]').css('border', '2px solid #FF0026');
        $('input[name=EmailModal]').css('border-radius', '2px');
        $('#statusErrorModal').append('E-Mail Adresse ist nicht angegeben');
        return;
    } else {
        $('input[name=EmailModal]').css('border', '1px solid #ccc');
        $('input[name=EmailModal]').css('border-radius', '4px');
        $("#validEmailIndexTest").css({
            "background-image": "none"
        });
    }

    if (isValidEmailAddress(email)) {
        if (phone != 0 && name != 0) {
            var formData = $('#formModal');
            $.ajax({
                type: "POST",
                url: '/ordermodal',
                data: formData.serialize(),
                success: function (data) {
                    $('input[name=PhoneModal]').val('');
                    $('input[name=EmailModal]').val('');
                    $('input[name=NameModal]').val('');
                    $("#EmailModal").css({
                        "background-image": "none"
                    });
                    $('#statusErrorModal').html(data);
                    $("#statusErrorModal").css('display', 'block');
                }
            });

        }
    } else {
        $('input[name=EmailModal]').css('border', '2px solid #FF0026');
        $('input[name=EmailModal]').css('border-radius', '2px');
        $('#statusErrorModal').append('Die E-Mail Adresse ist unkorrekt!');
    }
}

function freeConsulting() {
    $('#statusErrorFre').html(' ');

    var name = $('input[name=NameFree]').val();
    if (name == 0) {
        $('input[name=NameFree]').css('border', '2px solid #FF0026');
        $('input[name=NameFree]').css('border-radius', '2px');
        $('#statusErrorFree').html('Nachrname ist nicht angegeben<br>');
    } else {
        $('input[name=EmailFree]').css('border', '1px solid #ccc');
        $('input[name=EmailFree]').css('border-radius', '4px');
        $("#validEmailFree").css({
            "background-image": "none"
        });
    }

    var phone = $('input[name=PhoneFree]').val();
    if (phone == 0) {
        $('input[name=PhoneFree]').css('border', '2px solid #FF0026');
        $('input[name=PhoneFree]').css('border-radius', '2px');
        $('#statusErrorFree').append('Handynummer ist nicht angegeben<br>');
    } else {
        $('input[name=EmailFree]').css('border', '1px solid #ccc');
        $('input[name=EmailFree]').css('border-radius', '4px');
        $("#validEmailFree").css({
            "background-image": "none"
        });
    }

    var email = $('input[name=EmailFree]').val();
    if (email == 0) {
        $('input[name=EmailFree]').css('border', '2px solid #FF0026');
        $('input[name=EmailFree]').css('border-radius', '2px');
        $('#statusErrorFree').append('E-Mail Adresse ist nicht angegeben');
        return;
    } else {
        $('input[name=EmailFree]').css('border', '1px solid #ccc');
        $('input[name=EmailFree]').css('border-radius', '4px');
        $("#validEmailFree").css({
            "background-image": "none"
        });
    }

    if (isValidEmailAddress(email)) {
        if (phone != 0 && name != 0) {
            var formData = $('#formFreeConsulting');
            $.ajax({
                type: "POST",
                url: '/freeConsulting',
                data: formData.serialize(),
                success: function (data) {
                    $('input[name=PhoneFree]').val('');
                    $('input[name=EmailFree]').val('');
                    $('input[name=NameFree]').val('');
                    $("#EmailFree").css({
                        "background-image": "none"
                    });
                    $('#statusErrorFree').html(data);
                    $("#statusErrorFree").css('display', 'block');
                }
            });

        }
    } else {
        $('input[name=EmailFree]').css('border', '2px solid #FF0026');
        $('input[name=EmailFree]').css('border-radius', '2px');
        $('#statusErrorFree').append('Die E-Mail Adresse ist unkorrekt!');
    }
}
function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
    return pattern.test(emailAddress);
}
function isValidPassword(password, block, valid){
    var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
    var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
    var enoughRegex = new RegExp("(?=.{6,}).*", "g");
    if (false == enoughRegex.test(password.val())) {
        block.html('Paswort hat weniger als 4 Symbole');
        password.css('border', '2px solid #FF0026');
        password.css('border-radius', '5px');
        valid.css({
            "background-image": "url('images/no.png')"
        });
        return false;
    } else if (strongRegex.test(password.val())) {
        block.className = 'ok';
        block.html('<b style="color: green">Starkes Passwort</b>');
        password.css('border', '1px solid #d7d7d7');
        password.css('border-radius', '5px');
        valid.css({
            "background-image": "url('images/yes.png')"
        });
        return true;
    } else if (mediumRegex.test(password.val())) {
        block.className = 'alert';
        block.html('<b style="color: green">Starkes Passwort</b>');
        password.css('border', '1px solid #d7d7d7');
        password.css('border-radius', '5px');
        valid.css({
            "background-image": "url('images/yes.png')"
        });
        return true;
    } else {
        block.className = 'error';
        block.html('Schwaches Passwort');
        valid.css({
            "background-image": "url('images/no.png')"
        });
        return false;
    }
    return false;
}
function submitName(name) {
    document.getElementById("myModalLabel").textContent=name;
    document.getElementById("nameZ").value=name;
}
function closeModal() {

    $('input[name=NameModal]').val('');
    $('input[name=EmailModal]').val('');
    $('input[name=PhoneModal]').val('');
    $('input[name=EmailModal]').css('border', '1px solid #ccc');

    $('#statusErrorModal').html('');
    $('input[name=NameModal]').css('border', '1px solid #ccc');
    $('input[name=PhoneModal]').css('border', '1px solid #ccc');
    $("#validEmailModal").css({
        "background-image": "none"
    });

}
function otherCategory(select){
    if($(select).children('option:selected').text()=='andere'){
        $('#Category').css('display', 'block');
    }else {
        $('#Category').css('display', 'none');
    }
}