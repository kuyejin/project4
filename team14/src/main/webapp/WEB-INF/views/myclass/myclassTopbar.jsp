<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path21" value="${pageContext.request.contextPath }"/>


<head>

    <link type="text/css" rel="stylesheet" href="${path21}/resources/css/myStudy/common.css" media="all"/>
    <link type="text/css" rel="stylesheet" href="${path21}/resources/css/myStudy/mystudy.css" media="all"/>
    <link rel="stylesheet" href="${path21}/resources/css/myStudy/layout.css"/>
    <%--<script type="text/javascript" src="${path21}/resources/js/myStudy/common.js"></script>--%>
    <link rel="stylesheet" href="${path21}/resources/css/header/header.css">
    <%--    <script type="text/javascript" src="${path21}/resources/js/myStudy/jquery-1.8.3.min.js"></script>--%>
    <style>
        #dep04 {
            margin-left: 470px;
        }
    </style>

</head>
<body>

<!-- Sec01 -->
<div class="myStudySec01">
    <div class="mainCont">
        <!-- mystudyLry :  -->
        <div class="mystudyLryArea">
            <!-- mystudyOpen class="btnClose" 클릭시 class="mystudyClose" 에 on클래스가 추가되며 영역펼쳐짐  -->
            <div class="mystudyOpen">
                <!-- 내프로필 -->
                <dl class="myProfile">
                    <dt>
                        <span>내 프로필
                            <a href="javascript:;" onclick="mf_MoveToProfilePopup('ku1992');"
                               class="btns btnOrgline2"></a>

                            <!-- <span class="i_org_arr4">프로필 수정</span> -->
                            </span>
                        </p>
                    </dt>
                    <dd>
                        <div class="photo">
                            <!-- <a href="javascript:;" onclick="fnPopProfile();"> -->
                            <img src="${path21}/resources/img/myStudy/basic-profile-image_re.png">

                            </a>

                        </div>
                        <div class="info">
                            <span class="name">${member.name}<em> 님</em></span>

                            <ul class="infolist">

                                <c:choose>
                                    <c:when test="${member.pt >= 100000}">
                                        <li class="class" onclick="document.location.href=''" style="cursor:pointer;">등급
                                            :
<%--                                            <span class="cph_Contents_ucl_MyStudy_MyInfo_ltl_MemberClass1">--%>
                                            <span class="ico grade06">VIP</span>
                                        </li>
                                    </c:when>
                                    <c:when test="${member.pt >= 50000}">
                                        <li class="class" onclick="document.location.href=''" style="cursor:pointer;">등급
                                            :
<%--                                            <span class="cph_Contents_ucl_MyStudy_MyInfo_ltl_MemberClass1">--%>
                                            <span class="ico grade06">A</span>
                                        </li>
                                    </c:when>
                                    <c:when test="${member.pt >= 40000}">
                                        <li class="class" onclick="document.location.href=''" style="cursor:pointer;">등급
                                            :
<%--                                            <span class="cph_Contents_ucl_MyStudy_MyInfo_ltl_MemberClass1">--%>
                                            <span class="ico grade06">B</span>
                                        </li>
                                    </c:when>
                                    <c:when test="${member.pt >= 30000}">
                                        <li class="class" onclick="document.location.href=''" style="cursor:pointer;">등급
                                            :
<%--                                            <span class="cph_Contents_ucl_MyStudy_MyInfo_ltl_MemberClass1">--%>
                                            <span class="ico grade06">C</span>
                                        </li>
                                    </c:when>
                                    <c:when test="${member.pt >= 10000}">
                                        <li class="class" onclick="document.location.href=''" style="cursor:pointer;">등급
                                            :
<%--                                            <span class="cph_Contents_ucl_MyStudy_MyInfo_ltl_MemberClass1">--%>
                                            <span class="ico grade06">D</span>
                                        </li>
                                    </c:when>
                                    <c:when test="${member.pt >= 0 }">
                                        <li class="class" onclick="document.location.href=''" style="cursor:pointer;">등급
                                            :
