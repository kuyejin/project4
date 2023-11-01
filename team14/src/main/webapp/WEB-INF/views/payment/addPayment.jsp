<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="<%=request.getContextPath() %>" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수강 신청</title>
    <%@ include file="../include/head.jsp" %>

    <!-- 결제 api -->
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <style>
        .hero {
            height: 250px;
            margin-top: 40px;
        }

        /* 결제 버튼 스타일 */
        #pay, #buy {
            width: 100%;
        }
        .label {
            font-size: 16px; /* 원하는 크기로 조정하세요 */
        }

        /* Input 스타일링 */
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border: 1px solid #007BFF; /* 원하는 포커스 색상으로 조정하세요 */
        }
    </style>
</head>
<body>
<div class="container is-fullhd">
    <!-- 헤더 부분 인클루드 -->
    <jsp:include page="../include/header.jsp"></jsp:include>
    <figure class="visual" id="vs1">
        <ul class="imgbox">
            <li class="hero is-medium is-white">
                <div class="hero-body has-text-centered">
                    <p class="title is-size-3">
                        수강
                    </p>
                    <p class="subtitle is-size-5">
                        신청
                    </p>
                </div>
            </li>
        </ul>
    </figure>
    <div class="columns is-centered">
        <div class="column is-half">
            <form action="${path}/payment/addPayment.do" method="post">
                <div class="columns">
                    <div class="column is-half">
                        <div class="box">
                            <h3 class="title is-4">강의 정보</h3>
                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">강의 과목</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <input type="hidden" name="lec_no" id="no" value="${pro.no}">
                                            <span class="is-capitalized">${pro.cate}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">강의 명</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <span>${pro.title}</span>
                                            <input type="hidden" name="lec_name" id="lec_name" value="${pro.title}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">강사</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <span>${inst.name}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">가격</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <span>${pro.price}</span>
                                            <input type="hidden" name="price" id="price" value="${pro.price}">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">포인트 사용</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <input type="text" value="사용 가능 포인트 : ${member.pt}" readonly>
                                            <input type="number" name="pt" id="point" value="0" max="${member.pt}">
                                            <div class="help is-danger" id="point-check"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">실 결제 금액</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <div id="val-result"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">남은 수강인원</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <span>${pro.lec_max - pro.lec}</span>
                                            <input type="hidden" name="lec" id="lec" value="1" readonly/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="column is-half">
                        <div class="box">
                            <h3 class="title is-4">결제 정보</h3>
                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">결제 수단</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <div class="select">
                                                <select name="pmethod" id="pmethod" required>
                                                    <option value="신용카드">신용카드</option>
                                                    <option value="체크카드">체크카드</option>
                                                    <option value="계좌이체">계좌이체</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">결제사</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <div class="select">
                                                <select name="pcom" id="pcom" required>
                                                    <option value="">선택안함</option>
                                                </select>
                                            </div>
                                            <input type="hidden" name="pcom2" id="pcom2" value="">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class=" is-normal">
                                    <label class="label">결제 번호</label>
                                </div>
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <input type="text" name="cnum" id="cnum" required>
                                            <input type="hidden" name="payAmount" id="payAmount">
                                            <input type="hidden" name="payCk" id="payCk" value="no">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="field ">
                                <div class="field-body">
                                    <div class="field">
                                        <div class="control">
                                            <div class="control">
                                                <input type="button" id="pay" value="결제" class="button is-link is-outlined">
                                            </div>
                                        </div>
                                        <div>
                                            <p id="paymentResult" class="has-text-danger is-size-4"></p>
                                        </div>
                                        <div class="control">
                                            <div class="control">
                                                <input type="submit" id="buy" class="button is-link is-outlined" value="구매">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        var cardArr1 = ["현대카드","농협카드","BC카드","KB카드","삼성카드"];
        var cardArr2 = ["하나카드","농협카드","BC카드","KB카드","신한카드"];
        var bankArr = ["카카오뱅크","농협은행","신한은행","기업은행","국민은행"];
        $("#pmethod").change(function(){
            var th = $(this).val();
            $("#pcom").empty();
            if(th==="신용카드"){
                for(var i=0;i<cardArr1.length;i++) {
                    $("#pcom").append("<option value='" + cardArr1[i] + "'>" + cardArr1[i] + "</option>");
                }
            } else if(th==="체크카드"){
                for(var i=0;i<cardArr2.length;i++) {
                    $("#pcom").append("<option value='"+cardArr2[i]+"'>"+cardArr2[i]+"</option>");
                }
            } else {
                for(var i=0;i<bankArr.length;i++) {
                    $("#pcom").append("<option value='"+bankArr[i]+"'>"+bankArr[i]+"</option>");
                }
            }
        }).change();
        $("#pcom").change(function(){
            $("#pcom2").val($(this).val());
        });
    });
