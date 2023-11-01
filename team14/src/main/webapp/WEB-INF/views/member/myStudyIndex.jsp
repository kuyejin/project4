<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path14" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
    <title>나의 학습방</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <link rel="stylesheet" href="${path14}/resources/css/myStudy/myStudyIndex.css"/>


</head>


<body>


<div id="wrap">
    <jsp:include page="../include/header.jsp"></jsp:include>
    <%@ include file="/WEB-INF/views/mystudy/myStudyTopbar.jsp" %>


    <div class="mainCont">

        <div class="titArea">
            <h3 class="subMtit">최근 수강 강좌</h3>
            <span>수강 중인 강좌 <em> 0</em>개</span>


            <div class="board_wrap">
                <!-- <div class="board_title">
                    <strong>공지사항</strong>
                    <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
                </div> -->
                <div class="board_list_wrap">
                    <div class="board_list">
                        <div class="top">
                            <div class="num">분류</div>
                            <div class="title">강좌명</div>
                            <div class="writer">강사님</div>
                            <div class="date">수강기간</div>
                            <div class="count">남은기간</div>
                            <div class="count">상태</div>
                            <div class="count">학습</div>
                        </div>
                        <div>
                            <div class="num">5</div>
                            <div class="title"><a href="view.html">글 제목이 들어갑니다.</a></div>
                            <div class="writer">김이름</div>
                            <div class="date">2021.1.15</div>
                            <div class="count">33</div>
                        </div>
                        <div>
                            <div class="num">4</div>
                            <div class="title"><a href="view.html">글 제목이 들어갑니다.</a></div>
                            <div class="writer">김이름</div>
                            <div class="date">2021.1.15</div>
                            <div class="count">33</div>
                        </div>
                        <div>
                            <div class="num">3</div>
                            <div class="title"><a href="view.html">글 제목이 들어갑니다.</a></div>
                            <div class="writer">김이름</div>
                            <div class="date">2021.1.15</div>
                            <div class="count">33</div>
                        </div>
                        <div>
                            <div class="num">2</div>
                            <div class="title"><a href="view.html">글 제목이 들어갑니다.</a></div>
                            <div class="writer">김이름</div>
                            <div class="date">2021.1.15</div>
                            <div class="count">33</div>
                        </div>
                        <div>
                            <div class="num">1</div>
                            <div class="title"><a href="view.html">글 제목이 들어갑니다.</a></div>
                            <div class="writer">김이름</div>
                            <div class="date">2021.1.15</div>
                            <div class="count">33</div>
                        </div>
                    </div>
                    <!-- <div class="board_page">
                        <a href="#" class="bt first"><<</a>
                        <a href="#" class="bt prev"><</a>
                        <a href="#" class="num on">1</a>
                        <a href="#" class="num">2</a>
                        <a href="#" class="num">3</a>
                        <a href="#" class="num">4</a>
                        <a href="#" class="num">5</a>
                        <a href="#" class="bt next">></a>
                        <a href="#" class="bt last">>></a>
                    </div>
                    <div class="bt_wrap">
                        <a href="write.html" class="on">등록</a>

                    </div> -->
                </div>
            </div>
        </div>
    </div>

    <footer id="footer" class="footer-nav row expanded collapse">
        <!-- 푸터 부분 인클루드 -->
        <jsp:include page="../include/footer.jsp"></jsp:include>
    </footer>
</div>



</body>
</html>