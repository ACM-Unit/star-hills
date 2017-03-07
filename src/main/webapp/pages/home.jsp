<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div id="BlockImgAll">
    <div id="BlockImg">
        <div id="LeftBlock">
            <div class="box"><img src="images/top/img1.jpg"/></div>
            <div class="box"><img src="images/top/img2.jpg" /></div>
            <div class="box"><img src="images/top/img3.jpg" /></div>
            <div class="box"><img src="images/top/img4.jpg" /></div>
            <div class="box"><img src="images/top/img5.jpg" /></div>
        </div>
        <div id="SliderBlock">
            <div class="flex-container">
                <div class="flexslider">
                    <ul class="slides">
                        <li>
                            <img src="images/slider/4.jpg"/>
                            <div class="descr">
                                <p class="FisrtText">Kaufe dieses <span>Geschenk</span></p>
                                <p class="NextText">und beeindrucke deine Freunde</p>
                                <div class="ButtonOrder">
                                    <div class="Prezent"></div>
                                    <a href="/celebrities">Bestellen</a>
                                </div>
                                <div class="Clr"></div>
                            </div>
                        </li>

                        <li>
                            <img src="images/slider/5.jpg"/>
                            <div class="descr">
                                <p class="FisrtText">Glückwünsche <span>von den</span></p>
                                <p class="NextText">Stars, ein unvergessliches Geschenk</p>
                                <div class="ButtonOrder">
                                    <div class="Prezent"></div>
                                    <a href="/celebrities">Bestellen</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <img src="images/slider/6.jpg"/>
                            <div class="descr">
                                <p class="FisrtText">Bestelle ein <span>Treffen</span></p>
                                <p class="NextText">mit deinem Promi</p>
                                <div class="ButtonOrder">
                                    <div class="Prezent"></div>
                                    <a href="/celebrities">Bestellen</a>
                                </div>
                            </div>
                        </li>
                        <li>
                            <img src="images/slider/1.jpg"/>
                            <div class="descr">
                                <p class="FisrtText">Jeder <span>Bestellung</span></p>
                                <p class="NextText">bringt euch einen Star</p>
                                <div class="ButtonOrder">
                                    <div class="Prezent"></div>
                                    <a href="/celebrities">Bestellen</a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div id="RightBlock">
            <div class="box"><img src="images/top/img6.jpg"/></div>
            <div class="box"><img src="images/top/img7.jpg" /></div>
            <div class="box1">
                <p class="boxTop">Zu den</p>
                <div class="delimiter"></div>
                <p class="boxTop2"><span>Stiftungen</span></p>
                <a href="/charity"></a>
            </div>
            <div class="box"><img src="images/top/img8.jpg" /></div>
        </div>
    </div>
    <div class="Clr"></div>
    <div id="BlockImgBottom"></div>
</div>
<div id="VideoCongratulations">
    <section id="request1">

        <h1><span>Habe Sie Ihren gewünschten Star nicht gefunden?</span> Dann schlagen Sie uns Ihren Lieblingsstar vor und wir nehmen mit ihm/ihr Kontakt auf!</h1>
        <form id="requestStar">
        <div id="Celebrities">
            <input  type="text" class="validform" id="Name" name="Name" placeholder="Geben Sie den Namen des Stars an"/>
        </div>
        <div id="CelebritiesEmail">
            <input  type="text" class="validform" id="Email" name="Email" placeholder="Geben Sie Ihre E-Mail Adresse an"/><span id="validEmail"></span>
        </div>
        <div id="ButtonSaveStar"><a href="#request2" onclick="requeststar()">senden</a></div>
        </form>
        <div class="Clr"></div>
    </section>
    <section id="request2">
        <h2 style="margin-top:100px"><span>Ihre Anfrage wurde erfolgreich gesendet</span></h2>
    </section>
    <div id="BlockVideoBottom">
        <div id="TitleOurMission"><span>Welche</span>  Mission haben wir?</div>
    </div>
</div>
<div id="OurMission">
    <section>
        <div id="OurMissionBlock">
            <div id="TextOurMission">
                <p>Jeder Mensch auf unserem Planeten strebt danach glücklich zu werden und auch andere Menschen
                    glücklich zu machen. Das
                    Projekt StarHills bietet Ihnen diese Chance an. Durch die Bestellung von
                    einem Videoclip, der von Ihrem Lieblingsstar aufgenommen wird, werden Sie nicht nur Ihre
                    liebsten Menschen glücklich machen, sondern auch die, die es am meisten brauchen. </p>
                <p>Mit unseren
                    Partnern von den Wohltätigkeitsstiftungen, den Prominenten an unserer Seite und mit Ihnen als
                    Kunden, helfen wir den Menschen überall auf der Welt. Mit jedem verkauften Video geht ein Teil
                    an die Stiftungsorganisationen, um denen zu helfen, die diese Hilfe
                    so nötig haben. Unser Team ist
                    sich sicher, dass wir mit Ihnen die Welt bunter und glücklicher machen werden.</p>
           </div>
        </div>
    </section>
</div>