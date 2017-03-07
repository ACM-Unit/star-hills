<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="/js/crop/jquery.min.js"></script>
<script src="/js/crop/jquery.Jcrop.js"></script>
<script type="text/javascript">
    var jcrop_api;
 jQuery(function(){

 jQuery('#cropbox').Jcrop({
 aspectRatio: 1.375,
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
                url: '/photocrop',
                data: formData.serialize(),
                success: function (data) {
                    $('#wrapper3').css('background', 'lightgreen');
                    jcrop_api.setImage("/starSource/defaultcharitycrop.png"+ '?' + new Date().getTime());
                    $('#ok').css('display', 'block');
                    $('#croppedphoto').val('1');
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
<div id="AllBodyCheck">
    <section>
        <div id="TitleCheckIn2">
            <h1><span>Die</span> Wohltätigkeitsprojekte</h1>
            <div id="BelowlH1">Liebe Freunde! Jeder von Ihnen kann eine Wohltätigkeitsstiftung vorschlagen. Wir freuen uns auf Ihre Vorschläge!</div>
        </div>
    </section>
</div>


<div id="BlockCheckInaAll">
    <form id="Charity"  method="POST">
    <section>
        <div id="CenterCheckIn">Ich möchte eine Stiftung vorschlagen</div>
        <label><div id="BlockNamePr"><p>Name des Projektes</p><input type="text" name="ProjeckName" required /></div></label>
        <div class="clr"></div>
        <label><div class="BlockNameAll"><p>Vorname/Nachname</p><input type="text" name="FoolName" required  /></div></label>
        <label><div class="BlockNameAll"><p>Benötigte Summe</p><input type="text" name="Summa" /></div></label>
        <label><div class="BlockNameAll"><p>E-mail</p><input id="CharityEmail" type="text" name="Email" /><span style='margin-top: 13px;' id="validEmail"></span></div></label>
        <label><div class="BlockNameAll"><p>Frist (bis wann)</p><input type="text" id="datepicker" name="When" /></div></label>
        <label><div class="BlockNameAll2"><p>Adresse des Projektes</p><textarea type="text" cols="45" rows="4" name="Adress" ></textarea></div></label>
        <label><div class="BlockNameAll2"><p>Wie sind Sie auf StarHills aufmerksam geworden?</p><textarea type="text" cols="45" rows="4" name="How" ></textarea></div></label>
        <div class="clr"></div>
        <label><div id="BlockProject"><p>Projektbeschreibung</p>
            <div id="Texteditor">
                <textarea name="editor1" id="editor1" cols="45" rows="5" value=""></textarea>
                <script type="text/javascript">
                    CKEDITOR.replace( 'editor1', {
                        language: 'de',
                        uiColor: '#9AB8F3'
                    });
                </script>
            </div></div></label>
        <div class="clr"></div>
        <div class="mask-wrapper"  id="wrapper1">
            <div class="mask">
                <input id="my_file1" class="fileInputText" type="text" placeholder="Video hochladen" disabled>
                <button class="send-file">wählen...</button>
                <div id="fileList1" ></div>
            </div>
            <input class="custom-file-input" id="my_file11" type="file" multiple name="file" accept="video/*">
        </div>
        <div class="mask-wrapper"  id="wrapper2">
            <div class="mask">
                <input id="my_file2" class="fileInputText" type="text" placeholder="Bild hochladen" disabled>
                <button class="send-file">wählen...</button>
                <div id="fileList2" style="height:10px"></div>
            </div>
            <input  class="custom-file-input" id="my_file12" type="file" multiple name="file" accept="image/*">
        </div>
        <div class="mask-wrapper" id="wrapper3">
            <div class="mask">
                <input id="my_file3" class="fileInputText" type="text" placeholder="Abdeckung hochladen" disabled>
                <button class="send-file">wählen...</button>
                <div id="fileList3" ></div>
            </div>
            <input  class="custom-file-input" type="file" id="my_file13" name="mainfile" accept="image/*">
        </div>
        <div class="mask-wrapper"  id="wrapper4">
            <div class="mask">
                <input id="my_file4" class="fileInputText" type="text" placeholder="Dokumente hochladen" disabled>
                <button class="send-file">wählen...</button>
                <div id="fileList4" ></div>
            </div>
            <input  class="custom-file-input" type="file" id="my_file14" name="docfile"  accept=".pdf">
        </div>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
        <input type="hidden"
               name="croppedphoto"
               id="croppedphoto"
               value="0"/>
        <div class="clr"></div>
        <div id="ButtonSendAll" ><a onclick="charitySave()">Senden</a></div>
        <script src="/js/charity.js" type="text/javascript" ></script>
        <div id="validationcharity"></div>
    </section>
    </form>
    <script type="text/javascript">
        window.onload = function(){
            document.getElementById('my_file11').onchange = function(e){
                $('#wrapper1').css('background', 'lightgreen');
                var numFiles = e.currentTarget.files.length;
                var names='';
                for (i=0;i<numFiles;i++){
                    if(i<numFiles-1){
                        names=names+e.currentTarget.files[i].name+", ";
                    } else {
                        names=names+e.currentTarget.files[i].name;
                    }
                }
                $('#my_file1').attr('placeholder', names);
                };
            document.getElementById('my_file12').onchange = function(e){
                $('#wrapper2').css('background', 'lightgreen');
                var numFiles = e.currentTarget.files.length;
                var names='';
                for (i=0;i<numFiles;i++){
                    if(i<numFiles-1){
                        names=names+e.currentTarget.files[i].name+", ";
                    } else {
                        names=names+e.currentTarget.files[i].name;
                    }
                }
                $('#my_file2').attr('placeholder', names);
            };
            document.getElementById('my_file13').onchange = function(){
                var formData =  new FormData($('#Charity')[0]);
                $.ajax({
                    type: "POST",
                    url: '/photo-upload',
                    enctype: "multipart/form-data",
                    contentType: false,
                    processData: false,
                    cache: false,
                    data: formData,
                    success: function (data) {
                        try {
                            jcrop_api.setImage("/starSource/defaultcharity.png" + '?' + new Date().getTime());
                            document.location.href = '#cropphoto';
                        }catch(e){

                        }
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            };
            document.getElementById('my_file14').onchange = function(){
                $('#wrapper4').css('background', 'lightgreen');
                $('#my_file4').attr('placeholder', this.value);
            };
        };
        function charitySave(){
            var chek=true;
            var email=$('[name="Email"]').val();
            $('form[id="Charity"]').find('input').not('[type="submit"]').not('[type="hidden"]').not('[name="How"]').not('[class="fileInputText"]').not('[type="file"]').each(function() {
                if (this.value == 0){
                    $(this).css("box-shadow", "0 0 5px red");
                    $(this).next('.span').remove();
                    $(this).after('<span class="span" style="display: block; text-align: right; color: red; font-size:12px">это поле должно быть заполнено</span>');
                    chek=false;
                }
            });
            if (isValidEmailAddress(email) && chek==true) {
                var formData = new FormData($('#Charity')[0]);
                var areaText = CKEDITOR.instances['editor1'].getData();
               formData.append('editor', areaText);
                $.ajax({
                    type: "POST",
                    url: '/save-charity',
                    enctype: "multipart/form-data",
                    contentType: false,
                    processData: false,
                    cache: false,
                    data: formData,
                    success: function (data) {
                        $('form[id="Charity"]').find('input, textarea').not('[type="submit"]').not('[type="hidden"]').each(function() {
                            $(this).css("box-shadow", "none");
                            $(this).next('.span').remove();
                            $(this).val('');
                        });
                        CKEDITOR.instances['editor1'].updateElement();
                        CKEDITOR.instances['editor1'].setData('');
                        $("#validEmail").css({
                            "background-image": "none"
                        });
                        $('#wrapper3').css('background', 'none');
                        $('#my_file3').attr('placeholder', 'Abdeckung hochladen');
                        $('#BlockCheckInaAll').css('display', 'none');
                        $('#regSuchess').css('display', 'block');
                        setInterval(function() { // ставим пятисекундный интервал для перелистывания картинок
                            $('#BlockCheckInaAll').css('display', 'block');
                            $('#regSuchess').css('display', 'none');
                        },5000);
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }
        }

    </script>
    <div class="remodal" data-remodal-id="cropphoto" style="width: 100%;">
        <p>wählen Sie den Bereich für den Schnitt</p>
        <div id="imagebox" style="width: 100%; overflow: scroll; margin-top: 10px">
        <img src="/starSource/defaultcharity.png" id="cropbox"  style="display: inline-block; " />
        </div>

        <form method="POST" action="/photocrop" id="photocrop">
            <input type="hidden" id="x" name="x" />
            <input type="hidden" id="y" name="y" />
            <input type="hidden" id="w" name="w" />
            <input type="hidden" id="h" name="h" />
        </form>
        <button id="cropbutton" value="Crop Image" style="display: block; margin: 10px auto;" class="btn btn-large btn-inverse" onclick="checkCoords()">Foto zuschneiden</button>
        <button id="ok" value="Crop Image" style="margin: 10px auto;" class="btn btn-large btn-inverse" onclick="javascript: window.location='#';">Ok</button>
    </div>
</div>
<div id="regSuchess">
    <p>Ihr Projekt wurde gespeichert</p>
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
    $.noConflict();
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
                } else {
                    $('input[name=Date]').css('border', '2px solid #FF0026');
                    $('input[name=Date]').css('border-radius', '5px');
                }
            }
        });
        $(".datepicker").datepicker( $.datepicker.regional[ "de" ] );
    });
</script>