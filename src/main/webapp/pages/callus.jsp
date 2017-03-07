<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false"%>
<div id="AllBodyKont">
    <section>
        <div id="TitleKont">
            <h1><span>Kont</span>akte</h1>
            <div id="BelowlH1Kont">Lassen sie uns Ihre Nachricht. Wir freuen uns Ihnen zu helfen!</div>
        </div>
    </section>
</div>
<div id="BlockKotnAll">
    <section>
        <form id="callusform">
        <label>
            <div id="FirstName">
                <p id="FirstNameP">Vorname </p>
                <input type="text" name="FistName" required />
            </div>
        </label>
        <label>
            <div id="LastName">
                <p id="LastNameP">Nachname </p>
                <input type="text" name="LastName" required />
            </div>
        </label>
        <div class="clr"></div>
        <label>
            <div id="EmailBlock">
                <p id="EmailBlockP">E-Mail Adresse </p>
                <input type="email" id="CallUsEmail" name="Email" required />
                <span style='margin-top: 13px;' id="validEmail"></span>
            </div>
        </label>
        <label>
            <div id="BetreffBlock">
                <p id="BetreffBlockP">Betreff </p>
                <input type="email" name="Betreff" required />
            </div>
        </label>
        <label>
            <div id="TxtBlock">
                <p>Nachricht </p>
                <textarea  name="Nachricht" required /></textarea>
            </div>
        </label>
        <div id="ButtonKont"><a onclick="callus()">Absenden</a></div>
        </form>
    </section>
</div>
<div id="regSuchess">
    <p>Ihre Nachricht wurde erfolgreich gesendet!<br>In Kürze setzen wir uns mit Ihnen in Verbindung.</p>
</div>