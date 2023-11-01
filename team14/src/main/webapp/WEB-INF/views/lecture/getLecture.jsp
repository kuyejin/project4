<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세</title>
    <%@ include file="../include/head.jsp" %>

    <!-- Bulma CSS 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.10.1/css/bulma.min.css">
    <!-- 단일 페이지 사용자 정의 CSS 추가 -->
    <link rel="stylesheet" href="${path}/resources/css/video.css">
    <link rel="stylesheet" href="${path}/resources/css/lec2.css">
    <style>
        /* 사용자 정의 스타일 추가 */
        body {
            background-color: white; /* 페이지 배경색 */
        }
        .product {
            background-color: #fff; /* 상품 배경색 */
            padding: 20px;
            border-radius: 5px;
        }
        .productimg img {
            max-width: 100%;
            border: 5px solid #3273dc; /* 이미지 경계선 */
            border-radius: 5px;
        }
        .productdesc table td {
            font-size: 18px;
            color: #333;
        }
        .inbtn {
            background-color: #3273dc; /* 버튼 배경색 */
            color: #fff; /* 버튼 텍스트 색상 */
        }
        .inbtn:hover {
            background-color: #2558a8; /* 버튼 호버 배경색 */
        }
        table .lec{
            text-align: center;
        }
        .score{
            width: 100%; /* select 태그의 너비를 가로로 꽉 차게 설정 */
            padding: 10px; /* 내부 패딩을 추가하여 텍스트와 경계 사이의 간격을 설정 */
            border: 1px solid #ccc; /* 테두리 스타일 설정 */
            border-radius: 5px; /* 테두리의 모서리를 둥글게 만듭니다. */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
            background-color: #fff; /* 배경색 설정 */
        }
        textarea {
            resize: none;
        }
        #myTable td{
            text-align: center; /* 가로 가운데 정렬 */
            vertical-align: middle; /* 세로 가운데 정렬 */
        }
        .rev{
            width: 10%;
        }
        .rev2{
            width: 20%;
        }
        .rev-con {
            width: 40%;
        }
        #myTable th {
            text-align: center;
        }
    </style>
</head>

<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../include/header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">강의 상세</h2>
                <div class="product">
                    <div class="productimg">
                        <h3>OT(맛보기 영상)</h3>
                        <c:if test="${not empty pro.sfile1}">
                            <div class="player">
                                <div class="vdo_fr">
                                    <video id="video">
                                        <source src="${path}/resources/upload/${pro.sfile1}" type="video/mp4" />
                                    </video>
                                </div>
                                <div id="timebar">
                                    <span id="currentTime"></span>
                                </div>
                                <div id="buttonbar">
                                    <button id="restart" class="player_btn"></button>
                                    <button id="rew" class="player_btn"></button>
                                    <button id="play" class="player_btn"></button>
                                    <button id="pause" class="player_btn"></button>
                                    <button id="stop" class="player_btn"></button>
                                    <button id="fastFwd" class="player_btn"></button>
                                    <button id="mute" class="player_btn"></button>
                                    <button id="unmute" class="player_btn"></button>
                                    <input id="vol" type="range" value="500" min="0" max="1000">
                                    <button id="vmup" class="player_btn"></button>
                                    <button id="vmdown" class="player_btn"></button>
                                    <button id="volTxt">100%</button>
                                    <button id="sizeup" class="player_btn"></button>
                                    <button id="sizedown" class="player_btn"></button>
                                    <button id="full" class="player_btn"></button>
                                    <button id="original" class="player_btn"></button>
                                </div>
                                <div id="progress">
                                    <div id="progressBar"></div>
                                </div>
                            </div>
                        </c:if>
                        <script src="${path}/resources/js/vdo.js"></script>
                    </div>
                    <div class="productdesc">
                        <table class="table is-fullwidth">
                            <tr class="pname">
                                <th colspan="2">${pro.title}</th>
                            </tr>
                            <tr>
                                <th>과목</th>
                                <td>${pro.cate}</td>
                            </tr>
                            <tr>
                                <th>강좌 수준</th>
                                <td>${pro.slevel}</td>
                            </tr>
                            <tr>
                                <th>수강 기간</th>
                                <td>${pro.endDay} 일</td>
                            </tr>
                            <tr>
                                <th>수강료</th>
                                <td>${pro.price}</td>
                            </tr>
                            <tr>
                                <th>강사</th>
                                <td>${inst.name}</td>
                            </tr>
                            <tr>
                                <th>평점</th>
                                <c:choose>
                                    <c:when test="${empty avg || avg eq ''}">
                                        <td>0/5</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${avg}/5</td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <th>영상 수</th>
                                <td>${cnt}</td>
                            </tr>
                            <tr class="pbtn">
                                <c:if test="${not empty sid and isInst == false}">
                                <c:set var="isLiked" value="${likedProductIds.contains(pro.no)}" />
                                <td colspan="2">
                                    <a href="${path}/payment/addPayment.do?lec_no=${pro.no}" class="button is-success inbtn">수강신청</a>
                                    <a href="${path}/cart/cartInsert.do?lec_no=${pro.no}" class="button is-info inbtn">장바구니</a>
                                    <c:choose>
                                    <c:when test="${isLiked}">
                                    <a href="javascript:void(0);" onclick="toggleLike(${pro.no}, '${sid}');" class="inbtn is-link is-outlined likes" data-product-id="${pro.no}" style="color: #ff5050">♥</a>
                                    </c:when>
                                    <c:otherwise>
                                    <a href="javascript:void(0);" onclick="toggleLike(${pro.no}, '${sid}');" class="inbtn is-link is-outlined likes" data-product-id="${pro.no}" style="color: #b4b4b4">♥</a>
                                    </c:otherwise>
                                    </c:choose>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td class="adminbtn">
                                    <c:if test="${sid eq 'admin'}">
                                        <a href="${path }/lecture/updateLectureForm.do?no=${pro.no }" class="button is-info is-outlined">수정</a>
