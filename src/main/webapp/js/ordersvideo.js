/**
 * Created by Admin on 25.07.2016.
 */
var videoscreen, reqBtn, record, startBtn, ul, stream, recorder, vid, recordedBlobs, blobphoto, source;
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
}
function stopRecording() {

    videoscreen.style.display = 'none';
    recorder.stop();
    send();

}
function send() {
    $(".modalWaiting").css("display", "block");
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
        $(".modalWaiting").css("display", "none");
        $("#vidfile" + loopindex.value).css("display", "block");
        var data = xhr.response.replace(/\s+/g, '');
        $("#filename" + loopindex.value).html(data);
        $("#filename2" + loopindex.value).html('Video wurde hochgeladen! Die Bestellung wird ins „Laufende“ überführt!');
        $("#filedelete" + loopindex.value).val(data);
        $("#deletebut" + loopindex.value).css("display", "inline-block");
        $('#newvideo'+loopindex.value).css('display', 'block');
        $('#newvideo'+loopindex.value).attr('src', '/video-service?namevideo='+document.getElementById('orderid').value+'.webm');
        $('#newvideo'+loopindex.value).attr('poster', '/starSource/'+document.getElementById('starid').value+"/"+document.getElementById('orderid').value+".png");
        var video = $("#newvideo"+loopindex.value);
        document.getElementById('newvideo'+loopindex.value).controls = true;
        video[0].load();
        video[0].play();
    }
    xhr.onerror = function (e) {
        $("#filename" + loopindex.value).html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal");
    }
    xhr.setRequestHeader("Content-Type", "video/webm");
    xhr.setRequestHeader("id", document.getElementById('orderid').value);
    xhr.send(superBuffer);
}
function editVideo() {
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
            $(".modalWaiting").css("display", "none");
            $("#vidfile"+loopindex.value).css("display", "block");
            var datacrop=data.replace(/\s+/g, '');
            $("#filename"+loopindex.value).html(datacrop);
            $("#filename2"+loopindex.value).html('Video wurde hochgeladen! Die Bestellung wird ins „Laufende“ überführt!');
            $("#filedelete"+loopindex.value).val(datacrop);
            $("#deletebut"+loopindex.value).css("display", "inline-block");
            $('#newvideo'+loopindex.value).css('display', 'block');
            $('#newvideo'+loopindex.value).attr('src', '/video-service?namevideo='+document.getElementById('orderid').value+'.webm');
            $('#newvideo'+loopindex.value).attr('poster', '/starSource/'+document.getElementById('starid').value+"/"+document.getElementById('orderid').value+".png");
            var video = $("#newvideo"+loopindex.value);
            document.getElementById('newvideo'+loopindex.value).controls = true;
            video[0].load();
            video[0].play();
        },
        error: function (e) {
            console.log(e);
            $("#filename"+loopindex.value).html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal");
        }
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