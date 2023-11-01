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
    <title>성적표 목록</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <style>
        .view-button{
            height: 20px;
        }
        .hero-body h5{
            margin-left: 300px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<div class="page_wrap">
<jsp:include page="../include/header.jsp"></jsp:include>
<jsp:include page="../myclass/myclassTopbar.jsp"></jsp:include>
<section class="hero is-white is-small" style="padding-top: 27px">
    <div class="hero-body" style="margin-left: 390px; padding-bottom: 38px">
        <p style="font-size: 22px">성적표</p>
    </div>
</section>
<div class="content" id="content" style="min-height: 0px; margin-left: 40px; margin-top: 15px; margin-bottom: 30px">
    <div class="row column text-center">
        <div class="container" style="width: 1000px; margin-left: 400px; height: 285px; border-top: black solid 2px">
            <table id="myTable" style="font-size: 1.2rem">
                <thead>
                <tr>
                    <th width="80">No</th>
                    <th>학생 이름</th>
                    <th>학생 아이디</th>
                    <th>담당선생님 성함</th>
                    <th>시험 종류</th>
                    <th width="120">등록일</th>
                    <th>비고</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${sgradeList}" var="sgrade" varStatus="status">
                    <tr>
                        <td>${status.count}
                            <input type="hidden" name="no" id="no" value="${sgrade.no}">
                        </td>
                        <td>${sgrade.stuname}</td>
                        <td>${sgrade.stuid}</td>
                        <td>${sgrade.tname}
                            <input type="hidden" id="tid" name="tid" value="tid"/>
                        </td>
                        <td>${sgrade.exam}</td>
                        <td>
                            <fmt:parseDate value="${sgrade.regdate }" var="resdate" pattern="yyyy-MM-dd HH:mm:ss" />
                            <fmt:formatDate value="${resdate }" pattern="yyyy-MM-dd" />
                        </td>
                        <td colspan="2">
                            <c:if test="${sid == sgrade.stuid || sid == sgrade.tid}">
                                <a class="button view-button is-black is-outlined" onclick="window.open('${path}/grade/gradedetail.do?no=${sgrade.no}', '_blank', 'popup=yes', 'width=700px', 'height=700px', 'top=50px', 'left=50px')">상세보기</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <script>
                function detailClick(){

                }

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
</div>
<footer id="footer" class="footer-nav row expanded collapse">
    <!-- 푸터 부분 인클루드 -->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>
</body>
</html>