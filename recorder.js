/**
 * Created by slava on 20.07.16.
 */

(function(window){
var ourtimer;
var WORKER_PATH = '/js/recorderWorker.js';

    var Recorder = function(source, cfg){
        var config = cfg || {};
        var bufferLen = config.bufferLen || 4096;
        this.context = source.context;
        if(!this.context.createScriptProcessor){
            this.node = this.context.createJavaScriptNode(bufferLen, 2, 2);
        } else {
            this.node = this.context.createScriptProcessor(bufferLen, 2, 2);
        }

        var worker = new Worker(config.workerPath || WORKER_PATH);
        worker.postMessage({
            command: 'init',
            config: {
                sampleRate: this.context.sampleRate
            }
        });
        var recording = false,
            currCallback;

        this.node.onaudioprocess = function(e){
            if (!recording) return;
            worker.postMessage({
                command: 'record',
                buffer: [
                    e.inputBuffer.getChannelData(0),
                    e.inputBuffer.getChannelData(1)
                ]
            });
        }

        this.configure = function(cfg){
            for (var prop in cfg){
                if (cfg.hasOwnProperty(prop)){
                    config[prop] = cfg[prop];
                }
            }
        }
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
        this.record = function(){
            recording = true;
            ourtimer=true;
            document.getElementById('timer').style.display = 'inline-block';
            setTimeout(timer,1000);
        }

        this.stop = function(){
            recording = false;
            ourtimer=false;
            document.getElementById('seconds').innerHTML='00';
            document.getElementById('minutes').innerHTML='00';
            document.getElementById('timer').style.display = 'none';
        }

        this.clear = function(){
            worker.postMessage({ command: 'clear' });
        }

        this.getBuffers = function(cb) {
            currCallback = cb || config.callback;
            worker.postMessage({ command: 'getBuffers' })
        }

        this.exportWAV = function(cb, type){
            currCallback = cb || config.callback;
            type = type || config.type || 'audio/wav';
            if (!currCallback) throw new Error('Callback not set');
            worker.postMessage({
                command: 'exportWAV',
                type: type
            });
        }

        this.exportMonoWAV = function(cb, type){
            currCallback = cb || config.callback;
            type = type || config.type || 'audio/wav';
            if (!currCallback) throw new Error('Callback not set');
            worker.postMessage({
                command: 'exportMonoWAV',
                type: type
            });
        }

        worker.onmessage = function(e){
            var blob = e.data;
            currCallback(blob);
        }

        source.connect(this.node);
        this.node.connect(this.context.destination);   // iпf the script node is not connected to an output the "onaudioprocess" event is not triggered in chrome.
    };

    Recorder.setupDownload = function(blob, filename){
      /*  var url = (window.URL || window.webkitURL).createObjectURL(blob);
        var link = document.getElementById("save");
        link.href = url;
        link.download = filename || 'output.wav';*/
        document.getElementById('orderid').value = document.getElementById('idorder').value;
        orderID = document.getElementById('orderid').value;
        var starID = document.getElementById('starid').value;
        $(document).ajaxStart(function () {
            $(".modalWaiting").css("display", "none");
        });
        $("#progress-wrp").css("display", "block");
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/audio-service', true);
        xhr.onload=function(e){
            $("#progress-wrp").css("display", "none");
            var data=xhr.response.replace(/\s+/g, '');
            $("#idorder").val(data);
            var audiostatus = document.getElementById('audiostatus').value;
            if(audiostatus == 0 ) {
                $('#audioname').css('display', 'block');
                var audio = $("#audioname");
                audio.attr("src", "/audio-play?star="+starID+"&order="+data);
                document.getElementById('audioname').controls = true;
                audio[0].oncanplaythrough = audio[0].play();
            }
            if(audiostatus == 1 ) {
                $('#audiogreeting').css('display', 'block');
                var audio = $("#audiogreeting");
                audio.attr("src", "/audiogreeting-play?star="+starID+"&order="+document.getElementById('idorder').value);
                document.getElementById('audiogreeting').controls = true;
                audio[0].oncanplaythrough = audio[0].play();
            }
            if(audiostatus != 0 ) {
                var sent = "sent";
                $('input[name=audiosent]').val(sent);
                $("#SuccessMessage").html("Audioaufnahme wurde erfolgreich hochgeladen, wenn Sie die Aufnahmen wiederholen wollen, dann drücken " +
                    "Sie auf „wiederholen“ und Ihre Audioaufnahme wird ersetzt. Bitte vergessen Sie nicht die Pflichtfelder, wie E-Mail Adresse, " +
                    "Handynummer, Datum und Zeitpunkt des Verschickens, auszufüllen.");
                /*window.location = "#successUp";*/
                $("#audiostzakaz").html("Wiederholen");
                $('#statusErrorOrdering').html('Bitte füllen Sie die Pflichtfelder aus');
                $('input[name=NameOrdering]').css('border', '1px solid #d7d7d7');
                $('input[name=NameTwo]').css('border', '1px solid #d7d7d7');
                $('input[name=Event]').css('border', '1px solid #d7d7d7');
                $('textarea[name=Compliments]').css('border', '1px solid #d7d7d7');
                var email = $("#EmailOrdering").val();
                if (email != 0) {
                    if (isValidEmailAddress(email)) {
                        $('input[name=EmailOrdering]').css('border', '1px solid #d7d7d7');
                        $('input[name=EmailOrdering]').css('border-radius', '5px');
                    } else {
                        $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
                        $('input[name=EmailOrdering]').css('border-radius', '5px');
                    }
                } else {
                    $('input[name=EmailOrdering]').css('border', '2px solid #FF0026');
                    $('input[name=EmailOrdering]').css('border-radius', '5px');
                }

                var email = $("#EmailTwo").val();

                if (email != 0) {
                    if (isValidEmailAddress(email)) {
                        $('input[name=EmailTwo]').css('border', '1px solid #d7d7d7');
                        $('input[name=EmailTwo]').css('border-radius', '5px');
                    } else {
                        $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
                        $('input[name=EmailTwo]').css('border-radius', '5px');
                    }
                } else {
                    $('input[name=EmailTwo]').css('border', '2px solid #FF0026');
                    $('input[name=EmailTwo]').css('border-radius', '5px');
                }

                var PhoneOrdering = $('input[name=PhoneOrdering]').val();
                if (PhoneOrdering != 0) {
                    $('input[name=PhoneOrdering]').css('border', '1px solid #d7d7d7');
                    $('input[name=PhoneOrdering]').css('border-radius', '5px');
                } else {
                    $('input[name=PhoneOrdering]').css('border', '2px solid #FF0026');
                    $('input[name=PhoneOrdering]').css('border-radius', '5px');

                }
                var PhoneTwo = $('input[name=PhoneTwo]').val();
                if (PhoneTwo != 0) {
                    $('input[name=PhoneTwo]').css('border', '1px solid #d7d7d7');
                    $('input[name=PhoneTwo]').css('border-radius', '5px');
                } else {
                    $('input[name=PhoneTwo]').css('border', '2px solid #FF0026');
                    $('input[name=PhoneTwo]').css('border-radius', '5px');

                }

                var Date = $('input[name=Date]').val();
                if (Date != 0) {
                    $('input[name=Date]').css('border', '1px solid #d7d7d7');
                    $('input[name=Date]').css('border-radius', '5px');
                } else {
                    $('input[name=Date]').css('border', '2px solid #FF0026');
                    $('input[name=Date]').css('border-radius', '5px');

                }


                var Time2 = $('input[name=Time]').val();
                if (Time2 != 0) {
                    $('input[name=Time]').css('border', '1px solid #d7d7d7');
                    $('input[name=Time]').css('border-radius', '5px');
                } else {
                    $('input[name=Time]').css('border', '2px solid #FF0026');
                    $('input[name=Time]').css('border-radius', '5px');

                }
            }else{

                $("#SuccessMessage").html("Audioaufnahme mit Empfängername wurde erfolgreich hochgeladen, " +
                    "wenn Sie die Aufnahmen wiederholen wollen, dann drücken Sie auf „wiederholen“ und Ihre " +
                    "Audioaufnahme wird ersetzt. Bitte vergessen Sie nicht die Pflichtfelder, " +
                    "wie E-Mail Adresse, Handynummer, Datum und Zeitpunkt des Verschickens, auszufüllen.");
                $('#statusErrorOrdering').html('Bitte füllen Sie die Pflichtfelder aus');
                $("#audiost").html("Wiederholen");
                /*window.location = "#successUp";*/

            }

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
            $("#SuccessMessage").html("Es stimmt was nicht! Laden Sie bitte die Webseite neu und versuchen Sie noch einmal.");
            /*window.location  = "#successUp";*/
        }
        xhr.setRequestHeader("Content-Type", 'audio/wav');
        xhr.setRequestHeader("idstar",  document.getElementById('starid').value);
        xhr.setRequestHeader("idorder", orderID);
        xhr.setRequestHeader("audiostatus", document.getElementById('audiostatus').value);
        xhr.send(blob);
    }

    window.Recorder = Recorder;

})(window);
