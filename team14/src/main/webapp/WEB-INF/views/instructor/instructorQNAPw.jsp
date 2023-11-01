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
            $('#side_qna').css({
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

                    <figure class="visual" id="vs1">
                        <ul class="imgbox">
                            <li class="hero is-medium is-white">
                                <div class="hero-body has-text-centered">
                                    <p class="title is-size-3">
                                        QnA
                                    </p>
                                    <p class="subtitle is-size-5">
                                        비밀번호 입력
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </figure>
                    <div class="content" id="contents">
                        <div class="row column text-center">
                            <div class="container">
                                <form action="${path14}/instructor/instructorQNACheck.do?no=${instructor.no}" method="post">
                                    <table id="table1">
                                        <tbody>
                                        <tr>
                                            <th style="background-color:#dcdcdc">비밀번호</th>
                                            <td>
                                                <input type="password" name="pw" id="pw" class="input" placeholder="비밀번호" maxlength="18" required>
                                                <input name="bno" type="hidden" value="${bno}" >
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <input type="submit" class="submit button is-link is-outlined" value="입력" >
                                                <a class="button is-black is-outlined" href="${path14}/instructor/instructorQNA.do?no=${instructor.no}">글 목록</a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                        </div>
                    </div>
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