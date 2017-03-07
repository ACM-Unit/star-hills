<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false"%>

<div id="MyOrdersAll">
    <section>
        <h1><span>Sie helfen den</span> Menschen</h1>
        <div id="BelowH1Bottom">Meine Bestellungen</div>
    </section>
</div>
<div id="ButtonBlock">
    <section>
        <div class="Two" id="onebot"><a href="#ButtonBlock" onclick="showpage('Page1', '#onebot' )"><p><marquee id="mar" scrollamount="1" behavior="alternate" width="88%">Abgeschlossene</marquee></p></a></div>
        <div class="Two" id="twobot"><a href="#ButtonBlock" onclick="showpage('Page2', '#twobot')"><p>Laufende</p></a></div>
        <div class="One" id="threebot"><a href="#ButtonBlock" onclick="showpage('Page3', '#threebot')"><p>Neue</p></a></div>
        <div class="clr"></div>
    </section>
</div>
<div id="BlockAllVideo">
    <section>
        <div id="BlockVideo">
            <div id="Page1">
                <c:forEach var="closeorder" items="${closeorder}">
                <div class="OneVideo" id="videoclose${loop.index}">
                    <div class="BlVideo"><div class="Center">
                        <div style="width: 370px; height: 240px;" class="player" id="videoplayerclose${loop.index}"></div>
                        <script type="text/javascript">this.player = new Uppod({m:"video",uid:"videoplayerclose${loop.index}",file:"/video-service?namevideo=${closeorder.pathvideo}&id=${closeorder.star.id}"+ '?' + new Date().getTime(),poster:"/starSource/${closeorder.star.id}/${closeorder.id}.png"+ '?' + new Date().getTime()});</script>
                    </div></div>
                    <div class="RightDes">
                        <div class="TitleOneVideo"><p>${closeorder.event}</p></div>
                        <div class="NameDate"><p style="padding-right: 5px;">${closeorder.name}</p><p><fmt:formatDate dateStyle="short" value="${closeorder.date}" /></p></div>
                        <div class="clr"></div>
                        <div class="Confirmation">
                            <c:if test="${closeorder.paidstatus==true}">
                                <img src="images/MyOrders/yes.png" <sec:authorize access="hasAnyRole('ADMIN')">onclick="paidstatus(this, ${closeorder.id})" class="false" </sec:authorize>>
                                <p>Bezahlt</p>
                            </c:if>
                            <c:if test="${closeorder.paidstatus==false}">
                                <img src="images/MyOrders/no.png" <sec:authorize access="hasAnyRole('ADMIN')">onclick="paidstatus(this, ${closeorder.id})" class="true"</sec:authorize>>
                                <p>Nicht bezahlt</p>
                            </c:if>
                            <sec:authorize access="hasAnyRole('ADMIN')">
                                <div class="One"><div id="button${closeorder.id}" onclick="changeactive(this, ${closeorder.id})" class="${closeorder.active}"><p>Abgeschlossene</p></div></div>
                            </sec:authorize>
                            <div class="clr"></div>
                        </div>
                    </div>
                    <div class="ButtonMoreOneVideo"><a onclick="modalorders('${closeorder.name}', '<fmt:formatDate dateStyle="short" value="${closeorder.date}" />', '<fmt:formatDate type="time" value="${closeorder.date}" />', '${closeorder.event}', '${closeorder.text}', '${closeorder.photo}', '${closeorder.audiogreeting}', '${closeorder.audioname}')" href="#order">näher</a></div>
                    <div class="clr"></div>
                </div>
                </c:forEach>
                <div class="remodal" data-remodal-id="order">
                    <div class="TopBlockM">
                        <div class="FotoModal"><img style="width: 180px" id="photoactive" src=""></div>
                        <p id="modalname"></p>
                        <p id="modaldate"></p>
                        <p id="modaltime"></p>
                        <p id="modalevent"></p>
                        <div class="clr"></div>
                    </div>
                    <div class="BottomBlcokM">
                        <p id="modaltext"></p>
                    </div>
                </div>
            </div>
            <div id="Page2">
                <c:forEach var="activeorder" items="${activeorder}" varStatus="loop">
                    <div class="OneVideo" id="videoactive${loop.index}">
                        <div class="BlVideo" id="videoblock${loop.index}"><div class="Center">
                                <div style="width: 370px; height: 240px;" class="player" id="videoplayeractive${loop.index}"></div>
                                <script type="text/javascript">this.player = new Uppod({m:"video",uid:"videoplayeractive${loop.index}",file:"/video-service?namevideo=${activeorder.pathvideo}&id=${activeorder.star.id}"+ '?' + new Date().getTime(),poster:"/starSource/${activeorder.star.id}/${activeorder.id}.png"+ '?' + new Date().getTime()});</script>
                       </div></div>
                        <div class="RightDes">
                            <div class="TitleOneVideo"><p>${activeorder.event}</p></div>
                            <div class="NameDate"><p style="padding-right: 5px;">${activeorder.name}</p><p><fmt:formatDate dateStyle="short" value="${activeorder.date}" /></p></div>
                            <div class="clr"></div>
                            <div class="Confirmation">
                                <c:if test="${activeorder.paidstatus==true}">
                                    <img src="images/MyOrders/yes.png" <sec:authorize access="hasAnyRole('ADMIN')">onclick="paidstatus(this, ${activeorder.id})" class="false"</sec:authorize>>
                                    <p>Bezahlt</p>
                                </c:if>
                                <c:if test="${activeorder.paidstatus==false}">
                                    <img src="images/MyOrders/no.png" <sec:authorize access="hasAnyRole('ADMIN')">onclick="paidstatus(this, ${activeorder.id})" class="true"</sec:authorize>>
                                    <p>Nicht bezahlt</p>
                                </c:if>
                                <sec:authorize access="hasAnyRole('ADMIN')">
                                    <div class="One"><div id="button${activeorder.id}" onclick="changeactive(this, ${activeorder.id})" class="${activeorder.active}"><p>Laufende</p></div></div>
                                </sec:authorize>
                                <div class="clr"></div>
                            </div>
                        </div>
                        <div class="ButtonMoreOneVideo"><a onclick="modalorders('${activeorder.name}', '<fmt:formatDate dateStyle="short" value="${activeorder.date}" />', '<fmt:formatDate type="time" value="${activeorder.date}" />', '${activeorder.event}', '${activeorder.text}', '${activeorder.photo}', '${activeorder.audiogreeting}', '${activeorder.audioname}')" href="#order">näher</a>
                        <form action="delete-video" method="POST" style="margin-top: 10px;" id="vidfile1${loop.index}">
                            <p id="filename1${loop.index}" style="display: inline-block;">
                                <c:if test="${activeorder.pathvideo!=null}">${activeorder.pathvideo}</c:if></p>
                            <c:if test="${activeorder.pathvideo!=null}">
                                <img title="Video wurde gelöscht?" style="display: inline-block; margin-bottom: -3px; cursor: pointer;" id="deletebut1${loop.index}" src="/images/no.png" onclick="deletefile1('${loop.index}')">
                            </c:if>
                            <c:if test="${activeorder.pathvideo==null}">
                                <img title="Video wurde gelöscht?" style="display: none; margin-bottom: -3px; cursor: pointer;" id="deletebut1${loop.index}" src="/images/no.png" onclick="deletefile1('${loop.index}')">
                            </c:if>
                            <input type="hidden" name="filename" id="filedelete1${loop.index}" value="<c:if test="${activeorder.pathvideo!=null}">${activeorder.pathvideo}</c:if>">
                        </form>
                        </div>
                        <div class="clr"></div>
                    </div>
                </c:forEach>
            </div>
            <div id="Page3">
                <c:forEach var="neworder" items="${neworder}" varStatus="loop">
                    <c:if test="${neworder.paymentsystem!=null}">
                    <div class="OneVideo" id="videonew${loop.index}">
                        <div class="BlVideo" id="videoblock${loop.index}"><div class="Center">
                               <div style="display: none; width: 370px; height: 240px;" class="player" id="videoplayernew${loop.index}"></div>
                        </div></div>
                        <div class="RightDes">
                            <div class="TitleOneVideo"><p>${neworder.event}</p></div>
                            <div class="NameDate"><p style="padding-right: 5px;">${neworder.name}</p><p><fmt:formatDate dateStyle="short" value="${neworder.date}" /></p></div>
                            <div class="clr"></div>
                            <div class="Confirmation">
                                <c:if test="${neworder.paidstatus==true}">
                                    <img src="images/MyOrders/yes.png" <sec:authorize access="hasAnyRole('ADMIN')">onclick="paidstatus(this, ${neworder.id})"  class="false"</sec:authorize>>
                                    <p>Bezahlt</p>
                                </c:if>
                                <c:if test="${neworder.paidstatus==false}">
                                    <img src="images/MyOrders/no.png" <sec:authorize access="hasAnyRole('ADMIN')">onclick="paidstatus(this, ${neworder.id})" class="true"</sec:authorize>>
                                    <p>Nicht bezahlt</p>
                                </c:if>
                                <sec:authorize access="hasAnyRole('ADMIN')">
                                    <div class="One"><div id="button${neworder.id}" onclick="changeactive(this, ${neworder.id})" class="${neworder.active}"><p>Neue</p></div></div>
                                </sec:authorize>
                                <div class="clr"></div>
                            </div>
                        </div>
                        <div class="ButtonMoreOneVideo"><a onclick="modalordersnew('${neworder.name}', '<fmt:formatDate dateStyle="short" value="${neworder.date}" />', '<fmt:formatDate type="time" value="${neworder.date}" />', '${neworder.event}', '${neworder.text}', '${neworder.id}', '${neworder.photo}', '${loop.index}', '${neworder.star.id}', '${neworder.audiogreeting}', '${neworder.audioname}')" href="#neworder">näher</a>
                            <form action="delete-video" method="POST" style="margin-top: 10px;" id="vidfile${loop.index}">
                                <p id="filename${loop.index}" style="display: inline-block;">
                                    <c:if test="${neworder.pathvideo!=null}">${neworder.pathvideo}</c:if></p>
                                <c:if test="${neworder.pathvideo!=null}">
                                    <img title="Video wurde gelöscht?" style="display: inline-block; margin-bottom: -3px; cursor: pointer;" id="deletebut${loop.index}" src="/images/no.png" onclick="deletefile('${loop.index}')">
                                </c:if>
                                <c:if test="${neworder.pathvideo==null}">
                                    <img title="Video wurde gelöscht?" style="display: none; margin-bottom: -3px; cursor: pointer;" id="deletebut${loop.index}" src="/images/no.png" onclick="deletefile('${loop.index}')">
                                </c:if>
                                <input type="hidden" name="filename" id="filedelete${loop.index}" value="<c:if test="${neworder.pathvideo!=null}">${neworder.pathvideo}</c:if>">
                                <p id="filename2${loop.index}" style="display: inline-block;">
                            </form>

                        </div>
                        <div class="clr"></div>

                    </div>
                    </c:if>
                </c:forEach>

                <div id="output"><!-- error or success results --></div>
                <div id="videorecord" class="remodal" data-remodal-id="neworder">
                    <div class="TopBlockM" id="topmodal">
                        <div class="FotoModal"><img style="width: 180px" id="photonew" src=""></div>
                        <p id="modalnamenew"></p>
                        <p id="modaldatenew"></p>
                        <p id="modaltimenew"></p>
                        <p id="modaleventnew"></p>
                        <div class="clr"></div>
                    </div>
                    <div class="BottomBlcokM">
                            <p id="modaltextnew"></p>
                            <div id="audionameblock" style="width: 255px; display: block;">
                                <p  id="text1">Audioaufnahme des Namens</p>
                                <audio id="audioname" style="width: 255px" src=""></audio>
                            </div>
                            <div id="audiotextblock" style="width: 255px; display: block;">
                                <p id="text2">Audiobestellung</p>
                                <audio id="audiotext" style="width: 255px" src=""></audio>
                            </div>
                    </div>

                    <div id="loadvideos" style="max-width: 650px;">
                        <sec:authorize access="hasAnyRole('STAR')">
                        <video width="360" id="video" autoplay muted style="margin: auto;"></video>
                            <div id="timer" style="display:none"><span id="minutes">00</span>:<span id="seconds">00</span></div>
                            <div id="select">
                            <form method="POST" id="videoform" action="/new-video-with-file" onChange="editVideo()" enctype="multipart/form-data">

                                <div id="videofile"><div id="videoupload">
                                    <input type="file" name="file" id="upload" class="remodal-close1" accept="video/*" onclick="javascript: window.location = '#'" >Datei hochladen
                                    <input type="hidden"
                                           name="${_csrf.parameterName}"
                                           value="${_csrf.token}" />
                                    <input type="hidden" name="id" id="orderid" value="" />
                                </div></div>
                            </form>
                            <%-- <button id="upload">
                                 Загрузить файл
                             </button>--%>
                            <div id="requestblock">
                                <button id="request">
                                    Videoaufnahme
                                </button>
                            </div>
                        </div>
                        <div id="record">
                            <a disabled="" id="start"></a>

                            <input type="hidden" name="id" id="loopvalue" value="" />
                            <input type="hidden" name="starid" id="starid" value="" />
                        </div>
                        </sec:authorize>
                        <script>
                            var ourtimer, videoscreen, reqBtn, record, startBtn, ul, stream, recorder, vid, recordedBlobs, blobphoto, source;
                            videoscreen = document.getElementById('video');
                            reqBtn = document.getElementById('request');
                            startBtn = document.getElementById('start');
                            loopindex = document.getElementById('loopvalue');
                            record = document.getElementById('record');
                            select = document.getElementById('select');
                            ul = document.getElementById('ul');
                            reqBtn.onclick = requestVideo;
                            startBtn.onclick = startRecording;
                            startBtn.disabled = true;
                            ul.style.display = 'none';
                            stopBtn.disabled = true;
                            var localStream;
                            var mediaSource = new MediaSource();
                            var sourceBuffer;
                            var MediaStream;
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
                                $("#topmodal").css("display", "none");
                                videoscreen.style.display = 'block';
                                startBtn.style.display = 'inline-block';
                                document.getElementById('timer').style.display = 'inline-block';
                                startBtn.removeAttribute('disabled');
                                select.style.display = 'none';
                                record.style.display = 'block';
                                console.log('getUserMedia() got stream: ', stream);
                                window.stream = stream;
                                localStream= stream;
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
                                    window.location = '#';
                                } else {
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
                                                        'use other browser for record with webcam');
                                                console.error('Exception while creating MediaRecorder:', e2);
                                                return;
                                            }
                                        }
                                    }
                                    recorder.start(10);
                                }
                                recorder.ondataavailable = function (e) {
                                    try {
                                        vid = e.data;
                                        if (vid && vid.size > 0) {
                                            recordedBlobs.push(vid);
                                        }
                                    } catch (e2) {
                                        alert("error send");
                                    }
                                };
                                recorder.onstop = function (e1) {
                                }
                                setTimeout(timer,1000);

                            }
                            function stopRecording() {
                                ourtimer=false;
                                videoscreen.style.display = 'none';
                                recorder.stop();
                                send();

                            }
                            function closevideoorder(){
                                try {
                                    localStream.stop();
                                } catch(e) {
                                    localStream.getVideoTracks().forEach(function (track) {
                                        track.stop();
                                    });
                                }
                                videoscreen.style.display = 'none';
                                document.getElementById('select').style.display = 'block';
                                ourtimer=false;
                                document.getElementById('seconds').innerHTML='00';
                                document.getElementById('minutes').innerHTML='00';
                                document.getElementById('timer').style.display = 'none';
                                document.getElementById('record').style.display = 'none';
                            }
                            function send() {
                                $("#progress-wrp").css("display", "block");
                                $(".background-progress").css("display", "block");
                                var canvas = document.createElement('canvas');
                                canvas.width  = videoscreen.videoWidth;
                                canvas.height = videoscreen.videoHeight;
                                var ctx = canvas.getContext('2d');
                                ctx.drawImage(videoscreen, 0, 0);
                                var dataURL = canvas.toDataURL('image/png');
                                blobphoto = dataURItoBlobs(dataURL);
                                var xhrphoto = new XMLHttpRequest();
                                xhrphoto.open('POST', '/new-first-frame', true);
                                xhrphoto.setRequestHeader("Content-Type", "image/png");
                                xhrphoto.setRequestHeader("id",  document.getElementById('orderid').value);
                                xhrphoto.send(blobphoto);
                                xhrphoto.onload=function(e) {
                                }

                                var superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
                                var xhr = new XMLHttpRequest();
                                xhr.open('POST', '/new-video-with-web', true);
                                xhr.onload = function (e) {
                                    //$(".modalWaiting").css("display", "none");
                                    $("#vidfile" + loopindex.value).css("display", "block");
                                    var data = xhr.response.replace(/\s+/g, '');
                                    $("#filename" + loopindex.value).html(data);
                                    $("#filename2" + loopindex.value).html('Video wurde hochgeladen! Die Bestellung wird ins „Laufende“ überführt!');
                                    $("#filedelete" + loopindex.value).val(data);
                                    $("#deletebut" + loopindex.value).css("display", "inline-block");
                                    $('#videoplayernew'+loopindex.value).css('display', 'block');
                                    var player = new Uppod({m:"video",uid:"videoplayernew"+loopindex.value,file:'/video-service?namevideo='+document.getElementById('orderid').value+'.mp4'+'&id='+document.getElementById('starid').value+ '?' + new Date().getTime(),poster:'/starSource/'+document.getElementById('starid').value+"/"+document.getElementById('orderid').value+".png"+ '?' + new Date().getTime()});
                                    $("#progress-wrp").css("display", "none");
                                    $(".background-progress").css("display", "none");
                                    $("#progress-text").css("display", "none");

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
                                                if(percent==100){
                                                    $("#progress-text").css('display', 'block');
                                                    $("#progress-text").text("your file was uploaded and now it is converted");
                                                }
                                    } else {

                                    }
                                }

                                xhr.onerror = function (e) {
                                    $("#filename" + loopindex.value).html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal");
                                }
                                xhr.setRequestHeader("Content-Type", "video/webm");
                                xhr.setRequestHeader("id", document.getElementById('orderid').value);
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
                                    url: '/new-video-with-file',
                                    enctype: "multipart/form-data",
                                    contentType: false,
                                    processData: false,
                                    cache: false,
                                    data: formData,
                                    success: function (data) {
                                         $(".background-progress").css("display", "none");
                                        $("#progress-wrp").css("display", "none");
                                        $("#progress-text").css('display', 'none');
                                         $("#vidfile"+loopindex.value).css("display", "block");
                                        var datacrop=data.replace(/\s+/g, '');
                                        $("#filename"+loopindex.value).html(data);
                                        if(datacrop!="fileformatnotsupport") {
                                            $("#filename2" + loopindex.value).html('Video wurde hochgeladen! Die Bestellung wird ins „Laufende“ überführt!');
                                            $("#filedelete" + loopindex.value).val(datacrop);
                                            $("#deletebut" + loopindex.value).css("display", "inline-block");
                                            $('#videoplayernew' + loopindex.value).css('display', 'block');
                                            this.player = new Uppod({
                                                m: "video",
                                                uid: "videoplayernew" + loopindex.value,
                                                file: '/video-service?namevideo=' + document.getElementById('orderid').value + '.mp4' + '&id=' + document.getElementById('starid').value + '?' + new Date().getTime(),
                                                poster: '/starSource/' + document.getElementById('starid').value + "/" + document.getElementById('orderid').value + ".png" + '?' + new Date().getTime()
                                            });
                                        }



                                    },
                                    error: function (e) {
                                        console.log(e);
                                        $("#filename"+loopindex.value).html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal");
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
                            function deletefile(loop) {
                                var formData = $('#vidfile'+loop);
                                $.ajax({
                                    type: "POST",
                                    url: '/delete-video',
                                    data: formData.serialize(),
                                    success: function (data) {
                                        $("#deletebut"+loop).css("display", "none");
                                        $("#filename"+loop).html('Video wurde gelöscht!');
                                        $("#filename2"+loop).html('');
                                        $("#filedelete"+loop).val('');
                                    },
                                    error: function (e) {
                                        console.log(e);
                                    }
                                });

                            }
                            function deletefile1(loop) {
                                var formData = $('#vidfile1'+loop);
                                $.ajax({
                                    type: "POST",
                                    url: '/delete-video',
                                    data: formData.serialize(),
                                    success: function (data) {
                                        $('#deletebut1'+loop).css("display", "none");
                                        $("#filename1"+loop).html('Video wurde gelöscht! Die Bestellung wird ins „Neue“ überführt!');
                                        /* $('#videoactive'+loop).appendTo($('#Page3'));
                                         $('#videoblock'+loop).css('display', 'none');*/
                                        $("#filedelete1"+loop).val('');
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
    </section>
</div>
<script>
    var current = 'Page3';
    function showpage(id, but) {
        document.getElementById(current).style.display = 'none';
        $('#onebot').attr("class", "Two");
        $('#twobot').attr("class", "Two");
        $('#threebot').attr("class", "Two");
        document.getElementById(id).style.display = 'block';
        $(but).attr("class", "One");
        current = id;
        return false;
    }
    function modalorders(name, date, time, event, text, photo, audiogreeting, audioname){
        $("#modalname").html(' ');
        $("#modaldate").html(' ');
        $("#modaltime").html(' ');
        $("#modalevent").html(' ');
        $("#modaltext").html(' ');
        $("#modalname").append("<span>Empfänger </span>"+name);
        $("#modaldate").append("<span>Datum </span>"+date);
        $("#modaltime").append("<span>Zeit </span>"+time);
        $("#modalevent").append("<span>Betreff </span>"+event);
        $("#modaltext").append(text);
        $("#photoactive").attr("src", photo);
        return false;
    }
    function modalordersnew(name, date, time, event, text, id, photo, loop, starid, audiogreeting, audioname){
        $("#loopvalue").val(loop);
        $("#modalnamenew").html(' ');
        $("#modaldatenew").html(' ');
        $("#modaltimenew").html(' ');
        $("#modaleventnew").html(' ');
        $("#modaltextnew").html(' ');
        $("#orderid").html(' ');
        $("#modalnamenew").append("<span>Empfänger </span>"+name);
        $("#modaldatenew").append("<span>Datum </span>"+date);
        $("#modaltimenew").append("<span>Zeit </span>"+time);
        $("#modaleventnew").append("<span>Betreff </span>"+event);
        var audiotext = $("#audiotext");
        var audionameblock = $("#audioname");
        $("#modaltextnew").append(text);
        if(audiogreeting!=="audiogreeting"+id+".wav") {
            $("#text2").css('display', 'none');
            audiotext.css('display', 'none');
            audiotext.attr("src", "");
            audiotext.attr("controls", "false");
        } else {
            audiotext.attr("src", "/audiogreeting-play?star="+starid+"&order="+id);
            audiotext.attr("controls", "true");
            audiotext.css('display', 'block');
            $("#text2").css('display', 'block');
        }
        if(audioname!=="audioname"+id+".wav") {
            $("#text1").css('display', 'none');
            audionameblock.css('display', 'none');
            audionameblock.attr("src", "");
            audionameblock.attr("controls", "false");
        } else {
            $("#text1").css('display', 'block');
            audionameblock.attr("src", "/audio-play?star="+starid+"&order="+id);
            audionameblock.attr("controls", "true");
            //audionameblock.css('display', 'block');
        }
        $("#orderid").val(id);
        $("#starid").val(starid);
        $("#photonew").attr("src", photo);
        return false;
    }
    function dataURItoBlobs(dataURI) {
        if(typeof dataURI !== 'string'){
            throw new Error('Invalid argument: dataURI must be a string');
        }
        dataURI = dataURI.split(',');
        var type = dataURI[0].split(':')[1].split(';')[0],
                byteString = atob(dataURI[1]),
                byteStringLength = byteString.length,
                arrayBuffer = new ArrayBuffer(byteStringLength),
                intArray = new Uint8Array(arrayBuffer);
        for (var i = 0; i < byteStringLength; i++) {
            intArray[i] = byteString.charCodeAt(i);
        }
        return new Blob([intArray], {
            type: type
        });
    }
</script>
<sec:authorize access="hasAnyRole('ADMIN')">
    <script>
        function paidstatus(elem, id){
            var form = $('<form action="/change-paidstatus" method="POST" >');
            var paidstatus = $('<input>', { name: "paidstatus", type: "hidden", value: elem.className });
            var orderid = $('<input>', { name: "id", type: "hidden", value: id });
            form.append(paidstatus);
            form.append(orderid);
            $.ajax({
                    type: "POST",
                    url: "/change-paidstatus",
                    data: form.serialize(),
                success: function(data){
                    if(elem.className=="false"){
                        $(elem).attr('src', 'images/MyOrders/no.png');
                        elem.className="true";
                        $(elem).next().text('Nicht bezahlt');
                    }else{
                        $(elem).attr('src', 'images/MyOrders/yes.png');
                        elem.className="false";
                        $(elem).next().text('Bezahlt');
                    }
                },
                error: function(e){
                }
            });
        }
        function changeactive(elem, id){
            var form = $('<form action="/change-active" method="POST" >');
            var active = $('<input>', { name: "active", type: "hidden", value: elem.className });
            var orderid = $('<input>', { name: "id", type: "hidden", value: id });
            form.append(active);
            form.append(orderid);
            $.ajax({
                type: "POST",
                url: "change-active",
                data: form.serialize(),
                success: function(data){
                    var datacrop=data.replace(/\s+/g, '');
                    elem.className=datacrop;
                    if(datacrop==-2){
                        $(elem).html('<p>Neue</p>');
                    }else if(datacrop==-1){
                        $(elem).html('<p>Laufende</p>');
                    }else if(datacrop==1){
                        $(elem).html('<p>Abgeschlossene</p>');
                    }
                },
                error: function(e){

                }
            });
        }
    </script>
</sec:authorize>