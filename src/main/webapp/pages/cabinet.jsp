<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false"%>
<script src="/js/crop/jquery.min.js"></script>
<script src="/js/crop/jquery.Jcrop.js"></script>
<script type="text/javascript">
    $.noConflict();
    var jcrop_api;
    jQuery(function(){
        jQuery('#cropbox').Jcrop({
            aspectRatio: 1.684,
            onSelect: updateCoords
        },function(){
            jcrop_api = this;
        });

    });

    function updateCoords(c)
    {
        $('#x').val(c.x);
        $('#y').val(c.y);
        $('#w').val(c.w);
        $('#h').val(c.h);
    };

    function checkCoords()
    {
        if (parseInt($('#w').val())){
            var formData = $('#photocrop');
            $.ajax({
                type: "POST",
                url: '/photocropcabinet',
                data: formData.serialize(),
                success: function (data) {
                    jcrop_api.setImage("/starSource/defaultcrop.png"+ '?' + new Date().getTime());
                    $('#ok').css('display', 'block');
                },
                error: function (e) {
                    console.log(e);
                }
            });
        } else {
            alert('Please select a crop region then press submit.');
        }
    };

</script>
<style>
    .jcrop-keymgr{visibility: hidden;}
</style>

<style>
    <c:if test="${star.status==true}">
    #ButtonTurneOn{
        display: block;
    }
    #ButtonTurneOf{
        display: none;
    }

    </c:if>
    <c:if test="${star.status==false}">
    #ButtonTurneOn{
        display: none;
    }
    #ButtonTurneOf{
        display: block;
    }
    </c:if>
    <sec:authorize access="hasAnyRole('ADMIN')">
    <c:if test="${star.activate==true}">
    #ButtonActiveOn{
        display: block;
    }
    #ButtonActiveOf{
        display: none;
    }

    </c:if>
    <c:if test="${star.activate==false}">
    #ButtonActiveOn{
        display: none;
    }
    #ButtonActiveOf{
        display: block;
    }
    </c:if>
    </sec:authorize>
