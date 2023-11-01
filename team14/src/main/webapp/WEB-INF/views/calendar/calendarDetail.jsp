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
    <title>Title</title>
    <%@include file="../include/head.jsp"%>
</head>
<body>
<div class="content">
    <div class="container is-fullhd">
        <div class="content" id="content" >
            <tbody class="container">
            <section class="hero is-small is-dark">
                <div class="hero-body">
                    <p class="title">
                        일정 상세보기
                    </p>
                </div>
            </section>
            <section class="page" id="page1">
                <tbody class="page_wrap">
                <table class="tb1 box is-size-5" style="width: 540px; margin-left: 400px; margin-top: 50px;">
                    <tbody style="">
                    <tr>
                        <th >그룹명</th>
                        <td class="data">
                            <c:choose>
                            <c:when test="${calendar.groupId == 1}">
                                <c:out value="수업 수강 관련"/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="개인 일정 관련"/>
                            </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th >일정명</th>
                        <td class="data">${calendar.title}</td>
                    </tr>
                    <tr>
                        <th>일정 내용</th>
                        <td class="data">${calendar.content}</td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td class="data">${calendar.start}</td>
                    </tr>
                    <tr>
                        <th>종료일</th>
                        <td class="data">${calendar.end}</td>
                    </tr>
                    </tbody>
                </table>
                <table class="tb2" style="margin-left: 540px">
                    <tr>
                        <td colspan="2">
                            <a href="${path }/calendar/edit.do?no=${calendar.no}" class="button is-outlined is-link">일정 수정</a>
                            <a href="${path }/calendar/delete.do?no=${calendar.no}" class="button is-danger is-outlined">일정 삭제</a>
                        </td>
                    </tr>
                </table>
                </tbody>
            </section>
        </div>
    </div>
</div>
</div>
</body>
</html>
