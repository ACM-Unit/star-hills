﻿<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false"%>

<script>
    $(function () {
        $("input:checkbox").on('click', function () {

            var $box = $(this);
            if ($box.is(":checked")) {
                var group = "input:checkbox[name='" + $box.attr("name") + "']";
                $(group).prop("checked", false);
                $box.prop("checked", true);
            } else {
                $box.prop("checked", true);
            }
        });
    });
</script>
<script src="/js/audiodisplay.js"></script>
<script src="/js/recorder.js"></script>
<script src="/js/main.js"></script>
<style>
    /*html { overflow: hidden; }
    body {
        font: 14pt Arial, sans-serif;
        background: lightgrey;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        margin: 0 0;
    }*/
    canvas {
        display: inline-block;
       /* background: #c6c5ca;*/
        width: 95%;
        height: 45%;
       /* box-shadow: 0px 0px 10px #0000ff;*/
    }
#progress-wrp {
    display: none;
    border: 1px solid #0099CC;
    width: 200px;
    padding: 1px;
    position: fixed;
    right:1%;
    bottom: 0;
    border-radius: 3px;
    margin: 10px;
    text-align: left;
    background: #fff;
    box-shadow: inset 1px 3px 6px rgba(0, 0, 0, 0.12);
    z-index: 9999999;
}
#progress-wrp .progress-bar{
    height: 20px;
    border-radius: 3px;
    background-color: #00f323;
    width: 0;
    box-shadow: inset 1px 1px 10px rgba(0, 0, 0, 0.11);
}
#progress-wrp .status{
    top:3px;
    left:50%;
    position:absolute;
    display:inline-block;
    color: #000000;
}

    #wavedisplay{ margin:0px auto;}
    #audiogreeting {display: none}
    #audio {display: none}
    #controls {
        margin:0px auto;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-around;
        height: 20%;

    }
    #record { height: 10vh;  }
    #record.recording {
        /*background: red;*/
        background: -webkit-radial-gradient(center, ellipse cover, #ff0000 50%,transparent 25%,transparent 50%);
        background: -moz-radial-gradient(center, ellipse cover, #ff0000 50%,transparent 25%,transparent 50%);
        background: radial-gradient(center, ellipse cover, #ff0000 50%,transparent 25%,transparent 50%);
    }
    #viz {
        height: 80%;
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        align-items: center;
    }
    @media (orientation: landscape) {
        body { flex-direction: row;}
        #controls { flex-direction: column; height: 100%; width: 10%;}
        #viz { height: 100%; width: 90%;}
    }

</style>

<div id="Formalization">
	<section>
    	<h1><span>Video</span> bestellen</h1>
        <div id="BelowH1Bottom">Abwicklung der Bestellung – Schritt 2</div>
    </section>
</div>
<div id="FormalizationCabinet">
	<section>

    	<div id="LeftBlockForms">
            <div id="TitleTopForms">
                <p class="formaliza">Auftragsgeber</p>
                <%--<div id="ButtonTopForms"><a title="Sie können die Audioaufnahme machen und an uns senden" id="audiostzakaz" href="#load-audio" onclick="javascript: document.getElementById('audiohead').innerText='Audiobestellung'; document.getElementById('audiostatus').value = '1'; ">Audiobestellung</a></div>--%>
                <%--<span style="display: inline-block; text-align: right; width: 100%; padding-top: 15px; color: red;" id="statusErrorOrdering" class="modalMessage"></span>--%>
            </div>
            <form id="ordering">
            <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorNameOrdering" class="modalMessage">&nbsp;</span>
            <div id="BlockName2"><p>Vorname, Nachname</p><input type="text" name="NameOrdering"  /></div>
             <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorEmailOrdering" class="modalMessage">&nbsp;</span>
            <div id="Email2"><p>Email</p><input type="text" id="EmailOrdering" name="EmailOrdering"  /></div>
            <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorPhoneOrdering" class="modalMessage">&nbsp;</span>
            <div id="Phone2"><p>Handynummer</p><input type="tel" id="PhoneOrdering" name="PhoneOrdering" /></div>
            <div id="TwoTitleForms">
            	<p class="formaliza">Empfänger</p>
                <div id="ButtonTwoTitleForms1">
                    <a title="Sie können die Audioaufnahme machen und an uns senden" id="audiostzakaz" href="#load-audio" onclick="javascript: document.getElementById('audiohead').innerText='Audiobestellung'; document.getElementById('audiostatus').value = '1'; ">Audiobestellung</a>
                </div>
                <div id="ButtonTwoTitleForms1"><a  title="Sie können den Name des Empfängers aufnehmen, um die mögliche Namensfehler bei der Videoaufnahme zu vermeiden."  id="audiost" href="#load-audio" onclick="javascript: document.getElementById('audiostatus').value = '0'; document.getElementById('audiohead').innerText='Sie können den Name des Empfängers';"><marquee id="mar" scrollamount="1" behavior="alternate" width="88%">Audioaufnahme des Names</marquee></a></div>
                <div class="clr"></div>
            </div>
                <div style="width: 100%; height: 30px;">
                    <div id="ButtonTwoTitleForm"><div id="photo3"><label><p style="cursor: pointer; line-height: 2.5;">Foto des Empfängers</p>
                    <input type="file" name="file" onchange="editPhotoss()" class="file" accept="image/x-png, image/jpeg"></label></div></div>
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}" />
                    <input type="hidden"
                           name="Idstar2"
                           value="${star.id}" />
                    <input type="hidden"
                           name="filestatus"
                           id="filestatus"
                           value="0" />
                        
                </div>
                <div>
                        <div id="MethodUpOne">
                        <div id="MethodUp"><p>Art des Versandes</p></div>
                            <div id="RadioButton"><p>Email</p><input type="checkbox" name="MethodUp" value="1" checked="checked"></div>
                            <div id="RadioButton"><p>H-nummer</p><input type="checkbox" name="MethodUp" value="2"></div>
                            <div id="RadioButton"><p>Viber</p><input type="checkbox" name="MethodUp" value="3"></div>
                            <div id="RadioButton"><p>WhatsApp</p><input type="checkbox" name="MethodUp" value="4"></div>
                            <div id="RadioButton"><p>Facebook</p><input type="checkbox" name="MethodUp" value="5"></div>
                        </div>
                 </div>
                <div class="clr"></div>
            <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorNameTwoOrdering" class="modalMessage">&nbsp;</span>
            <div id="BlockName3"><p>Vorname, Nachname</p><input type="text" name="NameTwo"  /></div>
                <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorEmailTwoOrdering" class="modalMessage">&nbsp;</span>
            <div id="Email3"><p>E-Mail Adresse</p><input type="text"  id="EmailTwo" name="EmailTwo" /></div>
                <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorPhoneTwoOrdering" class="modalMessage">&nbsp;</span>
            <div id="Phone3"><p>Handynummer</p><input type="tel" id="PhoneTwo" name="PhoneTwo"  /></div>
                <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorEventOrdering" class="modalMessage">&nbsp;</span>
                <div id="Event"><p>Betreff</p><input type="text" name="Event"  /></div>
            <div id="CongratulatoryText3"><p>Angabe des Textes</p>
                <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorComplimentsOrdering" class="modalMessage">&nbsp;</span>
                <textarea name="Compliments"></textarea></div>
                <div id="DateCongratulations"><p>Datum des Verschickens</p>
                    <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorDateOrdering" class="modalMessage">&nbsp;</span>
                    <input type="text" id="datepicker" name="Date"></div>
                <div id="DateCongratulations"><p>Zeitpunkt des Verschickens</p>
                    <span style="display: inline-block; text-align: right; width: 100%; color: red;" id="statusErrorTimeOrdering" class="modalMessage">&nbsp;</span>
                    <input type="text" name="Time" class="timepicker" id="timepicker"></div>
            <input type="hidden" name="Price" value="${(star.price)*3}">
                <input type="hidden" name="Idorder" id="idorder" value="0" >
            <input type="hidden" name="audiosent" id="audiosent" value="no" >
            </form>
            <div class="clr"></div>
            <div id="videorecord" class="remodal" data-remodal-id="load-audio" >
                <div id="loadvideos" style="max-width: 650px; margin-top: 20px;">
                    <div id="audiohead"></div>
                    <div id="select">
                        <form method="POST" id="videoform" action="/audio-upload" onChange="editAudio()" enctype="multipart/form-data">
                            <div id="videofile"><div id="videoupload">
                                <input type="file" name="file" id="upload" class="remodal-close1" accept="audio/*" onclick="javascript: window.location = '#'" >Datei hochladen
                                <input type="hidden"
                                       name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                                <input type="hidden"
                                       name="idstar"
                                       id="starid"
                                       value="${star.id}" />
                                <input type="hidden"
                                       name="idorder"
                                       id="orderid"
                                       value="" />
                                <input type="hidden"
                                       name="audiostatus"
                                       id="audiostatus"
                                       value="" />
                                <input type="hidden"
                                       id="video"
                                       value="" />
                                <input type="hidden"
                                       id="videoplay"
                                       value="" />
                            </div></div>
                        </form>
                        <%-- <button id="upload">
                             Загрузить файл
                         </button>--%>
                        <div id="requestblock">
                            <button id="request">
                                Audioaufnahme
                            </button>
                        </div>
                    </div>
                    <div id="records">
                        <div id="viz">
                            <canvas id="analyser" width="1024" height="200"></canvas>
                        </div>
                        <div id="controls">
                            <img id="record" src="images/mic128.png" onclick="toggleRecording(this);">
                            <div id="timer" style="display:none"><span id="minutes">00</span>:<span id="seconds">00</span></div>
                            <p style="width: 300px;">Klicken Sie auf das Mikrofon, um die Audioaufnahme zu starten</p>
                        </div>
                        <canvas id="wavedisplay" width="1024" height="200"></canvas>
                        <audio id="audioname" style="margin: auto;">
                        </audio>
                        <audio id="audiogreeting" style="margin: auto;">
                        </audio>
                        <div id="SuccessMessage"></div>
                    </div>
                    <script type="text/javascript">
                        var audiostatus, audio, content, audioplay, reqBtn, record, sendBtn, playBtn, stopBtn, ul, stream, recorder, vid, recordedBlobs;
                        audio = document.getElementById('audio');
                        audioplay = document.getElementById('audioplay');
                        reqBtn = document.getElementById('request');
                        starID = document.getElementById('starid').value;
                        record = document.getElementById('records');
                        select = document.getElementById('select');
                        ul = document.getElementById('ul');
                        reqBtn.onclick = requestAudio;

                        function requestAudio() {
                            $('#select').css('display', 'none');
                            $('#records').css('display', 'block');
                            $('#record').css('display', 'block');
                            $('#analyser').css('display', 'block');
                            $('#wavedisplay').css('display', 'block');
                        }
                        function audioclose(){
                            $('#select').css('display', 'block');
                            $('#records').css('display', 'none');
                            $('#record').css('display', 'none');
                            $('#analyser').css('display', 'none');
                            $('#wavedisplay').css('display', 'none');
                            $('#audioname').css('display', 'none');
                            $('#audiogreeting').css('display', 'none');
                            document.getElementById('timer').style.display = 'none';
                            $("#SuccessMessage").html(' ');
                            var canvas = document.getElementById("wavedisplay");
                            var context = canvas.getContext('2d');
                            context.clearRect(0, 0, canvas.width, canvas.height);
                            stopRecording(document.getElementById('record'));
                            var audiostatus = document.getElementById('audiostatus').value;
                            var audio = $("#audioname");
                            $("#sourceaudioname").attr("src", "");
                            audio[0].stop();
                            var audiogreet = $("#audiogreeting");
                            audiogreet.attr("src", "");
                            audiogreet[0].stop();

                        }


                        function editAudio() {
                            $(document).ajaxStart(function () {
                                $(".modalWaiting").css("display", "none");
                            });
                            $("#progress-wrp").css("display", "block");
                            document.getElementById('orderid').value = document.getElementById('idorder').value;
                            orderID = document.getElementById('orderid').value;
                            var formData =  new FormData($('#videoform')[0]);
                            $.ajax({
                                type: "POST",
                                url: '/audio-upload',
                                enctype: "multipart/form-data",
                                contentType: false,
                                processData: false,
                                cache: false,
                                data: formData,
                                success: function (data) {
                                    $("#progress-wrp").css("display", "none");
                                    var datacrop=data.replace(/\s+/g, '');
                                    $("#idorder").val(datacrop);
                                    audiostatus = document.getElementById('audiostatus').value;
                                    if(audiostatus != 0 ) {

                                        var sent = "sent";
                                        $('input[name=audiosent]').val(sent);

                                        $("#statusSuccessMessage").html("Audioaufnahme wurde erfolgreich hochgeladen, wenn " +
                                                "Sie die Aufnahmen wiederholen wollen, dann drücken Sie auf „wiederholen“ und Ihre Audioaufnahme wird ersetzt. " +
                                                "Bitte vergessen Sie nicht die Pflichtfelder, wie E-Mail Adresse, Handynummer, Datum und Zeitpunkt des Verschickens, auszufüllen.");
                                        window.location = "#successUp";
                                        $("#audiostzakaz").html("Wiederholen");
                                        /*$('#statusErrorOrdering').html('Заполните обязательные поля ');*/

                                        $('input[name=NameOrdering]').css('border', '1px solid #d7d7d7');
                                        $('#statusErrorNameOrdering').html('&nbsp;');
                                        /*$('input[name=NameTwo]').css('border', '1px solid #d7d7d7');
                                        $('#statusErrorNameTwoOrdering').html('&nbsp;');*/
                                        $('input[name=Event]').css('border', '1px solid #d7d7d7');
                                        $('#statusErrorEventOrdering').html('&nbsp;');
                                        $('textarea[name=Compliments]').css('border', '1px solid #d7d7d7');
                                        $('#statusErrorComplimentsOrdering').html('&nbsp;');
                                        var email1 = $("#EmailOrdering").val();

                                        if (email1 != 0) {
                                            if (isValidEmailAddress(email)) {
                                                $('input[name=EmailOrdering]').css('border', '1px solid #d7d7d7');
                                                $('input[name=EmailOrdering]').css('border-radius', '5px');
                                                $('#statusErrorEmailOrdering').html('&nbsp;');
                                            } else {
                                                $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
                                                $('input[name=EmailOrdering]').css('border-radius', '5px');
                                                $('#statusErrorEmailOrdering').html('Geben Sie Ihre E-Mail Adresse an');
                                            }
                                        } else {
                                            $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
                                            $('input[name=EmailOrdering]').css('border-radius', '5px');
                                            $('#statusErrorEmailOrdering').html('Geben Sie Ihre E-Mail Adresse an');
                                        }

                                        var email2 = $("#EmailTwo").val();
                                        var chbox2 = $( 'input[name="MethodUp"]:checked' ).val();
                                        if (email2 != 0 && chbox2 == 1) {
                                            if (isValidEmailAddress(email)) {
                                                $('input[name=EmailTwo]').css('border', '1px solid #d7d7d7');
                                                $('input[name=EmailTwo]').css('border-radius', '5px');
                                                $('#statusErrorEmailTwoOrderingOrdering').html('&nbsp;');
                                            } else {
                                                $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
                                                $('input[name=EmailTwo]').css('border-radius', '5px');
                                                $('#statusErrorEmailTwoOrdering').html('Geben Sie E-Mail Adresse des Empfängers an oder wählen Sie eine andere Art des Verschickens aus.');
                                            }
                                        } else {
                                            $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
                                            $('input[name=EmailTwo]').css('border-radius', '5px');
                                             $('#statusErrorEmailTwoOrdering').html('Geben Sie E-Mail Adresse des Empfängers an oder wählen Sie eine andere Art des Verschickens aus.');
                                        }

                                        var PhoneOrdering1 = $('input[name=PhoneOrdering]').val();
                                        if (PhoneOrdering1 != 0) {
                                            $('input[name=PhoneOrdering]').css('border', '1px solid #d7d7d7');
                                            $('input[name=PhoneOrdering]').css('border-radius', '5px');
                                            $('#statusErrorPhoneOrdering').html('&nbsp;');
                                        } else {
                                            $('input[name=PhoneOrdering]').css('border', '2px solid #FF0026');
                                            $('input[name=PhoneOrdering]').css('border-radius', '5px');
                                            $('#statusErrorPhoneOrdering').html('Geben Sie Ihr Handynummer an');

                                        }
                                        var PhoneTwo1 = $('input[name=PhoneTwo]').val();
                                        if (PhoneTwo1 != 0) {
                                            $('input[name=PhoneTwo]').css('border', '1px solid #d7d7d7');
                                            $('input[name=PhoneTwo]').css('border-radius', '5px');
                                            $('#statusErrorPhoneTwoOrderingOrdering').html('&nbsp;');
                                        } else {
                                            $('input[name=PhoneTwo]').css('border', '2px solid #FF0026');
                                            $('input[name=PhoneTwo]').css('border-radius', '5px');
                                            $('#statusErrorPhoneTwoOrdering').html('Geben Sie die Handynummer des Empfänders an');

                                        }

                                        var Date1 = $('input[name=Date]').val();
                                        if (Date1 != 0) {
                                            $('input[name=Date]').css('border', '1px solid #d7d7d7');
                                            $('input[name=Date]').css('border-radius', '5px');
                                            $('#statusErrorDateOrdering').html('&nbsp;');
                                        } else {
                                            $('input[name=Date]').css('border', '2px solid #FF0026');
                                            $('input[name=Date]').css('border-radius', '5px');
                                            $('#statusErrorDateOrdering').html('Geben Sie die Handynummer des Empfänders an');

                                        }


                                        var Time1 = $('input[name=Time]').val();
                                        if (Time1 != 0) {
                                            $('input[name=Time]').css('border', '1px solid #d7d7d7');
                                            $('input[name=Time]').css('border-radius', '5px');
                                            $('#statusErrorTimeOrdering').html('&nbsp;');
                                        } else {
                                            $('input[name=Time]').css('border', '2px solid #FF0026');
                                            $('input[name=Time]').css('border-radius', '5px');
                                            $('#statusErrorTimeOrdering').html('Geben Sie den Zeitpunkt des Verschickens an');

                                        }

                                        var nameTwo1 = $('input[name=NameTwo]').val();
                                    if(nameTwo1 !=0){
                                        $('input[name=NameTwo]').css('border', '1px solid #d7d7d7');
                                        $('input[name=NameTwo]').css('border-radius', '5px');
                                        $('#statusErrorNameTwoOrdering').html('&nbsp;');
                                    } else {
                                        $('input[name=NameTwo]').css('border', '2px solid #FF0026');
                                        $('input[name=NameTwo]').css('border-radius', '5px');
                                        $('#statusErrorNameTwoOrdering').html('Geben Sie den Vor- und Nachname des Empfängers');

                                    }

                                    }else{

                                        $("#statusSuccessMessage").html("Audioaufnahme mit Empfängername wurde erfolgreich hochgeladen, wenn Sie die Aufnahmen wiederholen wollen, " +
                                                "dann drücken Sie auf „wiederholen“ und Ihre Audioaufnahme wird ersetzt. " +
                                                "Bitte vergessen Sie nicht die Pflichtfelder, wie E-Mail Adresse, Handynummer, Datum und Zeitpunkt des Verschickens, auszufüllen.");
                                        $("#audiost").html("Перезаписать");
                                      /*  $('#statusErrorOrdering').html('Заполните обязательные поля ');*/
                                        window.location = "#successUp";

                                    }


                                },
                                error: function (e) {
                                    $("#filename").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
                                    $("#statusSuccessMessage").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
                                    window.location  = "#successUp";
                                    console.log(e);
                                },
                                xhr: function() {
                                    var xhr = new window.XMLHttpRequest();

                                    // Upload progress
                                    xhr.upload.addEventListener("progress", function(oEvent) {
                                        if (oEvent.lengthComputable) {
                                            var percent = 0;
                                            var position = oEvent.loaded || oEvent.position;
                                            var total = oEvent.total;
                                            percent = Math.ceil(position / total * 100);
                                            //update progressbar
                                            $(".progress-bar").css("width", +percent + "%");
                                            $(".status").text(percent + "%");
                                        }
                                    }, false);
                                    return xhr;
                                },
                            });
                        }
                        function deletefile() {
                            var formData = $('#vidfile');
                            $.ajax({
                                type: "POST",
                                url: '/delete-video-confirm',
                                data: formData.serialize(),
                                success: function (data) {
                                    $("#vidfile").css("display", "none");
                                    $("#filename").html('Video wurde gelöscht!');
                                    $("#filedelete").val('');
                                },
                                error: function (e) {
                                    console.log(e);
                                }
                            });

                        }
                    </script>

                </div>
            </div>
        </div>
        <div id="RightBlockCabinet">
        	<div id="BlockPerson">
            	<div id="FotoFamosPerson"><img src="/starSource/${star.id}/mainphoto.png"></div>
                <div id="NamePerson"><p>Star</p><p class="Marker">${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></p></div>
                <div class="clr"></div>
                <div id="PricePerson"><p>Preis</p><p class="Marker"><span>${(star.price)*3}&#8364;</span></p></div>
                <div class="clr"></div>
                <div id="VideoPerson"><p>Video</p><p class="Marker">1 Minuten</p></div>
                <div class="clr"></div>
            </div>
            <div id="ButtonOrderCabinet">
            	<div class="PrezentCabinet"></div>
                <a id="button" onclick="ordering()">Bestellen</a>
            </div>


        </div>

        <div class="remodal" style="width: 95%" data-remodal-id="paymentmodal" >
            <%--<button data-remodal-action="close" class="remodal-close"></button>--%>

            <div id="statusErrorOrderingModal">
                <p>Ihre Bestellung war erfolgreich! Bitte wählen Sie die Zahlungsart.</p>
                <div id="buttonpay">
                <div id="blockpay1">
                <form name="_xclick" action="https://www.paypal.com/de/cgi-bin/webscr" method="post">
                    <input type="hidden" name="cmd" value="_xclick">
                    <input type="hidden" name="business" value="dima.schaible@googlemail.com">
                    <input type="hidden" name="currency_code" value="EUR">
                    <input type="hidden" name="item_name" value="0">
                    <input type="hidden" name="item_number" value="0">
                    <input type="hidden" name="return" value="0">
                    <input type="hidden" name="amount" value="${(star.price)*3}">
                    <input type="image" src="/images/paypal.png"  name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
                </form>
                </div>
                <div id="blockpay2">
                <!-- SOFORT Überweisung -->
                <form method="post" action="https://www.sofort.com/payment/start">
                    <input type="hidden" name="user_id" value="133738" />
                    <input type="hidden" name="project_id" value="292118" />
                    <input type="hidden" name="user_variable_1" value="0" />
                    <input type="hidden" name="user_variable_2" value="successfulordering" />
                    <input type="hidden" name="user_variable_3" value="0" />
                    <input type="hidden" name="reason_1" value="Test-Überweisung" />
                    <input type="hidden" name="reason_2" value="Bestellnummer" />
                    <input type="hidden" name="amount" value="${(star.price)*3}" />
                    <input type="image" name="submit"  src="/images/sofort.png"  value="Absenden" />
                </form>
                <!-- SOFORT Überweisung -->
                </div>


                    <div id="blockpay3">
                        <form action="/stripe" method="POST">


                          <script src="https://checkout.stripe.com/checkout.js"></script>

                            <input type="image" class="customButton" onclick="javascript: window.location = '#'" src="/images/master.png"/>
                            <input type="image" class="customButton" onclick="javascript: window.location = '#'" src="/images/visa.png"/>

                          <script>
                              var handler = StripeCheckout.configure({
                                  key: 'pk_test_KLw0U7D5N6VQBbiAWnkYt2fW',
                                  image: 'images/LogoRound.png',
                                  locale: 'auto',
                                  token: function(token) {
                                      // You can access the token ID with `token.id`.
                                      // Get the token ID to your server-side code for use.
                                      var idOrder2 = $('input[name=item_name]').val();
                                      $.post("/stripe", { stripeToken: token.id, id: idOrder2, amount: ${star.price*100} }, function( data ) {
                                          //location.href = '/charity';}
                                          location.href = '/successfulordering?id=' + idOrder2;
                                      });


                                  }
                              });

                              $('.customButton').on('click', function(e) {
                                  // Open Checkout with further options:

                                  handler.open({
                                      name: 'Star-Hills',
                                      description: 'Bezahlung',
                                      currency: "eur",
                                      amount: ${star.price*100*3}
                                  });
                                  e.preventDefault();
                              });

                              // Close Checkout on page navigation:
                              //$(window).on('popstate', function() {
                                 // handler.close();
                             // });
                          </script>




                        </form>
                    </div>

                    <div class="clr"></div>
                </div>

            </div>

            <%--<button data-remodal-action="cancel" class="remodal-cancel">Cancel</button>--%>
            <%--<button data-remodal-action="confirm" class="remodal-confirm">OK</button>--%>
        </div>
        <div class="remodal" style="width: 370px; visibility: visible; padding: 35px 10px;" data-remodal-id="successUp" >
            <%--<button data-remodal-action="close" class="remodal-close"></button>--%>

            <div id="statusSuccess">
                <p id="statusSuccessMessage"></p>
            </div>


        </div>
        <div class="clr">
        </div>

    </section>

</div>
<div id="BlockVideoFormaliz">
    <section>
        <div id="contentFlow" class="ContentFlow">

            <div class="loadIndicator"><div class="indicator"></div></div>

            <div class="flow">
                <c:forEach items="${stars}" var="stars">
                    <div class="item">
                        <img class="content" src="/starSource/${stars.id}/mainphoto.png"/>
                            <div class="caption">${stars.name}</div>
                    </div>
                </c:forEach>
            </div>
            <div class="globalCaption"></div>
            <div class="scrollbar">
                <div class="slider"><div class="position"></div></div>
            </div>

        </div>
    </section>
</div>
<script>
    $(function() {
        $("#datepicker").datepicker({
            dateFormat : "yy-mm-dd",
            minDate: 3,
            onSelect: function(dateText, inst) {
                var dateAsString = dateText; //the first parameter of this function
                var dateAsObject = $(this).datepicker( 'getDate' ); //the getDate method
                if (dateAsObject != 0) {
                    $('input[name=Date]').css('border', '1px solid #d7d7d7');
                    $('input[name=Date]').css('border-radius', '5px');
                    $('#statusErrorDateOrdering').html('&nbsp;');
                } else {
                    $('input[name=Date]').css('border', '2px solid #FF0026');
                    $('input[name=Date]').css('border-radius', '5px');
                }
            }
        });
        $(".datepicker").datepicker( $.datepicker.regional[ "de" ] );
    });
</script>