</style>
<div id="AllBody">
    <section>
        <div id="TitleCabinet">
            <sec:authorize access="hasAnyRole('STAR')">
                <h1><span>Mein Acount</span></h1>
                <div id="BelowH1">Willkommen zu Ihrem persönlichen Account.
                Hier können Sie die Änderungen von Ihren persönlichen Daten vornehmen und Ihren Kontostand und Ihre Bestellungen anschauen.
                </div>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('ADMIN')">
                <h1>${star.name}</h1>
            </sec:authorize>
        </div>
        <div id="CenterCabinet">

            <div id="LeftCabinet">
                <form method="POST" id="photoform" action="/cabinet" onChange="editPhoto()" enctype="multipart/form-data">
                <div id="BlockFoto">
                    <img id="img" src="/starSource/${star.id}/mainphoto.png">
                </div>
                <div id="ButtonFoto"><div id="photo"><label>
                    <input type="file" name="file" class="file" accept="image/x-png, image/jpeg">Neues Foto hochladen
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}" />
                    <input type="hidden"
                           id="idstar"
                           name="id"
                           value="${star.id}" /></label>
                </div></div></form>
                <div class="remodal" data-remodal-id="photomodal" style="width: 100%;">
                    <p>wählen Sie den Bereich für den Schnitt</p>
                    <div id="imagebox" style="width: 100%; overflow: scroll; margin-top: 10px">
                        <img src="/starSource/default.png" id="cropbox"  style="display: inline-block; " />
                    </div>

                    <form method="POST" action="/photocropcabinet" id="photocrop">
                        <input type="hidden" id="x" name="x" />
                        <input type="hidden" id="y" name="y" />
                        <input type="hidden" id="w" name="w" />
                        <input type="hidden" id="h" name="h" />
                    </form>
                    <button id="cropbutton" value="Crop Image" style="display: block; margin: 10px auto;" class="btn btn-large btn-inverse" onclick="checkCoords()">Foto zuschneiden</button>
                    <button id="ok" value="Crop Image" style="margin: 10px auto;" class="btn btn-large btn-inverse" onclick="javascript: window.location='#'; $('#img').attr('src', '/starSource/${star.id}/mainphoto.png'+ '?' + new Date().getTime());">Ok</button>
                </div>
                <p>Mein Kontostand</p>
                <sec:authorize access="hasAnyRole('STAR')">
                <div id="ButtonMoney"><a href="#">${star.balance}€</a></div>
                </sec:authorize>
                  <sec:authorize access="hasAnyRole('ADMIN')">
                      <div id="ButtonInput"><input  type="text" id="balanceAdmin" value="${star.balance}"></div>
                      <a style="margin-left: 80px;" href="/starSource/${star.id}/payStat.xls" download="">Zahlungsstatistik</a>
                  </sec:authorize>
                <div id="ButtonOrders"><a href="/my-orders?id=${star.id}">Meine Bestellungen: <span>${orders}</span></a></div>
                <form id="statusform">
                    <div id="ButtonTurneOn"><a title="Der Status ON bedeutet, dass Sie den Nutzern auf der Website sichtbar sind und werden neue Bestellungen erhalten." href="#ButtonTurneOn" onclick="statusON()">On</a></div>
                    <div id="ButtonTurneOf"><a title="Der Status OFF bedeutet, dass Sie den Nutzern auf der Website unsichtbar sind und werden keine neue Bestellungen erhalten." href="#ButtonTurneOf" onclick="statusOF()">Off</a></div>
                    <input type="hidden"
                           id="statusBut"
                           name="status"
                           value="" />
                </form>
                <sec:authorize access="hasAnyRole('ADMIN')">
                <form id="activeform">
                    <div id="ButtonActiveOn"><a href="#ButtonActiveOn" onclick="activeON()">Active</a></div>
                    <div id="ButtonActiveOf"><a href="#ButtonActiveOf" onclick="activeOF()">Unactive</a></div>
                    <input type="hidden"
                           id="activeBut"
                           name="active"
                           value="" />
                    <input type="hidden"
                           id="id"
                           name="id"
                           value="${star.id}" />
                </form>
                </sec:authorize>
                <div id="ButtonHelp"><a href="#help">Hilfe</a></div>
                <div class="remodal" style="width: 300px; height: 200px" data-remodal-id="help">
                    <h1>Hilfe</h1>
                        <p>wenn Sie unsere Hilfe brauchen, dann können Sie uns unter den Nummer +49 177 3002976 erreichen</p>
                </div>
            </div>
            <div id="RightCabinet">
              <c:if test="${!star.activate}">
                <div id="TopDescr">
                    <p><span>Sehr geehrter Nutzer!</span> Um deine Persönlichkeit zu bestätigen, schicke uns ein kurzes Video, wo dein Gesicht und dein Ausweis zu erkennen sind oder lasse uns mit dir Kontakt per Skype aufnehmen.</p>
                    <p>Nach der Überprüfung Ihrer Persönlichkeit, wird Ihr Account aktiveirt.</p>
                    <p>Falls das Video innerhalb von 24 Stunden nicht hochgeladen wurde,  dann  wird unserer Administrator sich mit Ihnen in Verbindung setzen.</p>
                    <div id="BottomDescr">
                        <div class="checkbox" id="checkbox">
                            <form id="skypeform"><input type="checkbox" <c:if test="${star.skypecheck==true}">checked="true"</c:if> id="depositonly" name="depositonly" value="Y" onchange="javascript: if(this.checked==true){ $('#checkbox').css('display', 'none'); $('#BlockSkype').css('display', 'block'); } " /><label style="height: 26px;" for="depositonly"><p id="skypetext">Ich möchte, dass StarHills mit mir den Kontakt per Skype aufnimmt, um meine Persönlichkeit zu bestätigen.</p></label><input type="hidden" name="skype" id="skype" value="" /></form>
                        </div>
                        <div id="BlockSkype">
                            <input type="text" class="validform" name="SkypeName" id="SkypeSend" required value=""  placeholder="Geben Sie Ihr Skype an"/>
                            <div id="ButtonSkype"><a href="#" onclick="submitskype()">senden</a></div>
                        </div>
                            <sec:authorize access="hasAnyRole('STAR')">
                                <div id="ButtonLoading"><a href="#load-video">Video hochladen</a></div>
                            </sec:authorize>
                            <sec:authorize access="hasAnyRole('ADMIN')">
                                <c:if test="${star.confirm!=null}">
                                     <div style="float: right; width: 200px; height: 200px;" class="player" id="videoplayerconfirm"></div>
                                    <script type="text/javascript">this.player = new Uppod({m:"video",uid:"videoplayerconfirm",file:"/video-service?namevideo=videoconfirm.mp4&id=${star.id}"+ '?' + new Date().getTime(),poster:"/starSource/${star.id}/videoconfirm.png"+ '?' + new Date().getTime()});</script>
                                </c:if>
                                <c:if test="${star.confirm==null}">
                                    <p style="float:right">Kein video</p>
                                </c:if>
                            </sec:authorize>
                        <form action="delete-video" method="POST" style="margin-top: 10px;" id="vidfile">
                                    <span id="filename" style="display: inline-block;">
                                        <c:if test="${star.confirm!=null}">${star.confirm}</c:if></span>
                            <c:if test="${star.confirm!=null}">
                                <img title="Video wurde gelöscht?" style="display: inline-block; margin-bottom: -3px; cursor: pointer;" id="deletebut" src="/images/no.png" onclick="deletefile()">
                            </c:if>
                            <c:if test="${star.confirm==null}">
                                <img title="Video wurde gelöscht?" style="display: none; margin-bottom: -3px; cursor: pointer;" id="deletebut" src="/images/no.png" onclick="deletefile()">
                            </c:if>
                            <input type="hidden" name="filename" id="filedelete" value="<c:if test="${star.confirm!=null}">${star.confirm}</c:if>">
                        </form>

                        <div class="clr"></div>
                            <div id="videorecord" class="remodal" data-remodal-id="load-video" >
                                <div id="loadvideos" style="max-width: 650px;">
                                                <div id="confirmmodal">Video für die Bestätigung</div>
                                    <video id="video" autoplay muted style="margin: auto;"></video>
                                    <video id="videoplay" autoplay loop style="margin: auto;"></video>
                                    <div id="timer" style="display:none"><span id="minutes">00</span>:<span id="seconds">00</span></div>

                                    <div id="select">
                                        <form method="POST" id="videoform" action="/video-upload" onChange="editVideo()" enctype="multipart/form-data">
                                        <div id="videofile"><div id="videoupload">
                                        <input type="file" name="file" id="upload" class="remodal-close1" accept="video/*" onclick="javascript: window.location = '#'" >Datei hochladen
                                        <input type="hidden"
                                               name="${_csrf.parameterName}"
                                               value="${_csrf.token}" />
                                        <input type="hidden"
                                               name="id"
                                               id="starid"
                                               value="${star.id}" />
                                            </div></div>
                                    </form>
                                       <%--<button id="upload">
                                            Загрузить файл
                                        </button>--%>
                                        <div id="requestblock">
                                        <button id="request">
                                            Videoaufnahme
                                        </button>
                                        </div>
                                    </div>
                                    <div id="record">
                                        <button id="start"></button>
                                        <p id="starttext">Klicken Sie hier um zu schreiben</p>
                                    </div>
                                    <script>
                                        var ourtimer, videoscreen, videoplay, confirm, reqBtn, startBtn,record, stream, recorder, vid, recordedBlobs;
                                        videoscreen = document.getElementById('video');
                                        videoplay = document.getElementById('videoplay');
                                        reqBtn = document.getElementById('request');
                                        startBtn = document.getElementById('start');
                                        record = document.getElementById('record');
                                        select = document.getElementById('select');
                                        confirm = document.getElementById('confirmmodal');
                                        reqBtn.onclick = requestVideo;
                                        startBtn.onclick = startRecording;
                                        var mediaSource = new MediaSource();
                                        var localStream;
                                        var sourceBuffer;
                                        mediaSource.addEventListener('sourceopen', handleSourceOpen, false);
                                        function timer() {
                                            if (ourtimer == true) {
                                                var sec = document.getElementById('seconds');
                                                var min = document.getElementById('minutes');
                                                sec.innerHTML++;
                                                if(sec.innerHTML<10){
                                                    sec.innerHTML='0'+sec.innerHTML;
                                                }
                                                if (sec.innerHTML == 60) {
                                                    min.innerHTML++;
                                                    if(min.innerHTML<10){
                                                        min.innerHTML='0'+min.innerHTML;
                                                    }
                                                    sec.innerHTML = '00';
                                                    setTimeout(timer, 1000);
                                                }
                                                else {
                                                    setTimeout(timer, 1000);
                                                }
                                            }
                                        }

                                        function requestVideo() {
                                            $(".modalWaiting").css("display", "block");
                                            navigator.getUserMedia = navigator.getUserMedia ||
                                                    navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

                                            var constraints = {
                                                audio: true,
                                                video: true
                                            };

                                            navigator.mediaDevices.getUserMedia(
                                                    constraints
                                            ).then(
                                                    successCallback,
                                                    errorCallback
                                            );
                                        }

                                        function successCallback(stream) {
                                            $(".modalWaiting").css("display", "none");
                                            videoscreen.style.display = 'block';
                                            startBtn.style.display = 'inline-block';
                                            $('#starttext').css('display', 'block');
                                            select.style.display = 'none';
                                            record.style.display = 'block';
                                            document.getElementById('timer').style.display = 'inline-block';
                                            $("#confirmmodal").css("padding-top", "0");
                                            console.log('getUserMedia() got stream: ', stream);
                                            localStream= stream;
                                            window.stream = stream;
                                            if (window.URL) {
                                                videoscreen.src = window.URL.createObjectURL(stream);
                                            } else {
                                                videoscreen.src = stream;
                                            }
                                        }

                                        function errorCallback(error) {
                                            console.log('navigator.getUserMedia error: ', error);
                                        }

                                        function handleSourceOpen(event) {
                                            console.log('MediaSource opened');
                                            sourceBuffer = mediaSource.addSourceBuffer('video/webm; codecs="vp8"');
                                            console.log('Source buffer: ', sourceBuffer);
                                        }
                                        function startRecording() {
                                            ourtimer = true;
                                            if (startBtn.classList.contains("videostart")) {
                                                recorder.stop();
                                                startBtn.classList.remove("videostart");
                                                videoscreen.style.display = 'none';
                                                send();
                                            } else {
                                                videoscreen.style.display = 'block';
                                                videoplay.style.display = 'none';
                                                startBtn.classList.add("videostart");
                                                recordedBlobs = [];
                                                var options = {mimeType: 'video/webm'};
                                                try {
                                                    recorder = new MediaRecorder(window.stream, options);
                                                } catch (e0) {
                                                    console.log('Unable to create MediaRecorder with options Object: ', e0);
                                                    try {
                                                        options = {mimeType: 'video/webm,codecs=vp9'};
                                                        recorder = new MediaRecorder(window.stream, options);
                                                    } catch (e1) {
                                                        console.log('Unable to create MediaRecorder with options Object: ', e1);
                                                        try {
                                                            options = {mimeType: 'video/webm,codecs=vp8'}; // Chrome 47
                                                            recorder = new MediaRecorder(window.stream, options);
                                                        } catch (e2) {
                                                            alert('MediaRecorder is not supported by this browser.\n\n' +
                                                                    'use firefox browser for record with webcam');
                                                            console.error('Exception while creating MediaRecorder:', e2);
                                                            return;
                                                        }
                                                    }
                                                }

                                                recorder.start(10);
                                            }
                                            recorder.ondataavailable = function(e) {
                                                try {
                                                    vid = e.data;
                                                    if (vid && vid.size > 0) {
                                                        recordedBlobs.push(vid);

                                                    }

                                                }catch(e2){
                                                    alert("error send");
                                                }

                                            };
                                            recorder.onstop = function(e1) {
                                            }
                                            setTimeout(timer,1000);
                                        }


                                        function stopRecording() {
                                            ourtimer=false;
                                            startBtn.style.display = 'inline-block';
                                            stopBtn.style.display = 'none';
                                            playBtn.style.display = 'inline-block';
                                            sendBtn.style.display = 'block';
                                            videoscreen.style.display = 'none';
                                            document.getElementById('timer').style.display = 'none';
                                            videoplay.style.display = 'block';
                                            recorder.stop();
                                            startBtn.removeAttribute('disabled');
                                            stopBtn.disabled = true;
                                            playBtn.removeAttribute('disabled');
                                        }
                                        function play() {
                                            videoplay.controls = true;
                                            var superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
                                            videoplay.src = window.URL.createObjectURL(superBuffer);
                                            document.getElementById('timer').style.display = 'inline-block';

                                        }
                                        function closevideoconfirm(){
                                            try {
                                                localStream.stop();
                                            } catch(e) {
                                                localStream.getVideoTracks().forEach(function (track) {
                                                    track.stop();
                                                });
                                            }
                                            videoscreen.style.display = 'none';
                                            videoplay.style.display = 'none';
                                            document.getElementById('select').style.display = 'block';
                                            ourtimer=false;
                                            document.getElementById('seconds').innerHTML='00';
                                            document.getElementById('minutes').innerHTML='00';
                                            document.getElementById('timer').style.display = 'none';
                                            document.getElementById('record').style.display = 'none';
                                        }
                                        function send() {
                                            ourtimer=false;
                                            document.getElementById('seconds').innerHTML='00';
                                            document.getElementById('minutes').innerHTML='00';
                                            $("#progress-wrp").css("display", "block");
                                            $(".background-progress").css("display", "none");
                                            var superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
                                            var xhr = new XMLHttpRequest();
                                            xhr.open('POST', '/video-service', true);
                                            xhr.onload=function(e){
                                                //$(".modalWaiting").css("display", "none");
                                                $("#vidfile").css("display", "block");
                                                var data=xhr.response.replace(/\s+/g, '');
                                                $("#filename").html(data);
                                                $("#filedelete").val(data);
                                                $("#deletebut").css("display", "inline-block");
                                                $('#videoplayerconfirm'+loopindex.value).css('display', 'block');
                                                this.player = new Uppod({m:"video",uid:"videoplayerconfirm"+loopindex.value,file:'/video-service?namevideo=videoconfirm.mp4'+'&id='+document.getElementById('starid').value+ '?' + new Date().getTime()});
                                                $("#progress-wrp").css("display", "none");
                                                $(".background-progress").css("display", "none");
                                            }
                                            xhr.upload.onprogress = function(oEvent) {
                                                if (oEvent.lengthComputable) {
                                                    var percent = 0;
                                                    var position = oEvent.loaded || oEvent.position;
                                                    var total = oEvent.total;
                                                    percent = Math.ceil(position / total * 100);
                                                    //update progressbar
                                                    $(".progress-bar").css("width", + percent +"%");
                                                    $(".status").text(percent +"%");
                                                } else {

                                                }
                                            }
                                            xhr.onerror=function(e){
                                                $("#filename").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
                                            }
                                            xhr.setRequestHeader("Content-Type", "video/webm");
                                            xhr.setRequestHeader("id",  document.getElementById('starid').value);
                                            xhr.send(superBuffer);
                                        }
                                        function editVideo() {
                                            $(document).ajaxStart(function () {
                                                $(".modalWaiting").css("display", "none");
                                            });
                                            $(".background-progress").css("display", "block");
                                            $("#progress-wrp").css("display", "block");
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
                                                    $("#progress-wrp").css("display", "none");
                                                    $("#progress-text").css('display', 'none');
                                                    //$(".modalWaiting").css("display", "none");
                                                    $("#vidfile").css("display", "block");
                                                    var datacrop=data.replace(/\s+/g, '');
                                                    $("#filename"+loopindex.value).html(data);
                                                    if(datacrop!="fileformatnotsupport") {
                                                        $("#filedelete").val(datacrop);
                                                        $("#deletebut").css("display", "inline-block");
                                                        $('#videoplayerconfirm' + loopindex.value).css('display', 'block');
                                                        this.player = new Uppod({
                                                            m: "video",
                                                            uid: "videoplayerconfirm" + loopindex.value,
                                                            file: "/video-service?namevideo=videoconfirm.mp4" + '&id=' + document.getElementById('starid').value + '?' + new Date().getTime()
                                                        });
                                                    }
                                                },
                                                error: function (e) {
                                                    $("#filename").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
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
                                                            if(percent==100){
                                                                $("#progress-text").css('display', 'block');
                                                                $("#progress-text").text("your file was uploaded and now it is converted");
                                                            }
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
                </div>
            </c:if>
                <form method="POST" id="cabinetform" action="/cabinet" enctype="multipart/form-data">
                <div <c:if test="${star.activate}">style="margin-top: 0px"</c:if> id="FormsBlock">
                    <input type="hidden" id="status" name="status"  value="${star.status}"/>
                    <input type="hidden" id="deposit" name="deposit"  value="false"/>
                    <input type="hidden" id="about" name="about"  value="false"/>
                    <input type="hidden"
                           name="balanceAdmin"
                           id="balanceHidden"
                           value="${star.balance}" />
                    <input type="hidden" name="Id"  value="${star.id}"/>
                    <div id="BlockName"><p>Vorname, Name</p><input type="text" name="Name" required value="${star.name}"/></div>
                    <div id="BlockAlias">
                        <p style="line-height: 40px;">Nickname</p><input type="text" name="Alias"  value="${star.alias}"/>
                        <p style="line-height: 40px;">Handynummer</p><input type="text" name="Phone" id="PhoneCabinet" value="${star.phone}"/>
                    </div>
                    <div id="BlockEmail">
                        <p>Skype</p><input type="text" id="skypestar" name="Skype"  value="${star.skype}"/>
                        <p>E-Mail Adresse</p><input type="text" id="Email" name="Email" required  value="${star.email}" />
                        <span id="validEmail"></span>
                    </div>
                    <div id="BlockAboutMe"> <p>Angaben zu Ihrer Persönlichkeit</p><textarea id="textar" name="Comment" >${star.comment}</textarea></div>
                    <sec:authorize access="hasAnyRole('ADMIN')">
                    <div id="AdminComment"><p>Angaben zu Ihrer Persönlichkeit von admin</p>
                        <div id="Texteditor">
                            <textarea name="editor1" id="editor1" cols="45" rows="5">${star.commentadmin}</textarea>
                            <script type="text/javascript">
                                CKEDITOR.replace( 'editor1', {
                                    language: 'de',
                                    uiColor: '#9AB8F3'
                                });
                            </script>
                        </div>
                    </div>
                    </sec:authorize>
                    <div class="clr"></div>
                    <div id="BlockIwant"><input type="checkbox" <c:if test="${star.aboutme==true}">checked="true"</c:if>id="AboutMe" name="AboutMe" value="false" onchange="javascript: document.getElementById('about').value=this.checked;"/> <label for="AboutMe"><p>Ich will, dass StarHills über mich schreibt.</p></label></div>
                    <div class="clr"></div>
                    <div id="BlockCategory">
                        <p>Kategorie</p>
                        <select name="Category" onchange="otherCategory(this)">
                            <c:forEach items="${categoryList}" var="category">
                                <c:if test="${star.category.id == category.id}">
                                    <option selected value=${category.id}>${category.name}</option>
                                </c:if>
                                <c:if test="${star.category.id != category.id}">
                                    <option value=${category.id}>${category.name}</option>
                                </c:if>
                            </c:forEach>
                            <option value="0">andere</option>
                        </select>
                        <input type="text" style="display: none" id="Category" name="OtherCategory" required placeholder="gewünschte Kategorie" />
                    </div>
                    <div id="BlockNumberVideos">
                        <p>Anzahl der Videoclips im Monat</p>
                        <input type="number" name="Videos" value="${star.video}" required />
                    </div>
                    <div id="BlockPriceVideo"><p>Preis pro Video</p><input name="Price" value="${star.price}"/></div>
                    <script>
                        document.getElementsByName('Videos')[0].onkeypress = function(e) {
                        e = e || event;
                        if (e.ctrlKey || e.altKey || e.metaKey) return;
                        var chr = getChar(e);
                        if (chr == null) return;
                        if (chr < '0' || chr > '9') {
                            return false;
                        }
                    }
                        document.getElementsByName('Price')[0].onkeypress = function(e) {
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
                    </script>
                    <div id="BlockMyProjects"><p>Meine Projekte für die Spenden</p>
                        <%--<select name="MyProjects">
                            <c:forEach items="${charities}" var="charitys">
                                <option>${charitys.charity.nameproject}</option>
                            </c:forEach>
                        </select>--%>
                        <select class="selec" id="MyProjects" name="MyProjects[]" multiple>

                            <c:forEach items="${activecharities}" var="charity">
                            <option  value="${charity.id}" <c:forEach items="${charities}" var="charitys">${charity.id == charitys.charity.id ? 'selected="selected"' : ''}</c:forEach>><a href="#">${charity.nameproject}</a></option>
                            </c:forEach>
                        </select>

                        <script>
                            $('.selec').multipleSelect();
                        </script>

                    </div>
                    <div class="clr"></div>
                    <div id="Button"><a href="#" <sec:authorize access="hasAnyRole('STAR')"> onclick="editcabinet()"</sec:authorize><sec:authorize access="hasAnyRole('ADMIN')"> onclick="editcabinetadmin()"</sec:authorize>>Speichern</a></div>
                    <div class="clr"></div>
    <div class="clr"><span style="display: inline-block; text-align: right; width: 100%; padding-top: 15px; color: red;" id="statusErrorCabinet" class="modalMessage"></span></div>
                </div>
                </form>
            </div>
        </div>
        <div class="clr"></div>
    </section>
</div>

<div class="remodal" style="width: 95%" data-remodal-id="pay-charity" >
    <%--<button data-remodal-action="close" class="remodal-close"></button>--%>

    <div id="statusErrorOrderingModal">
        <p>Sie können das Projekt unterstützen!</p>
        <p><span>Spenden </span><input style=" width: 6em" type="number"  min="10" name="amountCharity" value="100"  placeholder="100" id="amountCharity"><span> Евро</span></p>
        <%-- <input type="hidden" name="IdCharityPay" value="1">--%>
        <div id="buttonpay">
            <div id="blockpay1">
                <form name="_xclick" action="https://www.paypal.com/de/cgi-bin/webscr" method="post">
                    <input type="hidden" name="cmd" value="_xclick">
                    <input type="hidden" name="business" value="dima.schaible@googlemail.com">
                    <input type="hidden" name="currency_code" value="EUR">
                    <input type="hidden" id="IdCharityPayPal" name="item_name" value="0">
                    <input type="hidden" name="item_number" value="1">
                    <input type="hidden" id="ReturnIdCharityPayPal" name="return" value="0">
                    <input type="hidden" am="AmountPayPalCharity" name="amount" value="100">
                    <input type="image" src="/images/paypal.png"  name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
                </form>
            </div>
            <div id="blockpay2">
                <!-- SOFORT Überweisung -->
                <form method="post" action="https://www.sofort.com/payment/start">
                    <input type="hidden" name="user_id" value="133738" />
                    <input type="hidden" name="project_id" value="292118" />
                    <input type="hidden" id="IdCharitySofort" name="user_variable_1" value="0" />
                    <input type="hidden" name="user_variable_2" value="charity" />
                    <input type="hidden" name="user_variable_3" value="1" />
                    <input type="hidden" name="reason_1" value="Test-Überweisung" />
                    <input type="hidden" name="reason_2" value="Bestellnummer" />
                    <input type="hidden" am="AmountSofortCharity" name="amount" value="100" />
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
                                var id2 = $('#IdCharityPayPal').val();
                                var amount = $('input[name=amountCharity]').val();

                                var idOrder2 = -1*id2;
                                $.post("/stripe", { stripeToken: token.id, id: idOrder2, amount: amount*100 }, function( data ) {
                                            location.href = '/charity';

                                            /*var paych=data.replace(/\s+/g, '');
                                            $('#charity'+id2).html(paych);*/
                                        }

                                );


                                // '?id=' + idOrder2;
                            }


                        });

                        $('.customButton').on('click', function(e) {
                            // Open Checkout with further options:
                            var amount = $('input[name=amountCharity]').val();
                            handler.open({
                                name: 'Star-Hills',
                                description: 'Bezahlung',
                                currency: "eur",
                                amount: amount*100
                            });
                            e.preventDefault();
                        });

                        // Close Checkout on page navigation:
                        $(window).on('popstate', function() {
                            handler.close();
                        });
                    </script>




                </form>
            </div>

            <div class="clr"></div>
        </div>

    </div>

    <%--<button data-remodal-action="cancel" class="remodal-cancel">Cancel</button>--%>
    <%--<button data-remodal-action="confirm" class="remodal-confirm">OK</button>--%>
