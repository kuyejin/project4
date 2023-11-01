<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" isErrorPage="true" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>에러</title>
</head>
<body>
<h3>Spring : SecurityException</h3>
<h3>${exception.message}</h3>
</body>
</html>