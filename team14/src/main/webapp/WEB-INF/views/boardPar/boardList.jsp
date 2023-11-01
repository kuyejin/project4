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
    <title>학부모 게시판 목록</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <style>
        .hero {
            height: 250px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<jsp:include page="../include/header.jsp"></jsp:include>
<section class="hero is-white is-medium">
    <div class="hero-body has-text-centered">
        <p class="title is-size-3">
            학부모 게시판
        </p>
        <p class="subtitle is-size-5">
            목록
        </p>
    </div>
</section>
<div class="content" id="content">
    <div class="row column text-center">
        <div class="container">
            <table id="myTable">
                <thead>
                <tr>
                    <th width="80">No</th>
                    <th>Title</th>
                    <th width="120">RegDate</th>
                    <th width="100">Visited</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${boardList }" var="board" varStatus="status">
                    <tr>
                        <td>${status.count }</td>
                        <td><a href="${path}/boardPar/detail.do?bno=${board.bno }">${board.title }</a></td>
                        <td>
                            <fmt:parseDate value="${board.resdate }" var="resdate" pattern="yyyy-MM-dd HH:mm:ss" />
                            <fmt:formatDate value="${resdate }" pattern="yyyy-MM-dd" />
                        </td>
                        <td>${board.cnt }</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="button-group">
                <a class="button is-link is-outlined" href="${path}/boardPar/insert.do">글쓰기</a>
            </div>
            <script>
                $(document).ready( function () {
                    $('#myTable').DataTable({
                        pageLength : 10,
                        order: [[0, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
                        info: false,
                        dom: 't<f>p',
                        language: {
                            emptyTable: '등록된 글이 없습니다.'
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
</div>
<footer id="footer" class="footer-nav row expanded collapse">
    <!-- 푸터 부분 인클루드 -->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>
</body>
</html>