</div>
<script>

    document.getElementsByName('amountCharity')[0].onkeypress = function(e) {
        e = e || event;
        if (e.ctrlKey || e.altKey || e.metaKey) return;
        var chr = getChar(e);
        if (chr == null) return;
        if (chr < '0' || chr > '9') {
            return false;
        }
    }
</script>

<div id="SliderCabinet">
    <section>
        <div id="SliderBclock">
            <div id="TitleTopSlider"><span>Wohltätigkeitsprojekte,</span> die wir unterstützen</div>
            <div id="ListSlider">
                <c:forEach items="${activecharities}" var="charity">
                <div>
                    <div id="FotoSlider"><a href="/charity#${charity.id}" ><img src="starSource/charity/${charity.id}/${charity.mainphoto}"></a></div>

                    <div id="Txt"><p><a href="/charity#${charity.id}">${charity.nameproject}</a></p></div>
                    <div id="BottomSlider"><a href="#pay-charity" onclick="paycharity(${charity.id})" >Unterstützen</a></div>
                </div>
                </c:forEach>
            </div>
        </div>
        <sec:authorize access="hasAnyRole('STAR')">
        <div id="ButtonCabinetBottom"><a href="/add-charity">Ich möchte eine Stiftug vorschlagen</a></div>
        </sec:authorize>
    </section>
