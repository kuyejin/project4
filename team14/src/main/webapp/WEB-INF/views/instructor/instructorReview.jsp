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
    </style>
    <script>
        $(document).ready(function() {
            $('#side_review').css({
                'background-color': '#e5e5e5',
                'font-weight': 'bold'
            });
        });
    </script>

</head>
<body>
<div id="wrap">
    <jsp:include page="../include/header.jsp"></jsp:include>

    <div id="container">
        <div class="mypage-base">
            <%@ include file="./sidebar.jsp" %>
            <article class="my-page">
                <main class="container__inner">
                    <table class="table is-fullwidth" id="myTable">
                        <thead>
                        <tr>
                            <th class="rev" style="width: 15%">강의</th>
                            <th class="rev" style="width: 20%">점수</th>
                            <th class="rev-con" style="width: 50%">후기</th>
                            <th class="rev2" style="width: 15%">작성일</th>
<%--                            <th class="rev2">비고</th>--%>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="lev" items="${reviewList }" varStatus="status">
                            <tr>
                                <td><a href="${path14}/lecture/getLecture?no=${lev.lno}">${lev.title}</a></td>
                                <td class="starRating" data-score="${lev.score}"></td>
                                <td>${lev.content}</td>
                                <td>
                                    <fmt:parseDate value="${lev.resdate}" var="resdate" pattern="yyyy-MM-dd HH:mm:ss" />
                                    <fmt:formatDate value="${resdate}" pattern="yyyy-MM-dd" />
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
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
                                        .width(20)
                                        .height(20);
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
                    <script>
                        $(document).ready( function () {
                            $('#myTable').DataTable({
                                // sorting 화살표 제거
                                "targets": 'no-sort',
                                "bSort": false,

                                // 3번째 컬럼을 기준으로 내림차순 정렬
                                order: [[3, 'asc']],
                                pageLength : 5,
                                searching: false, //검색 제거
                                lengthChange: false, // show entries 제거
                                info: false,
                                language: {
                                    emptyTable: '작성된 후기가 없습니다.'
                                }
                            });
                            $('#myTable').css({
                                'border':'none',
                            });
                        } );
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