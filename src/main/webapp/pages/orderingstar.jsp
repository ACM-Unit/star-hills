<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false"%>

<div id="Formalization">
	<section>
        <h1><span>Video</span> bestellen</h1>
        <div id="BelowH1Bottom">Abwicklung der Bestellung – Schritt 1</div>
    </section>
</div>

<div id="BlockPerson">
<section>
<div id="LeftBlock">
	<div id="Photo">
    	<img src="/starSource/${star.id}/mainphoto.png">
    </div>

</div>
<div id="But">
	<div id="ButtonAgo"><a href="/celebrities">Zurück zur Suche</a></div>
</div>
<div id="BlockDesrcAll">
<div id="Descr">
	<div id="Topi">
    	<p><span class="Name"> ${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></span></p>
        <div id="Flip">
            <div class="onoffswitch">
                <c:if test="${star.status == true}">
                    <img src="/images/Cabinet/On.png">
                </c:if>
                <c:if test="${star.status == false}">
                    <img src="/images/Cabinet/Off.png">
                </c:if>

            </div>
        </div>
        <c:if test="${star.status == true}">
            <div id="On">On</div>
        </c:if>
        <c:if test="${star.status == false}">
            <div id="On">Off</div>
        </c:if>
        <div class="clr"></div>
    </div>
    <div id="Description">
        ${star.commentadmin}
        <p style="font-style: italic">Beschreibung des Stars</p>
        <p style="font-style: italic">${star.comment}</p>
    	    </div>
</div>
<div id="Info">
    <p class="Markeri">${(star.price)*3} &#8364; / 1 Minuten</p>
    <p class="Markeri">${star.video} Videos pro Monat</p>
    <c:if test="${freevideo>0}">
        <p class="Markeri">${freevideo} Videos sind frei</p>
    </c:if>
    <c:if test="${freevideo<=0}">
        <p style="color:red; font-size: 22px" class="Markeri">Kein freies Video</p>
    </c:if>
    <div id="SocProject">

<select style="width:100%;border: 1px solid #d7d7d7; font-size: 16px;height: 100%; text-align: center; font-size: 18px;
font-weight: bold;" id="MyProjects" onchange="window.open(this.options[this.selectedIndex].value, '_blank')">
    <option selected disabled hidden>WOHLTÄTIGKEIT</option>
<c:if test="${fn:length(charities) eq 0}">
<option disabled>noch keine Projekte</option>
</c:if>
<c:forEach items="${charities}" var="charitys">
 <option value="/charity#${charitys.charity.id}">${charitys.charity.nameproject}</option>
</c:forEach>
</select>
</div>
    <div id="ButtonOrderCabinetPerson">
        <c:if test="${freevideo>0}">
           <div class="PrezentCabinet"></div>
        <a href="/ordering?id=${star.id}">Bestellen</a>
        </c:if>
    </div>
</div>
<div class="clr"></div>
</div>
<div class="clr"></div>
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