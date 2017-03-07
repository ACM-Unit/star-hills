<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
