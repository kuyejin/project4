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
            $('#side_file').css({
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
                    <div>

                        <table class="table is-bordered is-striped is-hoverable" style="width: 800px">
                            <thead>
                            <tr class="title">
                                <th colspan="5">${instructorFile.title}</th>
                            </tr>
                            <tr>
                                <td>
                                    <c:if test='${sid eq instructor.id}'>
<%--                                        <a href="${path14}/instructor/instructorFileEdit.do?fileNo=${instructorFile.no}&no=${instructor.no}" class="button is-outlined is-link">수정</a>--%>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${sid eq instructor.id || sid eq 'admin'}">

                                        <a href="${path14}/instructor/instructorFileDelete.do?fileNo=${instructorFile.no}&no=${instructor.no}" class="button is-outlined is-danger">삭제</a>
                                    </c:if>
                                </td>
                                <td>${instructor.name}</td>
                                <td>${instructorFile.resdate}</td>
                                <td>조회수 : ${instructorFile.cnt}</td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td colspan="5" class="content">
                                    <div style="min-height: 200px">
                                        ${instructorFile.content}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" class="content">
                                    <img src="${path14}/resources/img/disk.png" alt="디스크이미지" style="width:24px;height:24px;"/>
                                    <a href="${path14}/resources/upload/${instructorFile.sfile1}" title="${realName1}" download="${realName1}" style="margin-right: 16px">${realName1}</a>
                                    <c:if test="${realName2 ne ''}">
                                    <img src="${path14}/resources/img/disk.png" alt="디스크이미지" style="width:24px;height:24px;"/>
                                    <a href="${path14}/resources/upload/${instructorFile.sfile2}" title="${realName2}" download="${realName2}" style="margin-right: 16px">${realName2}</a>
                                    </c:if>
                                    <c:if test="${realName3 ne ''}">
                                    <img src="${path14}/resources/img/disk.png" alt="디스크이미지" style="width:24px;height:24px;"/>
                                    <a href="${path14}/resources/upload/${instructorFile.sfile2}" title="${realName3}" download="${realName3}" style="margin-right: 16px">${realName3}</a>
                                    </c:if>
                                </td>





                            </tr>
                            </tbody>
                        </table>



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