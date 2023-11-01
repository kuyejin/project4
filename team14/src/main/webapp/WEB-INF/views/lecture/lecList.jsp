<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 목록</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <style>
        .hero {
            height: 250px;
            margin-top: 40px;
        }

        .img_tit {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
        }

        .img_tit img {
            max-height: 200px;
            overflow: hidden;
        }

        #myTable td {
            height: 280px;
            overflow: hidden;
            vertical-align: middle;
        }

        #search_from {
            text-align: right;
            font-size: 18px;
            margin-bottom: 20px; /* 아래쪽 여백 추가 */
        }
        #select_filter {
            padding: 5px; /* 셀렉트 박스 내부 패딩 추가 */
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px; /* 테두리 둥글게 만듭니다. */
            margin-right: 10px; /* 셀렉트 박스 오른쪽 여백 추가 */
            font-size: 16px; /* 폰트 크기 조정 */
        }

        #search_filter {
            padding: 5px; /* 입력 필드 내부 패딩 추가 */
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px; /* 테두리 둥글게 만듭니다. */
            font-size: 16px; /* 폰트 크기 조정 */
        }

        /* 선택된 셀렉트 박스 옵션 스타일 */
        #select_filter option:checked {
            background-color: #f2f2f2;
            font-weight: bold;
        }
    </style>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<jsp:include page="../include/header.jsp"></jsp:include>
<section class="hero is-medium is-white">
    <div class="hero-body has-text-centered">
        <p class="title is-size-3">
            강의
        </p>
        <p class="subtitle is-size-5">
            목록
        </p>
    </div>
</section>
<div class="content" id="content">
    <div class="row column text-center">
        <div class="container">
            <div  id="search_from">
                <select name="select_filter" id="select_filter">
                    <option value="1">과목</option>
                    <option value="2">학년</option>
                    <option value="3">제목</option>
                    <option value="6">상태</option>
                </select>
                <input type="text" name="search_filter" id="search_filter">
            </div>
            <table id="myTable">
                <thead>
                <tr>
                    <th>프로필</th>
                    <th>과목</th>
                    <th>학년</th>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>수강인원</th>
                    <th>상태</th>
                    <th>비고</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pro" items="${lecList }">
                    <tr>
                        <td>
                            <div class="img_tit"><a href="${path}/lecture/getLecture?no=${pro.no}"><img src="${path }/resources/upload/${pro.simg }"/></a></div>
                        </td>
                        <td>
                            <p>${pro.cate}</p>
                        </td>
                        <td>
                            <p>${pro.slevel}</p>
                        </td>
                        <td>
                            <p>${pro.title}</p>
                        </td>
                        <td>
                            <p>${pro.cnt}</p>
                        </td>
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
                                    <a href="${path }/payment/addPayment.do?lec_no=${pro.no }" class="button is-link is-outlined">수강신청</a>
                                    <a href="${path }/cart/cartInsert.do?lec_no=${pro.no }" class="button is-link is-outlined">장바구니</a>
                                    <c:choose>
                                        <c:when test="${isLiked }">
                                            <%-- 눌러도 새로고침 안되게 처리 ///                         현재 로그인한 사용자 ID                 pro.no을 저장하기 위한 역할 --%>
                                            <a href="javascript:void(0);" onclick="toggleLike(${pro.no}, '${sid}');" class="button is-link is-outlined likes" data-product-id="${pro.no}" style="color: #ff5050">♥</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="javascript:void(0);" onclick="toggleLike(${pro.no},'${sid}');" class="button is-link is-outlined likes" data-product-id="${pro.no}"  style="color: #b4b4b4">♥</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:if>
                            <c:if test="${sid eq 'admin'}">
                                <a href="${path }/lecture/updateLectureForm.do?no=${pro.no }" class="button is-link is-outlined">수정</a>
                            </c:if>
                            <script>
                                function toggleLike(productNo, id) {
                                    $.ajax({
                                        url: "${path}/lecture/lectureLike.do",
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
                    <a href="${path}/lecture/addLectureForm" class="button is-link is-outlined">강의 등록</a>
                </c:if>
            </div>
        </div>
    </div>
</div>
<footer id="footer" class="footer-nav row expanded collapse">
    <!-- 푸터 부분 인클루드 -->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>
</body>
</html>