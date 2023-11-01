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
    <title>게시판 입력</title>
    <%@ include file="../include/head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 플러그인 연결-->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <!-- 스타일 초기화 -->
    <link rel="stylesheet" href="../css/reset.css">
    <!-- 웹 폰트 -->
    <link rel="stylesheet" href="../css/font.css">

    <!-- css 모듈화 -->
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/hd.css">
    <link rel="stylesheet" href="../css/ft.css">
    <style>
        .hero {
            height: 250px;
            margin-top: 40px;
        }

        th {
            background-color: #dcdcdc;
            text-align: left;
        }
    </style>
    </style>
</head>
<body>
<div class="container is-fullhd">
    <!-- 헤더 부분 인클루드 -->
    <jsp:include page="../include/header.jsp"></jsp:include>
    <figure class="visual" id="vs1">
        <ul class="imgbox">
            <li class="hero is-medium is-white">
                <div class="hero-body has-text-centered">
                    <p class="title is-size-3">
                        강의
                    </p>
                    <p class="subtitle is-size-5">
                        등록
                    </p>
                </div>
            </li>
        </ul>
    </figure>
    <div class="content" id="contents">
        <div class="row column text-center">
            <div class="container">
                <form action="${path}/lecture/addLecture" class="frm" method="post" enctype="multipart/form-data">
                    <table class="tb1">
                        <tbody>
                        <tr>
                            <th>과목</th>
                            <td colspan="2">
                                <input type="text" name="cate" id="cate" value="" class="input" required readonly>
