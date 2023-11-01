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
    <title>성적표 상세 보기</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <style>

        .content table th{
            border: 1px solid white;
        }
        .content table td{
            border: 1px solid white;
        }

        #content{
            height: 701px;
            padding-top: 24px;
        }

        .re-button{
            right: 170px;
            top: 10px;
        }



    </style>
</head>
<body>
<!-- hero -->
<section class="hero is-black is-small">
    <div class="hero-body has-text-centered">
        <p class="title is-size-3">
            성적표 상세보기
        </p>
    </div>
</section>

<!-- content -->
<div class="content">
<div class="container is-fullhd">
    <div class="content" id="content" >
            <tbody class="container">
                <section class="page" id="page1">
                    <tbody class="page_wrap">
                        <table class="tb1 box is-size-5" style="width: 50%; margin: 0 auto; margin-top: 50px; position: relative;">
                            <tbody style="">
                            <tr>
                                <th >학생 이름</th>
                                <td class="data">${grade.stuname}</td>
                            </tr>
                            <tr>
                                <th >학생 아이디</th>
                                <td class="data">${grade.stuid}</td>
                            </tr>
                            <tr>
                                <th>시험 종류</th>
                                <td class="data">${grade.exam}</td>
                            </tr>
                            <tr>
                                <th>국어</th>
                                <td class="data">${grade.kor}점</td>
                            </tr>
                            <tr>
                                <th>영어</th>
                                <td class="data">${grade.eng}점</td>
                            </tr>
                            <tr>
                                <th>수학</th>
                                <td class="data">${grade.math}점</td>
                            </tr>
                            <tr>
                                <th>사회</th>
                                <td class="data">${grade.social}점</td>
                            </tr>
                            <tr>
                                <th>과학</th>
                                <td class="data">${grade.science}점</td>
                            </tr>
                            <tr>
                                <th>합계</th>
                                <td class="data">${grade.su}점</td>
                            </tr>
                            <tr>
                                <th>평균</th>
                                <td class="data">${grade.av}점</td>
                            </tr>
                            <tr>
                                <th>담당 선생님 성함</th>
                                <td class="data">
                                    ${grade.tname}
                                        <input type="hidden" name="tid" id="tid" value="tid"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <table class="tb2" style="margin-left: 540px">
                            <tr>
                                <td>
                                    <c:if test="${sid == grade.tid }">
                                    <a href="${path}/grade/gradeedit.do?no=${grade.no}" class="button re-button re-button is-outlined is-link">성적 수정</a>
                                    </c:if>
                                </td>
                            </tr>
                        </table>
                    </tbody>
                </section>
            </div>
    </div>
    </div>
</body>
</html>