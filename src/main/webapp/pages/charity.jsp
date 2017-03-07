<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
    var current = 'Page1';
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

</script>
<style>
    #Page1{display: block;}
    #Page2, #Page3{display: none;}</style>
<div id="CharitableProjectsTop">
    <section>
        <h1><span>Wohtätigkeits</span>projekte</h1>
        <div id="BelowH1Bottom">Wir unterstützen aktiv soziale Projekte, die sich auf die Verbesserung des Lebensstandards der Gesellschaft von heute konzentrieren.</div>
    </section>
</div>
<div id="SliderCabinet">
    <div id="ButtonCabinetBottom"><a href="/add-charity">Stiftung registrieren</a></div>
</div>
<div id="BlockSlider">
    <section>
        <div id="SliderCharitable">
            <c:forEach items="${charityAll.content}" var="charity" varStatus="loop">
                <div><a href="#${charity.id}"><img src="starSource/charity/${charity.id}/${charity.mainphoto}"></a></div>
            </c:forEach>
        </div>
    </section>
</div>
<div id="DescrCharitable">
    <section>
        <p>Unserem Team ist es sehr wichtig, dass jeder von uns auf dem Planeten ein würdevolles Leben, gesundes Essen, eine gute Bildung und ein Dach über den Kopf hat. Das jeder Mensch eine Möglichkeit hat etwas voranzutreiben, etwas zu entwickeln, die Menschen zu begeistern und damit die Welt zu verändern. Deswegen sind wir zum Entschluss gekommen, dass eine bestimmte Summe von jedem verkauften Video in die Wohltätigkeitsorganisationen gespendet werden. Das gibt die Kraft den Menschen, die in der Not sind und unsere gemeinsame Hilfe brauchen. </p>
        <p>Dieses große Ziel füllt unsere Herzen mit Energie und begeistert uns die besten Video-Geschenke für euch zu kreieren.<br>
            Tun Sie den Anderen was Gutes und das Gute kommt zu Ihnen mehrfach zurück. Das ist das Gesetz des Universums.</p>
        <p>Liebe Freunde, so lassen Sie uns gemeinsam die Welt bunter und glücklicher machen!</p>
    </section>
</div>
<div id="ButtonBlockCharit">
    <section>
        <div class="One" id="onebot"><a href="#ButtonBlockCharit" onclick="showpage('Page1', '#onebot' )"><p>Neue Projekte</p></a></div>
        <div class="Two" id="twobot"><a href="#ButtonBlockCharit" onclick="showpage('Page2', '#twobot')"><p>Laufende Projekte</p></a></div>
        <div class="Two" id="threebot"><a href="#ButtonBlockCharit" onclick="showpage('Page3', '#threebot')"><p>Abgeschlossene Projekte</p></a></div>
        <div class="clr"></div>
    </section>
