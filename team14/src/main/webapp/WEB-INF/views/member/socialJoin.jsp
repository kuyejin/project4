<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- /web/member/login.jsp -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소셜 회원가입</title>
    <jsp:include page="../include/head.jsp"></jsp:include>

    <!-- mobile responsive meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- theme meta -->
    <meta name="theme-name" content="kross-bulma"/>

    <!-- ** Plugins Needed for the Project ** -->
    <!-- bulma -->
    <link rel="stylesheet" href="${path}/resources/theme/plugins/bulma/bulma.min.css">
    <!-- slick slider -->
    <link rel="stylesheet" href="${path}/resources/theme/plugins/slick/slick.css">
    <!-- themefy-icon -->
    <link rel="stylesheet" href="${path}/resources/theme/plugins/themify-icons/themify-icons.css">

    <!-- Main Stylesheet -->
    <link href="${path}/resources/theme/css/style.css" rel="stylesheet">

    <!--Favicon-->
    <link rel="shortcut icon" href="${path}/resources/theme/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/theme/images/favicon.ico" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

    <style>
        @charset "UTF-8";

        * {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            box-sizing: border-box;
        }

        .content{
            margin: 0 auto;
            padding: 30px;
            clear: both;
            width: 80%;
            box-sizing: border-box;
            background: #fff;
            color: #000;
            height: auto;
            text-align: center;
        }

        a{
            text-decoration: none;
            color: black;
        }


        ul,ol,li {
            list-style: none;
        }



        .title_1{
            margin-top:20px;
            font-size:30px;
            font-weight: bold;
        }


        .titie_2{
            margin-top:20px;
            font-size:25px;
            font-weight: bold;
        }


        .title_3{
            margin: 0 auto;
            padding: 10px;
            width: 70%;
            border-radius: 7px;
            font-size:25px;
            font-weight: bold;
            background-color: rgb(92, 89, 89);
            color: #fff;
        }


        .footBtwrap{margin-top: 15px;}
        .footBtwrap>li{float: left;width: 50%;height: 60px;}
        .footBtwrap>li>button{display: block; width: 80%;height: 100%; font-size: 20px;text-align: center;line-height: 60px;}
        .fpmgBt1{background-color: #fff;color:black;   }
        .fpmgBt2{background-color: #0093FF; color: #fff;    }



    </style>


    <link rel="stylesheet" href="${path}/css/ft.css">
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<div class="wrap">
    <section class="hero is-white is-medium">
        <div class="hero-body has-text-centered">
            <p class="title is-size-3">소셜 회원 가입</p>
        </div>
    </section>

    <div class="content">


        <div class="title">
            <img src ="${path}/resources/img/smart_haebeop_logo.png" style="vertical-align:middle;">
            <span class="title_1"> 에 오신 것을 환영합니다!</span>

            <br><br>

            <span class="titie_2" style=""> Naver 계정으로 해법을 이용하실 수 있습니다! </span>

            <br><br><br>

            <div class="title_3">
                <p style="color: #fff; font-size:25px; font-weight: bold;">${socialEmail}</p>
            </div>
        </div>


        <br><br><br>
        <form action="${path}/member/naverJoin.do" method="post">
            <input type="hidden" name="socialEmail" value="${socialEmail}">
            <input type="hidden" name="socialName" value="${socialName}">
            <input type="hidden" name="socialTel" value="${socialTel}">

            <div class="check-menu-box" style="text-align: left; padding-left: 350px;">
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox1" name="checkAll" />
                    <label for="checkbox1">약관에 모두 동의</label>
                </div>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox2" name="checkOne" />
                    <label for="checkbox2">(필수) 만 14세 이상입니다</label>
                </div>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox3" name="checkOne" />
                    <label for="checkbox3">(필수) 서비스 이용약관에 동의</label>
                </div>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox4" name="checkOne" />
                    <label for="checkbox4">(필수) 개인정보 수집이용에 동의</label>
                </div>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox5" name="checkOne" />
                    <label for="checkbox5">(선택) 광고 수신 및 마케팅 이용에 동의</label>
                </div>
            </div>


            <br><br>

            <button type="reset" class="btn btn-outline-secondary "   style="    width: 200px;
                height: 50px;
                font-size: 20px;">취소</button>
            <button type="submit" class="btn btn-primary "  style="    width: 200px;
                height: 50px;
                font-size: 20px;">회원가입</button>


            <!-- <ul class="footBtwrap clearfix">
                <button type="button" class="btn btn-primary" type="submit">Primary</button>
                <li><button class="fpmgBt2" type="reset">가입 취소</button></li>
                <li><button class="fpmgBt1"  type="submit">가입 완료</button></li>

            </ul>
 -->

        </form>

    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

    <script>
        // 모두 => 동기화
        function allCheckFunc( obj ) {
            $("[name=checkOne]").prop("checked", $(obj).prop("checked") );
        }

        // 체크박스 체크시 전체선택 체크 여부
        function oneCheckFunc( obj )
        {
            var allObj = $("[name=checkAll]");
            var objName = $(obj).attr("name");

            if( $(obj).prop("checked") )
            {
                checkBoxLength = $("[name="+ objName +"]").length;
                checkedLength = $("[name="+ objName +"]:checked").length;

                // console.log("checkBoxLength : " + checkBoxLength + ", checkedLength : " + checkedLength);
                // 확인용

                if( checkBoxLength == checkedLength ) {
                    allObj.prop("checked", true);
                } else {
                    allObj.prop("checked", false);
                }
            }
            else
            {
                allObj.prop("checked", false);
            }
        }

        $(function(){
            $("[name=checkAll]").change(function(){
                allCheckFunc( this );
            });

            $("[name=checkOne]").change(function(){
                oneCheckFunc($(this));
            });
        });
    </script>


</div>
<jsp:include page="../include/footer.jsp"></jsp:include>
</div>
</body>
</html>