<%--                                        <a href="${path}/DeleteProduct.do?no=${pro.no}" class="button is-danger is-outlined">삭제</a>--%>
                                    </c:if>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <script>
                    function toggleLike(productNo, id) {
                        $.ajax({
                            url: "${path}/lecture/lectureLike.do",
                            method: "POST",
                            data: {
                                lno: productNo,
                                sid: id
                            },
                            success: function(response) {
                                var likeButton = $("[data-product-id='" + productNo + "']");

                                if (response.trim() === "liked") {
                                    alert("상품을 좋아요 했습니다!");
                                    likeButton.css("color","#ff5050");
                                } else if (response.trim() === "unliked") {
                                    alert("상품의 좋아요를 취소했습니다.");
                                    likeButton.css("color","#b4b4b4");                                                } else {
                                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                                }
                            }
                        });
                    }
                    $(document).ready(function() {
                        // 좋아요 상태를 기반으로 버튼 색 변경
                        $(".likes").each(function() {
                            var isLiked = $(this).hasClass("liked");
                            if (isLiked) {
                                $(this).addClass("liked");
                            }
                        });
                    });
                </script>

                <table class="table is-fullwidth">
                    <thead>
                        <tr class="title">
                            <th colspan="5">강의 설명</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="adminbtn" colspan="5">
                                ${pro.content}
                                <br><br><br>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <table class="table is-fullwidth">
                    <thead>
                        <tr class="title">
                            <th colspan="5">강의 영상</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="video" items="${videoList }" varStatus="status">
                            <tr>
                                <td class="adminbtn" colspan="5">
                                    ${status.count}. &nbsp; ${video}
                                    <br><br>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <table class="table is-fullwidth" id="myTable">
                    <thead>
                        <tr class="title">
                            <th colspan="5">후기</th>
                        </tr>
                        <tr>
                            <th class="rev">작성자</th>
                            <th class="rev">점수</th>
                            <th class="rev-con">댓글</th>
                            <th class="rev2">작성일</th>
                            <th class="rev2">비고</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="lev" items="${revList }">
                            <tr>
                                <td>${lev.id}</td>
                                <td class="starRating" data-score="${lev.score}"></td>
                                <td>${lev.content}</td>
                                <td>
                                    <fmt:parseDate value="${lev.resdate}" var="resdate" pattern="yyyy-MM-dd HH:mm:ss" />
                                    <fmt:formatDate value="${resdate}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>
                                    <c:if test="${sid eq lev.id || sid eq 'admin'}">
                                        <a href="${path}/review/updateReviewForm.do?par=${pro.no}" class="button is-info" style="height: 31px">수정</a>
                                        <a href="${path}/review/deleteReview.do?par=${pro.no}" class="button is-danger"style="height: 31px"> 삭제 </a>
                                    </c:if>
                                    <c:if test="${not empty sid }">
                                        <button class="button is-danger is-hovered" onclick="openReportPopup()">
                                            <img src="${path1}/resources/img/report.png" alt="!" style="height: 20px; margin-right: 6px">신고</button>
                                        <script>
                                            function openReportPopup() {
                                                // 팝업 창의 크기 및 위치를 지정합니다. 필요에 따라 조절할 수 있습니다.
                                                let width = 550;
                                                let height = 300;
                                                let left = (screen.width/2) - (width/2);
                                                let top = (screen.height/2) - (height/2);
                                                window.open('${path}/review/reportPopup.do?bno=${lev.no}&id=${sid}', '신고', 'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left);
                                            }
                                        </script>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <script>
                    $(document).ready(function() {
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

                        $('.starRating').each(function() {
                            const $this = $(this);
                            const score = $this.data('score');
                            renderStars($this, score);
                        });
                    });
                </script>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable({
                            // sorting 화살표 제거
                            "targets": 'no-sort',
                            "bSort": false,

                            // 3번째 컬럼을 기준으로 내림차순 정렬
                            order: [[3, 'asc']],
                            pageLength : 5,
                            searching: false, //검색 제거
                            lengthChange: false, // show entries 제거
                            info: false,
                            language: {
                                emptyTable: '작성된 후기가 없습니다.'
                            }
                        });
                        $('#myTable').css({
                            'border':'none',
                        });
                    } );
                </script>
                <form action="${path}/review/insertReview.do" id="login_frm" class="frm" method="post">
                    <table class="table is-fullwidth">
                        <tbody>
                            <c:choose>
                                <c:when test="${check == 1}">
                                    <tr>
                                        <th>
                                            <label for="score">점수</label>
                                        </th>
                                        <td colspan="5">
                                            <select name="score" id="score" class="score" required>
                                                <option value="5" selected>5</option>
                                                <option value="4">4</option>
                                                <option value="3">3</option>
                                                <option value="2">2</option>
                                                <option value="1">1</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="submit" value="작성" class="button is-success inbtn" id="ans_btn">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="content">후기</label>
                                        </th>
                                        <td colspan="5">
                                            <textarea name="content" id="content" class="textarea" placeholder="리뷰 작성" required></textarea>
                                        </td>
                                    </tr>
                                    <input type="hidden" name="par" value="${pro.no}" readonly>
                                </c:when>
                                <c:otherwise>
                                    <p id="nologin_comment">수강생 및 리뷰를 작성하지 않은 사람만 작성 가능합니다.</p>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </form>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../include/footer.jsp" %>
    </footer>
    <script src="/resources/js/vdo.js"></script>
</div>
</body>
</html>
