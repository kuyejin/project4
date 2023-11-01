<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="<%=request.getContextPath() %>"/>
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
    <jsp:include page="../include/head.jsp"></jsp:include>
    <link rel="stylesheet" href="${path}/resources/css/myPage/baseLayout.css"/>
    <link rel="stylesheet" href="${path}/resources/css/myPage/sidebar.css"/>
    <link rel="stylesheet" href="${path}/resources/css/myPage/validateUser.css"/>
    <link href="${path}/resources/css/myPage/com_write.css" rel="stylesheet">
    <link rel="stylesheet" href="${path}/resources/css/myStudy/myStudyIndex.css"/>
    <script type="text/javascript" src="${path}/resources/js/com_write.js" charset="UTF-8"></script>

    <title>수강 내역</title>


</head>
<body>


<div id="wrap">
    <jsp:include page="../include/header.jsp"></jsp:include>
    <%@ include file="/WEB-INF/views/myclass/myclassTopbar.jsp" %>


    <div class="mainCont">

        <div class="titArea">
            <h3 class="subMtit">나의 좋아요</h3>

            <div class="board_wrap">
                <div class="board_list_wrap">
                    <div class="board_list">
                        <div class="top">

                            <div class="leccate" style="width: 10%; vertical-align: middle;">번호</div>
                            <div class="lectitle" style="width: 40%; vertical-align: middle; ">상품명</div>
                            <div class="insName" style="text-align: center; width: 25%; vertical-align: middle;">등록날짜
                            </div>
                            <div class="lecday" style="text-align: center; width: 25%; vertical-align: middle;">비고</div>
                        </div>


                        <c:forEach var="like" items="${likeList }" varStatus="status">
                            <div>
                                <div class="leccate" style="width: 10%">${status.count }</div>
                                <div class="lectitle" style="width: 40%">${lectureList.get(status.index).title }</div>
                                <div class="insName" style="width: 25%">${like.liketime }</div>
                                <div class="lecday" style="width: 25%">
                                    <a href="${path}/cart/cartInsert.do?lec_no=${like.lno }" class="button is-info">장바구니
                                        추가</a>
                                    <a href="${path}/lecture/delLike.do?no=${like.lno}" class="button is-danger">제거</a>
                                </div>
                            </div>
                        </c:forEach>


                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>
