<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html" />
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex">
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Wohltätigkeit</title>
    <link rel="stylesheet" href="<c:url value="/allStyles.css"/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value="/styleie.css"/>" type="text/css" />
    <%--<link rel="shortcut icon" href="<c:url value="/images/favicon.ico"/>" type="image/x-icon" />--%>
    <link rel="stylesheet" href="/js/owl-carousel/owl.carousel.css" type="text/css" />
    <link rel="stylesheet" href="/js/wickedpicker.min.css" type="text/css" />
    <link rel="stylesheet" href="/remodal/jquery.remodal.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="/js/crop/jquery.Jcrop.css" type="text/css" />
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="/js/contentflow.css">
    <script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <script src="https://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
    <![endif]-->
    <script src="https://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="/js/jquery.flexslider-min.js"></script>
    <script src="/js/wickedpicker.js"></script>
    <script type="text/javascript" src="/js/owl-carousel/owl.carousel.js"></script>
    <script type="text/javascript" src="/js/contentflow.js"></script>
    <script src="/js/jquery.main.js" type="text/javascript" ></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script src="/js/datepicker-de.js" type="text/javascript" ></script>
    <script src="/ckeditor/ckeditor.js"></script>
    <script src="/js/multiple-select.js"></script>
    <script src="/js/uppod-0.8.7.js" type="text/javascript"></script>
    <script language="JavaScript" src="/js/uppod_flash.js"></script>
    <script language="JavaScript" src="/js/swfobject.js"></script>

    <script>
        function showremember(id, current) {
            document.getElementById(current).style.display = 'none';
            document.getElementById(id).style.display = 'block';
            current = id;
            $('#statusError').html(' ');
            $('#statusRecoverError').html(' ');
            $('input[name=email]').css('border', '1px solid #d7d7d7');
            $('input[name=email]').css('border-radius', '5px');
            $('input[name=j_password]').css('border', '1px solid #d7d7d7');
            $('input[name=j_password]').css('border-radius', '5px');
            $('input[name=j_username]').css('border', '1px solid #d7d7d7');
            $('input[name=j_username]').css('border-radius', '5px');
        }

    </script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
   <script src="/js/jquery.maskedinput.min.js"></script>
    <script type="text/javascript">
        $.noConflict();
        jQuery(function($){
            jQuery('#PhoneRegistration').mask('+49(ddd) dd-dd-dd-dd');
            jQuery('#PhoneFree').mask('+49(ddd) dd-dd-dd-dd');
            jQuery('#PhoneModal').mask('+49(ddd) dd-dd-dd-dd');
            jQuery('#PhoneCabinet').mask('+49(ddd) dd-dd-dd-dd');
            jQuery('#PhoneOrdering').mask('+49(ddd) dd-dd-dd-dd');
            jQuery('#PhoneTwo').mask('+49(ddd) dd-dd-dd-dd');
        });
    </script>

    <script src="/js/requests.js" type="text/javascript" ></script>
    <script src="/js/adapter.js" type="text/javascript" ></script>
    <script src="/js/ordering.js" type="text/javascript" ></script>
    <style>
        html { overflow-x: hidden; }
        body { overflow-x: hidden; }
        #BlockSkype {
            display: none;
        }
        #remember-me {
        display: none;
    }
    /*#vidfile{
        display: none;
    }*/
    #regSuchess{
        display: none;
    }
        #records {
            display: none;
        }
    #recording {
        display: none;
    }
    #video {
        display: none;
    }
    #videoplay {
        display: none;
    }
    #stop {
        display: none;
    }
    #start {
        display: none;
    }
        #starttext {
            display: none;
        }
    #play {
        display: none;
    }
    #send {
        display: none;
    }
        #request2{
            display: none;
        }
    </style>
    <style>#Page1, #Page2{
        display: none;
    }
    </style>

    <style type="text/css">
        #target {
            background-color: #ccc;
            width: 500px;
            height: 330px;
            font-size: 24px;
            display: block;
        }


    </style>
    <script src="/js/device.js"></script>
    <script>
        $(document).ready(function () {
            if(device.tablet() || device.mobile()){
                $('#requestblock').css('display','none');
                $('#videofile').css('border-radius', '16px 16px 16px 16px');
                $('#videofile').css('float', 'none');
                $('#videofile').css('margin', '8px auto');
            }
        });
    </script>
</head>
<body>
<div id="Top">
    <section>
        <div id="Home"><a href="/"></a></div>
        <nav>
            <ul>
                <li><a href="/aboutus">Über uns</a></li>
                <li><a href="/contacts">Kontakt</a></li>
                <li><a href="/celebrities">Stars</a></li>
                <li><a href="/charity">Wohltätigkeit</a></li>
            </ul>
        </nav>
        <div id="Phone1">+49 177 3002976
            <div id="BgPhone"></div>
        </div>
    </section>
    <div class="Clr"></div>
