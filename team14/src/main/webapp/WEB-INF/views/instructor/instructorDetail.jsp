<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path14" value="${pageContext.request.contextPath }"/>

<html>
<head>
    <title>${instructor.name} 선생님</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <link rel="stylesheet" href="${path14}/resources/css/instructorPage/baseLayout.css"/>
    <link rel="stylesheet" href="${path14}/resources/css/instructorPage/sidebar.css"/>
    <link rel="stylesheet" href="${path14}/resources/css/instructorPage/validateUser.css"/>
    <link rel="stylesheet" href="${path14}/resources/css/instructorPage/myPageindex.css"/>

    <style>
        #container {
            margin-top: 80px;
        }
        .instRight{
            float:right;
            /*background-color: red;*/
            height: 400px;
            width: 400px;
            padding-right: 30px;
        }
        .instName{
            text-align: right;
            font-size: 24px;
            margin-top: 30px;
        }
        .instIntro{
            text-align: right;
            font-size: 30px;
            margin-top: 6px;
            height: 110px;
            word-wrap: break-word;
            overflow: hidden;

        }
        .instReview{

        }
        .instReview h5 {
            text-align: left;
            float: left;
            margin-left: 20px;
            color: #0a0a0a;
        }
        .instReview h6 {
            text-align: right;
            float: right;
            color: #0a0a0a;

        }
        .instReview a:hover {
            text-decoration: none;
            color: #0a0a0a;
        }
        .reviewList {
            /*background-color: #c5d6e6;*/
            /*border-radius: 14px;*/
            width: 350px;
            height: 180px;
            margin-left: 20px;
            margin-top: 26px;
            border-top: 1px solid black;
        }
        .reviewList table {
            width:350px;
        }
        .reviewList tr {
            width:350px;
            line-height: 34px;
            border-bottom: 1px solid #c4c4c4;
        }
        .reviewList img {
            margin-top: 8px;
        }
        .starRating {
            width: 90px;
        }
        .reviewContent{
            max-width: 260px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>

</head>
<body>
<div id="wrap">
    <jsp:include page="../include/header.jsp"></jsp:include>

    <div id="container">
        <div class="mypage-base">
            <%@ include file="./sidebar.jsp" %>
            <article class="my-page">
                <main class="container__inner" style="background-color: #DEEBFA; height: 400px">
                    <div style="float:left; width: 400px; height: 400px; position: relative;">
                        <img src="${path14}/resources/upload/${instructor.img}" alt=""  style="position: absolute; bottom: 0; left: 10%">
                    </div>
                    <div class="instRight">
                        <div class="instName">
                            [${instructor.cate}] ${instructor.name} 선생님
                        </div>
                        <div class="instIntro">
                            ${instructor.intro}
                        </div>
                        <div class="instReview">
                                <h5>최신 후기</h5>
                                <h6>
                                    <a href="${path14}/instructor/instructorReview.do?no=${instructor.no }">
                                    + 더보기
                                    </a>
                                </h6>

                        </div>
                        <div class="reviewList">
                            <table>
                                <c:forEach var="lev" items="${reviewList }" begin="0" end="4">
                                    <tr>
                                        <td class="starRating" data-score="${lev.score}"></td>
                                        <td class="reviewContent">${lev.content}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function() {
                            const filledStarPath = '${path14}/resources/img/star.png';
                            const emptyStarPath = '${path14}/resources/img/empty_star.png';

                            function renderStars($starContainer, score) {
                                $starContainer.empty(); // 기존 내용을 지웁니다.
                                for (let i = 1; i <= 5; i++) {
                                    const starPath = i <= score ? filledStarPath : emptyStarPath;
                                    const $star = $('<img>').attr('src', starPath)
                                        .attr('alt', 'star')
                                        .width(16)
                                        .height(16);
                                    $starContainer.append($star);
                                }
                            }

                            $('.starRating').each(function() {
                                const $this = $(this);
                                const score = $this.data('score');
                                renderStars($this, score);
                            });
                        });
                    </script>
                </main>
            </article>
        </div>






    </div>
    <footer id="footer" class="footer-nav row expanded collapse">
        <!-- 푸터 부분 인클루드 -->
        <jsp:include page="../include/footer.jsp"></jsp:include>
    </footer>
</div>

<script
        src="https://kit.fontawesome.com/b17793764c.js"
        crossorigin="anonymous"
></script>


</body>
</html>