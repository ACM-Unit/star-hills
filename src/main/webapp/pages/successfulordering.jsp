<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false"%>

<div id="AllBody">
	<section>
    	<div id="TitleCabinet">
        	<h1><span><span>Das Video-Geschenk</span> bestellen</h1>
            <div id="BelowH1">Meine Bestellung</div>
        </div>
    </section>
</div>

<div id="BodyBlock">
	<section>
    	<div id="BlockCenter">
        	<div id="TitleBlockCenter">Ihre Bestellung war erfolgreich</div>
            <p>Auf Ihre angegebene E-Mail Adresse werden genaue Informationen zur Ihrer Bestellung geschickt.</p>
            <p>Ihr Ansprechspartner - Dima Schaible, +49(176) 70-20-35-32</p>
            <div id="BlockOrderAlli">
            	<p>Datum und Zeitpunkt des Verschickens</p>
                <div id="Time">
                	<p>${order.date}</p>
                    <div class="clr"></div>
                </div>
            </div>
            <div id="DescrOrd">
            	<p>Bestellung</p>
            	<div id="DeskrBlock">
                	<p>Art der Ware: Video-Geschenk</p>
                    <p>Star: ${order.star.name}</p>
                    <p>Dauer des Videos: 1 Minuten</p>
                    <p>Preis: ${order.payment}€</p>
                </div>
            </div>
        </div>
    </section>
</div>
<div id="Courusel">
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
