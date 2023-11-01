<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="path" value="<%=request.getContextPath() %>" />
<style>
    .text02{
        margin-bottom: 20px;
    }
    .text03{
        margin-top: 10px;
        margin-bottom: 20px;
    }
    .imgsize{
        width:1200px;
        height:800px;
    }
</style>

<section class="section has-background-primary is-relative testimonial-bg-shapes">
    <div class="container">
        <div class="has-text-centered">
            <h2 class="section-title has-text-grey">서비스 소개</h2>
        </div>
        <div class="columns is-centered">
            <div class="column is-10 testimonial-slider">
                <!-- slider-item01 -->
                <div class="has-text-centered">
                    <h3 class="has-text-grey text02">새로운 공부</h3>
                    <img class="imgsize" src="${path}/resources/img/learning.jpg" alt="slide-image">
                    <br>
                    <h4 class="has-text-grey text03">
                        기존의 따분한 공부에서 벗어나세요.<br>
                        스마트 해법은 언제나 수강생을 생각해서 딱 맞는 솔루션을 제공합니다.
                    </h4>
                </div>
                <!-- slider-item02 -->
                <div class="has-text-centered">
                    <h3 class="has-text-grey text02">진짜 커뮤니티</h3>
                    <img class="imgsize" src="${path}/resources/img/slidebanner02.png" alt="slide-image">
                    <br>
                    <h4 class="has-text-grey text03">
                        학생, 그리고 교사들이 모여 정보를 공유하고 소통할 수 있는 공간입니다.<br>
                        다양한 게시판을 통해 자유롭게 의견을 나누고, 정보를 교환하세요.
                    </h4>
                </div>
                <!-- slider-item03 -->
                <div class="has-text-centered">
                    <h3 class="has-text-grey text02">압도적 실력 향상</h3>
                    <img class="imgsize" src="${path}/resources/img/score.jpg" alt="slide-image">
                    <br>
                    <h4 class="has-text-grey text03">
                        스마트 해법만의 특화된 교육으로 자녀, 자신의 실력을 높이세요.<br>
                        수 많은 강사진이 여러분들을 기다리고 있습니다.
                    </h4>
                </div>
            </div>
        </div>
    </div>
</section>