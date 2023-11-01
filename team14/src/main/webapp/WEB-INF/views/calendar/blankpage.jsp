<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
    alert('완료되었습니다.')
    opener.document.location.href="${path}/calendar/list.do"
    self.close();
</script>
</body>
</html>
