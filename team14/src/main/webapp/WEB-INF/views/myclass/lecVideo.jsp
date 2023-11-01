<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="<%=request.getContextPath() %>"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 영상</title>
    <style>
        /* 스타일을 추가하여 비디오가 화면에 꽉 차게 설정 */
        video {
            width: 100%; /* 가로 폭을 100%로 설정 */
            height: auto; /* 세로는 비율에 맞게 자동 조정 */
        }
    </style>
</head>
<body>
<video controls>
    <source src="${path}/resources/upload/${video}" type="video/mp4">
</video>
</body>
</html>