</div>
<sec:authorize access="hasAnyRole('ADMIN')">
    <script>
        function activeON(){
            document.getElementById('activeBut').value=false;
            var formData = $('#activeform');
            $.ajax({
                type: "POST",
                url: '/send-active',
                data: formData.serialize(),
                success: function (data) {
                }
            });
            document.getElementById('ButtonActiveOn').style.display ='none';
            document.getElementById('ButtonActiveOf').style.display ='block';
        }
        function activeOF(){
            document.getElementById('activeBut').value=true;
            var formData = $('#activeform');
            $.ajax({
                type: "POST",
                url: '/send-active',
                data: formData.serialize(),
                success: function (data) {
                }
            });
            document.getElementById('ButtonActiveOn').style.display ='block';
            document.getElementById('ButtonActiveOf').style.display ='none';
        }
        function editcabinetadmin() {
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
            var chekskype = $('input[name=depositonly]').is(':checked');
            var skype = $('input[name=Skype]').val();
            if (chekskype == false && skype == 0) {
                $('input[name=Skype]').css('border', '2px solid #FF0026');
                $('input[name=Skype]').css('border-radius', '5px');
                $('#statusErrorCabinet').html('Geben Sie Ihr Skype an');
                return;
            }
            if (name != 0 && alias != 0 && email != 0 && price != 0 && phone != 0) {
                if (isValidEmailAddress(email)) {
                    $('#balanceHidden').val($('#balanceAdmin').val());
                    var formData = $('#cabinetform');
                    var areaText = CKEDITOR.instances['editor1'].getData();
                    $('#editor1').val(areaText);
                    $.ajax({
                        type: "POST",
                        url: '/edit-star',
                        data: formData.serialize(),
                        success: function (data) {
                            var datacrop = data.replace(/\s+/g, '');
                            if (datacrop == 'editname') {
                                /*alert("Вы изменили логин! Войдите под новым логином.");
                                 document.location.href='/#login';*/
                            } else if (datacrop == 'emailerror') {
                                $('#statusErrorCabinet').html("Diese E-Mail Adresse ist schon vorhanden");
                                $("#statusErrorCabinet").css('display', 'inline-block');
                            } else {
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
                } else {
                    $('#statusErrorCabinet').html('Die E-Mail Adresse wurde falsch angegeben');
                }
            }
        }
    </script>
</sec:authorize>