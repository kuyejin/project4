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
<div class="content" id="content">
    <div class="container is-fullhd">
        <!-- title -->
        <section class="hero is-small is-dark">
            <div class="hero-body">
                <p class="title">
                    일정 수정
                </p>
            </div>
        </section>
        <!-- title -->
        <div class="row column text-center">
            <div class="container">
                <form action="${path}/calendar/edit.do?no=${calendar.no}" method="post" id="calendarForm">
                    <div class="table_form_wrap">
                        <table class="table_form">
                            <tbody>
                            <tr>
                                <th>그룹명</th>
                                <td>
                                    <div class="select">
                                        <select name="groupId"  value="${calendar.groupId}">
                                            <option value="1">수업 수강 관련</option>
                                            <option value="2">개인 일정 관련</option>
                                        </select>
                                        <input type="hidden" name="groupId" id="groupId" value="${calendar.groupId}">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>일정명</th>
                                <td><input type="text" name="title" id="title" class="input"  value="${calendar.title}"></td>
                            </tr>
                            <tr>
                                <th>일정 내용</th>
                                <td><textarea class="textarea" name="content" cols="30" rows="10" value="${calendar.content}"></textarea></td>
                            </tr>
                            <tr>
                                <th>시작일</th>
                                <td><input type="date" name="start" id="start" class="input" value="${calendar.start}"></td>
                            </tr>
                            <tr>
                                <th>종료일</th>
                                <td><input type="date" name="end" id="end" class="input" value="${calendar.end}"></td>
                            </tr>
                            <script>
                                //값 받아올 때 -1일
                                $(document).ready(function() {
                                    var endDate = $('#end').val();
                                    if (endDate) {
                                        var date = new Date(endDate);
                                        date.setDate(date.getDate() - 1);
                                        var newDate = date.toISOString().split('T')[0];
                                        $('#end').val(newDate);
                                    }
                                });

                                //폼 전송할때 +1일
                                $(document).ready(function() {
                                    $('form').on('submit', function(e) {
                                        // 폼 제출을 일시적으로 중단
                                        e.preventDefault();

                                        // 날짜를 가져와서 1일을 더함
                                        var endDate = $('#end').val();
                                        var date = new Date(endDate);
                                        date.setDate(date.getDate() + 1);

                                        // 날짜 형식을 "YYYY-MM-DD"로 변환
                                        var dd = ('0' + date.getDate()).slice(-2);
                                        var mm = ('0' + (date.getMonth() + 1)).slice(-2);
                                        var yyyy = date.getFullYear();
                                        var newDate = yyyy + '-' + mm + '-' + dd;

                                        // 입력 필드의 값을 변경하고 폼을 제출
                                        $('#end').val(newDate);
                                        this.submit();
                                    });
                                });
                            </script>
                            <tr>
                                <th>글자색</th>
                                <td>
                                    <div class="select">
                                        <select name="textColor">
                                            <option value="${calendar.textColor}"><c:choose>
                                                <c:when test="${calendar.textColor eq '#EF5350'}">
                                                    <c:out value="Red"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#ff4757'}">
                                                    <c:out value="Water Melon"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#2d3436'}">
                                                    <c:out value="Black"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq 'white'}">
                                                    <c:out value="White"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#EF5350'}">
                                                    <c:out value="Bruschetta Tomato"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#f1f2f6'}">
                                                    <c:out value="Anti-Flash White"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#5C6BC0'}">
                                                    <c:out value="Indigo"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#f42A5F5'}">
                                                    <c:out value="Blue"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#70a1ff'}">
                                                    <c:out value="Sky Blue"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#26A69A'}">
                                                    <c:out value="Teal"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#66BB6A'}">
                                                    <c:out value="Green"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#9CCC65'}">
                                                    <c:out value="Light Green"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#D4E157'}">
                                                    <c:out value="Lime"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#FFEE58'}">
                                                    <c:out value="Yellow"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#FFCA28'}">
                                                    <c:out value="Amber"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#FFA726'}">
                                                    <c:out value="Orange"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#FF7043'}">
                                                    <c:out value="Deep Orange"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#8D6E63'}">
                                                    <c:out value="Brown"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#BDBDBD'}">
                                                    <c:out value="Grey"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#78909C'}">
                                                    <c:out value="Blue Grey"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#dfe4ea'}">
                                                    <c:out value="City Lights"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#AB47BC'}">
                                                    <c:out value="Purple"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#7E57C2'}">
                                                    <c:out value="Deep Purple"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.textColor eq '#ff6b81'}">
                                                    <c:out value="Pink"></c:out>
                                                </c:when>
                                                <c:otherwise >
                                                    <c:out value="Light Pink"></c:out>
                                                </c:otherwise>
                                            </c:choose></option>
                                            <option value="#EF5350">Red</option>
                                            <option value="#ff4757">Water Melon</option>
                                            <option value="#EF5350">Bruschetta Tomato</option>
                                            <option value="#2d3436">Black</option>
                                            <option value="white">White</option>
                                            <option value="#f1f2f6">Anti-Flash White</option>
                                            <option value="#5C6BC0">Indigo</option>
                                            <option value="#42A5F5">Blue</option>
                                            <option value="#70a1ff">Sky Blue</option>
                                            <option value="#26A69A">Teal</option>
                                            <option value="#66BB6A">Green</option>
                                            <option value="#9CCC65">Light Green</option>
                                            <option value="#D4E157">Lime</option>
                                            <option value="#FFEE58">Yellow</option>
                                            <option value="#FFCA28">Amber</option>
                                            <option value="#FFA726">Orange</option>
                                            <option value="#FF7043">Deep Orange</option>
                                            <option value="#8D6E63">Brown</option>
                                            <option value="#BDBDBD">Grey</option>
                                            <option value="#78909C">Blue Grey</option>
                                            <option value="#dfe4ea">City Lights</option>
                                            <option value="#AB47BC">Purple</option>
                                            <option value="#7E57C2">Deep Purple</option>
                                            <option value="#ff6b81">Pink</option>
                                            <option value="lightpink">lightpink</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>배경색</th>
                                <td>
                                    <div class="select">
                                        <select name="backgroundColor" >
                                            <option value="${calendar.backgroundColor}"><c:choose>
                                                <c:when test="${calendar.backgroundColor eq '#EF5350'}">
                                                    <c:out value="Red"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#ff4757'}">
                                                    <c:out value="Water Melon"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#2d3436'}">
                                                    <c:out value="Black"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq 'white'}">
                                                    <c:out value="White"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#EF5350'}">
                                                    <c:out value="Bruschetta Tomato"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#f1f2f6'}">
                                                    <c:out value="Anti-Flash White"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#5C6BC0'}">
                                                    <c:out value="Indigo"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#f42A5F5'}">
                                                    <c:out value="Blue"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#70a1ff'}">
                                                    <c:out value="Sky Blue"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#26A69A'}">
                                                    <c:out value="Teal"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#66BB6A'}">
                                                    <c:out value="Green"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#9CCC65'}">
                                                    <c:out value="Light Green"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#D4E157'}">
                                                    <c:out value="Lime"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#FFEE58'}">
                                                    <c:out value="Yellow"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#FFCA28'}">
                                                    <c:out value="Amber"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#FFA726'}">
                                                    <c:out value="Orange"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#FF7043'}">
                                                    <c:out value="Deep Orange"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#8D6E63'}">
                                                    <c:out value="Brown"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#BDBDBD'}">
                                                    <c:out value="Grey"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#78909C'}">
                                                    <c:out value="Blue Grey"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#dfe4ea'}">
                                                    <c:out value="City Lights"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#AB47BC'}">
                                                    <c:out value="Purple"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#7E57C2'}">
                                                    <c:out value="Deep Purple"></c:out>
                                                </c:when>
                                                <c:when test="${calendar.backgroundColor eq '#ff6b81'}">
                                                    <c:out value="Pink"></c:out>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="Light Pink"></c:out>
                                                </c:otherwise>
                                            </c:choose></option>
                                            <option value="#EF5350">Red</option>
                                            <option value="#ff4757">Water Melon</option>
                                            <option value="#EF5350">Bruschetta Tomato</option>
                                            <option value="#2d3436">Black</option>
                                            <option value="white">White</option>
                                            <option value="#f1f2f6">Anti-Flash White</option>
                                            <option value="#5C6BC0">Indigo</option>
                                            <option value="#42A5F5">Blue</option>
                                            <option value="#70a1ff">Sky Blue</option>
                                            <option value="#26A69A">Teal</option>
                                            <option value="#66BB6A">Green</option>
                                            <option value="#9CCC65">Light Green</option>
                                            <option value="#D4E157">Lime</option>
                                            <option value="#FFEE58">Yellow</option>
                                            <option value="#FFCA28">Amber</option>
                                            <option value="#FFA726">Orange</option>
                                            <option value="#FF7043">Deep Orange</option>
                                            <option value="#8D6E63">Brown</option>
                                            <option value="#BDBDBD">Grey</option>
                                            <option value="#78909C">Blue Grey</option>
                                            <option value="#dfe4ea">City Lights</option>
                                            <option value="#AB47BC">Purple</option>
                                            <option value="#7E57C2">Deep Purple</option>
                                            <option value="##ff6b81">Pink</option>
                                            <option value="lightpink">lightpink</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="1">
                                    <input type="submit" class="button is-link is-medium is-outlined" value="등록하기">
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