<%--                                            <span class="cph_Contents_ucl_MyStudy_MyInfo_ltl_MemberClass1">--%>
                                          <%--  <span class="my-transaction-info__title">회원등급</span>--%>
                                            <span class="ico grade06">F</span>
                                        </li>
                                    </c:when>
                                </c:choose>
                                </span>

                                </li>
                                <li class="point" onclick="document.location.href=''" style="cursor:pointer;">포인트 : <em>
                                    ${member.pt} </em>점
                                </li>
                                <li class="note" onclick="document.location.href=''" style="cursor:pointer;">새쪽지 : 0개
                                </li>
                            </ul>

                        </div>
                    </dd>
                </dl>
                <!-- //내프로필 -->
                <!-- 월간 학습 현황 -->
                <dl class="myPlan">
                    <dt><span>월간 학습 현황</span></dt>
                    <dd>
                        <ul class="planList2">

                            <div class="jb-wrap">
                                <div class="jb-image"><img src="${path21}/resources/img/myStudy/mystudy1.png" alt="">
                                </div>
                                <div class="jb-text">
                                    <div class="jb-text-table">
                                        <div class="jb-text-table-row">
                                            <div class="jb-text-table-cell">
                                                <p>출석일수</p>
                                                <span>2 <em>일</em></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="jb-wrap">
                                <div class="jb-image"><img src="${path21}/resources/img/myStudy/mystudy1.png" alt="">
                                </div>
                                <div class="jb-text">
                                    <div class="jb-text-table">
                                        <div class="jb-text-table-row">
                                            <div class="jb-text-table-cell">
                                                <p>수강강의수</p>
                                                <span> ${count } <em>개</em></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="jb-wrap">
                                <div class="jb-image"><img src="${path21}/resources/img/myStudy/mystudy1.png" alt="">
                                </div>
                                <div class="jb-text">
                                    <div class="jb-text-table">
                                        <div class="jb-text-table-row">
                                            <div class="jb-text-table-cell">
                                                <p>수강시간</p>
                                                <span style="margin: -10px;">${count * 5} <em>시간</em></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- <li><strong class="tit">출석일수</strong> <span>
                                2<em>일</em></span> </li>
                            <li><strong class="tit">수강강의</strong> <span>
                                0<em>강</em></span> </li>
                            <li><strong class="tit">수강시간</strong> <span>
                                0<em>분</em></span> </li> -->
                        </ul>
                        <!-- <ul class="inner">
                            <li>수강상태 : 수강 중</li>
                            <li>수강기간 :
                                없음</li>
                        </ul> -->
                    </dd>
                </dl>
                <!-- //월간 학습 현황 -->


                <!--
                진행 중인 이벤트
                <dl class="ingEvnt">
                    <dt><span>진행 중인 이벤트</span></dt>
                    <dd>
                        <ul id="course_bnr02" class="course_bnr02">