</div>
<div id="Header">
    <section>
        <div id="Logo"><a href="/"></a></div>
        <div id="Searching"><p>Finde hier deinen Star!</p>
            <form class="search" id="resultSearchHeader">
                <input type="text" id="resultSearchHeaderId" name="Search" placeholder="Finde deinen Star" class="input" />
                <input type="submit" name="" value="" class="submit" onclick="search('#resultSearchHeader'); return false;" />
            </form>
        </div>
        <div id="ButtonBlock">
            <sec:authorize access="!isAuthenticated()">
                <div id="ButtonUser"></div></p>
                <div id="ButtonLogin"><a href="#login">Log in</a></div></p>
                <div id="ButtonCheckIn"><a href="/registration">Registrierung</a></div>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <div id="ButtonUser"><span>Benutzername: <sec:authentication property="principal.username"/></span></div>
                <div id="ButtonLogin"><a href="/logout">Abmelden</a></div>
                <sec:authorize access="hasAnyRole('STAR')"> <div id="ButtonCheckIn"><a href="/cabinet">Account</a></div></sec:authorize>
            </sec:authorize>
            <div class="remodal" data-remodal-id="login" style="width: 320px;">
                <div id="auth">
                <h1>Log in</h1>
                <c:url value="/j_spring_security_check" var="loginUrl" />
                <form:form id="enterform" method="POST" action="${loginUrl}">
                    <div id="NameModal"><input  type="text" name="j_username" placeholder="Benutzername" value=""/></div>
                    <div id="PassModal"><input type="password" name="j_password" placeholder="Passwort" value=""/></div>
                    <div class="confirmok"><a href="#login" onclick="enter()">OK</a></div>
                </form:form>
                    <div class="confirm"><a href="#login" onclick="showremember('remember-me', 'auth'); return false;">Passwort vergessen?</a></div>
                    <c:if test="${error=='error'}">
                        <span style="display: inline-block; margin-top: 5px; width: 100%; text-align: right; color: red;" id="statusError" class="modalMessage">Benutzername oder Passwort ist ungültig</span>
                    </c:if>
                    <c:if test="${error!='error'}">
                        <span style="display: inline-block; margin-top: 5px; width: 100%; text-align: right; color: red;" id="statusError" class="modalMessage"></span>
                    </c:if>
            </div>
                    <div id="remember-me">
                    <h1>Passwort wiederherstellen</h1>
                    <form:form method="POST" id="recoverform" action="/recover-password">
                        <div id="NameModalrem"><input  type="text" name="email" placeholder="e-mail adresse" value=""/></div>
                        <div class="confirmrem"><a href="#login" onclick="recover()">wiederherstellen</a></div>
                        <div class="confirmremcancel"><a href="#login" onclick="showremember('auth', 'remember-me'); return false;">zurück</a></div>
                        <span style="display: inline-block; margin-top: 5px; width: 100%; text-align: right; " id="statusRecoverError" class="modalMessage"></span>
                    </form:form>
                </div>
            </div>

        </div>
    </section>
    <div class="Clr"></div>
</div>
<jsp:include page="${currentPage}" flush="true" />
<div id="BottomNavAll">
    <section>
        <div id="ListMenu">
            <ul>
                <li><a href="/aboutus">Über uns</a></li>
                <li><a href="/faq">FAQ</a></li>
                <li><a href="/contacts">Kontakt</a></li>
                <li><a href="/celebrities">Stars</a></li>

            </ul>
            <div class="Clr"></div>
            <ul>
                <li><a href="/charity">Wohltätigkeit</a></li>
                <li><a href="/callus">Impressum</a></li>
                <li><a href="/news">News</a></li>
            </ul>
            <div class="Clr"></div>
        </div>
        <div id="PhoneBottom">+49 177 3002976</div>
        <div id="Soc">
            <ul>
                <li><a href="#"></a></li>
                <li><a href="#"></a></li>
                <li><a href="#"></a></li>
                <li><a href="#"></a></li>
                <div class="Clr"></div>
            </ul>
        </div>
        <div class="Clr"></div>
    </section>
</div>

<div class="remodal" style="width: 100%; visibility: visible; padding: 35px 10px;" data-remodal-id="search" >
    <%--<button data-remodal-action="close" class="remodal-close"></button>--%>

    <div id="statusSuccess">
        <p>Suchergebnisse:</p>
        <p id = "statussearch"></p>
    </div>


</div>
<div id="progress-text"></div>
<div class="background-progress"></div>
<div id="progress-wrp"><div class="progress-bar"></div ><div class="status">0%</div></div>
<div class="modalWaiting"></div>
<footer>
    <span>Die Webseite wurde von der Firma</span> <a href="http://shulex.com" target="_blank"><img style="width: 80px; margin-bottom: -5px;" src="images/shulex.png"/></a> <span>entwickelt, 2016</span>
</footer>



<script>
    $(document).ready(function () {
        $('.flexslider').flexslider({
            animation: 'fade',
            controlsContainer: '.flexslider'
        });
    });
</script>
<script>
    $(function() {
    var options = {
        upArrow: 'wickedpicker__controls__control-up',
        twentyFour: true,
        close: 'wickedpicker__close', //The close class selector to use, for custom CSS
        hoverState: 'hover-state', //The hover state class to use, for custom CSS
        title: 'Zeitpunkt' //The Wickedpicker's title
    };
        $('.timepicker').wickedpicker(options);
});
</script>

<script src="/remodal/jquery.remodal.js"></script>
</body>
</html>
