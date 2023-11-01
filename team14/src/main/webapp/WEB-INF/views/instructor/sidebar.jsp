<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path4" value="${pageContext.request.contextPath }"/>

<nav style="margin-right: 0">
    <div class="sidebar">
        <div class="header" style="text-align: center;"><a href="${path4}/instructor/instructorDetail.do?no=${instructor.no}">${instructor.name} 선생님</a></div>
        <ul>
            <li id="side_list">
                <a href="${path4}/instructor/instructorLecture.do?no=${instructor.no }" >
                    강의 목록
                </a>
            </li>
            <li id="side_notice">
                <a href="${path4}/instructor/instructorNotice.do?no=${instructor.no }" >
                    공지
                </a>
            </li>
            <li id="side_qna">
                <a href="${path4}/instructor/instructorQNA.do?no=${instructor.no }">
                    Q&A
                </a>
            </li>
            <li id="side_file">
                <a href="${path4}/instructor/instructorFile.do?no=${instructor.no }">
                    자료실
                </a>
            </li>
            <li id="side_review">
                <a href="${path4}/instructor/instructorReview.do?no=${instructor.no }">
                    후기
                </a>
            </li>
            <c:if test="${isInst == true}">
                <li id="side_grade">
                    <a href="${path4}/grade/list.do?no=${instructor.no }">
                        성적 게시판 관리
                    </a>
                </li>
            </c:if>
        </ul>

    </div>
</nav>