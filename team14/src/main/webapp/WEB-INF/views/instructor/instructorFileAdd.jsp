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
        .tb1 {
            width: 800px;
        }
        .tb1 th {
            margin-left: 0;
            padding-left: 20px;
        }
        .frm {
            padding-top: 0;
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
                    <form action="${path14}/instructor/instructorFileAdd.do?no=${instructor.no}" class="frm" method="post" enctype="multipart/form-data">
                        <table class="tb1">
                            <tbody>
                            <tr>
                                <th>글 제목</th>
                                <td colspan="2"><input type="text" name="title" id="title" class="input" placeholder="제목 입력" required></td>
                            </tr>

                            <tr>
                                <th>글 내용</th>
                                <td colspan="2"> <textarea name="content" id="content" cols="50" class="textarea" rows="15" placeholder="내용 입력" required></textarea></td>
                            </tr>

                            <tr>
                                <th>첨부 파일1</th>
                                <td colspan="2"><input type="file" name="sfile1" id="sfile1" class="input" placeholder="첨부 파일1"  required></td>
                            </tr>
                            <tr>
                                <th>첨부 파일2</th>
                                <td colspan="2"><input type="file" name="sfile2" id="sfile2" class="input" placeholder="첨부 파일2" ></td>
                            </tr>
                            <tr>
                                <th>첨부 파일3</th>
                                <td colspan="2"><input type="file" name="sfile3" id="sfile3" class="input" placeholder="첨부 파일3" ></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="글 작성" class="button is-info">
                                    <input type="reset" value="취소" class="button is-danger" onclick="window.history.back();">
                                    <a href="${path14}/instructor/instructorFile" class="button is-link" style="float:right;">자료실</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>

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