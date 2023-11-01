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
                    일정 등록
                </p>
            </div>
        </section>
<!-- title -->
        <div class="row column text-center">
            <div class="container">
                <form action="${path}/calendar/insert.do" method="post">
                    <div class="table_form_wrap">
                        <table class="table_form">
                            <tbody>
                            <tr style="display: none;">
                                <th>작성자 id</th>
                                <td><input type="text" name="id" id="id" class="input"  value="${sid}"></td>
                            </tr>
                            <tr>
                                <th>그룹명</th>
                                <td>
                                    <div class="select">
                                        <select name="groupId"  value="${calendar.groupId}">
                                            <option value="1">수업 일정 관련</option>
                                            <option value="2">개인 일정 관련</option>
                                        </select>
                                        <input type="hidden" name="groupId" id="groupId" value="${calendar.groupId}">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>일정명</th>
                                <td><input type="text" name="title" id="title" class="input"  placeholder="달력에 나타낼 일정 이름을 입력하세요." style="color: pi"></td>
                            </tr>
                            <tr>
                                <th>일정 내용</th>
                                <td><textarea class="textarea" name="content" cols="30" rows="10" placeholder="일정에 대한 내용을 입력하세요."></textarea></td>
                            </tr>
                            <tr>
                                <th>시작일</th>
                                <td><input type="date" name="start" id="start" class="input" placeholder="일정의 시작일을 입력하세요."></td>
                            </tr>
                            <tr>
                                <th>종료일</th>
                                <td><input type="date" name="end" id="end" class="input" placeholder="일정의 종료일을 입력하세요."></td>
                            </tr>
                            <tr>
                                <th>글자색</th>
                                <td>
                                    <div class="select">
                                        <select name="textColor">
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
                            <tr>
                                <th>배경색</th>
                                <td>
                                    <div class="select">
                                        <select name="backgroundColor">
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
                <script>
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
            </div>
        </div>
    </div>
</div>
</body>
</html>
