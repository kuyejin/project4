<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath() %>" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 상세</title>
    <%@ include file="../include/head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 플러그인 연결-->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

    <%-- cleditor --%>
    <script type="text/javascript" src="${path}/resources/cleditor/jquery.cleditor.js"></script>
    <link rel="stylesheet" href="${path}/resources/cleditor/jquery.cleditor.css">

    <!-- datatables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css">
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>

    <!-- 스타일 초기화 -->
    <link rel="stylesheet" href="${path}/resources/css/reset.css">
    <!-- 웹 폰트 -->
    <link rel="stylesheet" href="${path}/resources/css/font.css">

    <!-- css 모듈화 -->
    <link rel="stylesheet" href="${path}/resources/css/common.css">
    <link rel="stylesheet" href="${path}/resources/css/hd.css">
    <link rel="stylesheet" href="${path}/resources/css/ft.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height: 110vh; background-image: url("../img/login.jpg");
            background-repeat: no-repeat; background-position: center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 100vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center;  color:#fff;
            padding-bottom: 1.3em; }

        .tb1 {
            width: 1200px;
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
            width: 6%;
            text-align: center;
        }.tb1 thead td:nth-child(2) {
             text-align: left;
             width: 14%;
         }
        .tb1 thead td:nth-child(3) {
            font-weight: 600;
            width: 55%;
        }
        .tb1 thead td:nth-child(4) {
            width: 15%;
        }
        .tb1 thead td:nth-child(5) {
            width: 8%;

        }
        /*글 내용*/
        .tb1 tbody tr td {
            padding-left: 10px;
            padding-top: 40px;
            font-size: 18px;
            text-align: left;


        }
        .content > div {
            min-height: 400px;
            border-bottom: 1px solid #7e7e7e;
        }

        .tb2{
            width: 1200px;
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
            width: 88px;
            line-height: 20px;
            text-align: center;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s; /* 마우스 오버 효과 */
        }

        .inbtn {
            background-color: #bbd4ff;
            color: #fff;
            border: none;
        }

        .inbtn:hover, .delete_btn:hover {
            background-color: #555;
        }

        .frm {
            margin-top: 50px;
        }

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
            width: 1200px;
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
            width: 1200px;
            text-align: center;
            padding-top: 60px;
            position: absolute;
            font-weight: bold;
        }

        .item4 .button{
            padding-top: 0;
            padding-bottom: 0;
        }

        .hero {
            height: 250px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <!-- 헤더 부분 인클루드 -->
    <jsp:include page="../include/header.jsp"></jsp:include>
    <section class="hero is-whtie is-medium">
        <div class="hero-body has-text-centered">
            <p class="title is-size-3">
                자유게시판
            </p>
            <p class="subtitle is-size-5">
                상세
            </p>
        </div>
    </section>
    <div class="contents" id="contents">
        <section class="page" id="page1">
            <div class="page_wrap">
<%--                <h2 class="page_tit">게시글</h2>--%>
                <table class="tb1">

                    <thead>
                    <tr class="title">
                        <th colspan="5">${dto.title}</th>
                    </tr>
                    <tr>
                        <td>
                            <c:if test="${dto.author eq sid && not empty sid}">
                                <a href="${path}/board/edit.do?bno=${dto.bno}" class="button is-outlined is-link">수정</a>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${not empty sid && (sid eq 'admin' || dto.author eq sid)}">
                                <a href="${path}/board/delete.do?bno=${dto.bno}" class="button is-outlined is-danger" >삭제</a>
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
                            <%-- 신고수 3이상이면 블라인드 / 관리자가 열람 설정 선택 --%>
                            <div>
                                <c:if test="${sid eq 'admin' && cntReport > 2}">
                                    <div class="select is-info">
                                        <select id="contentSelect" onchange="readableEdit(${dto.bno})">
                                            <option value="true">열람 가능</option>
                                            <option value="false">열람 불가능</option>
                                        </select>
                                    </div>
                                </c:if>
                                <c:choose>
                                    <%-- 관리자일 때 --%>
                                    <c:when test="${sid eq 'admin'}">
                                        <c:if test="${cntReport > 2}">
                                            <h4 style="text-align: center">[신고가 3건 이상 들어온 글입니다.]</h4>
                                        </c:if>
                                        <div style="display: block;">${dto.content}</div>
                                    </c:when>
                                    <%-- 관리자가 아닐 때 and 신고수 3이상일 때 and readable=false --%>
                                    <c:when test="${cntReport > 2 && dto.readable == false}">
                                        <h4 style="text-align: center">[신고가 누적되어 블라인드 처리되었습니다. 관리자에게 문의해주세요]</h4>
                                    </c:when>
                                    <%-- 관리자가 아닐 때 and (신고수 3미만일 때 or readable=true) --%>
                                    <c:otherwise>
                                        <div style="display: block;">${dto.content}</div>
                                    </c:otherwise>
                                </c:choose>

                                <script>
                                    function readableEdit(Bno) {
                                        let selected =  $("#contentSelect option:selected").val();
                                        //alert(selected);
                                        let params = {"Bno": parseInt(Bno), "selected" : selected};
                                        $.ajax({
                                            url:"${path }/board/readableEdit.do",
                                            type:"POST",
                                            data:params,
                                            success: function(result) {
                                                console.log(result);
                                            },
                                            error: function (request, status, error) {
                                                console.log("code: " + request.status)
                                                console.log("message: " + request.responseText)
                                                console.log("error: " + error);
                                            }
                                        });
                                    }

                                </script>

                                <script>
                                    // select 요소의 변경을 감지, content를 표시 또는 숨김
                                    const contentSelect = document.getElementById('contentSelect');
                                    const content = document.getElementById('content');

                                    contentSelect.addEventListener('change', function () {
                                        if (contentSelect.value === 'true') {
                                            content.style.display = 'block';
                                        } else if (contentSelect.value === 'false') {
                                            content.style.display = 'none';
                                        }
                                    });
                                </script>
                            </div>
                        </td>
                    </tr>
                    <c:if test="${not empty sid}">
                        <tr>
                            <td colspan="5" style="text-align: right" >
                                <c:choose>
                                    <c:when test="${isLiked }">
                                        <!-- 좋아요를 눌렀을 경우 -->
                                        <button type="button is-info is-hovered" onclick="toggleLike(${dto.bno}, '${sid}');" class="inbtn" data-board-id="${dto.bno}" style="width: 80px; height: 34px;"><img src="${path}/resources/img/like_blue.png" alt="!" style="height: 26px; margin-top: 5px "></button>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 좋아요를 누르지 않았을 경우 -->
                                        <button type="button is-danger is-hovered" onclick="toggleLike(${dto.bno}, '${sid}');" class="inbtn" data-board-id="${dto.bno}" style="width: 80px; height: 34px;"><img src="${path}/resources/img/like_white.png" alt="!" style="height: 26px; margin-top: 5px"></button>
                                    </c:otherwise>
                                </c:choose>
                                <button class="button is-danger is-hovered" onclick="openReportPopup()">
                                    <img src="${path}/resources/img/report.png" alt="!" style="height: 20px; margin-right: 6px">신고</button></td>
                        </tr>
                    </c:if>
                    </tbody>

                </table>
                <script>
                    function toggleLike(boardNo, ${sid }) {
                        $.ajax({
                            url: "${path}/board/boardLike.do",
                            method: "POST",
                            data: {
                                boardNo: boardNo,
                                sid: ${sid }
                            },
                            dataType: "json",
                            success: function(result) {
                                var likeButton = $("[data-board-id='" + boardNo + "']");
                                console.log(result.result);
                                var chk = result.result;

                                if (chk === "liked") {
                                    likeButton.html("<img src='${path}/resources/img/like_blue.png' alt='!' style='height: 26px; margin-top: 6px'/>");
                                } else if (chk === "unliked") {
                                    likeButton.html("<img src='${path}/resources/img/like_white.png' alt='!' style='height: 26px; margin-top: 6px'/>");
                                } else {
                                    // likeButton.css("color","#b4b4b4");
                                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                                }
                            }
                        });
                    }
                    $(document).ready(function() {
                        // 좋아요 상태를 기반으로 버튼 이미지 변경
                        $(".inbtn").each(function() {
                            var isLiked = $(this).hasClass("liked");
                            if (isLiked) {
                                $(this).addClass("liked");
                            }
                        });

                        // 기존의 readable 값 불러와서 select에 값 표시
                        let readable = ${dto.readable};
                        console.log(readable);
                        if(readable == true) {
                            $("#contentSelect").val("true");
                        } else {
                            $("#contentSelect").val("false");
                        }
                    });
                </script>

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
                                    <a href="${path}/board/commentEdit.do?bno=${lev.bno}" class="button is-link is-small is-outlined is-rounded ">수정</a>
                                    <a href="${path}/board/comDelete.do?bno=${lev.bno}&par=${lev.par}" class="button is-danger is-small is-outlined is-rounded"> 삭제 </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <script>
                    function openReportPopup() {
                        // 팝업 창의 크기 및 위치를 지정합니다. 필요에 따라 조절할 수 있습니다.
                        let width = 550;
                        let height = 300;
                        let left = (screen.width/2) - (width/2);
                        let top = (screen.height/2) - (height/2);

                        window.open('${path}/board/reportPopup.do?bno=${dto.bno}&id=${sid}', '신고', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
                    }
                </script>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable({
                            // sorting 화살표 제거
                            "targets": 'no-sort',
                            "bSort": false,
                            "destroy": true,

                            // 2번째 컬럼을 기준으로 내림차순 정렬
                            order: [[2, 'desc']],
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
                <form action="${path}/board/commentInsert.do" id="login_frm" class="frm" method="post">
                    <table class="tb3">
                        <tbody>
                        <tr>
                            <c:if test="${not empty sid}">
                                <th class="has-text-centered">${sid}</th>
                                <th><textarea name="content" id="content" cols="100" rows="5" placeholder="댓글 작성" required ></textarea></th>
                                <th><input type="submit" value="글쓰기" class="inbtn" id="ans_btn"></th>
                                <input type="hidden" name="bno" value="${dto.bno}" readonly>
                                <input type="hidden" name="id" value="${sid}" readonly>
                            </c:if>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../include/footer.jsp" %>
    </footer>
</div>
</body>

</html>