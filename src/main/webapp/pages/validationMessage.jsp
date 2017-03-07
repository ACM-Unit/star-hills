<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <c:if test="${status ne null }">
                <c:choose>
                    <c:when test="${status eq 'sendrecoverpassword'}">
                        <p style="color: green"> – Ihr Passwort wurde wiederhergestellt. Ein neues Passwort wird Ihnen per E-Mail an die angegebene E-Mail Adresse gesendet.</p>
                    </c:when>
                    <c:when test="${status eq 'sendrecoverpassworderror'}">
                        <p style="color: red">Benutzer mit dieser E-Mail Adresse existiert nicht</p>
                    </c:when>
                    <c:when test="${status eq 'errorReg'}">
                        <p style="color: red">Benutzer mit diesen Benutzernamen existiert nicht</p>
                    </c:when>
                    <c:when test="${status eq 'errorRegEmail'}">
                        <p style="color: red">Benutzer mit dieser E-Mail Adresse existiert bereits</p>
                    </c:when>
                    <c:when test="${status eq 'errorRegEmailAll'}">
                        two
                    </c:when>
                    <c:when test="${status eq 'suchReg'}">
                        Ok
                    </c:when>
                    <c:when test="${status eq 'sendrecoverpassworderror1'}">
                        <p style="color: red">Die Nachricht konnte nicht versendet werden. Laden Sie die Webseite neu und versuchen Sie es noch einmail! </p>
                    </c:when>
                    <c:when test="${status eq 'errorName'}">
                        Dieser Benutzername ist bereits vergeben.
                    </c:when>
                    <c:when test="${status eq 'activeOrder'}">
                        ${orderActive}
                    </c:when>
                    <c:when test="${status eq 'editName'}">
                        Die Änderungen wurden gespeichert
                    </c:when>
                    <c:when test="${status eq 'editcabinet'}">
                        <p style="color: green">Die Änderungen wurden gespeichert</p>
                    </c:when>
                    <c:when test="${status eq 'editcabinetskype'}">
                        <p style="color: green">Ihr Kontaktwunsch via Skype mit Ihnen wurde an unseren Administrator weitergeleitet.</p>
                    </c:when>
                    <c:when test="${status eq 'editcabinetaboutskype'}">
                        <p style="color: green">Die Änderungen wurden gespeichert.<br>Ihr Kontaktwunsch via Skype mit Ihnen wurde an unseren Administrator weitergeleitet.. <br>Заявка на описание вас отправлена администратору</p>
                    </c:when>
                    <c:when test="${status eq 'editcabinetabout'}">
                        <p style="color: green">Die Änderungen wurden gespeichert. <br>Ihr Wunsch zur „Angeben zu Ihrer Persönlichkeit wurde an unseren Administrator weitergeleitet.</p>
                    </c:when>
                    <c:when test="${status eq 'editcabineterror'}">
                        emailerror
                    </c:when>
                    <c:when test="${status eq 'erorrcabinet'}">
                        Benutzer mit diesen Benutzernamen existiert bereits
                    </c:when>
                    <c:when test="${status eq 'OkUpload'}">
                        ${filename}
                    </c:when>
                    <c:when test="${status eq 'Idord'}">
                        ${idord}

                    </c:when>
                    <c:when test="${status eq 'editname'}">
                        editname
                    </c:when>

                    <c:when test="${status eq 'CharityPay'}">
                        ${chpay}
                    </c:when>
                    <c:when test="${status eq 'errror'}">
                        error
                    </c:when>
                    <c:when test="${status eq 'Search'}">
                        Suchergebnis - ${srh} Treffer
                        <ul>
                            <c:forEach items="${stars}" var="star" varStatus="loop">
                                <c:choose>
                                    <c:when test="${loop.last}">
                                        <li style="text-align: left; display: table; height: auto; margin-left: 15px; margin-top: 15px"><div style="float: left; margin-right: 15px" id="box5"><a href="/orderingstar?id=${star.id}"><img  style="border: 1px solid #d4d1d5; border-radius: 3px; padding: 2px;" width="60" height="auto" src="/starSource/${star.id}/mainphoto.png" ></a></div><a href="/orderingstar?id=${star.id}" style="display: table-cell; vertical-align: middle" class ="ids" idstar="${star.id}" names="${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if>">${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></a>
                                    </c:when>
                                    <c:otherwise>
                                        <li style="text-align: left; display: table; height: auto; margin-left: 15px; margin-top: 15px"><div style="float: left; margin-right: 15px" id="box4"><a href="/orderingstar?id=${star.id}"><img  style="border: 1px solid #d4d1d5; border-radius: 3px; padding: 2px;" width="60" height="auto" src="/starSource/${star.id}/mainphoto.png" ></a></div><a href="/orderingstar?id=${star.id}" style="display: table-cell; vertical-align: middle" class ="ids" idstar="${star.id}" names="${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if>">${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>

                    </c:when>

                    <c:when test="${status eq 'SearchZero'}">



                            <div id="NameModalsrch" >
                                <span>Suchergebnis - ${srh} treffer, senden Sie uns die Nachricht und wir werden uns freuen Sie zu informieren, wenn dieser Star auf unserer Seite erscheint.</span>
                                <form id="requestStarSrch">
                                        <input type="text"  id="Emailrem" name="Emailrem" placeholder="Email"/><span id="validEmailrem" style=" margin-top: 23px;  margin-left: -25px; position: absolute;  width: 16px;  height: 16px;  z-index: 1060;"></span>
                                        <input type="text"  name="Namerem" value="${srch}" placeholder="${srch}"/>
                                </form>
                            </div>
                        <div id="NameModalsrch2" style="display: none">
                            <p style="margin-top: 10px">Vielen Dank! Ihre Nachricht wurde erfolgreich versendet.</p>
                        </div>
                            <div class="srch">
                            <div class="confirmsrch"><a onclick="requeststarsrch()">Senden</a></div>
                            </div>
                            <div class="clr"></div>
                            <script>

                                $(document).ready(function () {


                                    $("#Emailrem").bind('input',  function () {

                                        $('input[name=Emailrem]').css('border', '1px solid #ccc');
                                        var email = $('input[name=Emailrem]').val();
                                        if (email != 0) {
                                            if (isValidEmailAddress(email)) {

                                                $("#validEmailrem").css({

                                                    "background-image": "url('images/yes.png')"
                                                });
                                                $('input[name=Emailrem]').css('border', '1px solid #ccc');
                                            } else {

                                                $("#validEmailrem").css({
                                                    "background-image": "url('images/no.png')"
                                                });
                                            }

                                        } else {
                                            $("#validEmailrem").css({
                                                "background-image": "none"
                                            });
                                        }
                                    });


                            });


                            </script>


                    </c:when>

                </c:choose>
            </c:if>