</div>
<div id="Block">
    <section>
        <div id="Page1">
          <%--  <c:if test="${fn:length(charityNew) eq 0}">
                <h1 style="text-align: center">Diese Kategorie ist zurzeit leer</h1>
            </c:if>--%>
            <c:forEach items="${charityAll.content}" var="charity">
                <c:if test="${charity.status==-1}">
                     <div class="OneBlock" id="${charity.id}">
                <div class="GeneralUnit">
                    <div class="ImgBlock">
                        <img src="starSource/charity/${charity.id}/${charity.mainphoto}">
                    </div>
                    <div class="NameProject">
                        <div class="Name">${charity.nameproject}
                        <sec:authorize access="hasAnyRole('ADMIN')">
                            <c:if test="${charity.activate==true}">
                                <img src="images/MyOrders/yes.png" onclick="changestatus(this, ${charity.id})" class="0" >
                                <span style="color: black">Active</span>
                            </c:if>
                            <c:if test="${charity.activate==false}">
                                <img src="images/MyOrders/no.png" onclick="changestatus(this, ${charity.id})" class="1">
                                <span style="color: black">Unactive</span>
                            </c:if>
                        </sec:authorize></div>
                        <p>Gesammelt:<span id="charity${charity.id}" class="Collected">${charity.moneycollected}</span><span class="Currency">€</span></p>
                    </div>
                    <div class="clr"></div>
                    <div id="charityblok${charity.id}" class="DescrGener">
                        ${charity.comment}
                    </div>
                    <div style="cursor: pointer; color: blue" class="charityclick">weiter lesen</div>
                    <div class="ButtonBlockGener">
                        <c:if test="${charity.document!='document.octet-stream'}"><div class="Doc"><a target="_blank" href="starSource/charity/${charity.id}/${charity.document}">Dokumente</a></div></c:if>
                        <div class="Support"><a href="#pay-charity" onclick="paycharity(${charity.id})">Unterstützen</a></div>
                        <div class="clr"></div>
                    </div>
                </div>
                <div class="VideoUnit">
                        <div class="Video" id="createvideo${charity.id}">
                            <script>
                                var videos="${charity.video}".split('*');
                                for (i = 0; i < videos.length-1; i++) {
                                    var video=document.createElement("video");
                                    $(video).attr('src', "starSource/charity/${charity.id}/"+videos[i]);
                                    $(video).attr('controls', "true");
                                    $(video).attr('autobuffer', "true");
                                    document.getElementById("createvideo${charity.id}").appendChild(video);
                                }
                            </script>
                        </div>
                </div>
                <div class="SlidUnit" id="SlidUnit${charity.id}">
                    <div class="Vwidget">
                        <a class="up" id="up${charity.id}" onclick="up${charity.id}();" /></a>
                        <div class="VjCarouselLite">
                            <ul>
                                <li>
                                    <div  id="slideone1${charity.id}">
                                    </div>
                                </li>
                                <li>
                                    <div id="slideone2${charity.id}">
                                    </div>
                                </li>
                                <li>
                                    <div id="slideone3${charity.id}">
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <a class="down" id="down${charity.id}" onclick="down${charity.id}();" /></a>
                    </div>
                    <script>
                            var slides${charity.id}="${charity.photo}".split('*');

                            var image${charity.id}="starSource/charity/${charity.id}/";
                            var frame${charity.id}=0; // текущий кадр для отбражения - индекс картинки из массива
                           function set${charity.id}(image1, image2, image3) { // установка нужного фона слайдеру
                               document.getElementById('slideone1${charity.id}').style.backgroundImage = "url('"+image1+"')";
                               document.getElementById('slideone2${charity.id}').style.backgroundImage = "url('"+image2+"')";
                               document.getElementById('slideone3${charity.id}').style.backgroundImage = "url('"+image3+"')";
                            }
                           function init${charity.id}() {
                                this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                            }
                            function up${charity.id}() {
                                if(this.slides${charity.id}.length>3 && this.frame${charity.id} != 0){
                                this.frame${charity.id}--;
                                this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                                }
                            }
                            function down${charity.id}() { // крутим на один кадр вправо
                                if(this.slides${charity.id}.length>3 && this.frame${charity.id}+2 != this.slides${charity.id}.length-2){
                                this.frame${charity.id}++;
                                this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                                }
                            }
                            document.getElementById('slideone1${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[0]+"')";
                            document.getElementById('slideone2${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[1]+"')";
                            document.getElementById('slideone3${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[2]+"')";
                            if(this.slides${charity.id}.length==1){
                               $('#SlidUnit${charity.id}').css('display', 'none');
                            }
                    </script>

                </div>
                <div class="clr"></div>
            </div>
                </c:if>
            </c:forEach>
        </div>
        <div id="Page2">
            <%--<c:if test="${fn:length(charityActual) eq 0}">
            <h1 style="text-align: center">Diese Kategorie ist zurzeit leer</h1>
            </c:if>--%>
            <c:forEach items="${charityAll.content}" var="charity">
                <c:if test="${charity.status==0}">
                <div class="OneBlock">
                    <div class="GeneralUnit">
                        <div class="ImgBlock">
                            <img src="starSource/charity/${charity.id}/${charity.mainphoto}">
                        </div>
                        <div class="NameProject">
                            <div class="Name">${charity.nameproject}
                            <sec:authorize access="hasAnyRole('ADMIN')">
                                <c:if test="${charity.activate==true}">
                                    <img src="images/MyOrders/yes.png" onclick="changestatus(this, ${charity.id})" class="0" >
                                    <span style="color: black">Active</span>
                                </c:if>
                                <c:if test="${charity.activate==false}">
                                    <img src="images/MyOrders/no.png" onclick="changestatus(this, ${charity.id})" class="1">
                                    <span style="color: black">Unactive</span>
                                </c:if>
                            </sec:authorize></div>
                            <p>Gesammelt:<span id="charity${charity.id}" class="Collected">${charity.moneycollected}</span><span class="Currency">€</span></p>
                        </div>
                        <div class="clr"></div>
                        <div id="charityblok${charity.id}" class="DescrGener">
                                ${charity.comment}
                        </div>
                        <div style="cursor: pointer; color: blue" class="charityclick">weiter lesen</div>
                        <div class="ButtonBlockGener">
                            <c:if test="${charity.document!='document.octet-stream'}"><div class="Doc"><a target="_blank" href="starSource/charity/${charity.id}/${charity.document}">Dokumente</a></div></c:if>
                            <div class="Support"><a href="#pay-charity" onclick="paycharity(${charity.id})">Unterstützen</a></div>
                            <div class="clr"></div>
                        </div>
                    </div>
                    <div class="VideoUnit">
                        <div class="Video" id="createvideo${charity.id}">
                            <script>
                                var videos="${charity.video}".split('*');
                                for (i = 0; i < videos.length-1; i++) {
                                    var video=document.createElement("video");
                                    $(video).attr('src', "starSource/charity/${charity.id}/"+videos[i]);
                                    $(video).attr('controls', "true");
                                    $(video).attr('autobuffer', "true");
                                    document.getElementById("createvideo${charity.id}").appendChild(video);
                                }
                            </script>
                        </div>
                    </div>
                    <div class="SlidUnit">
                        <div class="Vwidget">
                            <a class="up" onclick="up${charity.id}();" /></a>
                            <div class="VjCarouselLite">
                                <ul>
                                    <li>
                                        <div  id="slideone1${charity.id}">
                                        </div>
                                    </li>
                                    <li>
                                        <div id="slideone2${charity.id}">
                                        </div>
                                    </li>
                                    <li>
                                        <div id="slideone3${charity.id}">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <a class="down" onclick="down${charity.id}();" /></a>
                        </div>
                        <script>
                            var slides${charity.id}="${charity.photo}".split('*');
                            var image${charity.id}="starSource/charity/${charity.id}/";
                            var frame${charity.id}=0; // текущий кадр для отбражения - индекс картинки из массива
                            function set${charity.id}(image1, image2, image3) { // установка нужного фона слайдеру
                                document.getElementById('slideone1${charity.id}').style.backgroundImage = "url('"+image1+"')";
                                document.getElementById('slideone2${charity.id}').style.backgroundImage = "url('"+image2+"')";
                                document.getElementById('slideone3${charity.id}').style.backgroundImage = "url('"+image3+"')";
                            }
                            function init${charity.id}() {
                                this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                            }
                            function up${charity.id}() {
                                if(this.slides${charity.id}.length>3 && this.frame${charity.id} != 0){
                                    this.frame${charity.id}--;
                                    this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                                }
                            }
                            function down${charity.id}() { // крутим на один кадр вправо
                                if(this.slides${charity.id}.length>3 && this.frame${charity.id}+2 != this.slides${charity.id}.length-2){
                                    this.frame${charity.id}++;
                                    this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                                }
                            }
                            document.getElementById('slideone1${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[0]+"')";
                            document.getElementById('slideone2${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[1]+"')";
                            document.getElementById('slideone3${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[2]+"')";
                        </script>

                    </div>
                    <div class="clr"></div>
                </div>
                </c:if>
            </c:forEach>
        </div>
        <div id="Page3">
          <%--  <c:if test="${fn:length(charityClose) eq 0}">
                <h1 style="text-align: center">Diese Kategorie ist zurzeit leer</h1>
            </c:if>--%>
            <c:forEach items="${charityAll.content}" var="charity">
                <c:if test="${charity.status==1}">
                <div class="OneBlock">
                    <div class="GeneralUnit">
                        <div class="ImgBlock">
                            <img src="starSource/charity/${charity.id}/${charity.mainphoto}">
                        </div>
                        <div class="NameProject">
                            <div class="Name">${charity.nameproject}
                            <sec:authorize access="hasAnyRole('ADMIN')">
                            <c:if test="${charity.activate==true}">
                                <img src="images/MyOrders/yes.png" onclick="changestatus(this, ${charity.id})" class="0" >
                                <span style="color: black">Active</span>
                            </c:if>
                            <c:if test="${charity.activate==false}">
                                <img src="images/MyOrders/no.png" onclick="changestatus(this, ${charity.id})" class="1">
                                <span style="color: black">Unactive</span>
                            </c:if>
                            </sec:authorize></div>
                            <p>Gesammelt:<span  class="Collected">${charity.moneycollected}</span><span class="Currency">€</span></p>
                        </div>
                        <div class="clr"></div>
                        <div id="charityblok${charity.id}" class="DescrGener">
                                ${charity.comment}
                        </div>
                        <div style="cursor: pointer; color: blue" class="charityclick">weiter lesen</div>
                        <div class="ButtonBlockGener">
                            <c:if test="${charity.document!='document.octet-stream'}"><div class="Doc"><a target="_blank" href="starSource/charity/${charity.id}/${charity.document}">Dokumente</a></div></c:if>
                            <div class="Support"><a href="#pay-charity" onclick="paycharity(${charity.id})" >Unterstützen</a></div>
                            <div class="clr"></div>
                        </div>
                    </div>
                    <div class="VideoUnit">
                        <div class="Video" id="createvideo${charity.id}">
                            <script>
                                var videos="${charity.video}".split('*');
                                for (i = 0; i < videos.length-1; i++) {
                                    var video=document.createElement("video");
                                    $(video).attr('src', "starSource/charity/${charity.id}/"+videos[i]);
                                    $(video).attr('controls', "true");
                                    $(video).attr('autobuffer', "true");
                                    document.getElementById("createvideo${charity.id}").appendChild(video);
                                }
                            </script>
                        </div>
                    </div>
                    <div class="SlidUnit">
                        <div class="Vwidget">
                            <a class="up" onclick="up${charity.id}();" /></a>
                            <div class="VjCarouselLite">
                                <ul>
                                    <li>
                                        <div  id="slideone1${charity.id}">
                                        </div>
                                    </li>
                                    <li>
                                        <div id="slideone2${charity.id}">
                                        </div>
                                    </li>
                                    <li>
                                        <div id="slideone3${charity.id}">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <a class="down" onclick="down${charity.id}();" /></a>
                        </div>
                        <script>
                            var slides${charity.id}="${charity.photo}".split('*');
                            var image${charity.id}="starSource/charity/${charity.id}/";
                            var frame${charity.id}=0; // текущий кадр для отбражения - индекс картинки из массива
                            function set${charity.id}(image1, image2, image3) { // установка нужного фона слайдеру
                                document.getElementById('slideone1${charity.id}').style.backgroundImage = "url('"+image1+"')";
                                document.getElementById('slideone2${charity.id}').style.backgroundImage = "url('"+image2+"')";
                                document.getElementById('slideone3${charity.id}').style.backgroundImage = "url('"+image3+"')";
                            }
                            function init${charity.id}() {
                                this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                            }
                            function up${charity.id}() {
                                if(this.slides${charity.id}.length>3 && this.frame${charity.id} != 0){
                                    this.frame${charity.id}--;
                                    this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                                }
                            }
                            function down${charity.id}() { // крутим на один кадр вправо
                                if(this.slides${charity.id}.length>3 && this.frame${charity.id}+2 != this.slides${charity.id}.length-2){
                                    this.frame${charity.id}++;
                                    this.set${charity.id}(image${charity.id}+this.slides${charity.id}[this.frame${charity.id}], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+1], image${charity.id}+this.slides${charity.id}[this.frame${charity.id}+2]);
                                }
                            }
                            document.getElementById('slideone1${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[0]+"')";
                            document.getElementById('slideone2${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[1]+"')";
                            document.getElementById('slideone3${charity.id}').style.backgroundImage = "url('"+image${charity.id}+slides${charity.id}[2]+"')";
                        </script>

                    </div>
                    <div class="clr"></div>
                </div>
                </c:if>
            </c:forEach>
        </div>
    </section>
