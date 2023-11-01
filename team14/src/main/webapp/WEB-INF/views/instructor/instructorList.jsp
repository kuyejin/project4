<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>선생님 목록</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <style>
        .hero {
            height: 50px;
            margin-top: 40px;
        }

        .instructorList{
            height: 600px;
            padding-top: 40px;
        }
        .listTitle{
            border-bottom: 1px solid #cccccc;
            height: 60px;
            margin-bottom: 30px;
        }
        .listTitle h2{
            text-align: center;
            font-size: 30px;
            line-height: 60px;
        }

        .instructorCard {
            width:250px;
            height: 400px;
            margin-right: 40px;
            background-color: #fff;
            border: 1px solid #e0e0e0;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s;
            float: left;
        }
        .columns .instructorCard:first-child{
            margin-left: 50px;
        }
        .instructorCard:last-child{
            margin-right: 0;
        }

        .instructorCard:hover {
                /*transform: scale(1.05); !* 확대 효과*!*/
        }

        .instructorImage {
            width: 250px;
            height: 300px;
            /*margin: 0 auto;*/
            text-align: center;
            overflow: hidden;
            position: relative;
        }
        .instructorImage img {
            width: 250px;
            /*height: 320px;*/
            overflow: hidden;
            position: absolute;
            bottom: 0;
            margin-bottom: 0;
            left: 50%; /* 가운데 정렬을 위해 가로 위치 조정 */
            transform: translateX(-50%); /* 가운데 정렬 */
        }

        .instructorInfo {
            height: 100px;
            padding: 0px 15px 15px 15px;
        }
        .instructorCate {
            font-size: 16px;
            margin-bottom: 2px;
            color: #6b6b6b;
            height: 50px;
            vertical-align: bottom;
            display: table-cell;
        }
        .instructorTitle {
            font-size: 20px;
            /*margin-bottom: 10px;*/
            font-weight: bold;
        }

        .instructorPrice {
            font-size: 16px;
            font-weight: bold;
        }

        .is-active{
            font-weight: bold;
        }

    </style>
    <script>
        $(document).ready(function() {
            $('.instructorCard').hover(
                function() {
                    // 마우스가 올라갔을 때
                    $(this).find('.instructorImage').css('background-color', '#DEEBFA');
                },
                function() {
                    // 마우스가 떠났을 때
                    $(this).find('.instructorImage').css('background-color', '');
                }
            );
        });
    </script>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<jsp:include page="../include/header.jsp"></jsp:include>
<%--<section class="hero is-medium is-white">--%>
<%--    <div class="hero-body has-text-centered">--%>
<%--    </div>--%>
<%--</section>--%>

<div class="content" id="content">
    <div class="row column text-center">
        <div class="container" id="cate" style="text-align: center">
            <h2 style="margin-top: 100px">스마트해법 선생님</h2>
            <div class="tabs is-centered is-boxed">
                <ul>
                    <li class="is-active" id="selectKor">
                        <a>
                            <span>국어</span>
                        </a>
                    </li>
                    <li id="selectMath">
                        <a>
                            <span>수학</span>
                        </a>
                    </li>
                    <li id="selectEng">
                        <a>
                            <span>영어</span>
                        </a>
                    </li>
                    <li id="selectSoc">
                        <a>
                            <span>사회</span>
                        </a>
                    </li>
                    <li id="selectSci">
                        <a>
                            <span>과학</span>
                        </a>
                    </li>
                    <li id="selectHis">
                        <a>
                            <span>한국사</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
