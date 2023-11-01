<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>
    <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
    <script src='${path}/resources/fullcalendar-6.1.9/dist/index.global.js'></script>
    <title>calendar</title>
    <%@include file="../include/head.jsp"%>

    <style>

        body {
            margin: 40px 10px;
            padding: 0;
            font-family: 'NanumSquare' !important;
            
        }

        #calendar {
            max-width: 1100px;
            margin: 0 auto;
            font-size: 12px;
        }

        .reg-button{
            margin-left: 1275px;
            height: 30px;
            width: 66px;
            top: 30px;
            font-size: 12px;
            background-color: #007BFF;
            color: black;
        }
        .section-middle{
            padding-top: 0px;
        }

        .content-container{
            width: 624px;
            margin-right: 1000px;
        }

        .container h4{
            width: 150px;
            margin-left: 115px;
            margin-top: 50px;
        }

        .fc-day-sun a{
            color: red;
        }

        .fc-day-mon a{color: black;}
        .fc-day-tue a{color: black;}
        .fc-day-wed a{color: black;}
        .fc-day-thu a{color: black;}
        .fc-day-fri a{color: black;}

        .button.is-medium {
            font-size: 12px;
        }

        .fc-daygrid-event{
            font-size: 12px;
            font-weight: bolder;
        }

        fc-toolbar-title{
            margin-left: 10px;
        }

        .section-middle{
            margin-top: 20px;
        }





    </style>
</head>
<body>
<div class="page_wrap">
    <%@include file="../include/header.jsp"%>
    <%@include file="../myclass/myclassTopbar.jsp"%>
    <div class="container content-container" style="margin-top: 40px">
        <a style="font-size: 20px; margin-left: 120px">학습계획표</a>
    </div>
    <div class="section section-middle" style="padding-top: 0px">
    <div class="registar-btn">
        <button class="button reg-button is-link is-medium" onclick="window.open('${path}/calendar/insert.do', '_blank', 'popup=true')" style="background-color: #007BFF; border-color: #007BFF; font-weight: bold">일정등록</button>
    </div>
    <div id='calendar'></div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            themeSystem: 'bootstrap5',
            locale:'ko',
            editable: true,
            selectable: true,
            businessHours: true,
            dayMaxEvents: true, // allow "more" link when too many events
            events:
                [
                    <c:forEach items="${calendarList}" var="calen">
                    {
                        no: '${calen.no}',
                        groupId: '${calen.groupId}',
                        title: '${calen.title}',
                        start: '${calen.start}',
                        end: '${calen.end}',
                        rurl : '${path}/calendar/detail.do?no=${calen.no}',
                        textColor: '${calen.textColor}',
                        backgroundColor:'${calen.backgroundColor}',
                        borderColor:'${calen.backgroundColor}'
                    },
                    </c:forEach>
                ],
            eventClick: function (info){
                let popOption = 'width=1344px, height=570px, top=50px, left=50px, _blank, popup=true';
                let url = info.event.extendedProps.rurl;
                var zz;
                zz = window.open(url,'popup=yes',popOption);
                zz.foucus();
            }
        });

        calendar.render();
    });

</script>
<%@include file="../include/footer.jsp"%>
</body>
</html>