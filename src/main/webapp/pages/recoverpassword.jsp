<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false"%>
<div id="ChekInAll">
    <section>
        <h1><span>Hallo</span>  ${name}</h1>
        <div id="CenterPChek">geben Sie Ihr neues Passwort ein und bestätigen Sie das.</div>
    </section>
    <section>
        <div id="ChekBlock" style="margin: 0px auto; float: none;">
            <form method="POST" id="formrecover" action="/recover-password-send">
                <div><input type="hidden" name="userid" value="${id}"/></div>
                <div id="Password"><p>Passwort</p><input  class="validform" type="password" name="Password" placeholder="Geben Sie Ihr Passwort an"/><span id="validPassword1"></span><div id="passvalid" class="validmessage"></div></div>
                <div id="PasswordReply"><p>Neues Passwort wiederholen</p><input  class="validform" type="password" id="PassRep" name="PasswordReply" placeholder="Bestätigen Sie Ihr Passwort"/><span id="validPassword"></span><div id="passrepvalid" class="validmessage"></div></div>
            </form>
            <div id="Agreement">
                <div id="ButtonLoading"><a href="#" onclick="recoverpassword()">Senden</a></div>
                <div class="clr"><span style="display: inline-block; padding-right: 40px; text-align: right; width: 100%; padding-top: 15px; color: red;" id="statusErrorReg" class="modalMessage"></span></div>
            </div>
            <div class="clr"></div>
        </div>
        <div id="regSuchess">
            <p>Glückwunsch!<br>Ihr Passwort wurde geändert!</p>
            <div id="ButtonSuchess"><a href="#login">Anmelden</a></div>
        </div>
        <div class="clr"></div>
    </section>
</div>
<script>
    $('input[name=Password]').bind('input', function () {
        $('#statusErrorReg').html('');
        $('input[name=Password]').css('border', '1px solid #d7d7d7');
        $('input[name=Password]').css('border-radius', '5px');
        $('input[name=Password]').attr('class', 'validform');
        $('input[name=Password]').attr('placeholder', 'geben Sie Ihr Passwört');
        $('#passvalid').html('');
        isValidPassword($(this), $('#passvalid'), $('#validPassword1'));

    });
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
    function recoverpassword() {
        $('#statusErrorReg').html(' ');
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

        if(password!=0 && passwordrep!=0 && password==passwordrep && isValidPassword($('input[name=Password]'), $('#passvalid'), $('#validPassword1'))) {
                var formData = $('#formrecover');
                $.ajax({
                    type: "POST",
                    url: '/recover-password-send',
                    data: formData.serialize(),
                    success: function (data) {
                        if (data.search('Ok') !== -1) {
                            $("#regSuchess").css('display', 'block');
                            $("#ChekBlock").css('display', 'none');
                        }
                    }
                });
        }
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
</script>