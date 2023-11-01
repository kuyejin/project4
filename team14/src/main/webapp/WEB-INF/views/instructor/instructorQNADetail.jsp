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
            font-size: 17px;
            margin-bottom: 50px;
            border-collapse: collapse; /* 테이블 간격 없애기 */
        }

        .tb1 thead th {
            line-height: 32px;
            padding: 12px 15px; /
            /*border: 1px solid #f5f5f5; !*/
        box-sizing: border-box;
            background-color: #eeeeee; /* 배경색 조정 */
            font-size: 22px;
            font-weight: 600;
            border-radius: 10px;
        }

        .tb1 thead td {
            font-size: 16px;
            text-align: right;
            line-height: 40px;
            border-bottom: #7e7e7e 1px solid;

        }
        .tb1 thead td:nth-child(1) {
            width: 15%;
            text-align: center;
        }.tb1 thead td:nth-child(2) {
             text-align: left;
             width: 15%;
         }
        .tb1 thead td:nth-child(3) {
            font-weight: 600;
            width: 30%;
        }
        .tb1 thead td:nth-child(4) {
            width: 30%;
        }
        .tb1 thead td:nth-child(5) {
            width: 15%;

        }
        /*글 내용*/
        .tb1 tbody tr td {
            padding-left: 10px;
            padding-top: 40px;
            font-size: 18px;
            text-align: left;
            border-bottom: #7e7e7e 1px solid;


        }
        .content > div {
            min-height: 400px;
        }



        .tb2{
            width: 800px;
        }

        .tb2 .item1 { width: 10%; }
        .tb2 .item2 { width: 68%;}
        .tb2 .item3 { width: 10%; }
        .tb2 .item4 { width: 12%;
        }
        .tb2 td {
            border-bottom: 1px solid #7e7e7e;
            vertical-align: middle;
            height: 60px;
        }

        .tb2 thead tr th{
            text-align: center;
        }
        .tb2 tbody tr td:first-child{
            text-align: center;
            font-weight: bold;

        }
        .tb2 tbody tr td:nth-child(2){
            word-break: break-word;

        }
        .tb2 tbody tr td:nth-child(3){
            text-align: center;
        }

        .inbtn, .delete_btn {
            display: inline-block;
            border-radius: 5px;
            width: 50px;
            line-height: 28px;
            text-align: center;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s; /* 마우스 오버 효과 */
        }

        .inbtn {
            background-color: #333;
            color: #fff;
        }

        .delete_btn {
            background-color: red;
            color: #fff;
        }

        .inbtn:hover, .delete_btn:hover {
            background-color: #555;
        }

        .frm {
            margin-top: 50px;
        }

        /*.frm tr > * {*/
        /*    margin-right: 10px;*/
        /*}*/

        .btn_group {
            margin-top: 50px;
        }

        #ans_btn {

            border-radius: 5px;
            width: 80px; /* 버튼 크기  */
            padding: 7px 15px;
            text-align: center;
        }



        .tb3{
            width: 800px;
            height: 140px;
            margin-bottom: 50px;
            background-color: #eeeeee;
            border-radius: 10px;
        }

        .tb3 th {
            line-height: 100px;

            text-align: center;
            vertical-align: middle;

        }
        .tb3 th:first-child{
            width: 15%;
            font-weight: bold;
            font-size: 18px;

        }
        .tb3 th:nth-child(2){
            width: 70%;
        }
        .tb3 th:last-child{
            width: 15%;

        }
        textarea {
            resize: none;
            padding: 10px;
            height: 80px;
            border: 1px solid #ccc;
            border-radius: 5px;
            vertical-align: middle;
        }
        #nologin_comment {
            width: 800px;
            text-align: center;
            padding-top: 60px;
            position: absolute;
            font-weight: bold;
        }

        .item4 .button{
            padding-top: 0;
            padding-bottom: 0;
        }
    </style>

    <script>
        $(document).ready(function() {
            $('#side_qna').css({
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
                                <table class="tb1">
                                    <thead>
                                    <tr class="title">
                                        <th colspan="5">${dto.title}</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <c:if test="${dto.author eq sid && not empty sid}">
<%--                                                <a href="${path14}/instructor/instructorQNAEdit.do?bno=${dto.bno}&no=${instructor.no}" class="button is-outlined is-link">수정</a>--%>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${not empty sid && (sid eq 'admin' || dto.author eq sid)}">
                                                <a href="${path14}/instructor/instructorQNADelete.do?bno=${dto.bno}&no=${instructor.no}" class="button is-outlined is-danger" >삭제</a>
                                            </c:if>
                                        </td>
                                        <td>${dto.author}</td>
                                        <td>${dto.resdate}</td>
                                        <td>조회수 : ${dto.cnt}</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td colspan="5" class="content">
                                            <div>
                                                ${dto.content}
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>

                                </table>
                                <table class="tb2" id="myTable">
                                    <thead>
                                    <tr>
                                        <th class="item1">작성자</th>
                                        <th class="item2">댓글</th>
                                        <th class="item3">작성일</th>
                                        <th class="item4"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="lev" items="${comment }">
                                        <tr>
                                            <td class="item1">${lev.author}</td>
                                            <td class="item2">${lev.content}</td>
                                            <td class="item3">${lev.resdate}</td>
                                            <td class="item4">
                                                <c:if test="${sid eq lev.author || sid eq 'admin'}">
<%--                                                    <a href="${path14}/instructor/instructorQNACommentEdit.do?bno=${lev.bno}&no=${instructor.no}" class="button is-small is-link is-outlined is-rounded">수정</a>--%>
                                                    <a href="${path14}/instructor/instructorQNAComDelete.do?bno=${lev.bno}&par=${lev.par}&no=${instructor.no}" class="button is-small is-danger is-outlined is-rounded"> 삭제 </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <script>
                                    $(document).ready( function () {
                                        $('#myTable').DataTable({
                                            // sorting 화살표 제거
                                            "targets": 'no-sort',
                                            "bSort": false,

                                            // 3번째 컬럼을 기준으로 내림차순 정렬
                                            order: [[3, 'asc']],
                                            pageLength : 5,
                                            searching: false, //검색 제거
                                            lengthChange: false, // show entries 제거
                                            info: false,

                                            language: {
                                                emptyTable: '작성된 댓글(이)가 없습니다.'
                                            }
                                        });
                                        $('#myTable').css({
                                            'border':'none',
                                        });

                                    } );
                                </script>
                                <form action="${path14}/instructor/instructorQNACommentInsert.do?no=${instructor.no}" id="login_frm" class="frm" method="post">
                                    <table class="tb3">
                                        <tbody>
                                        <tr>
                                            <c:if test="${not empty sid}">
                                                <th class="has-text-centered">${sid}</th>
                                                <th><textarea name="content" id="content" cols="100" rows="5" placeholder="댓글 작성" required style="width: 600px;"></textarea></th>
                                                <th><input type="submit" value="글쓰기" class="inbtn" id="ans_btn"></th>
                                                <input type="hidden" name="bno" value="${dto.bno}" readonly>
                                                <input type="hidden" name="id" value="${sid}" readonly>
                                            </c:if>
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