<%--                                <select name="cate" id="cate" class="select is-fullwidth" autofocus required>--%>
<%--                                    <option value="국어" selected>국어</option>--%>
<%--                                    <option value="수학">수학</option>--%>
<%--                                    <option value="영어">영어</option>--%>
<%--                                    <option value="과학">과학</option>--%>
<%--                                    <option value="과학">사회</option>--%>
<%--                                </select>--%>
                            </td>
                        </tr>

                        <tr>
                            <th>수강 대상</th>
                            <td colspan="2">
                                <select name="level1" id="level1" class="select is-fullwidth" autofocus required>
                                    <option value="초등학교" selected>초등학교</option>
                                    <option value="중학교">중학교</option>
                                    <option value="고등학교">고등학교</option>
                                </select>

                                <select name="level2" id="level2" class="select is-fullwidth" autofocus required>--%>
                                    <option value="1학년" id="op1" selected>1학년</option>
                                    <option value="2학년" id="op2">2학년</option>
                                    <option value="3학년" id="op3">3학년</option>
                                    <option value="4학년" id="op4">4학년</option>
                                    <option value="5학년" id="op5">5학년</option>
                                    <option value="6학년" id="op6">6학년</option>
                                </select>

                                <script>
                                    var c1 = document.getElementById("level1");
                                    var c2 = document.getElementById("level2");
                                    var op1 = document.querySelectorAll("#op1,#op2,#op3");
                                    var op2 = document.querySelectorAll("#op4,#op5,#op6");

                                    c1.addEventListener("change", function() {
                                        if (c1.value === "초등학교") {
                                            op2.forEach(option => {
                                                option.style.display = "block";
                                            });
                                        } else {
                                            op1.forEach(option => {
                                                option.style.display = "block";
                                            });

                                            op2.forEach(option => {
                                                option.style.display = "none";
                                            });
                                        }
                                    });
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <th>강의 이름</th>
                            <td colspan="2"><input type="text" name="title" id="title" class="input" placeholder="상품 이름 입력" required></td>
                        </tr>
                        <tr>
                            <th>강사 이름</th>
                            <td colspan="2">
                                <select name="ino" id="ino" class="select is-fullwidth" autofocus required>
                                    <c:forEach items="${instList}" var="inst" varStatus="status">
                                        <option value="${inst.no}">${inst.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <script>
                            $(document).ready(function () {
                                // 처음 시작할 때
                                let ino = $('#ino').val();

                                // AJAX로 서버에 신고 정보 전송
                                $.ajax({
                                    type: "POST",
                                    url: "${path}/instructor/getInstCate.do",
                                    data: {
                                        ino: ino
                                    },
                                    dataType: "json",
                                    success: function(result) {
                                        $("#cate").val(result.result);
                                        console.log('result.result :'+result.result);
                                        console.log("전달 완료");
                                    },
                                    error: function(result) {
                                        console.log(result.cate);
                                        console.log("전달 오류")
                                    }
                                });

                                $('#ino').on('change', function () {
                                let ino = $('#ino').val();

                                // AJAX로 서버에 신고 정보 전송
                                    $.ajax({
                                        type: "POST",
                                        url: "${path}/instructor/getInstCate.do",
                                        data: {
                                            ino: ino
                                        },
                                        dataType: "json",
                                        success: function(result) {
                                            $("#cate").val(result.result);
                                            console.log('result.result :'+result.result);
                                            console.log("전달 완료");
                                        },
                                        error: function(result) {
                                            console.log(result.result);
                                            console.log("전달 오류")
                                        }
                                    });
                                });
                            });
                        </script>
                        <tr>
                            <th>강의 설명</th>
                            <td colspan="2"> <textarea name="content" id="content" cols="50" class="textarea" rows="15" placeholder="상품 설명 입력" required></textarea></td>
                        </tr>
                        <tr>
                            <th>강의 가격</th>
                            <td colspan="2"><input type="number" name="price" id="price" class="input" placeholder="가격 입력" required></td>
                        </tr>
                        <tr>
                            <th>최대 수강인원</th>
                            <td colspan="2"><input type="text" name="lec_max" id="lec_max" class="input" placeholder="최대 수강인원" required></td>
                        </tr>
<%--                        <tr>--%>
<%--                            <th>수강신청 시작일</th>--%>
<%--                            <td colspan="2"><input type="date" name="aplctClss1" id="aplctClss1" class="input" placeholder="수강신청 시작일" required></td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <th>수강신청 마감일</th>--%>
<%--                            <td colspan="2"><input type="date" name="aplctClss2" id="aplctClss2" class="input" placeholder="수강신청 마감일" required></td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <th>강의 시작일</th>--%>
<%--                            <td colspan="2"><input type="date" name="studystart" id="studystart" class="input" placeholder="강의 시작일" required></td>--%>
<%--                        </tr>--%>
<%--                        <tr>--%>
<%--                            <th>강의 종료일</th>--%>
<%--                            <td colspan="2"><input type="date" name="studyend" id="studyend" class="input" placeholder="강의 종료일" required></td>--%>
<%--                        </tr>--%>
                        <tr>
                            <th>최대 수강일</th>
                            <td colspan="2"><input type="int" name="endDay" id="endDay" class="input" placeholder="최대 수강일" required></td>
                        </tr>
                        <tr>
                            <th>표지 이미지</th>
                            <td colspan="2"><input type="file" name="simg" id="simg" class="input" placeholder="표지 이미지" accept=".jpg, .png" required></td>
                        </tr>
                        <tr>
                            <th>샘플(OT) 영상</th>
                            <td colspan="2"><input type="file" name="sfile1" id="sfile1" class="input" placeholder="샘플 영상1" accept=".mp4" required></td>
                        </tr>
                        <tr>
                            <th>강의 영상 1</th>
                            <td colspan="2"><input type="file" name="sfile2" id="sfile2" class="input" placeholder="강의 영상1" accept=".mp4" required></td>
                        </tr>
                        <tr>
                            <th>강의 영상 2</th>
                            <td colspan="2"><input type="file" name="sfile3" id="sfile3" class="input" placeholder="강의 영상2" accept=".mp4"></td>
                        </tr>
                        <tr>
                            <th>강의 영상 3</th>
                            <td colspan="2"><input type="file" name="sfile4" id="sfile4" class="input" placeholder="강의 영상3" accept=".mp4"></td>
                        </tr>
                        <tr>
                            <th>강의 영상 4</th>
                            <td colspan="2"><input type="file" name="sfile5" id="sfile5" class="input" placeholder="강의 영상4" accept=".mp4"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="상품등록" class="button is-info">
                                <input type="reset" value="취소" class="button is-danger" onclick="window.history.back();">
                                <a href="${path}/lecture/lecList" class="button is-link">상품목록</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- footer imclude -->
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>