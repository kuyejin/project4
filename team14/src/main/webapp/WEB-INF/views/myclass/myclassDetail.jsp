<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%-- <!-- 부트스트랩 4.0 CSS -->
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
           integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
     <!-- 제이쿼리 -->
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
             integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
             crossorigin="anonymous" type="text/javascript"></script>
 --%>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
    <link rel="stylesheet" href="${path}/resources/css/myPage/baseLayout.css"/>
    <link rel="stylesheet" href="${path}/resources/css/myPage/validateUser.css"/>
    <link href="${path}/resources/css/myStudy/com_write.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/93f6428cee.js" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <%--    <script type="text/javascript" src="${path}/resources/js/com_write.js" charset="UTF-8"></script>--%>


    <title>강의 상세보기</title>

    <style>
        .search_from {
            text-align: right;
            font-size: 18px;
            margin-bottom: 20px; /* 아래쪽 여백 추가 */
        }

        .select_filter {
            padding: 5px; /* 셀렉트 박스 내부 패딩 추가 */
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px; /* 테두리 둥글게 만듭니다. */
            margin-right: 10px; /* 셀렉트 박스 오른쪽 여백 추가 */
            font-size: 16px; /* 폰트 크기 조정 */
            height: auto;
        }

        .search_filter {
            padding: 5px; /* 입력 필드 내부 패딩 추가 */
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 5px; /* 테두리 둥글게 만듭니다. */
            font-size: 16px; /* 폰트 크기 조정 */
            display: inline;
        }

        /* 선택된 셀렉트 박스 옵션 스타일 */
        .select_filter option:checked {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        #ud_tab-content1 th {
            width: 170px;
        }

        #ud_tab-content1 td {
            padding-right: 100px;
        }

        #myTable2 {
            font-size: 20px;
        }


        /* 강좌 정보 */

        .all_lecture_info {
            margin-top: 120px;
            position: relative;
            z-index: 20;
            background-color: #f8f8f8;
        }


        .all_lecture_items {
            /* position: relative;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            padding: 5rem 5.5rem;
            z-index: 11; */
            height: 370px;
            background: #e1f5fd;
            /* position: relative; */
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            padding: 0px 0px 0px 21px;
            z-index: 11;
        }


        .all_lecture_items .cont_wrap {
            position: relative;
            z-index: 4;
            padding: 50px 10px 10px 10px;
        }

        .all_lecture_items .flag_wrap {
            margin-bottom: 1rem;
        }


        .all_lecture_items .tit_wrap {
            max-width: 60rem;
        }

        .all_lecture_items .teacher_wrap {
            /*display: block;
            width: 40rem;
            !* position: absolute; *!
            right: 10.5rem;
            bottom: 0;
            z-index: 5;*/

            display: block;
            width: 12rem;
            position: absolute;
            right: 10.5rem;
            bottom: -14px;
            z-index: 5;
            margin-bottom: -5px;
        }


        .all_lecture_items .teacher_wrap .slide_item {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-pack: end;
            -ms-flex-pack: end;
            justify-content: flex-end;
            position: relative;
            width: 100%;
        }

        a {
            text-decoration: none;
            color: #212121;
            outline: none;
        }

        .all_lecture_items .teacher_wrap .name {
            display: block;
            position: absolute;
            left: 4rem;
            bottom: 5rem;
            font-size: 1.8rem;
            text-align: left;
            color: #0c1f3a;
            line-height: 2.3rem;


        }

        .all_lecture_items .teacher_wrap .name strong {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            font-weight: bold;
            white-space: nowrap;
        }


        .all_lecture_items .teacher_wrap .img {
            width: 23.2rem;
        }


        .all_lecture_items .teacher_wrap .img img {
            width: 100%;
        }


        [class^='flag_ro_col'] {
            display: -webkit-inline-box;
            display: -ms-inline-flexbox;
            display: inline-flex;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            padding: 0 1rem;
            margin-right: 0.2rem;
            height: 2.1rem;
            font-size: 1.2rem;
            color: #fff;
            vertical-align: middle;
            border-radius: 25px;
            border-bottom-right-radius: 0;
        }

        .flag_ro_col1 {
            background: #334075;
        }

        .flag_ro_col2 {
            background: #1056c5;
        }

        .flag_ro_col3 {
            background: #334075;
        }

        .flag_ro_col4 {
            background: #334075;
        }

        .video-style {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 500px;
        }


    </style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<div class="wrap">
    <jsp:include page="./myclassTopbar.jsp"></jsp:include>


    <div class="content-wrap" style="display: flex;justify-content: center;">
        <div class="content-section">
            <br>
            <div class="content">
                <div id="ud_tab" style="">
                    <input type="radio" name="ud_tabs" id="tab1" checked>
                    <label for="tab1">강좌소개</label>
                    <input type="radio" name="ud_tabs" id="tab2">
                    <label for="tab2">강좌목차</label>
                    <input type="radio" name="ud_tabs" id="tab3">
                    <label for="tab3">공지사항</label>
                    <input type="radio" name="ud_tabs" id="tab4">
                    <label for="tab4">QnA</label>
                    <input type="radio" name="ud_tabs" id="tab5">
                    <label for="tab5">수강후기</label>
                    <input type="radio" name="ud_tabs" id="tab6">
                    <label for="tab6">자료실</label>


                    <!-- 모든강좌정보  -->
                    <div class="all_lecture_info">
                        <!-- 강좌주제 -->
                        <div class="all_lecture_items">
                            <div class="cont_wrap">
                                <div class="flag_wrap" style="font-size: 20px;">
                                    <!-- <i class="fa-solid fa-message fa-flip-horizontal" style="color: #76bed0;"></i>
                                    <i class="fa-solid fa-message fa-flip-horizontal" style="color: #76bed0;"></i>
                                    <i class="fa-solid fa-message fa-flip-horizontal" style="color: #76bed0;"></i>
                                     -->
                                    <br>
                                    <span class="flag_ro_col1">고3</span>
                                    <span class="flag_ro_col2">입문</span>
                                    <!-- <span class="flag_ro_col3 cStep02">기본</span>
                                    <span class="flag_ro_col4">최종평가</span> -->
                                </div>

                                <c:forEach items="${takingList2 }" var="takingList2" varStatus="status">
                                    <div class="tit_wrap">
                                        <h2 class="tit">${takingList2.lecTitle }</h2>
                                    </div>


                                    <p class="name">
                                        <strong2 style="font-size: 30px;">${takingList2.insName }</strong2>
                                            <%--<i class="fas fa-solid fa-house fa-2x" ></i>--%>

                                        <a href="${path}/instructor/instructorDetail.do?no=${ino}">
                                             <img src="${path}/resources/img/icon_house.png" style="width: 30px;">
                                        </a>

                                    </p>
                                </c:forEach>

                                <div class="like_wrap">
                                    <!-- <button type="button" id="btnCouseGoodYn" class="btn_XL_like "
                                            onclick="javascript:courseGoodYn('S20220000579');">
                                        <span>좋아요</span>
                                    </button>
                                    <button type="button" class="btn_XL_col3"
                                            onclick="javascript:openIt('https://WSTR.ebsi.co.kr/M41M2201/S20220000579/S20220000579_1M4_100030029084.mp4',2) ">
                                        <span>OT</span></button>
                                    <button type="button" class="btn_XL_col2"
                                            onclick="registerCourse('S20220000579','');"><span>수강신청</span></button> -->
                                </div>
                            </div>
                            <div class="teacher_wrap">
                                <p class="slide_item">
                                    <a href="/ebs/pot/potg/retrieveCourseH3TeacherInfo.ebs?dstgCd=T0283">
                                        <!-- <p class="name"><strong>정승익</strong></p> -->
                                        <%--  <p class="img"><img src="${path}/resources/img/수학_홍길동.png"
                                                              alt=""
                                                              onError="this.src='/ebs/public_hsp/images/common/img_teacher_noimg212.png'"/>
                                          </p>--%>

                                        <%--<p class="img"><img src="${path }/resources/upload/${takingList.simg }"/></p>--%>

                                        <p class="img"><img src="${path }/resources/upload/${lecList.simg }"/></p>
                                    </a>
                            </div>
                        </div>

                    </div>


                    <%--강의 소개--%>
                    <div id="ud_tab-content1" class="ud_content">
                        <h3> 강좌 정보 </h3>
                        <table style="font-size: 25px">
                            <c:forEach items="${takingList2 }" var="takingList2" varStatus="status">
                                <tr>
                                    <th>강좌 제목</th>
                                    <td> ${takingList2.lecTitle }</td>
                                </tr>

                                <tr>
                                    <th>강좌 설명</th>
                                    <td>${takingList2.lecContent }</td>
                                </tr>

                                <tr>
                                    <th>강사</th>
                                    <td>${takingList2.insName }</td>
                                </tr>

                                <tr>
                                    <th>대상 학년</th>
                                    <td> ${takingList2.slevel} </td>
                                </tr>

                                <tr>
                                    <th>제작 강의수</th>
                                    <td>${cnt}개</td>
                                </tr>

                                <tr>
                                    <th>강좌 관심수</th>
                                    <td> 강좌 관심수</td>
                                </tr>

                                <tr>
                                    <th>평균 별점</th>
                                    <c:choose>
                                        <c:when test="${empty avg || avg eq ''}">
                                            <td>0/5</td>
                                        </c:when>

                                        <c:otherwise>
                                            <td class="starRating" data-score="${avg}"></td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>

                                <tr>
                                    <th>관련 교재</th>
                                    <td> 교재</td>
                                </tr>
                            </c:forEach>

                        </table>
                    </div>


                    <%--강의 목차--%>
                    <%-- 강의 소개 처럼 따로 jsp파일에 넣어서 해봤는데 잘 안되서 그냥 여기에 코드 넣음 (오세훈) --%>
                    <div id="ud_tab-content2" class="ud_content">
                        <%--<h5> 강의 목차 </h5>--%>
                        <div id="search_from2" class="search_from">
                            <select name="select_filter2" id="select_filter2" class="select_filter">
                                <option value="0">강의번호</option>
                                <option value="1">강의명</option>
                            </select>
                            <input type="text" name="search_filter2" id="search_filter2"
                                   class="search_filter">
                        </div>
                        <table id="myTable2" class="table">
                            <thead>
                            <tr>
                                <th style="width: 15%; text-align: center; vertical-align: middle;">순번</th>
                                <th style="width: 70%; text-align: center; vertical-align: middle;">강의명</th>
                                <%--                                <th style="width: 10%; text-align: center">시간</th>--%>
                                <%--                                <th style="width: 10%; text-align: center">최근 학습일</th>--%>
                                <%--                                <th style="width: 10%; text-align: center">학습 완료</th>--%>
                                <th style="width: 15%; text-align: center; vertical-align: middle;">학습 하기</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="video" items="${videoList }" varStatus="status">
                                <tr>
                                    <td style="text-align: center; vertical-align: middle;">${status.count}</td>
                                    <td class="video-style" style="text-align: center; vertical-align: middle;">${video}</td>
                                        <%--                                    <td>${vtl.get(status.index)} 초</td>--%>
                                    <td style="text-align: center;">
                                        <button type="button" class="button is-info"
                                                onclick="openVideoWindow('${path}/lecture/getLecVideo?sfile=${videoList2.get(status.index)}')"
                                                target="_blank">학습</button>


                                        <%--<a href="javascript:void(0);"
                                           onclick="openVideoWindow('${path}/lecture/getLecVideo?sfile=${videoList2.get(status.index)}')"
                                           target="_blank">학습</a>--%>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>


                    <%--공지사항--%>
                    <div id="ud_tab-content3" class="ud_content">

                        <div class="content" id="content">
                            <div class="row column text-center">
                                <div class="container">
                                    <table id="myTable2">
                                        <thead>
                                        <tr>
                                            <th width="80" style="text-align: center">번호</th>
                                            <th style="text-align: center">제목</th>
                                            <th width="140" style="text-align: center">등록일</th>
                                            <th width="100" style="text-align: center">조회수</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${instructorNotices}" var="notice"
                                                   varStatus="status">
                                            <tr>
                                                <td style="text-align: center">${status.count }</td>
                                                <td style="text-align: center">
                                                    <a href="${path14}/instructor/instructorNoticeDetail.do?noticeNo=${notice.no }&no=${instructor.no}">${notice.title }</a>
                                                </td>
                                                <td style="text-align: center">
                                                    <fmt:parseDate value="${notice.resdate }"
                                                                   var="resdate"
                                                                   pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    <fmt:formatDate value="${resdate }"
                                                                    pattern="yyyy-MM-dd"/>
                                                </td>
                                                <td style="text-align: center">${notice.cnt }</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <c:if test='${sid eq "admin"}'>
                                        <div class="button-group">
                                                <%--<a class="button is-link is-outlined"
                                                   href="${path}/notice/insert.do">글쓰기</a>--%>
                                        </div>
                                    </c:if>

                                </div>

                            </div>
                        </div>
                    </div>


                    <%--QnA--%>
                    <div id="ud_tab-content4" class="ud_content">

                        <div class="container">
                            <table id="myTable2">
                                <thead>
                                <tr>
                                    <th width="80" style="text-align: center">번호</th>
                                    <th style="text-align: center">제목</th>
                                    <th width="140" style="text-align: center">등록일</th>
                                    <th width="100" style="text-align: center">조회수</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${qnaList }" var="board" varStatus="status">
                                    <tr>
                                        <td style="text-align: center">${status.count }</td>
                                        <c:choose>
                                            <c:when test="${empty board.pw || board.pw eq ''}">
                                                <td style="text-align: center">
                                                    <a href="${path}/qna/detail.do?bno=${board.bno}">${board.title}</a>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td style="text-align: center">
                                                    <a href="${path}/qna/qnapw.do?bno=${board.bno}">[비밀글] ${board.title}</a>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>
                                            <fmt:parseDate value="${board.resdate }" var="resdate"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/>
                                            <fmt:formatDate value="${resdate }"
                                                            pattern="yyyy-MM-dd"/>
                                        </td>
                                        <td style="text-align: center">${board.cnt }</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test='${not empty sid}'>
                                <div class="button-group">
                                        <%-- <a class="button is-link is-outlined"
                                            href="${path}/qna/insert.do">글쓰기</a>--%>
                                </div>
                            </c:if>

                        </div>
                    </div>


                    <%--수강 후기--%>
                    <div id="ud_tab-content5" class="ud_content">

                        <table class="table is-fullwidth" id="myTable2">
                            <thead>
                            <tr>
                                <th class="rev"  style="text-align: center">강의</th>
                                <th class="rev" style="text-align: center">점수</th>
                                <th class="rev-con" style="text-align: center">댓글</th>
                                <th class="rev2" style="text-align: center">작성일</th>
                                <%--                            <th class="rev2">비고</th>--%>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="lev" items="${reviewList }">
                                <tr>
                                    <td style="text-align: center">
                                        <a href="${path14}/lecture/getLecture?no=${lev.lno}">${lev.title}</a>
                                    </td>
                                    <td style="text-align: center">${lev.score}</td>
                                    <td style="text-align: center">${lev.content}</td>
                                    <td style="text-align: center">${lev.resdate}</td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>


                    <%--자료실--%>
                    <div id="ud_tab-content6" class="ud_content">

                        <table class="table is-fullwidth" id="myTable2">
                            <thead>
                            <tr>
                                <th width="80" style="text-align: center">번호</th>
                                <th style="text-align: center">제목</th>
                                <th width="140" style="text-align: center">등록일</th>
                                <th width="100" style="text-align: center">조회수</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${instructorFiles}" var="file" varStatus="status">
                                <tr>
                                    <td style="text-align: center">${status.count }</td>
                                    <td style="text-align: center">
                                        <a href="${path14}/instructor/instructorFileDetail.do?fileNo=${file.no }&no=${instructor.no}">${file.title }</a>
                                    </td>
                                    <td style="text-align: center">
                                        <fmt:parseDate value="${file.resdate }" var="resdate"
                                                       pattern="yyyy-MM-dd HH:mm:ss"/>
                                        <fmt:formatDate value="${resdate }" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td style="text-align: center">${file.cnt }</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>


                    </div>


                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const filledStarPath = '${path}/resources/img/star.png';
        const emptyStarPath = '${path}/resources/img/empty_star.png';

        function renderStars($starContainer, score) {
            $starContainer.empty(); // 기존 내용을 지웁니다.
            for (let i = 1; i <= 5; i++) {
                const starPath = i <= score ? filledStarPath : emptyStarPath;
                const $star = $('<img>').attr('src', starPath)
                    .attr('alt', 'star')
                    .width(20)
                    .height(20);
                $starContainer.append($star);
            }
        }

        $('.starRating').each(function () {
            const $this = $(this);
            const score = $this.data('score');
            renderStars($this, score);
        });
    });
</script>

<script>
    $(document).ready(function () {
        $('#myTable').DataTable({
            pageLength: 10,
            order: [[0, 'desc']], // 0번째 컬럼을 기준으로 내림차순 정렬
            info: false,
            dom: 't<f>p',
            language: {
                emptyTable: '등록된 글이 없습니다.'
            }
        });
    });
    $(document).ready(function () {
        $('.dataTables_paginate').css({
            'textAlign': 'left',
            'float': 'none',
            'margin-top': '10px',
        });
        $('.dataTables_filter').css({
            'float': 'left',
            'margin-top': '14px',
            'margin-right': '280px'
        });
        $('#myTable_paginate').css({
            'margin-right': '120px'
        });
    });
</script>

<%-- 강의 창 띄울때 사이즈 조절하는 js 코드 --%>
<script>
    function openVideoWindow(url) {
        var width = 800;
        var height = 400;
        var left = (window.innerWidth - width) / 2;
        var top = (window.innerHeight - height) / 2;

        window.open(url, 'VideoPlayer', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
    }
</script>
<%-- datatables 관련 코드가 들어있는 스크립트 파일 --%>
<script src="${path}/resources/js/myStudy/myclassDetail.js"></script>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>