var videoscreen, videoplay, reqBtn, sendBtn, playBtn, startBtn, stopBtn, ul, stream, recorder, vid, recordedBlobs;
videoscreen = document.getElementById('video');
videoplay = document.getElementById('videoplay');
reqBtn = document.getElementById('request');
startBtn = document.getElementById('start');
stopBtn = document.getElementById('stop');
playBtn = document.getElementById('play');
sendBtn = document.getElementById('send');
loopindex = document.getElementById('loopvalue');
record = document.getElementById('record');
select = document.getElementById('select');
ul = document.getElementById('ul');
reqBtn.onclick = requestVideo;
startBtn.onclick = startRecording;
stopBtn.onclick = stopRecording;
playBtn.onclick = play;
sendBtn.onclick = send;
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
    /* var isSecureOrigin = location.protocol === 'https:' ||
     location.host === 'localhost';
     if (!isSecureOrigin) {
     alert('getUserMedia() must be run from a secure origin: HTTPS or localhost.' +
     '\n\nChanging protocol to HTTPS');
     location.protocol = 'HTTPS';
     }*/

    navigator.getUserMedia = navigator.getUserMedia ||
        navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

    var constraints = {
        audio: true,
        video: false
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
    videoplay.style.display = 'none';
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
    recordedBlobs = [];
    var options={mimeType: 'video/webm'};
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
    videoscreen.style.display = 'block';
    videoplay.style.display = 'none';
    startBtn.style.display = 'none';
    stopBtn.style.display = 'inline-block';
    recorder.start(10);
    stopBtn.removeAttribute('disabled');
    startBtn.disabled = true;
    playBtn.style.display = 'none';
    sendBtn.style.display = 'none';
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
}
function stopRecording() {
    startBtn.style.display = 'inline-block';
    stopBtn.style.display = 'none';
    playBtn.style.display = 'inline-block';
    sendBtn.style.display = 'block';
    videoscreen.style.display = 'none';
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

}
function send() {
    $(".modalWaiting").css("display", "block");
    var superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/new-video-with-web', true);
    xhr.onload=function(e){
        try {
            localStream.stop();
        } catch(e) {
            localStream.getVideoTracks().forEach(function (track) {
                track.stop();
            });
        }
        $(".modalWaiting").css("display", "none");
        $("#vidfile"+loopindex.value).css("display", "block");
        var data=xhr.response.replace(/\s+/g, '');
        $("#filename"+loopindex.value).html(data);
        $("#filename2"+loopindex.value).html('Video wurde hochgeladen! Die Bestellung wird ins „Laufende“ überführt!');
        $("#filedelete"+loopindex.value).val(data);
        $("#deletebut"+loopindex.value).css("display", "inline-block");

    }
    xhr.onerror=function(e){
        $("#filename"+loopindex.value).html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
    }
    xhr.setRequestHeader("Content-Type", "video/webm");
    xhr.setRequestHeader("id",  document.getElementById('orderid').value);
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
        },
        error: function (e) {
            console.log(e);
            $("#filename"+loopindex.value).html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
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

