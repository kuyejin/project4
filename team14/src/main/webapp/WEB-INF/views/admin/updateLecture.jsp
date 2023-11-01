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
                        수정
                    </p>
                </div>
            </li>
        </ul>
    </figure>
    <div class="content" id="contents">
        <div class="row column text-center">
            <div class="container">
                <form action="${path}/lecture/updateLecture.do" class="frm" method="post" enctype="multipart/form-data">
                    <table class="tb1">
                        <tbody>
                        <tr>
                            <th>과목</th>
                            <td colspan="2">
                                <input type="hidden" name="no" id="no" value="${lecture.no}" readonly>
                                <input type="text" name="cate" id="cate" value="${instructor.cate}" class="input" readonly>
                            </td>
                        </tr>

                        <tr>
                            <th>수강 대상</th>
                            <td colspan="2">
                                <c:set var="splitValues" value="${fn:split(lecture.slevel, ' ')}" />
                                <c:set var="level1" value="${splitValues[0]}" />
                                <c:set var="level2" value="${splitValues[1]}" />

                                <select name="level1" id="level1" class="select is-fullwidth" autofocus required>
                                    <c:choose>
                                        <c:when test="${level1 eq '초등학교'}">
                                            <option value="초등학교" selected>초등학교</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="초등학교">초등학교</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level1 eq '중학교'}">
                                            <option value="중학교" selected>중학교</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="중학교">중학교</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level1 eq '고등학교'}">
                                            <option value="고등학교" selected>고등학교</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="고등학교">고등학교</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>

                                <select name="level2" id="level2" class="select is-fullwidth" autofocus required>
                                    <c:choose>
                                        <c:when test="${level2 eq '1학년'}">
                                            <option value="1학년" selected>1학년</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1학년">1학년</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level2 eq '2학년'}">
                                            <option value="2학년" selected>2학년</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="2학년">2학년</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level2 eq '3학년'}">
                                            <option value="3학년" selected>3학년</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="3학년">3학년</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level2 eq '4학년'}">
                                            <option value="4학년" selected>4학년</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="4학년">4학년</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level2 eq '5학년'}">
                                            <option value="5학년" selected>5학년</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="5학년">5학년</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${level2 eq '6학년'}">
                                            <option value="6학년" selected>6학년</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="6학년">6학년</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>

                                <script>
                                    $(document).ready(function () {
                                        var c1 = document.getElementById("level1");
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
                                    })
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <th>강의 이름</th>
                            <td colspan="2"><input type="text" name="title" id="title" class="input" value="${lecture.title}" placeholder="상품 이름 입력" required></td>
                        </tr>
                        <tr>
                            <th>강사 이름</th>
                            <td colspan="2">
                                <input type="text" class="input" value="${instructor.name}" readonly>
                                <input type="hidden" name="ino" value="${instructor.no}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <th>강의 설명</th>
                            <td colspan="2">
                                <textarea name="content" id="content" class="textarea" cols="50" rows="15" placeholder="상품 설명 입력" required>${lecture.content}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>표지 이미지</th>
                            <td colspan="2">
                                <input type="text" value="기존파일: ${lecFileList.get(0)}" class="input" readonly>
                                <input type="file" name="simg" id="simg" class="input" placeholder="표지 이미지" accept=".jpg, .png">
                            </td>
                        </tr>
                        <tr>
                            <th>샘플(OT) 영상</th>
                            <td colspan="2">
                                <input type="text" value="기존파일: ${lecFileList.get(1)}" class="input" readonly>
                                <input type="file" name="sfile1" id="sfile1" class="input" placeholder="샘플 영상1" accept=".mp4">
                            </td>
                        </tr>
                        <tr>
                            <th>강의 영상 1</th>
                            <td colspan="2">
                                <input type="text" value="기존파일: ${lecFileList.get(2)}" class="input" readonly>
                                <input type="file" name="sfile2" id="sfile2" class="input" placeholder="강의 영상1" accept=".mp4">
                            </td>
                        </tr>
                        <tr>
                            <th>강의 영상 2</th>
                            <td colspan="2">
                                <input type="text" value="기존파일: ${lecFileList.get(3)}" class="input" readonly>
                                <input type="file" name="sfile3" id="sfile3" class="input" placeholder="강의 영상2" accept=".mp4">
                            </td>
                        </tr>
                        <tr>
                            <th>강의 영상 3</th>
                            <td colspan="2">
                                <input type="text" value="기존파일: ${lecFileList.get(4)}" class="input" readonly>
                                <input type="file" name="sfile4" id="sfile4" class="input" placeholder="강의 영상3" accept=".mp4">
                            </td>
                        </tr>
                        <tr>
                            <th>강의 영상 4</th>
                            <td colspan="2">
                                <input type="text" value="기존파일: ${lecFileList.get(5)}" class="input" readonly>
                                <input type="file" name="sfile5" id="sfile5" class="input" placeholder="강의 영상4" accept=".mp4">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="강의수정" class="button is-info">
                                <input type="reset" value="취소" class="button is-danger" onclick="window.history.back();">
                                <a href="${path}/lecture/lecList" class="button is-info">강의목록</a>
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