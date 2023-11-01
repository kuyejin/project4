<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path13" value="<%=request.getContextPath() %>"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">
    <!-- 아이콘 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
          integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA=="
          crossorigin="anonymous"/>
    <!-- 부트스트랩 4.0 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- 제이쿼리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>

    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../../include/head.jsp"></jsp:include>
    <link rel="stylesheet" href="${path13}/resources/css/myPage/baseLayout.css"/>
    <link rel="stylesheet" href="${path13}/resources/css/myPage/sidebar.css"/>
    <link rel="stylesheet" href="${path13}/resources/css/myPage/validateUser.css"/>
    <link href="${path13}/resources/css/myPage/com_write.css" rel="stylesheet">
    <script type="text/javascript" src="${path13}/resources/js/com_write.js" charset="UTF-8"></script>
    <script>
        $(document).ready(function() {
            $('#side_grade').css({
                'background-color': '#e5e5e5',
                'font-weight': 'bold'
            });
        });
    </script>
    <title>성적 내역</title>
</head>
<body>
<jsp:include page="../../include/header.jsp"></jsp:include>

<div class="mypage-base">
    <%@ include file="../../instructor/sidebar.jsp" %>

    <div class="content-wrap" style="float:left; margin-left: -50px">
            <h5 class="font"> 목록 > </h5>
            <br>

            <form class="content">

                <div id="ud_tab" style="float:left; margin-left: -20px">
                    <input type="radio" name="ud_tabs" id="tab1" checked>
                    <label for="tab1">성적 내역</label>

                    <div id="ud_tab-content1" class="ud_content" style="float:left; margin-left: -20px">
                        <table id="myTable" style="font-size: 16px">
                            <thead>
                            <tr>
                                <th>이름</th>
                                <th>아이디</th>
                                <th>시험종류</th>
                                <th width="120">등록일</th>
                                <th>비고</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${gradeList}" var="grade" varStatus="status">
                                <tr>
                                    <td>${grade.stuname}</td>
                                    <td>${grade.stuid}<input type="hidden" id="tid" name="tid" value="tid"/></td>
                                    <td>${grade.exam}</td>
                                    <td>
                                        <fmt:parseDate value="${grade.regdate }" var="resdate" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        <fmt:formatDate value="${resdate }" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td colspan="2">
                                        <c:if test="${sid == grade.stuid || sid == grade.tid}">
                                            <a class="button is-black is-outlined"
                                               onclick="window.open('${path13}/grade/gradedetail.do?no=${grade.no}', '_blank', 'popup=yes', 'width=700px', 'height=700px', 'top=50px', 'left=50px')">상세보기</a>
                                        </c:if>
                                        <c:if test="${sid == grade.tid}">
                                            <a href="${path13}/grade/gradedelete.do?no=${grade.no}"
                                               class="button is-danger is-outlined">성적삭제</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="button-group">
                            <a class="button is-link is-outlined"
                               onclick="window.open('${path13}/grade/gradeinsert.do', '_blanck', 'popup=yes', 'width=700px', 'height=700px', 'top=50px', 'left=50px')">성적입력</a>
                        </div>
                        <script>
                            $(document).ready(function () {
                                $('#myTable').DataTable({
                                    pageLength: 5,
                                    order: [[3, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
                                    info: false,
                                    search: false,
                                    dom: 't<f>p',
                                    language: {
                                        emptyTable: '등록된 글이 없습니다.'
                                    }

                                });
                            });
                            $(document).ready(function () {
                                $('.dataTables_paginate').css({
                                    'textAlign': 'center',
                                    'float': 'none',
                                    'margin-top': '10px',
                                });
                                $('.dataTables_filter').css('display', 'none');
                                $('#myTable_paginate').css({
                                    'margin-right': '120px'
                                });
                            });
                        </script>
                    <%--<input type="button" id="check11" value="더보기">
                    <div class="error11"></div>--%>

                    </div> <%-- 작성글("ud_tab-content1") 끝--%>



            <%-- ---------------------------------------------------------------------------------------------  --%>


            </form>
        </div>







</div>
</div>


<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>
