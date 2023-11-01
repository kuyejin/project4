<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <style>
        .hero {
            height: 250px;
            margin-top: 40px;
        }
        #myTable{
            max-height: 600px;
        }
    </style>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<jsp:include page="../include/header.jsp"></jsp:include>
<section class="hero is-medium is-white">
    <div class="hero-body has-text-centered">
        <p class="title is-size-3">
            장바구니
        </p>
        <p class="subtitle is-size-5">

        </p>
    </div>
</section>
<div class="content" id="content">
    <div class="row column text-center">
        <div class="container">
            <table id="myTable">
                <thead>
                <tr>
                    <th>연번</th>
                    <th>과목</th>
                    <th>강의명</th>
                    <th>강사</th>
                    <th>가격</th>
                    <th>비고</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cart" items="${cartList }" varStatus="status">
                    <tr>
                        <td><span>${status.count }</span></td>
                        <td><span title="${cart.lec_no}">${lecList.get(status.index).cate}</span></td>
                        <td>${lecList.get(status.index).title}</td>
                        <td>${instList.get(status.index).name}</td>
                        <td><fmt:formatNumber value="${lecList.get(status.index).price}" type="number" pattern="#,##0" /></td>
                        <td>
                            <a href="${path}/payment/addPayment.do?lec_no=${cart.lec_no}" class="btn1">구매</a>
                            <a href="${path}/cart/cartDelete.do?cartno=${cart.cartno}" class="btn1">제거</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <script>
            $(document).ready( function () {
                $('#myTable').DataTable({
                    pageLength : 10,
                    order: [[0, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
                    info: false,
                    dom: 't<f>p',
                    language: {
                        emptyTable: '장바구니 내역(이)가 없습니다.'
                    }
                });
            } );
            $(document).ready(function() {
                $('.dataTables_paginate').css({
                    'textAlign':'left',
                    'float': 'none',
                    'margin-top':'10px',
                });
                $('.dataTables_filter').css({
                    'float': 'left',
                    'margin-top':'14px',
                    'margin-right':'280px'
                });
                $('#myTable_paginate').css({
                    'margin-right':'120px'
                });
            });
        </script>
    </div>
</div>
<footer id="footer" class="footer-nav row expanded collapse">
    <!-- 푸터 부분 인클루드 -->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>
</body>
</html>