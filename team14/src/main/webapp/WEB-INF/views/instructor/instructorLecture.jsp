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

        .img_tit img{
            width: 100px;
            overflow: hidden;
        }
    </style>
    <script>
        $(document).ready(function() {
            $('#side_list').css({
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
                    <table id="myTable">
                        <thead>
                        <tr>
                            <th>프로필</th>
<%--                            <th>과목</th>--%>
                            <th>학년</th>
                            <th>제목</th>
<%--                            <th>조회수</th>--%>
                            <th>수강인원</th>
                            <th>상태</th>
                            <th>비고</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="pro" items="${lecList }">
                            <tr>
                                <td>
                                    <div class="img_tit"><a href="${path14}/lecture/getLecture?no=${pro.no}"><img src="${path14}/resources/upload/${pro.simg }"/></a></div>
                                </td>
<%--                                <td>--%>
<%--                                    <p>${pro.cate}</p>--%>
<%--                                </td>--%>
                                <td>
                                    <p>${pro.slevel}</p>
                                </td>
                                <td>
                                    <p>${pro.title}</p>
                                </td>
<%--                                <td>--%>
<%--                                    <p>${pro.cnt}</p>--%>
<%--                                </td>--%>
                                <td>
                                    <p>${pro.lec} / ${pro.lec_max}</p>
                                </td>
                                <td>
                                    <c:if test="${pro.lec == pro.lec_max}">
                                        <p style="color: red">수강불가</p>
                                    </c:if>
                                    <c:if test="${pro.lec < pro.lec_max}">
                                        <p style="color: #3273dc">수강가능</p>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty sid and isInst == false}">
                                        <c:set var="isLiked" value="${likedProductIds.contains(pro.no)}" />
                                        <c:if test="${pro.lec < pro.lec_max}">
                                            <a href="${path14}/payment/addPayment.do?lec_no=${pro.no }" class="button is-link is-outlined">수강신청</a>
                                            <a href="${path14}/cart/cartInsert.do?lec_no=${pro.no }" class="button is-link is-outlined">장바구니</a>
                                            <c:choose>
                                                <c:when test="${isLiked }">
                                                    <%-- 눌러도 새로고침 안되게 처리 ///                         현재 로그인한 사용자 ID                 pro.no을 저장하기 위한 역할 --%>
                                                    <a href="javascript:void(0);" onclick="toggleLike(${pro.no}, '${sid}');" class="button is-link is-outlined likes" data-product-id="${pro.no}" style="color: #ff5050">♥</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="javascript:void(0);" onclick="toggleLike(${pro.no}, '${sid}');" class="button is-link is-outlined likes" data-product-id="${pro.no}"  style="color: #b4b4b4">♥</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${sid eq 'admin'}">
                                        <a href="${path14}/lecture/updateLectureForm.do?no=${pro.no }" class="button is-link is-outlined">수정</a>
                                    </c:if>
                                    <script>
                                        function toggleLike(productNo, id) {
                                            $.ajax({
                                                url: "${path14}/lecture/lectureLike.do",
                                                method: "POST",
                                                data: {
                                                    lno: productNo,
                                                    sid: id
                                                },
                                                success: function(response) {
                                                    var likeButton = $("[data-product-id='" + productNo + "']");

                                                    if (response.trim() === "liked") {
                                                        alert("상품을 좋아요 했습니다!");
                                                        likeButton.css("color","#ff5050");
                                                    } else if (response.trim() === "unliked") {
                                                        alert("상품의 좋아요를 취소했습니다.");
                                                        likeButton.css("color","#b4b4b4");                                                } else {
                                                        alert("오류가 발생했습니다. 다시 시도해주세요.");
                                                    }
                                                }
                                            });
                                        }
                                        $(document).ready(function() {
                                            // 좋아요 상태를 기반으로 버튼 색 변경
                                            $(".likes").each(function() {
                                                var isLiked = $(this).hasClass("liked");
                                                if (isLiked) {
                                                    $(this).addClass("liked");
                                                }
                                            });
                                        });
                                    </script>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <script>
                        $(document).ready( function () {
                            let $table = $('#myTable').DataTable({
                                //search 창 오른쪽 상단으로 이동
                                "dom": '<"top"i>rt<"bottom"flp><"clear">',

                                pageLength : 5,
                                order: [[2, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
                                info: false,
                                lengthChange: false, // show entries 제거
                                language: {
                                    emptyTable: '등록된 상품이 없습니다.'
                                }
                            });

                            $('.dataTables_paginate').css({
                                'textAlign':'center',
                                'float': 'none',
                                'margin-top':'10px',
                            });

                            $('.dataTables_filter').remove();  // dataTable 자체 search input 없애기

                            $('#select_filter').change(function () { // select 선택값에 따라  해당 선택 열 input이 검색하는곳 변경
                                $table.columns('').search('').draw();
                                $table.columns(Number($('#select_filter').val())).search($('#search_filter').val()).draw();
                            });

                            $('#search_filter').keyup(function () { //input의 값대로 search
                                let $value = $(this).val();
                                $table.columns(Number($('#select_filter').val())).search($value).draw();
                            })
                        });
                    </script>
                    <div class="btn_group">
                        <c:if test="${sid eq 'admin' }">
                            <a href="${path14}/lecture/addLectureForm" class="button is-link is-outlined">강의 등록</a>
                        </c:if>
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


</body>
</html>