</script>
<script>
    //주소 연동 API
    function findAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
                var roadAddr = data.roadAddress;
                var jibunAddr = data.jibunAddress;
                document.getElementById("postcode").value = data.zonecode;
                if(roadAddr !== '') {
                    document.getElementById("address1").value = roadAddr;
                } else if(jibunAddr !== ''){
                    document.getElementById("address1").value = jibunAddr;
                }
                document.getElementById("address2").focus();
            }
        }).open();
    }
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //결제모듈 API 연동
    $(document).ready(function(){
        var totalPay=0;
        var proName;
        $("#pay").click(function(){
            // 포인트가 제대로 됐는지 체크
            var point = $('#point').val();
            var maxPoint = $('#point').attr('max');
            // console.log(point);
            // console.log(maxPoint);
            if(parseInt(point) > parseInt(maxPoint)) {
                alert("사용할 포인트를 수정해주세요");
                $("#point").focus();
                return false;
            }

            var pcom = $('#pcom').val();
            if(pcom == '') {
                alert('결제사를 선택 해주세요');
                $('#pcom').focus();
                return false;
            }

            // 카드 번호 입력 확인
            var cnum = $('#cnum').val();
            if(cnum == '') {
                alert("카드 번호를 입력해주세요");
                $("#cnum").focus();
                return false;
            }

            var email = $("#email").val();
            var cname = $("#name").val();
            var tel = $("#tel").val();
            var postcode = $("#postcode").val();
            proName = $("#proName").val();
            if($("#amount").val()!="") {
                totalPay = parseInt($("#price").val());
            } else {
                alert("구매할 수량을 입력하지 않으셨습니다.");
                $("#amount").focus();
                return;
            }
            alert("결제할 금액 : "+totalPay);
            //상품명_현재시간
            var d = new Date();
            var date = d.getFullYear()+''+(d.getMonth()+1)+''+d.getDate()+''+d.getHours()+''+d.getMinutes()+''+d.getSeconds();
            var IMP = window.IMP; // 생략가능
            IMP.init('imp85122075'); // 결제 API를 사용하기 위한 코드 입력!
            IMP.request_pay({		//결제 요청
                pg: "T5102001",
                merchant_uid : '상품명_' + date, //상점 거래 ID
                name : proName,				// 결제 명
                amount : totalPay,					// 결제금액
                buyer_email : email, // 구매자 email
                buyer_name : cname,				// 구매자 이름
                buyer_tel : tel,		// 구매자 전화번호
                buyer_postcode : postcode			// 구매자 우편번호
            }, function(rsp){
                if(rsp.success){
                    console.log(rsp);
                    var msg = '결제가 완료 되었습니다.';
                    var r1 = '고유 아이디 : ' +rsp.imp_uid;
                    var r2 = '상점 거래 아이디 : ' +rsp.merchant_uid;
                    var r3 = '결제 금액 : ' +rsp.paid_amount;
                    var r4 = '카드 승인 번호 : '+rsp.apply_num;

                    // 실제 결제 창
                    // $("#payCk").val("yes");
                    // $("#payAmount").val(rsp.paid_amount);
                    // $("#pmethod").val(rsp.pay_method);
                    // $("#pcom").val(rsp.pg_provider);
                    // $("#cnum").val(rsp.apply_num);
                    // alert(msg);
                    // $("#paymentResult").html(r1+"<br>"+r2+"<br>"+r3+"<br>"+r4);
                } else{
                    //$("#paymentResult").html('결제실패<br>'+'에러내용 : ' +rsp.error_msg);
                }
                //테스트용이므로 실패시에도 그냥 통과시킴
                $("#payCk").val("yes");
                $("#payAmount").val(totalPay);
                // $("#pmethod").val("신용카드");
                // $("#pcom").val("삼성카드");
                // $("#cnum").val("123-1234-1234-1278");
                $("#paymentResult").text("결제 완료 : "+totalPay);
            });
        });
    });
</script>
<script>
    function payCheck(f){
        var payCk = f.payCk.value;
        console.log(payCk);
        if(payCk!="yes"){
            alert("아직 결제 전 입니다.");
            return false;
        }
    }
</script>
<script>
    $(document).ready(function() {
        // 초기 페이지 로딩 시, 계산하고 결과를 표시
        calculateAndDisplayResult();

        // 사용자가 point를 조정할 때 이벤트 처리
        $('#point').on('input', function() {
            calculateAndDisplayResult();
        });

        function calculateAndDisplayResult() {
            var proPrice = parseInt($('#price').val()); // pro.price 값을 가져옴
            var memberPoints = parseInt($('#point').val()); // point 값을 가져옴
            var maxPoints = parseInt($('#point').attr('max')); // max 속성에서 최대 포인트 값을 가져옴

            if (!isNaN(proPrice) && !isNaN(memberPoints)) {
                if(memberPoints > maxPoints) {
                    memberPoints = maxPoints;
                    $('#point-check').text(`고객님이 사용할 수 있는 포인트가 초과되었습니다.`).css('color','red');
                } else {
                    $('#point-check').text(``);
                }
                var result = proPrice - memberPoints;
                if (result < 0) {
                    result = 0; // 만약 음수가 되면 0으로 설정
                }
                $('#val-result').text(result);
            } else {
                $('#val-result').text("계산 불가"); // 유효한 숫자가 아닌 경우 표시
            }
        }
    });
</script>
<!-- footer imclude -->
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>