</div>
<div id="pageable" style="text-align:center; font-size:16px">
    <a style="margin-right: 15px" href="/charity-page-1">Titelseite</a>
    <c:forEach begin="1" end="${charityAll.totalPages}" step="1" var="i">
        <c:if test="${i<pageNumber+2 && i>pageNumber-2}">
            <c:if test="${i==pageNumber}">
                <b style="color: red">${i}</b>
            </c:if>
            <c:if test="${i!=pageNumber}">
                <a href="/charity-page-${i}">${i}</a>
            </c:if>
        </c:if>
    </c:forEach>
    <a style="margin-left: 25px" href="/charity-page-${charityAll.totalPages}">Letzteseite</a>

</div>


<div class="remodal" style="width: 95%" data-remodal-id="pay-charity" >
    <%--<button data-remodal-action="close" class="remodal-close"></button>--%>

    <div id="statusErrorOrderingModal">
        <p>Sie können das Projekt unterstützen!</p>
        <p><span>Spenden </span><input style=" width: 6em" type="number"  min="10" name="amountCharity" value="100"  placeholder="100" id="amountCharity"><span> Euro</span></p>
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
                    <input type="image" src="/images/paypal.png"  name="submit" alt="Bezahlen Sie mit PayPal! Das ist schnell, kostenlos und sicher!">
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
                                            //location.href = '/charity';}

                                            var paych=data.replace(/\s+/g, '');
                                            $('#charity'+id2).html(paych);
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
<sec:authorize access="hasAnyRole('ADMIN')" >
    <script>
        function changestatus(elem, id){
            var form = $('<form action="/change-charity-status" method="POST" >');
            var newsstatus = $('<input>', { name: "status", type: "hidden", value: elem.className });
            var newsid = $('<input>', { name: "id", type: "hidden", value: id });
            form.append(newsstatus);
            form.append(newsid);
            $.ajax({
                type: "POST",
                url: "/change-charity-status",
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
    </script>
</sec:authorize>