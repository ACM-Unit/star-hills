<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false"%>
<script src="/js/requests.js" type="text/javascript" ></script>
<div id="ChekInAll">
    <section>
        <h1><span>Registrierung für die</span>  Stars</h1>
        <div id="CenterPChek">Ein interessantes, leichtes und neuartiges Weg zu Ihren Fans näher zu sein!</div>
    </section>
    <section>
        <div id="ChekBlock">
            <form method="POST" id="formregistration" action="/registration">
<div></div>
                <div id="BlockName1"><p>Vorname, Nachname</p><input type="text" class="validform" name="Name" placeholder="Geben Sie Ihren vollständigen Namen an"/></div>

                <div id="BlockAlias1"><p>Email</p><input  type="text" class="validform" id="Email" name="Email" placeholder="Geben Sie Ihre E-Mail Adresse an"/><span id="validEmail"></span><div id="emailvalid" class="validmessage"></div></div>

                <div id="Phone"><p>Handynummer</p><input type="text" class="validform" id="PhoneRegistration" name="Phone" placeholder="Geben Sie Ihr Handynummer an"/><div id="phonevalid" class="validmessage"></div></div>

                <div id="Login"><p>Benutzernamen</p><input  type="text" class="validform" name="Login" placeholder="Geben Sie Ihren Benutzernamen an"/><span id="validLogin"></span><div id="loginvalid" class="validmessage"></div></div>

                <div id="Password"><p>Passwort</p><input  class="validform" type="password" name="Password" placeholder="Geben Sie Ihr Passwort an"/><span id="validPassword1"></span><div id="passvalid" class="validmessage"></div></div>

                <div id="PasswordReply"><p>Neues Passwort wiederholen</p><input  class="validform" type="password" id="PassRep" name="PasswordReply" placeholder="Bestätigen Sie Ihr Passwort"/><span id="validPassword"></span><div id="passrepvalid" class="validmessage"></div></div>
            </form>
                <div id="Agreement">

                    <input  type="checkbox" id="IAgry" name="IAgry" value="Y" /> <label for="IAgry"><p>Ich bin mit allgemein Geschäftsbedingungen (AGB) einverstanden</p></label>

                    <div id="ButtonLoading"><a href="#" onclick="registration()">Registrieren</a></div>

                    <div class="clr"><span style="display: inline-block; padding-right: 40px; text-align: right; width: 100%; padding-top: 15px; color: red;" id="statusErrorReg" class="modalMessage"></span></div>
                </div>
                <div class="clr"></div>
        </div>
        <div id="regSuchess">
            <p>Glückwunsch!<br>Sie wurden erfolgreich registriert!</p>
            <div id="ButtonSuchess"><a href="#login">Anmelden</a></div>
        </div>
        <div id="BoxIcon">
            <ul>
                <li><p>Schnell</p></li>
                <li><p>Leicht</p></li>
                <li><p>Kostenlos</p></li>
                <li><p>Lustig</p></li>
                <li><p>Einfach</p></li>
                <li><p>Rentabel</p></li>
            </ul>
        </div>
        <div class="clr"></div>
    </section>
</div>
<div id="Advantages">
    <section>
        <div id="BgAdvantages">
            <ul>
                <li>Schnelle Bezahlung</li>
                <li>Sie wählen selbst den Preis für Ihres Video aus</li>
                <li>Sie helfen den Menschen</li>
                <li>Sie bestimmen selbst die Anzahl<br> von den verschickten Videos</li>
            </ul>
        </div>
    </section>
</div>
