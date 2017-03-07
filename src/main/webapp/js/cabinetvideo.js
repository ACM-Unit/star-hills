/**
 * Created by Admin on 25.07.2016.
 */
var videoscreen, videoplay, confirm, reqBtn, startBtn,record, stream, recorder, vid, recordedBlobs;
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
    document.getElementById('record').style.display = 'none';
}
function send() {
    $(".modalWaiting").css("display", "block");
    var superBuffer = new Blob(recordedBlobs, {type: 'video/webm'});
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/video-service', true);
    xhr.onload=function(e){
        $(".modalWaiting").css("display", "none");
        $("#vidfile").css("display", "block");
        var data=xhr.response.replace(/\s+/g, '');
        $("#filename").html(data);
        $("#filedelete").val(data);
        $("#deletebut").css("display", "inline-block");
        $('#videoplay').css('display', 'block');
        $('#videoplay').attr('src', '/video-service?namevideo=videoconfirm.webm');
        var video = $("#videoplay");
        document.getElementById('videoplay').controls = true;
        video[0].load();
        video[0].play();
    }
    xhr.onerror=function(e){
        $("#filename").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
    }
    xhr.setRequestHeader("Content-Type", "video/webm");
    xhr.setRequestHeader("id",  document.getElementById('starid').value);
    xhr.send(superBuffer);
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
            $(".modalWaiting").css("display", "none");
            $("#vidfile").css("display", "block");
            var datacrop=data.replace(/\s+/g, '');
            $("#filename").html(datacrop);
            $("#filedelete").val(datacrop);
            $("#deletebut").css("display", "inline-block");
            $('#videoplay').css('display', 'block');
            $('#videoplay').attr('src', '/video-service?namevideo=videoconfirm.webm');
            var video = $("#videoplay");
            document.getElementById('videoplay').controls = true;
            video[0].load();
            video[0].play();
        },
        error: function (e) {
            $("#filename").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
            console.log(e);
        }
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