<%--       ---------------------------국어--------------------------------- --%>
        <div class="container" id="korList">

            <c:set var="finalKoreanCount" value="0" />
            <c:forEach items="${instructorList}" var="inst">
                <c:if test="${inst.cate == '국어'}">
                    <c:set var="finalKoreanCount" value="${finalKoreanCount + 1}" />
                </c:if>
            </c:forEach>

            <c:set var="koreanCount" value="0" />

            <c:forEach items="${instructorList}" var="inst">
                <c:if test="${inst.cate == '국어'}">
                    <c:set var="koreanCount" value="${koreanCount + 1}" />

                    <c:if test="${koreanCount % 4 == 1}">
                        <div class="columns" style="margin: 0 auto; padding-top: 20px; width: 1200px">
                    </c:if>
                    <div class="instructorCard">
                        <a href="${path}/instructor/instructorDetail.do?no=${inst.no}"><div class="instructorImage"><img src="${path}/resources/upload/${inst.img}"/></div></a>
                        <div class="instructorInfo">
                            <div class="instructorCate">${inst.intro}</div>
                            <div class="instructorTitle">${inst.name}</div>
                        </div>
                    </div>
                    <c:if test="${koreanCount % 4 == 0 || koreanCount == finalKoreanCount}">
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
        </div> <%-- 국어 end --%>

        <%--       ---------------------------수학--------------------------------- --%>
        <div class="container" id="mathList" style="display: none">
            <c:set var="finalMathCount" value="0" />
            <c:forEach items="${instructorList}" var="inst">
                <c:if test="${inst.cate == '수학'}">
                    <c:set var="finalMathCount" value="${finalMathCount + 1}" />
                </c:if>
            </c:forEach>

            <c:set var="mathCount" value="0" />

            <c:forEach items="${instructorList}" var="inst">
                <c:if test="${inst.cate == '수학'}">
                    <c:set var="mathCount" value="${mathCount + 1}" />

                    <c:if test="${mathCount % 4 == 1}">
                        <div class="columns" style="margin: 0 auto; padding-top: 20px; width: 1200px">
                    </c:if>

                    <div class="instructorCard">
                        <a href="${path}/instructor/instructorDetail.do?no=${inst.no}">
                            <div class="instructorImage"><img src="${path}/resources/upload/${inst.img}"/></div>
                        </a>
                        <div class="instructorInfo">
                            <div class="instructorCate">${inst.intro}</div>
                            <div class="instructorTitle">${inst.name}</div>
                        </div>
                    </div>

                    <c:if test="${mathCount % 4 == 0 || mathCount == finalMathCount}">
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
        </div> <%-- 수학 end --%>


    <%--       ---------------------------영어--------------------------------- --%>
        <div class="container" id="engList" style="display: none">
            <c:set var="finalEngCount" value="0" />
            <c:forEach items="${instructorList}" var="inst">
                <c:if test="${inst.cate == '영어'}">
                    <c:set var="finalEngCount" value="${finalEngCount + 1}" />
                </c:if>
            </c:forEach>

            <c:set var="engCount" value="0" />

            <c:forEach items="${instructorList}" var="inst">
                <c:if test="${inst.cate == '영어'}">
                    <c:set var="engCount" value="${engCount + 1}" />

                    <c:if test="${engCount % 4 == 1}">
                        <div class="columns" style="margin: 0 auto; padding-top: 20px; width: 1200px">
                    </c:if>

                    <div class="instructorCard">
                        <a href="${path}/instructor/instructorDetail.do?no=${inst.no}"><div class="instructorImage"><img src="${path}/resources/upload/${inst.img}"/></div></a>
                        <div class="instructorInfo">
                            <div class="instructorCate">${inst.intro}</div>
                            <div class="instructorTitle">${inst.name}</div>
                        </div>
                    </div>

                    <c:if test="${engCount % 4 == 0 || engCount == finalEngCount}">
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>


        </div> <%-- 영어 end --%>

        <%--       ---------------------------사회탐구--------------------------------- --%>
        <div class="container" id="socList" style="display: none">
                <c:set var="finalSocCount" value="0" />
                <c:forEach items="${instructorList}" var="inst">
                    <c:if test="${inst.cate == '사회'}">
                        <c:set var="finalSocCount" value="${finalSocCount + 1}" />
                    </c:if>
                </c:forEach>

                <c:set var="socCount" value="0" />

                <c:forEach items="${instructorList}" var="inst">
                    <c:if test="${inst.cate == '사회'}">
                        <c:set var="socCount" value="${socCount + 1}" />

                        <c:if test="${socCount % 4 == 1}">
                            <div class="columns" style="margin: 0 auto; padding-top: 20px; width: 1200px">
                        </c:if>

                        <div class="instructorCard">
                            <a href="${path}/instructor/instructorDetail.do?no=${inst.no}"><div class="instructorImage"><img src="${path}/resources/upload/${inst.img}"/></div></a>
                            <div class="instructorInfo">
                                <div class="instructorCate">${inst.intro}</div>
                                <div class="instructorTitle">${inst.name}</div>
                            </div>
                        </div>

                        <c:if test="${socCount % 4 == 0 || socCount == finalSocCount}">
                            </div>
                        </c:if>
                    </c:if>
                </c:forEach>


        </div> <%-- 사회탐구 end --%>

        <%--       ---------------------------한국사 --------------------------------- --%>
        <div class="container" id="hisList" style="display: none">
                <c:set var="finalHisCount" value="0" />
                <c:forEach items="${instructorList}" var="inst">
                    <c:if test="${inst.cate == '한국사'}">
                        <c:set var="finalHisCount" value="${finalHisCount + 1}" />
                    </c:if>
                </c:forEach>

                <c:set var="hisCount" value="0" />

                <c:forEach items="${instructorList}" var="inst">
                    <c:if test="${inst.cate == '한국사'}">
                        <c:set var="hisCount" value="${hisCount + 1}" />

                        <c:if test="${hisCount % 4 == 1}">
                            <div class="columns" style="margin: 0 auto; padding-top: 20px; width: 1200px">
                        </c:if>

                        <div class="instructorCard">
                            <a href="${path}/instructor/instructorDetail.do?no=${inst.no}"><div class="instructorImage"><img src="${path}/resources/upload/${inst.img}"/></div></a>
                            <div class="instructorInfo">
                                <div class="instructorCate">${inst.intro}</div>
                                <div class="instructorTitle">${inst.name}</div>
                            </div>
                        </div>

                        <c:if test="${hisCount % 4 == 0 || hisCount == finalHisCount}">
                            </div>
                        </c:if>
                    </c:if>
                </c:forEach>

        </div> <%-- 한국사 end --%>

        <%--       ---------------------------과탐--------------------------------- --%>
        <div class="container" id="sciList" style="display: none">
                <c:set var="finalSciCount" value="0" />
                <c:forEach items="${instructorList}" var="inst">
                    <c:if test="${inst.cate == '과학'}">
                        <c:set var="finalSciCount" value="${finalSciCount + 1}" />
                    </c:if>
                </c:forEach>

                <c:set var="sciCount" value="0" />

                <c:forEach items="${instructorList}" var="inst">
                    <c:if test="${inst.cate == '과학'}">
                        <c:set var="sciCount" value="${sciCount + 1}" />

                        <c:if test="${sciCount % 4 == 1}">
                            <div class="columns" style="margin: 0 auto; padding-top: 20px; width: 1200px">
                        </c:if>

                        <div class="instructorCard">
                            <a href="${path}/instructor/instructorDetail.do?no=${inst.no}"><div class="instructorImage"><img src="${path}/resources/upload/${inst.img}"/></div></a>
                            <div class="instructorInfo">
                                <div class="instructorCate">${inst.intro}</div>
                                <div class="instructorTitle">${inst.name}</div>
                            </div>
                        </div>

                        <c:if test="${sciCount % 4 == 0 || sciCount == finalSciCount}">
                            </div>
                        </c:if>
                    </c:if>
                </c:forEach>
        </div> <%-- 과탐 end --%>




        <script>
            $(document).ready(function() {
                $('.tabs ul li').on('click', function() {
                    // 모든 탭에서 is-active 클래스 제거
                    $('.tabs ul li').removeClass('is-active');

                    // 클릭한 탭에 is-active 클래스 추가
                    $(this).addClass('is-active');

                    // 모든 컨테이너를 숨김
                    $('.container:not(#cate)').hide();

                    // 해당하는 컨테이너만 표시
                    var id = $(this).attr('id').replace('select', '').toLowerCase() + 'List';
                    $('#' + id).show();
                });
            });

        </script>
    </div>
</div>
<footer id="footer" class="footer-nav row expanded collapse">
    <!-- 푸터 부분 인클루드 -->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>
</body>
</html>