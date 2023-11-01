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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
            integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
            crossorigin="anonymous" type="text/javascript"></script>

    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <link rel="stylesheet" href="${path13}/resources/css/myPage/baseLayout.css"/>
    <link rel="stylesheet" href="${path13}/resources/css/myPage/sidebar.css"/>
    <link rel="stylesheet" href="${path13}/resources/css/myPage/validateUser.css"/>
    <link href="${path13}/resources/css/myPage/com_write.css" rel="stylesheet">
    <script type="text/javascript" src="${path13}/resources/js/com_write.js" charset="UTF-8"></script>
    <title>작성글</title>
    <style>
        form table {
            border-top: #0c0c0c solid 2px;
            border-bottom: #0c0c0c solid 1px;
        }

        .table-section tbody tr td {
            padding-top: 25px;
            font-size: 1.2rem;
        }
    </style>

</head>
<body>
<div class="page_wrap">
<!-- 헤더 인클루드 -->
<jsp:include page="../include/header.jsp"></jsp:include>
    <jsp:include page="../myclass/myclassTopbar.jsp"></jsp:include>
<!-- content -->
<div class="mypage-base">
    <div class="content-wrap" style="float:left; margin-left: -50px">
        <div class="content-section">
            <a class="font" style="font-size: 20px; margin-left: 40px">내가 남긴 댓글</a>
            <form class="content" style="margin-left: 45px; margin-top: 50px;">
                        <div id="ud_tab-content2" class="ud_content">
                                <h5> 자유 게시판</h5>
                                <table class="table-section" style="width: 1100px; margin-left: -20px; font-size: 18px; margin-bottom: 40px;">
                                    <thead>
                                    <tr>
                                        <th style="width: 60%; text-align: center">내용</th>
                                        <th style="width: 35%; text-align: center">작성일</th>
                                        <th style="width: 15%; text-align: center"></th></tr>
                                    </thead>
                                    <tbody class="tbody">
                                    <c:forEach items="${board_comlist }" var="board_comlist">
                                        <tr class = "commentlist">
                                            <td style="text-align: center">${board_comlist.content}</td>
                                            <td style="text-align: center">${board_comlist.write_date}</td>
                                            <td><button type="button" class ="button is-black is-outlined" onclick="location.href='${path13}/board/detail.do?bno=${board_comlist.num}'">원문보기</button></td>
                                        </tbody>
                                    </c:forEach>
                                    </table>
                            <!-- 강의평 -->
                            <h5>강의평</h5>
                            <table class="table-section" style="width:1100px; margin-left: -20px; font-size: 18px;">
                                <thead>
                                <tr>
                                    <th style="width: 50%; text-align: center">내용</th>
                                    <th style="width: 20%; text-align: center">작성일</th>
                                    <th style="width: 10%; padding-left: 0px">점수</th>
                                    <th style="width: 5%;"></th>
                                    <th style="width: 5%;"></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${revList }" var="revList">
                                    <tr class = "commentlist">
                                        <td style="text-align: center"++>${revList.content}</td>
                                        <td style="text-align: center;">${revList.resdate}</td>
                                        <td>${revList.score}</td>
                                        <td style="text-align: center;"><button type="button" class ="button is-black is-outlined" onclick="location.href='${path13}/lecture/getLecture?no=${revList.par}'">원문보기</button></td>
                                        <td></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
            </form>
        </div>
</div>
</div>
</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
