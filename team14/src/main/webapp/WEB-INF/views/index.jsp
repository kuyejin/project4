<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<!DOCTYPE html>
<!--
// WEBSITE: https://themefisher.com
// TWITTER: https://twitter.com/themefisher
// FACEBOOK: https://www.facebook.com/themefisher
// GITHUB: https://github.com/themefisher/
-->
<html lang="zxx">
<head>
    <meta charset="utf-8">
    <title>스마트 해법 메인 페이지</title>
    <!-- mobile responsive meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- theme meta -->
    <meta name="theme-name" content="kross-bulma"/>
    <!-- ** Plugins Needed for the Project ** -->
    <!-- bulma -->
    <link rel="stylesheet" href="${path}/resources/theme/plugins/bulma/bulma.min.css">
    <!-- slick slider -->
    <link rel="stylesheet" href="${path}/resources/theme/plugins/slick/slick.css">
    <!-- themefy-icon -->
    <link rel="stylesheet" href="${path}/resources/theme/plugins/themify-icons/themify-icons.css">
    <!-- Main Stylesheet -->
    <link href="${path}/resources/theme/css/style.css" rel="stylesheet">
    <!--Favicon-->
    <link rel="shortcut icon" href="${path}/resources/img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/img/favicon.ico" type="image/x-icon">


    <!-- 슬라이드 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>

    <style>
        .swiper {
            z-index: 2;
        }

        * {
            font-family: 'NanumSquare' !important;
        }

        .buttons {
            margin-bottom: 0;
        }

        .buttons .button {
            margin-bottom: 0;
        }





        /*비디오*/
        body { padding: 0px; margin: 0px; }
        .jb-box { width: 100%;overflow: hidden;margin: 0px auto; position: relative; padding-top: 0px;}
        video { width: 100%; }
        .jb-text { position: absolute; top: 50%; width: 100%; }
        .jb-text p { margin-top: -24px; text-align: center; font-size: 48px; color: #ffffff; }

        .navbar{
            position: fixed;
            /*background-color: grey;*/
            /*opacity: 0.5;*/
            background-color: rgba(255, 255, 255, 0.6) !important;
        }


    </style>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<%--<jsp:include page="include/header.jsp"></jsp:include>--%>

<header id="header">
    <nav class="navbar is-dark is-fixed-top" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="${path}/" >
                <img src="${path}/resources/img/smart_haebeop_logo.png" width="112" height="28">
            </a>
            <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false"
               data-target="navbarBasicExample">
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
            </a>
        </div>

        <!-- header menu -->
        <div class="navbar-start">
            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link is-arrowless" id="menu1"
                   onmouseover="$(this).css({'background-color': '#CDEBFF', 'color': 'white'});"
                   onmouseout="$(this).css({'background-color': '', 'color': ''});">
                    <strong>강의</strong>
                </a>
                <div class="navbar-dropdown is-transparent is-size-6 is-dark is-outlined"
                     onmouseover="$('#menu1').css({'background-color': '#CDEBFF', 'color': 'white'});"
                     onmouseout="$('#menu1').css({'background-color': '', 'color': ''});">
                    <a href="${path}/lecture/lecList" class="button is-link2 is-rounded b2">
                        강의 목록
                    </a>
                </div>
            </div>

            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link is-arrowless" id="menu2"
                   onmouseover="$(this).css({'background-color': '#CDEBFF', 'color': 'white'});"
                   onmouseout="$(this).css({'background-color': '', 'color': ''});">
                    <strong>선생님</strong>
                </a>
                <div class="navbar-dropdown is-transparent is-size-6 is-dark is-outlined"
                     onmouseover="$('#menu2').css({'background-color': '#CDEBFF', 'color': 'white'});"
                     onmouseout="$('#menu2').css({'background-color': '', 'color': ''});">
                    <a href="${path}/instructor/instructorList" class="button is-link2 is-rounded b2">
                        선생님 목록
                    </a>
                </div>
            </div>


            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link is-arrowless" id="menu3"
                   onmouseover="$(this).css({'background-color': '#CDEBFF', 'color': 'white'});"
                   onmouseout="$(this).css({'background-color': '', 'color': ''});">
                    <strong>입시 커뮤니티</strong>
                </a>
                <div class="navbar-dropdown is-transparent is-size-6 is-dark is-outlined"
                     onmouseover="$('#menu3').css({'background-color': '#CDEBFF', 'color': 'white'});"
                     onmouseout="$('#menu3').css({'background-color': '', 'color': ''});">
                    <a href="${path}/board/list.do" class="navbar-item">
                        자유 게시판
                    </a>
                    <a href="${path}/infoStu/list.do" class="navbar-item">
                        교육 정보
                    </a>
                    <a href="${path}/infoUni/list.do" class="navbar-item">
                        대입 정보
                    </a>
                    <a href="${path}/infoAct/list.do" class="navbar-item">
                        대외 활동
                    </a>
                    <a href="${path}/file/filelist1.do" class="navbar-item">
                        자료실
                    </a>
                    <a href="${path}/news/list.do" class="navbar-item">
                        뉴스
                    </a>

                </div>
            </div>

            <div class="navbar-item is-hoverable has-dropdown">
                <a class="navbar-link is-arrowless" href="${path}/myclass/myclassIndex.do" style="color:black;"
                   id="menu5" onmouseover="$(this).css({'background-color': '#CDEBFF', 'color': 'white'});"
                   onmouseout="$(this).css({'background-color': '', 'color': ''});"> <%--class="button is-link2 is-rounded b2" --%>
                    <strong>나의 학습방</strong>
                </a>
            </div>

        </div>
        <!-- header menu end -->
        <div class="navbar-end">
            <div class="navbar-item">
                <div style="padding-right: 10px">

                </div>
                <div class="buttons" style="margin-bottom: 0">
                    <c:if test="${isInst==true}"> <%-- 선생님으로 로그인 한 경우 --%>
                        <a href="${path}/instructor/instructorDetail.do?no=${instNo}" class="button is-link is-rounded b2"  style="margin-bottom: 0">
                            나의 선생님 페이지
                        </a>
                    </c:if>
                    <c:if test="${not empty sid and sid ne ''}"> <%-- 회원으로 로그인한 경우 --%>
                        <a href="${path}/member/mypage.do" class="button is-link is-rounded b2"
                           style="margin-bottom: 0">
                            <img src="${path}/resources/img/account_thin.svg" alt="${sid}" width="26px">
                            &nbsp;${sid}님
                        </a>
                        <a href="${path}/cart/cartList.do" class="button is-link2 is-rounded b2"
                           style="margin-bottom: 0">
                            <img src="${path}/resources/img/cart_thin.svg" alt="" width="26px">
                                <%--                            장바구니--%>
                        </a>
                        <a href="${path}/member/logout.do" class="button is-link2 is-rounded b2"
                           style="margin-bottom: 0">
                            <img src="${path}/resources/img/logout_thin.svg" alt="" width="26px">
                                <%--                            로그아웃--%>
                        </a>
                    </c:if>
                    <c:if test="${empty sid}"> <%-- 로그인을 안 한 경우 --%>
                        <a href="${path}/member/login.do" class="button is-link2 is-rounded b2"
                           style="margin-bottom: 0">
                            로그인
                            <img src="${path}/resources/img/login_thin.svg" alt="" width="26px">

                        </a>
                        <a href="${path}/member/join.do" class="button is-link is-rounded b2" style="margin-bottom: 0">
                            회원가입
                            <img src="${path}/resources/img/person_add_thin.svg" alt="" width="26px">
                        </a>

                    </c:if>
                    <c:if test="${sid eq 'admin'}"> <%-- 관리자로 로그인 한 경우 --%>
                        <a href="${path}/admin/adminMain.do" class="button is-link is-rounded b2"
                           style="margin-bottom: 0">
                            <img src="${path}/resources/img/settings_thin.svg" alt="" width="26px">
                                <%--                            관리자페이지--%>
                        </a>
                    </c:if>
                </div>
                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link is-arrowless" id="menu4"
                       onmouseover="$(this).css({'background-color': '#CDEBFF', 'color': 'white'});"
                       onmouseout="$(this).css({'background-color': '', 'color': ''});">
                        <img src="${path}/resources/img/help_thin.svg" alt="" width="26px">
                        <%--                        <strong>고객센터</strong>--%>
                    </a>
                    <div class="navbar-dropdown is-transparent is-size-6 is-dark is-outlined"
                         onmouseover="$('#menu4').css({'background-color': '#CDEBFF', 'color': 'white'});"
                         onmouseout="$('#menu4').css({'background-color': '', 'color': ''});">
                        <a href="${path}/notice/list.do" class="navbar-item">
                            공지 사항
                        </a>
                        <a href="${path}/faq/list.do" class="navbar-item">
                            자주 묻는 질문
                        </a>
                        <a href="${path}/qna/list.do" class="navbar-item">
                            QnA
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>


<!-- hero area -->
<section class="hero-area has-background-primary" id="parallax" style="padding-top: 0;">
    <%--<div class="columns">
        <img src="${path }/resources/img/main_banner.png">
    </div>--%>

    <%--<div class="columns">
        <img src="${path }/resources/img/index_1.png">
    </div>--%>

        <div class="jb-box">
            <video muted autoplay loop>
                <source src="${path }/resources/video/main_video.mp4" type="video/mp4">
                <strong></strong>
            </video>
            <div class="jb-text">

            </div>
        </div>





    <!-- slidebar banner -->
    <div class="swiper mySwiper" style="margin-top: -10px">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <img src="${path }/resources/img/index_1.png" alt="메인페이지 배너1" style="width: 100vw">
            </div>
            <div class="swiper-slide">
                <img src="${path }/resources/img/index_2.png" alt="메인페이지 배너2" style="width: 100vw">
            </div>
            <div class="swiper-slide">
                <img src="${path }/resources/img/index_3.png" alt="메인페이지 배너3" style="width: 100vw">
            </div>
            <div class="swiper-slide">
                <img src="${path }/resources/img/index_4.png" alt="메인페이지 배너4" style="width: 100vw">
            </div>
        </div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-pagination"></div>
    </div>

    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
        var swiper = new Swiper(".mySwiper", {
            spaceBetween: 30,
            centeredSlides: true,
            loop: true, // 무한 루프
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });
    </script>

</section>
<!-- /hero area -->
<!-- 사이드 메뉴 -->
<%@include file="main/sidemenu.jsp" %>
<!-- 사이드 메뉴 -->
<!-- 소개글 -->
<%@include file="main/introduction.jsp" %>
<!-- 소개글 -->
<!-- slidebanner -->
<%@include file="main/slidebanner.jsp" %>
<!-- slidebanner -->
<!-- awards -->
<%@include file="main/awards.jsp" %>
<!-- awards -->
<!-- footer -->

<jsp:include page="include/footer.jsp"></jsp:include>

<!-- /footer -->
<!-- jQuery -->
<script src="${path}/resources/theme/plugins/jQuery/jquery.min.js"></script>
<!-- slick slider -->
<script src="${path}/resources/theme/plugins/slick/slick.min.js"></script>
<!-- filter -->
<script src="${path}/resources/theme/plugins/shuffle/shuffle.min.js"></script>
<!-- Main Script -->
<script src="${path}/resources/theme/js/script.js"></script>

<!-- 상담 api -->
<!--Start of Tawk.to Script-->
<script type="text/javascript">
    var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
    (function () {
        var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
        s1.async = true;
        s1.src = 'https://embed.tawk.to/652532e4eb150b3fb99ff97a/1hccktjhr';
        s1.charset = 'UTF-8';
        s1.setAttribute('crossorigin', '*');
        s0.parentNode.insertBefore(s1, s0);
    })();
</script>
<!--End of Tawk.to Script-->
</body>
</html>