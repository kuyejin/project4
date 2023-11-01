<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*, java.lang.*" %>
<%@ page import="java.text.*, java.net.InetAddress" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <!-- 헤드 부분 인클루드 -->
    <jsp:include page="../include/head.jsp"></jsp:include>
</head>
<body>
<!-- 헤더 부분 인클루드 -->
<jsp:include page="../include/header.jsp"></jsp:include>
<section class="hero is-white">
    <div class="hero-body has-text-centered">
        <p class="title is-size-3">
        </p>
        <p class="subtitle">

        </p>
    </div>
</section>

<div class="container">
    <div class="columns">
        <jsp:include page="./adminMenu.jsp"></jsp:include>


<%--        -----------------이하 컨텐츠 부분--------------------------   ----%>
        <div class="column is-9">
            <nav class="breadcrumb" aria-label="breadcrumbs">
                <ul>
                    <li><a href="../">Haebeop</a></li>
                    <li class="is-active"><a href="#" aria-current="page">Admin</a></li>
                </ul>
            </nav>
            <section class="hero is-white welcome is-small">
                <div class="hero-body">
                    <div class="container">
                        <h1 class="title" style="text-align: center">
                            강사 등록
                        </h1>
                    </div>
                </div>
            </section>

            <div class="is-fullwidth">
                <form action="${path}/admin/instInsert.do" method="post" enctype="multipart/form-data">
                    <table id="table" style="width: 100%">
                        <tbody>
                        <tr>
                            <th style="background-color:#dcdcdc">아이디</th>
                            <td>
                                <input type="text" name="id" id="id" class="input" placeholder="아이디" maxlength="20" autofocus required>
                                <button type="button" id="ck_btn" class="button is-black is-outlined" onclick="idCheck()">중복확인</button>
                                <input type="hidden" name="idck" id="idck" value="no">
                            </td>
                            <div>
                                <c:if test="${empty qid }">
                                    <p id="msg" style="padding-left:0.5rem">아직 아이디 중복 체크를 하지 않으셨습니다.</p>
                                </c:if>
                                <c:if test="${not empty qid }">
                                    <p id="msg" style="padding-left:0.5rem">아이디 중복 체크후 수정하였습니다.</p>
                                </c:if>
                            </div>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">비밀번호</th>
                            <td>
                                <input type="password" name="pw" id="pw1" class="input" placeholder="비밀번호" maxlength="98" autofocus required>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">비밀번호</th>
                            <td>
                                <input type="password" name="pw2" id="pw2" class="input" placeholder="비밀번호" maxlength="98" autofocus required>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">이름</th>
                            <td>
                                <input type="text" name="name" id="name" class="input" placeholder="이름" maxlength="10" autofocus required>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">생년월일</th>
                            <td>
                                <input type="date" name="birth" id="birth" class="input" placeholder="생일" maxlength="10" autofocus required>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">전화번호</th>
                            <td>
                                <input type="tel" name="tel" id="tel" class="input" placeholder="전화번호" maxlength="18" autofocus required>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">이메일</th>
                            <td>
                                <input type="email" name="email" id="email" class="input" placeholder="이메일" maxlength="98" autofocus required>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">주소</th>
                            <td>
                                <input type="text" name="addr1" id="addr1" placeholder="기본 주소 입력" class="input" required readonly/><br>
                                <input type="text" name="postcode" id="postcode" style="width:160px;float:left;margin-right:20px;" placeholder="우편번호" class="input" readonly><br>
                                <button type="button" id="post_btn" onclick="findAddr()" class="button is-black is-outlined">우편번호 검색</button><br>
                                <input type="text" name="addr2" id="addr2" placeholder="상세 주소 입력" class="input" required /><br>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">담당 과목</th>
                            <td colspan="2">
                                <select name="cate" id="cate" class="select is-fullwidth" autofocus required>
                                    <option value="국어" selected>국어</option>
                                    <option value="수학">수학</option>
                                    <option value="영어">영어</option>
                                    <option value="과학">과학</option>
                                    <option value="사회">사회</option>
                                    <option value="한국사">한국사</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">선생님 설명</th>
                            <td colspan="2"> <textarea name="intro" id="intro" class="textarea" cols="50" rows="4" placeholder="설명 입력" maxlength="39" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th style="background-color:#dcdcdc">선생님 이미지</th>
                            <td colspan="2"><input type="file" name="img" id="img" class="input" placeholder="이미지" accept=".jpg, .png" required></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" class="submit button is-link is-outlined" value="선생님 가입" >
                                <input type="reset" value="취소" class="button is-danger is-outlined" onclick="window.history.back();">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <script>
                $(document).ready(function(){
                    $("#id").keyup(function(){
                        $("#idck").val("no");
                        if($(this).val()!=""){
                            $("#msg").html("<strong>아이디 입력중입니다.</strong>");
                            $("#id").focus();
                        } else {
                            $("#msg").html("아직 아이디 중복 체크를 하지 않으셨습니다.");
                        }
                    });
                });
                function idCheck(){
                    if($("#id").val()==""){
                        alert("아이디를 입력하지 않으셨습니다.");
                        $("#id").focus();
                        return;
                    }
                    var params = {	id : $("#id").val()	} //전송되어질 데이터를 객체로 묶음
                    $.ajax({
                        url:"${path }/admin/idCheck.do",	//아이디가 전송되어질 곳
                        type:"post",		//전송방식
                        dataType:"json",	//데이터 반환 방식
                        data:params,		//전송방식이 post인 경우 객체로 묶어서 전송
                        success:function(result){
                            console.log(result.result);
                            var idChk = result.result;	//true 또는 false를 받음
                            if(idChk==false){	//사용할 수 없는 아이디
                                $("#idck").val("no");
                                $("#msg").html("<strong style='color:red'>기존에 사용되고 있는 아이디 입니다. 다시 입력하시기 바랍니다.</strong>");
                                $("#id").focus();
                            } else if(idChk==true){	//사용 가능한 아이디
                                $("#idck").val("yes");
                                $("#msg").html("<strong style='color:blue'>사용가능한 아이디 입니다.</strong>");
                            } else if(idck==""){
                                $("#msg").html("<strong>아이디가 확인되지 않았습니다. 다시 시도해주시기 바랍니다.</strong>");
                            }
                        }
                    });
                }
            </script>
            <script>
                function joinCheck(f){
                    if(f.pw.value!=f.pw2.value){
                        alert("비밀번호와 비밀번호 확인이 서로 다릅니다.");
                        f.pw.focus();
                        return false;
                    }
                    if(f.idck.value!="yes"){
                        alert("아이디 중복 체크를 하지 않으셨습니다.");
                        return false;
                    }
                }
                function findAddr() {
                    new daum.Postcode({
                        oncomplete: function (data) {
                            console.log(data);
                            var roadAddr = data.roadAddress;
                            var jibunAddr = data.jibunAddress;
                            document.getElementById("postcode").value = data.zonecode;
                            if (roadAddr !== '') {
                                document.getElementById("addr1").value = roadAddr;
                            } else if (jibunAddr !== '') {
                                document.getElementById("addr1").value = jibunAddr;
                            }
                            document.getElementById("addr2").focus();
                        }
                    }).open();
                }
            </script>
            <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        </div>
    </div>
</div>

<footer id="footer" class="footer-nav row expanded collapse">
    <!-- 푸터 부분 인클루드 -->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>
</body>
</html>