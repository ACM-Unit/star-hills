<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="/index_files/favicon.ico" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${seo.title}</title>
    <meta name="keywords" content="${seo.keywords}">
    <meta name="description" content="${seo.description}">
    <style>
        @import url(https://fonts.googleapis.com/css?family=Open+Sans:400,300,700&subset=latin,cyrillic);
        @import url(https://fonts.googleapis.com/css?family=Changa+One);

        .comingcontainer { font-family: 'Open Sans', sans-serif; font-size: 14px; color: #3c3c3c;
            background: url(/img/ch2.png) top right no-repeat, url(/img/ch1.png) top left no-repeat, #b3d3f7 url(/img/bg1.png);background-attachment:fixed;
        }
        @keyframes go3d {
            0% { text-shadow: 0px 0px 2px #686868; }
            100% {
                /***** 3D Трансформация *****/
                text-shadow: 0px 0px 2px #686868,
                0px 1px 1px #ddd,
                0px 2px 1px #d6d6d6,
                0px 3px 1px #ccc,
                0px 4px 1px #c5c5c5,
                0px 5px 1px #c1c1c1,
                0px 6px 1px #bbb,
                0px 7px 1px #777,
                0px 8px 3px rgba(100, 100, 100, 0.4),
                0px 9px 5px rgba(100, 100, 100, 0.1),
                0px 10px 7px rgba(100, 100, 100, 0.15),
                0px 11px 9px rgba(100, 100, 100, 0.2),
                0px 12px 11px rgba(100, 100, 100, 0.25),
                0px 13px 15px rgba(100, 100, 100, 0.3);  }
        }

        @-webkit-keyframes go3d {
            0% { text-shadow: 0px 0px 2px #686868; }
            100% {
                /***** 3D Трансформация *****/
                text-shadow: 0px 0px 2px #686868,
                0px 1px 1px #ddd,
                0px 2px 1px #d6d6d6,
                0px 3px 1px #ccc,
                0px 4px 1px #c5c5c5,
                0px 5px 1px #c1c1c1,
                0px 6px 1px #bbb,
                0px 7px 1px #777,
                0px 8px 3px rgba(100, 100, 100, 0.4),
                0px 9px 5px rgba(100, 100, 100, 0.1),
                0px 10px 7px rgba(100, 100, 100, 0.15),
                0px 11px 9px rgba(100, 100, 100, 0.2),
                0px 12px 11px rgba(100, 100, 100, 0.25),
                0px 13px 15px rgba(100, 100, 100, 0.3);  }
        }

        @-moz-keyframes go3d {
            0% { text-shadow: 0px 0px 2px #686868; }
            100% {
                /***** 3D Трансформация *****/
                text-shadow: 0px 0px 2px #686868,
                0px 1px 1px #ddd,
                0px 2px 1px #d6d6d6,
                0px 3px 1px #ccc,
                0px 4px 1px #c5c5c5,
                0px 5px 1px #c1c1c1,
                0px 6px 1px #bbb,
                0px 7px 1px #777,
                0px 8px 3px rgba(100, 100, 100, 0.4),
                0px 9px 5px rgba(100, 100, 100, 0.1),
                0px 10px 7px rgba(100, 100, 100, 0.15),
                0px 11px 9px rgba(100, 100, 100, 0.2),
                0px 12px 11px rgba(100, 100, 100, 0.25),
                0px 13px 15px rgba(100, 100, 100, 0.3);  }
        }

        @-ms-keyframes go3d {
            0% { text-shadow: 0px 0px 2px #686868; }
            100% {
                /***** 3D Трансформация *****/
                text-shadow: 0px 0px 2px #686868,
                0px 1px 1px #ddd,
                0px 2px 1px #d6d6d6,
                0px 3px 1px #ccc,
                0px 4px 1px #c5c5c5,
                0px 5px 1px #c1c1c1,
                0px 6px 1px #bbb,
                0px 7px 1px #777,
                0px 8px 3px rgba(100, 100, 100, 0.4),
                0px 9px 5px rgba(100, 100, 100, 0.1),
                0px 10px 7px rgba(100, 100, 100, 0.15),
                0px 11px 9px rgba(100, 100, 100, 0.2),
                0px 12px 11px rgba(100, 100, 100, 0.25),
                0px 13px 15px rgba(100, 100, 100, 0.3);  }
        }

        @-o-keyframes go3d {
            0% { text-shadow: 0px 0px 2px #686868; }
            100% {
                /***** 3D Трансформация *****/
                text-shadow: 0px 0px 2px #686868,
                0px 1px 1px #ddd,
                0px 2px 1px #d6d6d6,
                0px 3px 1px #ccc,
                0px 4px 1px #c5c5c5,
                0px 5px 1px #c1c1c1,
                0px 6px 1px #bbb,
                0px 7px 1px #777,
                0px 8px 3px rgba(100, 100, 100, 0.4),
                0px 9px 5px rgba(100, 100, 100, 0.1),
                0px 10px 7px rgba(100, 100, 100, 0.15),
                0px 11px 9px rgba(100, 100, 100, 0.2),
                0px 12px 11px rgba(100, 100, 100, 0.25),
                0px 13px 15px rgba(100, 100, 100, 0.3);  }
        }

        .go3d {
            -webkit-animation: go3d 2s;
            -moz-animation: go3d 2s;
            -ms-animation: go3d 2s;
            -o-animation: go3d 2s;
            animation: go3d 2s;
        }

        .comingcontainer{
            width: 100%;
        }

        .checkbacksoon {
            width: auto;
            height: 100%;
            padding-top: 8%;
            padding-bottom: 8%;
        }

        .checkbacksoon p {
            text-shadow: none;
            font-weight: normal;
            color: #666;
            font-family: 'Open Sans', sans-serif;
            display: block;
            margin: auto;
            text-align:center;
            text-shadow: 0px 1px 0px #ffffff;
        }


        .checkbacksoon p span {
            color:#fff;
            font-family: 'Changa One', cursive;
            font-size: 200px;
            line-height: 140px;
            letter-spacing: 1px;

            cursor:pointer;

            -webkit-transition: all 0.1s linear;
            -moz-transition: all 0.1s linear;
            -o-transition: all 0.1s linear;
            -ms-transition: all 0.1s linear;
            transition: all 0.1s linear;

            /***** 3D Трансформация *****/
            text-shadow: 0px 0px 2px #686868,
            0px 1px 1px #ddd,
            0px 2px 1px #d6d6d6,
            0px 3px 1px #ccc,
            0px 4px 1px #c5c5c5,
            0px 5px 1px #c1c1c1,
            0px 6px 1px #bbb,
            0px 7px 1px #777,
            0px 8px 3px rgba(100, 100, 100, 0.4),
            0px 9px 5px rgba(100, 100, 100, 0.1),
            0px 10px 7px rgba(100, 100, 100, 0.15),
            0px 11px 9px rgba(100, 100, 100, 0.2),
            0px 12px 11px rgba(100, 100, 100, 0.25),
            0px 13px 15px rgba(100, 100, 100, 0.3);
        }
        .checkbacksoon p .before{font-size: 60px;}
        .checkbacksoon p span:hover {
            text-shadow: 0px 0px 2px #686868;

            -webkit-transition: all 0.1s linear;
            -moz-transition: all 0.1s linear;
            -o-transition: all 0.1s linear;
            -ms-transition: all 0.1s linear;
            transition: all 0.1s linear;
        }

        .error {
            font-size: 16px;
            width: 700px;
            max-width: 90%;
            line-height: 2em;
            letter-spacing: 1px;font-weight: 400;text-shadow: 0px 1px 1px #ffffff;
        }

        /* Нижняя панель навигации
        ================================================== */

        /* Media Queries
        ================================================== */

        /* Меньше, чем стандартные 960 (устройства и браузеры) */
        @media only screen and (max-width: 1200px) {

        }
        @media only screen and (max-width: 959px) {

        }

        /* Планшетный экран размер стандартного 960 (устройства и браузеры) */
        @media only screen and (min-width: 768px) and (max-width: 959px) {

        }

        /* Все мобильные экраны (устройства и браузеры) */
        @media only screen and (max-width: 767px) {

        }

        /* Мобильные экраны и планшеты (устройства и браузеры) */
        @media only screen and (min-width: 480px) and (max-width: 767px) {
            .checkbacksoon p span { font-size: 150px; line-height: 100px; }.error {font-size: 14px;}.search {width: 220px;}
            .checkbacksoon p .before { font-size: 45px; line-height: 100px; }.error {font-size: 14px;}.search {width: 220px;}
        }
        /* Мобильные экраны (устройства и браузеры) */
        @media only screen and (max-width: 479px) {
            .checkbacksoon p span { font-size: 140px; line-height: 100px; }.error {font-size: 14px;}.search {width: 220px;}
            .checkbacksoon p .before { font-size: 40px; line-height: 100px; }.error {font-size: 14px;}.search {width: 220px;}
        }
    </style>
</head>
<body>
<div class="comingcontainer">
    <div class="checkbacksoon">
        <p>
            <span class="go3d">5</span>
            <span class="go3d">0</span>
            <span class="go3d">0</span>
            <span class="go3d">!</span>
            <br>
            <span class="go3d before">INTERNAL </span>
            <span class="go3d before">SERVER </span>
            <span class="go3d before">ERROR!</span>
            <br>
            <p style="font-size: 30px; color: red">${headstack}</p>
        <br>
        <p>${stack}</p>
        </p>
    </div>

</div>
</body>
</html>