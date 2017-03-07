<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false"%>
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
                url: '/photocropnews',
                data: formData.serialize(),
                success: function (data) {
                    jcrop_api.setImage("/starSource/defaultnewscrop.png"+ '?' + new Date().getTime());
                    $('#wrapper3').css('background', 'lightgreen');
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
<div id="CharitableProjectsTop">
    <section>
        <h1><span>Nachrichten</span></h1>
        <div id="BelowH1Bottom">Hier finden Sie immer die aktuellen Nachrichten über alle unseren Veranstaltungen und erfahren über die Neuheiten und Veränderungen auf unserer Webseite. </div>
    </section>
</div>
<style>
    #Page1{display: block;}</style>
<div id="BlockSlider">
    <section>
        <div id="SliderCharitable">
            <c:forEach items="${news.content}" var="news" varStatus="loop">
                <div><a href="#${news.id}"><img src="starSource/news/${news.id}/${news.newsPhoto}"></a></div>
            </c:forEach>
        </div>
    </section>
</div>

<div id="DescrCharitable">
    <section>
        <p>Wir freuen uns Ihnen die aktuellsten und spannendsten News bereit zu stellen. Auf
            unserer Webseite befindet sich die Information über alle Dienste und Angebote, die Sie
            nutzen und genießen können.</p>
            <p>Besuchen Sie uns öfters, um immer auf dem aktuellsten Stand der StarHills zu sein!</p>

    </section>
</div>

<div id="Block">
    <section>
        <div id="Page1">
            <c:forEach items="${news.content}" var="news" varStatus="loop">
                <div class="OneBlock" id="${news.id}">
                    <%--<div class="GeneralUnit" style="width: 100%">
                        <div class="ImgBlock">
                            <img src="starSource/news/${news.id}/${news.newsPhoto}">
                        </div>
                        <div class="NameProject">
                            <div class="Name">${news.titleNews}</div>
                            <p style="font-size: 10px; font-style: italic">Дата: ${news.date}</p>
                            <div class="clr"></div>
                            <div id="newsComment">

                                <p>${news.comment}</p>

                            </div>
                        </div>


                    </div>--%>


                    <div class="NameNews">${news.titleNews}
                        <sec:authorize access="hasAnyRole('ADMIN')">
                        <c:if test="${news.status==1}">
                            <img src="images/MyOrders/yes.png" onclick="changestatus(this, ${news.id})" class="0" >
                            <p>Active</p>
                        </c:if>
                        <c:if test="${news.status==0}">
                            <img src="images/MyOrders/no.png" onclick="changestatus(this, ${news.id})" class="1">
                            <p>Unactive</p>
                        </c:if>
                            <img src="images/edit.png" onclick="editNews('${news.id}', '${news.titleNews}')">
                            <img src="images/MyOrders/plus.png" onclick="addNews()">
                        </sec:authorize>

                    </div>
                    <p style="font-size: 10px; font-style: italic">Дата: ${news.date}</p>
                    <div class="leftp" id="text${news.id}"><img src="starSource/news/${news.id}/${news.newsPhoto}" width="220" height="160" class="leftimg">${news.comment}</div>

                    <div class="clr"></div>
                </div>
            </c:forEach>
            <div id="pageable" style="text-align:center; font-size:16px">
                <a style="margin-left: 25px" href="/news-page-1">Titelseite</a>
                <c:forEach begin="1" end="${news.totalPages}" step="1" var="i">
                    <c:if test="${i<pageNumber+2 && i>pageNumber-2}">
                        <c:if test="${i==pageNumber}">
                            <b style="color: red">${i}</b>
                        </c:if>
                        <c:if test="${i!=pageNumber}">
                            <a href="/news-page-${i}">${i}</a>
                        </c:if>
                    </c:if>
                </c:forEach>
                <a style="margin-left: 25px" href="/news-page-${news.totalPages}">Letzteseite</a>

            </div>
        </div>
    </section>
    <sec:authorize access="hasAnyRole('ADMIN')">
        <div id="AddNews">
            <section>
                <form id="News"  method="POST">
                <div class="mask-wrapper" id="wrapper3" style="float: right; margin-bottom: 30px; margin-top: 0px;">
                    <div class="mask">
                        <input id="my_file3" class="fileInputText" type="text" placeholder="Abdeckung hochladen" disabled>
                        <button class="send-file">wählen...</button>
                        <div id="fileList3" ></div>
                    </div>
                    <input  class="custom-file-input" type="file" id="my_file13" name="mainfile" accept="image/*">
                </div>
            <div id="BlockEmail">
                <p>Titel</p><input type="text" id="skypestar" name="Title"  value=""/>
            </div>
            <div id="AdminComment"><p>News-Text</p>
                <div id="Texteditor">
                    <textarea name="editor1" id="editor1" cols="45" rows="5"></textarea>
                    <script type="text/javascript">
                        CKEDITOR.replace( 'editor1', {
                            language: 'de',
                            uiColor: '#9AB8F3'
                        });
                    </script>
                </div>
            </div>

            <script type="text/javascript">
                window.onload = function(){
                    document.getElementById('my_file13').onchange = function(){
                        var formData =  new FormData($('#News')[0]);
                        $.ajax({
                            type: "POST",
                            url: '/photo-news',
                            enctype: "multipart/form-data",
                            contentType: false,
                            processData: false,
                            cache: false,
                            data: formData,
                            success: function (data) {
                                jcrop_api.setImage("/starSource/defaultnews.png"+ '?' + new Date().getTime());
                                document.location.href='#newsmodal';
                            },
                            error: function (e) {
                                console.log(e);
                            }
                        });
                    };
                };
            </script>
                    <div class="clr"></div>
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                    <input type="hidden"
                           name="croppedphoto"
                           id="croppedphoto"
                           value="0"/>
                    <input type="hidden"
                           name="newsid"
                           id="newsid"
                           value="0"/>
                    <div id="Button"><a href="#" onclick="savenews()">Speichern</a></div>
                    <div class="clr"></div>
                </form>
            <div class="remodal" data-remodal-id="newsmodal" style="width: 100%;">
                <p>wählen Sie den Bereich für den Schnitt</p>
                <div id="imagebox" style="width: 100%; overflow: scroll; margin-top: 10px">
                    <img src="/starSource/defaultnews.png" id="cropbox"  style="display: inline-block; " />
                </div>

                <form method="POST" action="/photocropnews" id="photocrop">
                    <input type="hidden" id="x" name="x" />
                    <input type="hidden" id="y" name="y" />
                    <input type="hidden" id="w" name="w" />
                    <input type="hidden" id="h" name="h" />
                    <input type="hidden" id="id" name="id" value="0" />
                </form>
                <button id="cropbutton" value="Crop Image" style="display: block; margin: 10px auto;" class="btn btn-large btn-inverse" onclick="checkCoords()">Foto zuschneiden</button>
                <button id="ok" value="Crop Image" style="margin: 10px auto;" class="btn btn-large btn-inverse" onclick="javascript: window.location='#';">Ok</button>
            </div>

            </section>
        </div>
        <div id="regSuchess">
            <p>Ihr Nachrichten wurde gespeichert</p>
        </div>
        <script>
            function savenews() {
                var formData = $('#News');
                        var areaText = CKEDITOR.instances['editor1'].getData();
                        $('#editor1').val(areaText);
                        $.ajax({
                            type: "POST",
                            url: '/save-news',
                            data: formData.serialize(),
                            success: function (data) {
                                $('form[id="News"]').find('input, textarea').not('[type="submit"]').not('[type="hidden"]').each(function() {
                                    $(this).val('');
                                });
                                CKEDITOR.instances['editor1'].updateElement();
                                CKEDITOR.instances['editor1'].setData('');
                                $('#AddNews').css('display', 'none');
                                $('#regSuchess').css('display', 'block');
                                $('#wrapper3').css('background', 'none');
                                $('#my_file3').attr('placeholder', 'Abdeckung hochladen');
                                $('#newsid').val('0');
                                $('#id').val('0');
                                document.location.href='#regSuchess';
                                setInterval(function() { // ставим пятисекундный интервал для перелистывания картинок
                                    $('#AddNews').css('display', 'block');
                                    $('#regSuchess').css('display', 'none');
                                },5000);
                            },
                            error: function (e) {
                                console.log(e);
                            }
                        });
            }
            function editNews(id, title){
                var html=$('#text'+id).html();
                html = html.replace(/<img[^>]*>/g,"");
                CKEDITOR.instances['editor1'].updateElement();
                CKEDITOR.instances['editor1'].setData(html);
                $('#skypestar').val(title);
                $('#newsid').val(id);
                $('#id').val(id);
                document.location.href='#AddNews';
            }
            function addNews(){
                CKEDITOR.instances['editor1'].updateElement();
                CKEDITOR.instances['editor1'].setData(' ');
                $('#skypestar').val(' ');
                $('#newsid').val('0');
                $('#id').val('0');
                document.location.href='#AddNews';
            }
            function changestatus(elem, id){
                var form = $('<form action="/change-newsstatus" method="POST" >');
                var newsstatus = $('<input>', { name: "status", type: "hidden", value: elem.className });
                var newsid = $('<input>', { name: "id", type: "hidden", value: id });
                form.append(newsstatus);
                form.append(newsid);
                $.ajax({
                    type: "POST",
                    url: "/change-newsstatus",
                    data: form.serialize(),
                    success: function(data){
                        if(elem.className=="0"){
                            $(elem).attr('src', 'images/MyOrders/no.png');
                            elem.className="1";
                            $(elem).next().text('Unactive');
                        }else{
                            $(elem).attr('src', 'images/MyOrders/yes.png');
                            elem.className="0";
                            $(elem).next().text('Active');
                        }
                    },
                    error: function(e){
                    }
                });
            }
        </script>
    </sec:authorize>
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