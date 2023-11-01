<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>

    <style>
        th{
            text-align: left;
            width: 20%;
            font-size: 20px;
            padding: 15px;
        }

        .ud_content td{
            font-size: 20px;
            vertical-align: middle;
            padding : 15px;
        }
    </style>
</head>
<body>

<%--강좌 소개--%>
<div id="ud_tab-content1" class="ud_content">
    <h3> 강좌 정보 </h3>

    <table>
        <%--<thead>--%>

        <div id="ud_tab-content1" class="ud_content">
            <c:forEach items="${myclassList }" var="myclass" varStatus="status">
            <h3> 강좌 정보 </h3>

            <tr>
                <th>강좌 제목</th>
                <td> ${myclass.lecTitle }</td>
            </tr>

            <tr>
                <th>강좌 설명</th>
                <td>${myclass.lecContent }</td>
            </tr>

            <tr>
                <th>강사</th>
                <td>${myclass.insName }</td>
            </tr>

            <tr>
                <th>대상 학년</th>
                <td> ${myclass.slevel} </td>
            </tr>

            <tr>
                <th>제작 강의수</th>
                <td> 제작강의수 </td>
            </tr>

            <tr>
                <th>강좌 관심수</th>
                <td> 강좌 관심수 </td>
            </tr>

            <tr>
                <th>평균 별점</th>
                <td> 평균 별점 </td>
            </tr>

            <tr>
                <th>관련 교재</th>
                <td> 교재 </td>
            </tr>
            </c:forEach>
        </div>

        <%-- </thead>--%>

        <%--<tbody>


        <c:forEach items="${boardlist }" var="boardlist">
            <tr class="boardlist1">
                <td>${boardlist.num}</td>
                <td><a class="path"
                       href="${path13}/board/detail.do?bno=${boardlist.num}">${boardlist.subject}</a>
                </td>
                <td>${boardlist.write_date}</td>
            </tr>
        </c:forEach>
        </tbody>--%>
    </table>
</div>

</body>
</html>