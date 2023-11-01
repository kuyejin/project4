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
                    <form action="${path14}/instructor/instructorQNAInsert.do?no=${instructor.no}" method="post">
                        <table id="table1">
                            <tbody>
                            <tr>
                                <th style="background-color:#dcdcdc">글 제목</th>
                                <td>
                                    <input type="text" name="title" id="title" class="input" placeholder="제목 입력" maxlength="98" required>
                                </td>
                            </tr>
                            <tr>
                                <th style="background-color:#dcdcdc">비밀번호</th>
                                <td>
                                    <input type="password" name="pw" id="pw" class="input" placeholder="비밀글로 하고 싶은 경우 비밀번호 입력" maxlength="18">
                                    <div id="keyShow" class="button is-link">SHOW</div>
                                </td>
                            </tr>
                            <tr>
                                <th style="background-color:#dcdcdc">글 내용</th>
                                <td>
                                    <textarea name="content" id="content" class="textarea" placeholder="내용 입력" rows="8" cols="100" maxlength="900" required></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" class="submit button is-link is-outlined" value="글 등록" >
                                    <a class="button is-black is-outlined" href="${path14}/instructor/instructorQNA.do?no=${instructor.no}">글 목록</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>

                </main>
            </article>
            <script>
                $("#keyShow").on("click", function() {
                    if ($("#pw").attr("type") == "password") {
                        $("#pw").attr("type", "text");
                        $($(this)).text("H I D E");
                    } else {
                        $("#pw").attr("type", "password");
                        $($(this)).text("SHOW");
                    }
                });
            </script>

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