<li class="slide-node slide-node-0"><a href="https://high.milkt.co.kr/EventNew/20200716_free/frm_Event_Tablet10DaysReg.aspx"><img src="/UploadFile/Banner/620aec30-a22e-4e34-be18-5a5d5840dcff20231017083444.png" alt="10월 무료체험 이벤트" /></a></li>
<li class="slide-node slide-node-1"><a href="https://high.milkt.co.kr/DalJa/Attend/frm_Attend_Event.aspx?menucode=110900"><img src="/UploadFile/Banner/78e92bd6-1f4a-4604-8890-72517c5b2c5e20220602092508.jpg" alt="출석 체크 이벤트" /></a></li>
</ul>
<ul class="bnrCtrl" id="course_bn_btn02">
<li><a href="https://high.milkt.co.kr/EventNew/20200716_free/frm_Event_Tablet10DaysReg.aspx">1번</a></li>
<li><a href="https://high.milkt.co.kr/DalJa/Attend/frm_Attend_Event.aspx?menucode=110900">2번</a></li>
</ul>

                    </dd>
                </dl>
                 //진행 중인 이벤트


                <a href="#" class="btnClose">닫기</a>-->
            </div>
            <!-- //mystudyOpen -->
            <!-- mystudyClose -->
            <div class="mystudyClose">
                <ul>
                    <li class="myProfile"><strong>내 프로필</strong> <span class="fst">등급 : 일반</span> <span>포인트
                        : 1000점</span></li>
                    <li class="myPlan"><strong>월간 학습 현황</strong> <span class="fst">수강상태 : 수강중</span> <span>
                        월간 출석일수 : 2일</span></li>
                </ul>
                <a href="#" class="bntOpen">열기</a>
            </div>
            <!-- //mystudyClose -->
        </div>
        <!--// mystudyLry -->
        <div class="studyGnbArea">
            <ul class="studyGnb">
                <li class="menu01" onfocus="menu_open('1');" onmouseover="menu_open('1');"><a
                        href="${path21}/myclass/myclassIndex.do" id="lnk0101">나의
                    강의실</a>
                    <%--<ul class="dep02" id="dep01">
                        <li><a id="sub010101" href="">수강중인 강좌</a></li>
                        <li><a id="sub010102" href="">강좌 찾기</a></li>
                        <li><a id="sub010112" href="">수강 완료 강좌</a></li>
                        <li><a id="sub010103" href="">학습노트</a></li>

                    </ul>--%>
                </li>

                <li class="menu02" onfocus="menu_open('2');" onmouseover="menu_open('2');"><a
                        href="${path21}/myclass/likeList.do" id="lnk0111">나의
                    좋아요</a>
                    <%--<ul class="dep02" id="dep02">
                        <li><a id="sub011101" href="">서브메뉴</a></li>
                        <li><a id="sub011102" href="">서브메뉴</a></li>
                        <li><a id="sub011103" href="">서브메뉴</a></li>
                        <li><a id="sub011105" href="">서브메뉴</a></li>
                        <li><a id="sub011104" href="">서브메뉴</a></li>
                    </ul>--%>
                </li>

                <li class="menu04" id="menu010701" onfocus="menu_open('4');" onmouseover="menu_open('4');"><a
                        href="${path21}/member/memberWrittenBoard.do"
                        id="lnk0107">내가
                    쓴 글</a>
                    <ul class="dep02" id="dep04">
                        <li><a id="sub010714" href="${path21}/member/memberWrittenBoard.do">내가 쓴 글</a></li>
                        <li><a id="sub010712" href="${path21}/member/memberWrittenComent.do">내가 남긴 댓글</a></li>
                    </ul>
                </li>
                <li class="menu05" onfocus="menu_open('5');" onmouseover="menu_open('5');"><a
                        href="${path21}/grade/slist.do" id="lnk0130">성적표</a></li>

                <li class="menu06" onfocus="menu_open('6');" onmouseover="menu_open('6');"><a
                        href="${path21}/calendar/list.do" id="lnk1007">학습계획표</a></li>
            </ul>
        </div>
    </div>
</div>
<!-- //Sec01 -->


<script type="text/javascript">

    function menu_open(menu) {

        var dep = menu;
        var currentMenu; //현재메뉴
        var currentDep; //현재 뎁스
        var currentMenuClass;//현재 메뉴 클래스

        //TEST ZONE 메뉴
        //if (menu == 11) {
        //    menu = menu - 1;
        //}

        if (menu < 10) {
            currentMenu = ".menu0" + menu;
        } else {
            currentMenu = ".menu" + menu;
        }
        currentDep = "#dep0" + dep;
        currentMenuClass = $(currentMenu).attr('class');

        //메뉴 개수 만큼
        for (i = 1; i <= 12; i++) {

            if (i < 10) {
                $(".menu0" + i).attr("class", "menu0" + i);
            } else {
                $(".menu" + i).attr("class", "menu" + i);
            }

            $("#dep0" + i).hide();
        }

        $(currentMenu).attr("class", currentMenuClass + " on");
        $(currentDep).show(); //서브메뉴 펼치기

    }

    function fnDefaultMenu() {
        var $obj = $("#lnk0111");
        if ($obj) {
            var idx = $("ul.studyGnb>li").index($obj.parent());
            menu_open(eval(idx + 1));
            console.log(idx)
        }
    }


</script>
</body>