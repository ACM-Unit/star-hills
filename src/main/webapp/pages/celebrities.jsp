<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript">
<!--//---------------------------------+
//  Developed by Roshan Bhattarai 
//  Visit http://roshanbh.com.np for this script and more.
//  This notice MUST stay intact for legal use
// --------------------------------->
$(document).ready(function()
{
	//slides the element with class "menu_body" when paragraph with class "menu_head" is clicked 
	$("#firstpane p.menu_head").click(function()
    {
		$(this).css({backgroundImage:""}).next("div.menu_body").slideToggle(300).siblings("div.menu_body").slideUp("slow");
       	$(this).siblings().css({backgroundImage:""});
	});
	//slides the element with class "menu_body" when mouse is over the paragraph
	$("#secondpane p.menu_head").mouseover(function()
    {
	     $(this).css({backgroundImage:""}).next("div.menu_body").slideDown(500).siblings("div.menu_body").slideUp("slow");
         $(this).siblings().css({backgroundImage:""});
	});
});
</script>


<style>
<c:forEach items="${sections}" var="section" varStatus="loop">
<c:if test="${section.image!=null}">
    #Style${section.id} {background: url(/images/SearckCat/${section.image}.png) 5% center no-repeat, #e7e6e9;}
    #Style${section.id}:hover {background: url(/images/SearckCat/${section.image}Hover.png) 5% center no-repeat, #e32026;}
</c:if>
</c:forEach>
</style>


</head>
<body>

<div id="AllSearch">
<section>
<div id="SearchingBlock">
        <form class="search" id="resultSearch">
  		<input type="search" id="resultSearchId" name="Search" placeholder="Finde deinen Star" class="input" />
  		<input type="submit" name="" value="" class="submit" onclick="search('#resultSearch'); return false;" />
		</form>
   </div>

    <div id="FotoBLockAll">
        <div id="FotoS" ><img src="starSource/noPhoto.png"></div>
        <div id="NameS"></div>
        <div id="ButtonN"><p>weiter</p></div>
    </div>

<div id="Left">
<div class="SlideToggle">
	<div id="BlockSerch"><p>Suche nach Kategorien</p></div>
</div>
  <div id="firstpane" class="menu_list">
        <c:forEach items="${sections}" var="section">
		    <p class="menu_head" id="Style${section.id}">${section.name}</p>
            <div class="menu_body">
                <c:forEach items="${categories}" var="category">
                    <c:if test="${section.id == category.section.id}">
                    <li class='drop-link'><a>${category.name}</a>
                        <ul class='drop-block'>
                            <c:forEach items="${stars}" var="star">
                           <c:if test="${star.category.id == category.id}">
                            <li><a class ="ids" idstar="${star.id}" names="${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if>">${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></a><sec:authorize access="hasAnyRole('ADMIN')"><img src="images/edit.png" onclick="javascript: window.location = '/starscabinet?id=${star.id}'"></sec:authorize></li>
                            </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
            </div>
        </c:forEach>
      <p class="menu_head" id="Style${section.id}">${section.name}</p>
      <div class="menu_body">
          <c:forEach items="${categories}" var="category">
              <c:if test="${section.id == category.section.id}">
                  <li class='drop-link'><a>${category.name}</a>
                      <ul class='drop-block'>
                          <c:forEach items="${stars}" var="star">
                              <c:if test="${star.category.id == category.id}">
                                  <li><a class ="ids" idstar="${star.id}" names="${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if>">${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></a><sec:authorize access="hasAnyRole('ADMIN')"><img src="images/edit.png" onclick="javascript: window.location = '/starscabinet?id=${star.id}'"></sec:authorize></li>
                              </c:if>
                          </c:forEach>
                      </ul>
                  </li>
              </c:if>
          </c:forEach>
          <sec:authorize access="hasAnyRole('ADMIN')">
          <li class='drop-link'><a>${newCategory.name}</a>
              <ul class='drop-block'>
                  <c:forEach items="${stars}" var="star">
                      <c:if test="${star.category.id == newCategory.id}">
                          <li><a class ="ids" idstar="${star.id}" names="${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if>">${star.name} <c:if test="${star.alias != null}">(${star.alias})</c:if></a><img src="images/edit.png" onclick="javascript: window.location = '/starscabinet?id=${star.id}'"></li>
                      </c:if>
                  </c:forEach>
              </ul>
          </li>
          </sec:authorize>
      </div>
       <div class="clr"></div>
  </div>
  </div>
  
  <div class="clr"></div>

</section>   
</div>
<div id="request1">
<div id="Offer">
<section>

<div id="offerblock">
<form id="requestStar">
    <p>Habe Sie Ihren gewünschten Star nicht gefunden? Dann schlagen</p>
    <p>Sie uns Ihren Lieblingsstar vor und wir nehmen mit ihm/ihr Kontakt auf!

        <input type="text" claass="validform" id="Email" name="Email" placeholder="Email"><span id="validEmail" style="margin-left: -25px;"></span>
        <input type="text" name="Name" placeholder="Name des Stars">

   </p>
</form>
</div>
    <%--<div id="ButOf"><div id="ButtonOffer"><a onclick="requeststar()" >senden</a></div></div>--%>
    <div id="ButtonOffer"><a onclick="requeststar()" >senden</a></div>
    <div class="clr"></div>


</section>

</div>
</div>



<div id="request2">

    <div id="Offer">
        <section>

            <div id="offerblock">
                <p>Ihre Anfrage wurde erfolgreich gesendet</p>
            </div>

            <div class="clr"></div>


        </section>

    </div>

</div>


<div class="modalWaitingSearсh"></div>

<script>
$(document).ready(function () {
	$('.flexslider').flexslider({
		animation: 'fade',
		controlsContainer: '.flexslider'
	});
});
</script>


