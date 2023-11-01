<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path4" value="${pageContext.request.contextPath }"/>

<nav style="margin-right: 0">
    <div class="sidebar">
        <div class="header" style="text-align: center; margin-bottom: 8px">스마트 해법</div>
        <ul>
            <li id="side_modify">
                <a href="${path4}/member/update.do?id=${sid }" >
                    개인정보 수정
                </a>
            </li>
            <li id="side_writtenList">
                <a href="${path4}/member/writtenList.do" >
                    작성글
                </a>
            </li>
            <li id="side_myLikeList">
                <a href="${path4}/member/myLikeList.do">
                    추천한 게시글
                </a>
            </li>
            <li id="side_myReportList">
                <a href="${path4}/member/myReportList.do">
                    신고한 게시글
                </a>
            </li>
            <li id="side_paymentList">
                <a href="${path4}/payment/paymentList.do">
                    결제내역
                </a>
            </li>
<%--            <c:if test="${isInst == true}">--%>
<%--                <li id="side_grade">--%>
<%--                    <a href="${path4}/grade/list.do">--%>
<%--                        성적 게시판 관리--%>
<%--                    </a>--%>
<%--                </li>--%>
<%--            </c:if>--%>
<%--            <li>--%>
<%--                <a href="${path4}/lecture/lecMemList.do">--%>
<%--                    수강내역--%>
<%--                </a>--%>
<%--            </li>--%>
        </ul>
        <a href="${path4}/qna/list.do" class="mypage-inquiry">
            <div>
                <span class="ask-help">도움이 필요하신가요?</span>
                <span>1:1 문의하기</span>
            </div>
        </a>
    </div>
</nav>