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

    <title>결제 수강 내역</title>

    <style>
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
    <script>
        $(document).ready(function() {
            $('#side_paymentList').css({
                'background-color': '#e5e5e5',
                'font-weight': 'bold'
            });
        });
    </script>
</head>
<body>
<jsp:include page="../../include/header.jsp"></jsp:include>

<div class="mypage-base">
    <%@ include file="/WEB-INF/views/include/sidebar.jsp" %>

    <div class="content-wrap" style="float:left; margin-left: -50px">
            <h5 class="font"> 목록 > </h5>
            <br>

            <form class="content">

                <div id="ud_tab" style="float:left; margin-left: -20px">
                    <input type="radio" name="ud_tabs" id="tab1" checked>
                    <label for="tab1">결제 내역</label>

                    <div id="ud_tab-content1" class="ud_content" style="float:left; margin-left: -20px">
                        <div  id="search_from">
                            <select name="select_filter" id="select_filter" style="float: left">
                                <option value="0">번호</option>
                                <option value="1">정보</option>
                                <option value="2">상품</option>
                                <option value="3">결제일</option>
                            </select>
                            <input type="text" name="search_filter" id="search_filter">
                        </div>
                        <table class="tb1" id="myTable" style="width: 800px; margin-left: -20px">
                            <thead>
                            <tr>
                                <th class="item1">결제번호</th>
                                <th class="item2">결제정보</th>
                                <th class="item3">결제상품</th>
                                <th class="item4">결제일</th>
                                <th class="item4">작업</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pay" items="${payList }" varStatus="status">
                                    <tr>
                                        <td class="item1">${pay.sno }</td>
                                        <td class="item2">
                                            <p>결제 방법 : ${pay.pmethod }</p>
                                            <p>결제 대행 : ${pay.pcom }</p>
                                            <p>결제 카드 : ${pay.cnum }</p>
                                            <p>결제 금액 : ${pay.price }</p>
                                        </td>
                                        <td class="item3">
                                            <span title="${pay.lec_no }">${pay.lec_name }</span>
                                        </td>
                                        <td class="item4">
                                            <p>${pay.resdate }</p>
                                        </td>
                                        <td class="item4">
                                            <c:if test="${pay.state==0}">
                                                <a href="${path13 }/payment/returnPayment.do?sno=${pay.sno }" class="inbtn">환불요청</a>
                                                <a href="${path13 }/payment/buyPayment.do?sno=${pay.sno }&lno=${pay.lec_no}&pt=${pay.price / 10}" class="inbtn">구매확정</a>
                                            </c:if>
                                            <c:if test="${pay.state==1}">
                                                <span>구매 확정</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <script>
                        $(document).ready( function () {
                            let $table = $('#myTable').DataTable({
                                //search 창 오른쪽 상단으로 이동
                                "dom": '<"top"i>rt<"bottom"flp><"clear">',

                                pageLength : 5,
                                order: [[3, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
                                info: false,
                                lengthChange: false, // show entries 제거
                                language: {
                                    emptyTable: '결제 내역(이)가 없습니다.'
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
