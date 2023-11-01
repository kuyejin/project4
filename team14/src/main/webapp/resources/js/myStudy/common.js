/***************************************************************************************
**********************************  Form Element Style **********************************
****************************************************************************************/

// make selectbox
function makeSelect(obj, fn) {
    if(obj.parent().hasClass("selectStyle")) {
        return false;
    }

    // 부모창이 보이지 않을때 리턴 (레이어 팝업 클래스 변경해야함)
    if(obj.closest('.popupWrap').css('display') == 'none'){
            return;
    }

    // 부모 감싸기
    obj.wrap('<div class="selectStyle"></div>');
    obj.after('<ul class="selectList"></ul>');


    $selectBox = obj.closest('.selectboxWrap').eq(0);
    $selectBox.find('.selectStyle').each(function(){
        //select가 selected일때 a태그로 추출
        $(this).find('.select').after('<a href="#" class="selectResult">'+$(this).find('.select option:selected').text()+'</a>');

        $(this).find('.selectResult').width(obj.closest('.selectboxWrap').eq(0).width() - 22);
        $(this).find('.selectList').width(obj.closest('.selectboxWrap').eq(0).width() - 2);

        for(var i=0;i<=$(this).find('.select option').length-1;i++){
            var value = $(this).find('.select option').eq(i).attr('value');

            if(value){
                value = ' data-value="' + value + '"';
            }else{
                value = '';
            }

            $(this).find('.selectList').append('<li><a href="#"' + value + ' >'+$(this).find('.select option').eq(i).text()+'</a></li>');

        }

        if($(this).find('select').find('>option').length > 11){
            $(this).find('.selectList').addClass('maxHeight');
        }

        //option에 selected 일때
        $(this).find('select').find('>option').each(function(idx, obj){
            if($(obj).is(':selected')){
                var index = $(obj).index();

                $(this).closest($selectBox).find('.selectList > li').removeClass('on');
                $(this).closest($selectBox).find('.selectList > li').eq(index).addClass('on');
            }
        });

        // select option 정의
        $(this).find('.selectList > li').each(function(idx, obj){
            if($(obj).hasClass('on')){
                $(obj).attr('data-selected', true);
            }
            else{
                $(obj).attr('data-selected', false);
            }
        });

        //select가 disabled 일때
        if($(this).find('.select').is(':disabled')){
            $(this).find('.selectResult').addClass('disabled');

            return;
        }

    });

    $selectBox.find('.selectResult').off('click').on({
        click : function(e){
            e.preventDefault();
            var windowInnerHeight = window.innerHeight || $(window).height();
            var $list = $(this).next('.selectList');

            //select가 disabled 일때
            if($(this).prev('.select').is(':disabled')){
                $list.removeClass('on');

                return;
            }

            if($list.hasClass('on')){
                $list.removeClass('on').hide().css({zIndex: 5});
            }
            else{
                $('.selectStyle').find('.selectList').removeClass('on').hide().css({zIndex: 5});
                $list.addClass('on').show().css({zIndex: 10});

                setTimeout(function(){
                    if($list.find('>li[data-selected=true]').length > 0){
                        $list.find('>li[data-selected=true] a').focus();
                    }
                }, 0);
            }

            // 위치 체크
            if($(this).next('.selectList').hasClass('reversal')){
                $list.addClass('reversal');
            }else{
                if(windowInnerHeight > $list.height() && $(this).offset().top + $(this).height() + $list.height() - $(window).scrollTop() > windowInnerHeight){
                    $list.addClass('reversal');
                }else{
                    $list.removeClass('reversal');
                }
            }

            // 타켓이 바깥일 경우
            $(document).off('click').on('click' , function(e){
                if($(e.target).next(".selectList").size() == 0) {
                    $('.selectStyle').find('.selectList').removeClass('on').hide().css({zIndex: 5});
                }
            });
        }
    });
    $selectBox.find('.selectList li a').on({
        click : function(e){
            e.preventDefault();
            var selectText = $(this).text();
            var idx = $(this).closest('li').index();

            $(this).closest('.selectStyle').find('.selectResult').text(selectText);

            var $selectStyle = $(this).closest('.selectStyle');

            $(this).closest('.selectList').removeClass('on').hide().css({zIndex: 5});

            //selected 초기화..
            $selectStyle.find('.select option').prop('selected', false);
            $selectStyle.find('.select option').eq(idx).prop('selected' , 'selected');
            $selectStyle.find('.select').trigger("change");
            $selectStyle.find('.selectList li').attr({'data-selected': false}).removeClass('on');
            $(this).closest('li').attr({'data-selected': true}).addClass('on');
            $selectStyle.find('.selectResult').eq(0).focus();
            $(this).closest('.selectStyle').find('.selectResult').focus();

            fn && fn(); //callback

        }
    });
}

//make selectbox reFresh
function selectBoxReFresh(){

    $selectBox = $('.select').closest('.selectboxWrap');
    $selectBox.find('.selectStyle').each(function(){

        $(this).find('.selectList').find('li').remove();

        for(var i=0;i<=$(this).find('.select option').length-1;i++){
            var value = $(this).find('.select option').eq(i).attr('value');

            if(value){
                value = ' data-value="' + value + '"';
            }else{
                value = '';
            }

            $(this).find('.selectList').append('<li><a href="#"' + value + ' >'+$(this).find('.select option').eq(i).text()+'</a></li>');

        }

        if($(this).find('select').find('>option').length > 11){
            $(this).find('.selectList').addClass('maxHeight');
        }

        //option에 selected 일때
        $(this).find('select').find('>option').each(function(idx, obj){
            if($(obj).is(':selected')){
                var index = $(obj).index();

                $(this).closest($selectBox).find('.selectList > li').removeClass('on');
                $(this).closest($selectBox).find('.selectList > li').eq(index).addClass('on');
            }
        });

        // select option 정의
        $(this).find('.selectList > li').each(function(idx, obj){
            if($(obj).hasClass('on')){
                $(obj).attr('data-selected', true);
            }
            else{
                $(obj).attr('data-selected', false);
            }
        });

        //select가 disabled 일때
        if($(this).find('.select').is(':disabled')){
            $(this).find('.selectResult').addClass('disabled');

            return;
        }

    });

    $selectBox.find('.selectList li a').off('click').on({
        click : function(e){
            e.preventDefault();
            var selectText = $(this).text();
            var idx = $(this).closest('li').index();

            $(this).closest('.selectStyle').find('.selectResult').text(selectText);

            var $selectStyle = $(this).closest('.selectStyle');

            $(this).closest('.selectList').removeClass('on').hide().css({zIndex: 5});

            //selected 초기화..
            $selectStyle.find('.select option').prop('selected', false);
            $selectStyle.find('.select option').eq(idx).prop('selected' , 'selected');
            $selectStyle.find('.select').trigger("change");
            $selectStyle.find('.selectList li').attr({'data-selected': false}).removeClass('on');
            $(this).closest('li').attr({'data-selected': true}).addClass('on');
            $selectStyle.find('.selectResult').eq(0).focus();
            $(this).closest('.selectStyle').find('.selectResult').focus();

        }
    });
}

//make checkbox
function makeCheckbox(obj) {
    if(obj.parent().hasClass("checkStyle")) {
        return false;
    }

    // 부모 감싸기
    obj.wrap('<span class="checkStyle"></span>');

    var checkbox = obj.parent();

    // 체크파악
    checkbox.each(function(){
        if($(this).find('.inputCheckbox').is(':checked') == true){
            $(this).closest('.checkStyle').addClass('on');
        }
        // 선택 불가
        if($(this).find('.inputCheckbox').is(':disabled') == true){
            $(this).closest('.checkStyle').addClass('disabled');
        }
    });

    checkbox.find('.inputCheckbox').on({
        change : function(){
            if($(this).is(':checked') == true){
                $(this).closest('.checkStyle').addClass('on');
            }
            else{
                $(this).closest('.checkStyle').removeClass('on');
            }
        },
        focusin : function(){
            $(this).closest('.checkStyle').addClass('focus');
        },
        focusout : function(){
            $(this).closest('.checkStyle').removeClass('focus');
        }
    });
}

//make radio
function makeRadio(obj) {
    if(obj.parent().hasClass("radioStyle")) {
        return false;
    }
    // 부모 감싸기
    obj.wrap('<span class="radioStyle"></span>');

    var radioStyle = obj.parent();
    // 체크파악
    radioStyle.each(function(){
        if($(this).find('.inputRadio').is(':checked') == true){
            $(this).closest('.radioStyle').addClass('on');
        }
        // 선택 불가
        if($(this).find('.inputRadio').is(':disabled') == true){
            $(this).closest('.radioStyle').addClass('disabled');
        }
    });

    radioStyle.find('.inputRadio').on({
        click : function(){
            //console.log('click');
            if($(this).is(':checked') == true){
                $('input:radio[name='+$(this).attr('name')+']').closest('.radioStyle').removeClass('on');
                $(this).closest('.radioStyle').addClass('on');
            }
        },
        focusin : function(){
            $(this).closest('.radioStyle').addClass('focus');
        },
        focusout : function(){
            $(this).closest('.radioStyle').removeClass('focus');
        }
    });
}

//make placeholder
function makePlaceholder(){
    var havePlaceholder = false;
    var input = document.createElement('input');
    havePlaceholder = ('placeholder' in input);
    var selectEl;

    selectEl = $('input[type=text], input[type=password], textarea:not(.noPlaceholderGuide)');

    if(!havePlaceholder){
        selectEl.each(function(idx, obj){
            havePlaceholder = $(this).attr('placeholder');

            if(havePlaceholder){
                var _this = $(this);
                var _thisWidth  = _this.outerWidth();
                var placeholderAttr = 'placeholder';
                var placeholderText = _this.attr(placeholderAttr);


                // 부모창이 보이지 않을때 리턴 (레이어 팝업 클래스 변경해야함)
                if(_this.closest('.layerPop').css('display') == 'none'){
                        return;
                }

                if(_this.prev('.placeholderGuidetext').length <= 0){

                    _this.wrap('<span class="placeholderWrap" style="display:inline-block;position:relative;"></span>');

                    _this.before('<span class="placeholderGuidetext" style="display:inline-block;width:95%;"></span>');

                    _this.closest('.placeholderWrap').css({width : _thisWidth});
                    _this.css({'width' : '100%'});

                    var prevGuideText = _this.prev('.placeholderGuidetext');
                    prevGuideText.text(placeholderText);
                    prevGuideText.hide();
                    if(_this.val() == ''){
                        prevGuideText.show();
                    }

                    if(_this.css('text-align') == 'right'){
                        prevGuideText.css({left: 'auto', right: 13});
                    }

                    prevGuideText.addClass('placeholderGuidetext');

                    _this.bind('mousedown focusin', function(e){
                        if(!$(this).prop('disabled') || !$(this).prop('readonly')){
                            prevGuideText.hide();
                        }
                    }).bind('focusout', function(e){
                        if($(this).val() == ''){
                            prevGuideText.show();
                        }
                    });

                    prevGuideText.bind('mousedown', function(e){
                        if(!$(this).next(input).prop('disabled') || !$(this).next(input).prop('readonly')){
                            $(this).hide();
                        }
                        setTimeout(function(){
                            _this.focus();
                        }, 100);
                    });
                }
            }
        });
    }
}

// placeholder 값 채웠을 경우 placeholder 겹치는 부분 해제
// @example
// textPlaceHolderRefresh(selector);
// textPlaceHolderRefresh($('#input_id'));
// textPlaceHolderRefresh('#input_id');
function textPlaceHolderRefresh(_selector){
        if(_selector && _selector.length > 0){
            _selector = $(_selector);
            var prevGuideText = _selector.prev('.placeholderGuidetext');

            _selector.triggerHandler('focusin');
            if(_selector.val().length > 0){
                prevGuideText.hide();
            }else{
                prevGuideText.show();
            }
        }
    };

// ajax용 placeholder
function ajaxTextPlaceHolderRefresh(){
    $('input[type=text], textarea, input[type=password], textarea').each(function(){
        $(this).on('mousedown focusin', function(e){
            var prevGuideText = $(this).prev('.placeholderGuidetext');

            if(!$(this).prop('disabled') || !$(this).prop('readonly')){
                prevGuideText.hide();
            }
        }).on('focusout', function(e){
            var prevGuideText = $(this).prev('.placeholderGuidetext');
            if($(this).val() == ''){
                prevGuideText.show();
            }
        });

        $(this).prev('.placeholderGuidetext').bind('mousedown', function(e){
            var prevGuideText = $(this);
            if(!prevGuideText.next('input[type=text], textarea, input[type=password], textarea').prop('disabled') || !prevGuideText.next('input[type=text], textarea, input[type=password], textarea').prop('readonly')){
                prevGuideText.hide();
            }
            setTimeout(function(){
                prevGuideText.next('input[type=text], textarea, input[type=password], textarea').focus();
            }, 100);
        });
    })
}

// UI FormControll
function formControl(){
    // 셀렉트 박스 경우
    if($('select').hasClass('select') == true){
        $('select.select').each(function(i) {
            makeSelect($(this));
        });
    }

    // 체크 박스 경우
    if($('input[type="checkbox"]').hasClass('inputCheckbox') == true){
        $('input.inputCheckbox').each(function(i) {
            makeCheckbox($(this));
        });
    }

    // 라디오 경우
    if ($('input[type="radio"]').hasClass('inputRadio') == true) {
        $('input.inputRadio').each(function(i) {
            makeRadio($(this));
        });
    }

    // 텍스트 필드
    makePlaceholder();
}

/***************************************************************************************
**********************************   [UI UX] Script   **********************************
****************************************************************************************/

/**
 * @module [공통] 탭메뉴
 * @description 탭메뉴
 * @example
 * tabUI();
 */
function tabUI() {

    var el;
    var tabLen;

    el = $('.tabGroup');
    tabType = $('.tchpromArea'); //선생님 서브메인 탭

    if(el.length <= 0){
        return;
    }

    // if (tabType.length > 0) {    //선생님 서브메인 탭일 경우 랜던 활성화
    //     var randomIndex;
    //     var tabLen;

    //     tabLen = $('.tab > li').length;

    //     if (intMenuOnClick > 0) {
    //         randomIndex = intMenuOnClick-1;
    //     } else {
    //         randomIndex = Math.floor(Math.random() * tabLen);
    //     }
    //     randomIndex = Math.floor(Math.random() * tabLen);

    //     el.each(function (idx, obj) {
    //         $(obj).find('.tab > li').removeClass('on').eq(randomIndex).addClass('on');
    //         $(obj).find('.tab > li.on > a').after('<span class="hide_txt">선택됨</span>');
    //         $(obj).find('.tabContent').hide().eq(randomIndex).show();

    //         bindEvents(obj);
    //     });
    // } else {
    //     el.each(function (idx, obj) {
    //         $(obj).find('.tab > li').removeClass('on').eq(0).addClass('on');
    //         $(obj).find('.tab > li.on > a').after('<span class="hide_txt">선택됨</span>');
    //         $(obj).find('.tabContent').hide().eq(0).show();

    //         bindEvents(obj);
    //     });
    // }
    el.each(function (idx, obj) {
        $(obj).find('.tab > li').removeClass('on').eq(0).addClass('on');
        $(obj).find('.tab > li.on > a').after('<span class="hide_txt">선택됨</span>');
        $(obj).find('.tabContent').hide().eq(0).show();

        bindEvents(obj);
    });

    function bindEvents(obj){
        var $this = $(obj);

        $this.find('.tab > li > a').on('click', function(e){
            e.preventDefault();
            var index = $(this).closest('li').index();

            if($this.find('.tabContent').eq(index).length <= 0){
                return;
            }

            $this.find('.tab > li > span.hide_txt').remove();
            $(this).after('<span class="hide_txt">선택됨</span>');
            $this.find('.tab > li').removeClass('on').eq(index).addClass('on');
            $this.find('.tabContent').hide().eq(index).show();

        });

    }
}

/**
 * @module [공통] 아코디언
 * @description 아코디언
 * @example
 * accodianUI();
 */
function accodianUI() {
    var el;

    el = $('.accordianList');

    if(el.length <= 0){
        return;
    }

    el.find('>ul>li').removeClass('on');
    el.find('>ul>li>dl>dt>a').append('<span class="hide_txt">접기</span>');

    bindEvents();

    function bindEvents(){
        el.find('>ul>li>dl>dt>a').on('click', function(e){
            e.preventDefault();

            var index = $(this).closest('li').index();

            el.find('>ul>li').each(function(idx, obj){
                if(idx == index){
                    if($(obj).hasClass('on')){
                        $(obj).removeClass('on');
                        $(obj).find('dl>dt>a').find('span.hide_txt').remove();
                        $(obj).find('dl>dt>a').append('<span class="hide_txt">접기</span>');
                    }else{
                        $(obj).addClass('on');
                        $(obj).find('dl>dt>a').find('span.hide_txt').remove();
                        $(obj).find('dl>dt>a').append('<span class="hide_txt">펼치기</span>');
                    }
                }else{
                    $(obj).find('dl>dt>a').find('span.hide_txt').remove();
                    $(obj).find('dl>dt>a').append('<span class="hide_txt">접기</span>');
                    $(obj).removeClass('on');
                }
            });

        });
    }
}

/**
 * @module [공통] 퀵메뉴
 * @description 퀵메뉴
 * @example
 * quickMenuUI();
 */
function quickMenuUI(){
    var el, header, banner;

    el = $('.wrapQuick');

    if(el.length <= 0){
        return;
    }

    bindEvents();

    function bindEvents(){
        banner = $('[class^=bnnrTop]:visible');
        header = $('#header');

        var mainVisuHeight = 0;
        var bnnrIntrodHeight = 0;

        if($('.mainSec01_v2018 .mainCont').length > 0){
            mainVisuHeight = $('.mainSec01_v2018 .mainCont').outerHeight();
        }
        if($('.mainSec02 .mainCont').length > 0){
            bnnrIntrodHeight = $('.mainSec02 .mainCont').outerHeight();
        }

        //console.log(mainVisuHeight);
        // el.css({
        //     top : header.outerHeight() + banner.outerHeight(),
        //     marginTop : 0
        // });

        $(window).on('scroll', function(){
            var st = $(this).scrollTop();

        // if(banner.css('display') == 'block'){
        //     if(st >= header.outerHeight() + mainVisuHeight){
        //         el.css({
        //             position : 'fixed',
        //             top : header.outerHeight() + mainVisuHeight,
        //         });
        //     }
        //     else{
        //         el.css({
        // 			position : 'fixed',
        //             top : header.outerHeight() + mainVisuHeight - st,
        //         });
        //     }
        // }
        //     if(banner.css('display') == 'block'){
        //         if(st >= header.outerHeight() + banner.outerHeight()){
        //             el.css({
        //                 position : 'fixed',
        //                 // top : header.outerHeight() + banner.outerHeight(),
        //                 top : 0,
        //             });
        //         }
        //         else{
        //             el.css({
		// 				position : 'fixed',
        //                 top : header.outerHeight() + banner.outerHeight() - st,
        //             });
        //         }
        //     }
        //     else{
        //         if(st > header.outerHeight() + mainVisuHeight){
        //             el.css({
        //                 position : 'fixed',
		// 				'top' : 0
        //             });
        //         }
        //         else{
        //             el.css({
        //                 position : 'fixed',
        //                 top : header.outerHeight() + mainVisuHeight - st,
        //             });
        //         }
        //     }

        });

        el.find('.btnTop').on('click', function(e){
            e.preventDefault();
            $('body, html').stop().animate({
                scrollTop : 0
            },300);
        });

        banner.find('.btnClose').on('click', function(e){
            e.preventDefault();
            el.css({
                top : header.outerHeight() + mainVisuHeight + bnnrIntrodHeight,
                marginTop : 0
            });
        });

    }
}


/**
 * @module [공통] 롤링 슬라이드
 * @description 롤링 슬라이드
 * @example
 * rollingSlideUI();
 */
function rollingSlideUI(){
    var el;
    var btnPrev;
    var btnNext;
    var rollingBody;
    var rollingDot;
    var currentId;
    var pageSize;
    var rollingList;
    var rollingListWidth;
    var rollingListSize;
    var pagingKOR;

    el = $('.rollingSlide');

    if(el.length <= 0){
        return;
    }

    btnPrev = el.find('.btnPrev');
    btnNext = el.find('.btnNext');
    rollingDot = el.find('.dottedBox');

    rollingBody = el.find('.imgList > ul');

    rollingList = rollingBody.find('> li');

    if(rollingList.css('margin-left') || rollingList.css('margin-right')){
        rollingListWidth = rollingList.outerWidth(true);
    }
    else{
        rollingListWidth = rollingList.outerWidth();
    }

    rollingListSize = rollingList.length;

    pagingKOR = ['첫', '두', '세', '네', '다섯', '여섯', '일곱', '여덟', '아홉', '열'];

    rollingBody.css({width: rollingListSize * rollingListWidth});
    pageSize = Math.ceil(rollingBody.width() / rollingListWidth);

    currentId = 0;

    var rollingContent = '';
     for(var i = 0 ; i < pageSize ; i++){
        rollingContent += '<a href="#"><span class="hide_txt">' + pagingKOR[i] + '번째 페이지</span></a>\n';
    }

    rollingDot.html(rollingContent);

    rollingDot.find('a:eq(0)').addClass('on');

    el.find(btnPrev).hide();

    rollingList.attr('aria-hidden' , true);
    rollingList.eq(0).attr('aria-hidden' , false);

    bindEvents();

    function bindEvents(){
        btnPrev.on('click', function(e){
            e.preventDefault();

            if(currentId > 0){
                currentId--;
                moveRolling();
            }
        });

        btnNext.on('click', function(e){
            e.preventDefault();

            if(currentId < pageSize-1){
                currentId++;
                moveRolling();
            }
        });

        rollingDot.find(' > a').off('click').on('click', function(e){
            e.preventDefault();

            var index = $(this).index();

            currentId = index;
            moveRolling();
        });

    }

    function moveRolling(){
        rollingBody.stop().animate({marginLeft: -currentId * rollingListWidth}, 500, function(){
            rollingDot.find('a').removeClass('on').eq(currentId).addClass('on');
        });

        if(currentId >= pageSize-1){
            el.find(btnPrev).show();
            el.find(btnNext).hide();
        }
        else if(currentId <= 0){
            el.find(btnNext).show();
            el.find(btnPrev).hide();
        }
        else{
            el.find(btnPrev).show();
            el.find(btnNext).show();
        }

        rollingList.attr('aria-hidden' , true);
        rollingList.eq(currentId).attr('aria-hidden' , false);
    }
}

/**
 * @module [공통] 전체메뉴
 * @description 전체메뉴 슬라이드
 * @example
 * allMenuUI();
 */
function allMenuUI(){
    var el, elBtn, isitMove, elHeight;

    el = $('.allMenuWrap');
    elBtn = $('.gnbSch .allMenu');
    elHeight = 567; // 2022-05-02 고등 브랜드웹 UI개선
    isitMove = false;

    if(el.length <= 0){
        return;
    }

    setup();

    // 전체메뉴에 스크립트가 다중으로 먹어서.. 언바인드 후 바인딩
    elBtn.unbind();

    bindEvents();

    focusEvent();

    function setup(){
        TweenMax.set(el, {height:0, ease: Power2.easeOut});
    }

    function bindEvents(){
        elBtn.on('click', function(e){
            e.preventDefault();
            window.focusBtn = e.currentTarget;
            if(isitMove == false){
                isitMove = true;
                if(elBtn.hasClass('allmenuClose')){
                    closeEvent();


                }
                else{
                    openEvent();


                    // 상단 검색레이어 해제
                    $('.allSchView').removeAttr('style').css('height' , 0);
                    $('.gnbSch .btnSch').removeClass('btnSchClose').find('span').text('검색');

                }
            }

        });
    }

	function openEvent(){
		elBtn.attr('class' , 'allMenu allmenuClose');
		elBtn.find('span').text('전체메뉴 닫기');
		el.show();
		TweenMax.to(el ,  0.2 , {height:elHeight , ease:Power2.easeOut, onComplete : function(){
			isitMove = false;
		}});
	}

	function closeEvent(notFocus){
		elBtn.attr('class', 'allMenu');
		elBtn.find('span').text('전체메뉴 펼치기');
		TweenMax.to(el ,  0.2 , {height:0 , ease:Power2.easeOut, onComplete : function(){
			el.hide();
			if(!notFocus){
				if(window.focusBtn){
					window.focusBtn.focus();
				}
			}

			setup();
			isitMove = false;


		}});
	}

	function focusEvent(){
		el.find('.allMenuArea > li:last-child > ul > li:last-child').find('>a').on('focusout' , function(){
			closeEvent(true);
		});
		el.find('> ul > li:first-child').find('>a').on('keydown', function(e){
			var ekeyCode = e.keyCode || e.which;
			if(ekeyCode == 9){
				// shift + tab
				if(e.shiftKey){
					closeEvent(true);
				}
			}
		});
		elBtn.filter('.allmenuClose').on('keydown', function(e){
			var ekeyCode = e.keyCode || e.which;
			if(ekeyCode == 9){
				// shift + tab
				if(e.shiftKey){
					closeEvent(true);
				}
			}
		});
	}
}

/**
 * @module [공통] 헤더 검색 레이어
 * @description 헤던 검색 레이어 오픈
 * @example
 * searchLayerUI();
 */
function searchLayerUI(){
    var el, elBtn, isitMove, elHeight;

    el = $('.allSchView');
	dim = $('.dimPop');   //aaaa
    elBtn = $('.gnbSch .btnSch');
    elHeight = 165;
    isitMove = false;

    if(el.length <= 0){
        return;
    }

    setup();

    bindEvents();

    focusEvent();

    function setup(){
        TweenMax.set(el, {height:0, ease: Power2.easeOut});
    }

    function bindEvents(){
        elBtn.on('click', function(e){
            e.preventDefault();
            window.focusBtn = e.currentTarget;
            if(isitMove == false){
                isitMove = true;
                if(elBtn.hasClass('btnSchClose')){
                    closeEvent();
                }
                else{
                    openEvent();

                    // 전체메뉴 해제
                    $('.allMenuWrap').removeAttr('style').css('height' , 0);
                    $('.gnbSch .allMenu').removeClass('allmenuClose').find('span').text('전체메뉴');
                }
            }

        });
    }

    function openEvent(){
            elBtn.attr('class' , 'btnSch btnSchClose');
            elBtn.find('span').text('검색 닫기');
            el.show();
			dim.show();
            TweenMax.to(el ,  0.1 , {height:elHeight , ease:Power2.easeOut, onComplete : function(){
                isitMove = false;
            }});
        }

        function closeEvent(notFocus){
            elBtn.attr('class', 'btnSch');
            elBtn.find('span').text('검색');
            TweenMax.to(el ,  0.1 , {height:0 , ease:Power2.easeOut, onComplete : function(){
                el.hide();
				dim.hide();
                if(!notFocus){
                    if(window.focusBtn){
                        window.focusBtn.focus();
                    }
                }

                setup();
                isitMove = false;
            }});
        }

        function focusEvent(){
            el.find('.searchInbox').find('>a').on('focusout' , function(){
                closeEvent(true);
            });
            el.find('.searchHit li:first-child').find('>a').on('keydown', function(e){
                var ekeyCode = e.keyCode || e.which;
                if(ekeyCode == 9){
                    // shift + tab
                    if(e.shiftKey){
                        closeEvent(true);
                    }
                }
            });
            elBtn.filter('.btnSchClose').on('keydown', function(e){
                var ekeyCode = e.keyCode || e.which;
                if(ekeyCode == 9){
                    // shift + tab
                    if(e.shiftKey){
                        closeEvent(true);
                    }
                }
            });
        }
}

/**
 * @module [공통] 상단 My Menu 레이어
 * @description 상단 My Menu 레이어 오픈
 * @example
 * headerMyMenuUI();
 */
function headerMyMenuUI(){
    var el, isitMove, elAfterHeight;

    el = $('.loginArea.after');
    isitMove = false;
    elAfterHeight = 310;

    if(el.length <= 0){
        return;
    }

    setup();

    bindEvents();

    function setup(){
        TweenMax.set(el.find('.gnbmyLyr'), {height:0, display: 'none' , ease: Power2.easeOut});
    }

    function bindEvents(){
        el.find('.btnMymenu').on('click', function(e){
            e.preventDefault();
            if(isitMove == false){
                isitMove = true;
                if(el.find('.gnbmyLyr').hasClass('on')){
                    TweenMax.to(el.find('.gnbmyLyr'), 0.1, {height : 0, ease: Power2.easeOut, onComplete : function(){
                        el.find('.gnbmyLyr').hide();
                        el.find('.gnbmyLyr').removeClass('on');
                        el.find('.btnMymenu').removeClass('open');
                        isitMove = false;
                    }});
                }
                else{
                    el.find('.gnbmyLyr').show();
                    $(this).addClass('open');
                    TweenMax.to(el.find('.gnbmyLyr'), 0.1, {height : elAfterHeight, ease: Power2.easeOut, onComplete : function(){
                        el.find('.gnbmyLyr').addClass('on');
                        isitMove = false;
                    }});
                }
            }
        });
    }

}

/**
 * @module   [이벤트페이지] 스크롤에 따라 aside toggle
 * @description   스크롤에 따라 li의  acitve가 바뀌도록..
 * @example   scrollAndToggle('[class^=contMid0], .contHigh01','.aside .linkPurchase li'); *
 */
window.scrollAndToggle = function(a,b){
    var $page = $(a);
    var $link = $(b);
    var toggleFn = null;

    $(window).on('scroll',function(){
        if (!$('html, body').is(':animated')) {
            if (toggleFn) {
                clearTimeout(toggleFn);
            }
            toggleFn = setTimeout(function() {
                var currentScroll = $(window).scrollTop();
                for (var i = 0;  i < $page.length ; i++) {
                    var currentTarget = $page.eq(i);
                    if (currentTarget.offset().top <= (currentScroll + 80)) {
                        activeToggle(i);
                    }
                }
            },100);
        }
    });

    function activeToggle(num){
        $link.removeClass('active');
        $link.eq(num).addClass('active');
    }
}

/**
 * @module   [이벤트페이지] aside scroll시
 * @description  스크롤시 aside 세로위치 고정(position:fixed)
 * @example asideScrollFix('.aside');
 */
window.asideScrollFix = function(a){
    var $aside = $(a);
    var asideOffsetTop = $aside.offset().top;
    $(window).scroll(function(){
        if($('.wrap').find('[class^="bnnrTop"]').length !== 0) {
            if(($(window).scrollTop() - 50) >= asideOffsetTop){
                $aside.addClass('fixed');
            }else{
                $aside.removeClass('fixed');
            }
        } else {
            if(($(window).scrollTop() + 50) >= asideOffsetTop){
                $aside.addClass('fixed');
            }else{
                $aside.removeClass('fixed');
            }
        }
    });
}

/**
 * @module [메인] 메인 비쥬얼
 * @description 메인비쥬얼 슬라이드
 * @example
 * mainVisUI();
 */
function mainVisUI(){
    var el, beforeHeight, afterHeight ;

    el = $('.mainVis');
    beforeHeight = el.find('.mainVisCon').not('.on').width();
    afterHeight = el.find('.mainVisCon.on').width();

    if(el.length <= 0){
        return;
    }

    setup();

    bindEvents();

    function setup(){
        TweenMax.set(el.find('.mainVisCon'), {width : beforeHeight, ease:Power2.easeOut});
        TweenMax.set(el.find('.mainVisCon.on'), {width : afterHeight, ease:Power2.easeOut});
    }

    function bindEvents(){
        el.find('.mainVisCon .mainVisConOff > a').on('click', function(e){
            e.preventDefault();
            el.find('.mainVisCon').removeClass('on');
            $(this).closest('.mainVisCon').addClass('on');

            TweenMax.to(el.find('.mainVisCon'), 0.4 , {width : beforeHeight, ease:Power2.easeOut});
            TweenMax.to($(this).closest('.mainVisCon'), 0.4 , {width : afterHeight, ease:Power2.easeOut});
        });
    }

}

/**
 * @module [공통] openLayer
 * @description 오픈 레이어 팝업
 * @example
 * openLayer(selector);
 */
window.openLayer = function(selector, type){
    var settings = {
        position : 'fixed',
        width : '100%',
        minHeight : '100%',
        top : 0,
        opacity : 0,
        scale : 0.9,
        y : 0
    }

    TweenMax.set(selector, settings);

    $(selector).show();

    $('html').addClass('noScroll');

    // 가운데 정렬
    switch (type) {
        case 'D': // 하드코딩으로 된 팝업이 아닌, 개발에서 html()로 작성한 후 노출되는 팝업(열공미션 배지보드내 팝업)
            var layerPop = $(selector).find('.layerPop:visible');
            if(layerPop.outerHeight() < $(window).height()){
                layerPop.css({
                    position : 'fixed',
                    top : '50%',
                    marginTop : -layerPop.outerHeight() / 2
                });
            }
            break;
        default:
            if($(selector).find('.layerPop').outerHeight() < $(window).height()){
                $(selector).find('.layerPop').css({
                    position : 'fixed',
                    top : '50%',
                    marginTop : -$(selector).find('.layerPop').outerHeight() / 2
                });
            }
            break;
    }

    TweenMax.to($(selector), 0.4, {
        opacity : 1,
        scale : 1,
        y : 0,
        top : 0,
        onComplete : function() {
            //$(window).scrollTop(0);
            $(selector).css({
                position : 'absolute',
                transform : 'none'
            });
            // formControl 실행
            formControl();
        }
    });

    $(selector).attr('tabIndex' , -1).focus();
}

/**
 * @module [공통] closeLayer
 * @description 클로즈 레이어 팝업
 * @example
 * closeLayer(selector);
 */
window.closeLayer = function(selector){
    $(selector).hide().removeAttr('tabindex');
    $('html').removeClass('noScroll');
    if(window.focusBtn){
        window.focusBtn.focus();
    }
}

/**
 * @module [공통] 윈도우 팝업
 * @description 윈도우 팝업 스크린상 가운데 위치
 * @example
 *  openWinPop('popup.html', 600, 400) // default는 스크롤 없음
 *	openWinPop('popup.html', 600, 400, 'yes') // 스크롤추가 시
 */

window.openWinPop = function (href, wid, hei, scroll){
    var href = href;
    var w = wid;
    var h = hei;
    var winW= $(window).width();
    var winH = $(window).height();
    var posL=( winW - w ) / 2;
    var posT=( winH - h ) / 2;
	var scrollOpt = 'no';
	scrollOpt = scroll;

    window.open(href,'newWin','width='+ w +',height='+ h +',top='+ posT +',left='+ posL +',resizable=no,scrollbars='+scrollOpt);
}

/**
 * @module [공통] 동영상 레이어 팝업
 * @description
 * @example  /html_source/script_sample.html 참조
 *
 */
$.fn.openVodLayer  = function(option){
    var settings = $.extend({
        target : '#container', // 레이어를 추가할 엘레먼트
        addClass : '',
        width : 980,    // 아이프레임 가로사이즈
        height: 598,    // 아이프레임 세로사이즈
        href : '',      // 아이프레임 src
        BgImgYN : 'N',  // 동영상 기본이미지 유무 ( Y | N )
        BgImgUrl : '',  // 동영상 기본이미지 경로
        btnCloseImgUrl : '/Img/btn/close_layer_pop01.png' // 레이어닫기이미지 경로
    },option);

    return this.each(function(){
        var elemStr = '';
            elemStr = '<div class="popVodLayer '+ settings.addClass+'">';
            elemStr += '    <div class="cntArea"></div>';
            elemStr += '    <p class="closeLayer"><a href="javascript:;" onclick="closeVodLayer();"><img src="'+ settings.btnCloseImgUrl +'" alt="레이어 닫기"></a></p>';
            elemStr += '</div>';
            elemStr += '<div class="dim"></div>';

        $(elemStr).appendTo(settings.target);
        $('.popVodLayer').css({'width':settings.width,'height':settings.height,'margin-top':-(settings.height/2),'margin-left':-(settings.width/2)});
        $('.popVodLayer .cntArea').html('<iframe id="ifrmVodView" width="' + settings.width + '" height="' + settings.height + '" frameborder=0 scrolling=no src="/Lesson/Bridge/SmallPlayer/bridge_Small_Player_New.aspx?Movie=' + settings.href + '&Type=G&Mwidth=' + settings.width + '&Mheight=' + (settings.height - 42) + '&BgImgYN=' + settings.BgImgYN + '&BgImgUrl=' + settings.BgImgUrl + '&ToolbarYN=Y&auto=Y" frameborder="0" allowfullscreen></iframe>');
        $('.popVodLayer').show();
        $('.popVodLayer').next('.dim').show();
        settings.href = '';
    });
}

// 동영상 레이어팝업 닫기
function closeVodLayer(){
    $('#ifrmVodView').attr('src','');
    $('body').find('.popVodLayer').next('.dim').remove();
    $('body').find('.popVodLayer').remove();
    return false;
};

/**
 * @module [서브 메인] 상단 정보
 * @description 서브 메인 상단 정보 Show
 * @example
 * subTopInfoUI();
 */
function subTopInfoUI(){
    var el;

    el = $('.mystudyLryArea');

    if(el.length <= 0){
        return;
    }

    bindEvents();

    function bindEvents(){
        el.find('.mystudyOpen').on('click' , '.btnClose' , function(e){
            e.preventDefault();
            $(this).closest('.mystudyOpen').hide();
            el.find('.mystudyClose').show();
        });

        el.find('.mystudyClose').on('click' , '.bntOpen' , function(e){
            e.preventDefault();
            $(this).closest('.mystudyClose').hide();
            el.find('.mystudyOpen').show();
        });
    }
}

/**
 * @module [서브 메인] 상단 메뉴
 * @description 서브 메인 상단 메뉴
 * @example
 * subTopGnbUI();
 */
function subTopGnbUI(){
    var el;

    el = $('.studyGnbArea');

    if(el.length <= 0){
        return;
    }

    bindEvents();
    function bindEvents(){
        el.find('.studyGnb > li > a').on('mouseenter' , function(e){
            el.find('.studyGnb > li').removeClass('on');
            $(this).closest('li').addClass('on');
        });
    }
}

/**
 * 개발소스에서 컨트롤하는 부분으로 실질적으로 해당 소스는  사용하지 않고 있음
 * /top/ucl_Top_Menu.ascx에서 컨트롤
 *
 * @module [공통] 최상단 배너
 * @description 최상단 배너
 * @example
 *  bannerTopUI();
 */
function bannerTopUI(){
    var topBnnr = $('.mainTopBnnr');
    var bgBnnr = $('.mainTopBnnr .bg');
    var scene01 = $('.mainTopBnnr .scene01');
    var scene02 = $('.mainTopBnnr .scene02');
    var scene03 = $('.mainTopBnnr .scene03');
    var layerClose = $('.mainTopBnnr .btnClose');

    scene01.find('.objTab, .cnt li').css({'opacity':0, 'filter':'alpha(opacity=0)'}); // ie8

    topBnnr.find('.inner').click(function(){
         location.href = "/Course/frm_Course_Main.aspx?MenuCode=200000";
    });

    if(topBnnr.length <= 0){
        return;
    }

    bnnrScene01();
    setTimeout(function(){
        bnnrScene02();
    }, 5100);

    // scene01
    function bnnrScene01(){
        var delay = 1000;
        topBnnr.animate({'height':700}, 450, 'easeInOutBack');
        bgBnnr.delay(670).animate({'opacity':1, 'filter':'alpha(opacity=1)', 'bottom':0}, 200);
        scene01.show().find('.objTab').delay(500).animate({'left':425, 'opacity':1, 'filter':'alpha(opacity=1)'}, 700, 'easeInOutElastic');
        scene01.find('.cnt li').each(function(){
            $(this).delay(delay).animate({'opacity':1, 'filter':'alpha(opacity=1)', 'margin-top':0}, 500, 'easeInOutBack');
            delay += 400;
        });
        bindEvents();
    }

    // scene02
    function bnnrScene02(){
        scene01.animate({'top':'-100%'}, 600, 'easeInOutBack');
        scene02.animate({'top':'0'}, 600, 'easeInOutExpo');

        // tab paging
        var cnt = scene02.find('.tabList .cnt');
        var container = scene02.find('.tabList .cnt ul');
        var btnLeft = $('.scene02 .tabList .btnPrev');
        var btnRight = $('.scene02 .tabList .btnNext');

        btnRight.click(function (e){
            if (Math.abs(container.position().left) == (cnt.find('li').size()-1) * cnt.width()){
                container.css({left:0});
            } else {
                container.css({ left: '-=' + cnt.width()});
            }

            e.stopPropagation();
        });
        btnLeft.click(function (e) {
             if (Math.abs(container.position().left) == 0){
                container.css({left: (-(cnt.find('li').size()-1) * cnt.width())});
            } else {
                container.css({ left: '+=' + cnt.width()});
            }
            e.stopPropagation();
        });

        var timer = null;
        function startInterval() {
            timer = setInterval(function () {
                btnRight.trigger('click');
            }, 3000)
        }

        startInterval();

        $('.mainTopBnnr .inner').hover(function () {
            clearInterval(timer);
        }, function () {
            startInterval();
        });

        bindEvents();

        topBnnr.on('click' , '.btnOpen', function(e){
             startInterval();
             container.css({left:0});
             e.stopPropagation();
             quickMenuUI();
        });

        topBnnr.on('click' , '.btnFold', function(e){
            clearInterval(timer);
            e.stopPropagation();
            quickMenuUI();
        });

    }

    // scene03
    function bnnrScene03(){
        topBnnr.on('click' , '.btnOpen a', function(e){
            topBnnr.removeClass('close').animate({'height':'700'}, 300, 'easeInOutBack');
            bgBnnr.show().delay(150).animate({'opacity':1, 'filter':'alpha(opacity=1)', 'bottom':0}, 300);
            scene03.css('top','100%').animate({'opacity':'0', 'filter':'alpha(opacity=0)'}, 300);
            scene02.show().css('top','-700px').animate({'top':0}, 300);
            $(this).parent().removeClass('btnOpen').addClass('btnFold');
            layerClose.find('img').attr('src' , '/img_new/common/btn_notice_close.png');
            //e.stopPropagation();
            quickMenuUI();
        });
        layerClose.click(function(e){
            topBnnr.stop().slideUp('fast');
            e.stopPropagation();
            quickMenuUI();
        });
        $(window).on('scroll', function(){
            var lastScrollTop = 0;
            $(window).scroll(function(event){
               var st = $(this).scrollTop();
               if (st > lastScrollTop){
                   scene03.find('.obj').stop().animate({'top':'-24px'});
               } else {
                 scene03.find('.obj').stop().animate({'top':'12px'});
               }
               lastScrollTop = st;
            });

        });
    }

    function bindEvents(){
        topBnnr.on('click' , '.btnFold a', function(e){
            $(this).parent().removeClass('btnFold').addClass('btnOpen');
            topBnnr.addClass('close');
            bgBnnr.hide().css('bottom','-100%').animate({'opacity':0, 'filter':'alpha(opacity=0)'});
            $(this).closest(topBnnr).animate({height : 200}, 350, 'easeInOutBack');
            scene03.css('top','0').animate({'opacity':'1', 'filter':'alpha(opacity=1)'}, 300).siblings('[class^="scene"]').hide();
            layerClose.find('img').attr('src' , '/img_new/main/topbnnr_160813/btn_close_layer.png');
            //e.stopPropagation();
            quickMenuUI();
        });
        bnnrScene03();
    }

}

function bannerTopUI170704(){
    var topBnnr = $('.mainTopBnnr170704');
    var bgBnnr = $('.mainTopBnnr170704 .bg');
    var scene01 = $('.mainTopBnnr170704 .scene01');
    var scene02 = $('.mainTopBnnr170704 .scene02');
    var layerClose = $('.mainTopBnnr170704 .btnClose');
	var container = $('#container');

    if(topBnnr.length <= 0){
        return;
    }

	if(container.is('.main')){
		bnnrScene01(); //메인페이지일 경우
	}else{
		bnnrDefault(); //컨텐츠 띠배너
	}

    topBnnr.find('.scene01, .scene02').click(function(){
         location.href = "/EventNew/20170704_tab/frm_Event_20170704.aspx";
    });

    function bnnrDefault(){
        $(this).parent().removeClass('btnFold').addClass('btnOpen');
        topBnnr.addClass('close');
        bgBnnr.hide().css('bottom','-100%').animate({'opacity':0, 'filter':'alpha(opacity=0)'});
        topBnnr.animate({height : 198}, 350, 'easeInOutBack');
        scene02.css('top','0').animate({'opacity':'1', 'filter':'alpha(opacity=1)'}, 300).siblings('[class^="scene"]').hide();
        $('.btn').removeClass('btnFold').addClass('btnOpen');
        layerClose.find('img').attr('src' , '/img_new/main/topbnnr_170704/btn_close_layer.png');
		$('.mainTopBnnr170704 .btnOpen a').off('click').on('click',function(){
			bnnrScene01();
		});
    }
    // scene01
    function bnnrScene01(){
        var delay = 1000;
        topBnnr.animate({'height':609}, 450, 'easeInOutBack');
        bgBnnr.delay(670).animate({'opacity':1, 'filter':'alpha(opacity=1)', 'bottom':0}, 200);
        scene01.show().find('.tit').delay(500).animate({'margin-top':0, 'opacity':1, 'filter':'alpha(opacity=1)'}, 700, 'easeInOutElastic');
        scene01.find('.cnt li').each(function(){
            $(this).delay(delay).animate({'opacity':1, 'filter':'alpha(opacity=1)', 'margin-top':0}, 500, 'easeInOutBack');
            delay += 400;
        });
        bindEvents();
    }

    // scene02
    function bnnrScene02(){
        topBnnr.on('click' , '.btnOpen a', function(e){
            topBnnr.removeClass('close').animate({'height':'609'}, 300, 'easeInOutBack');
            bgBnnr.show().delay(150).animate({'opacity':1, 'filter':'alpha(opacity=1)', 'bottom':0}, 300);
            scene01.show().css('top','-700px').animate({'top':0}, 300);;
            scene02.css('top','100%').animate({'opacity':'0', 'filter':'alpha(opacity=0)'}, 300);
            $(this).parent().removeClass('btnOpen').addClass('btnFold');
            layerClose.find('img').attr('src' , '/img_new/common/btn_notice_close.png');
            //e.stopPropagation();
            quickMenuUI();
        });
        layerClose.click(function(e){
            topBnnr.stop().slideUp('fast');

            quickMenuUI();
        });
        $(window).on('scroll', function(){
            var lastScrollTop = 0;
            $(window).scroll(function(event){
               var st = $(this).scrollTop();
               if (st > lastScrollTop){
                   scene02.find('.obj').stop().animate({'top':'-24px'});
               } else {
                 scene02.find('.obj').stop().animate({'top':'12px'});
               }
               lastScrollTop = st;
            });

        });
    }

    function bindEvents(){
        topBnnr.on('click' , '.btnFold a', function(e){
            $(this).parent().removeClass('btnFold').addClass('btnOpen');
			 topBnnr.addClass('close');
            bgBnnr.hide().css('bottom','-100%').animate({'opacity':0, 'filter':'alpha(opacity=0)'});
            $(this).closest(topBnnr).animate({height : 198}, 350, 'easeInOutBack');
            scene02.css('top','0').animate({'opacity':'1', 'filter':'alpha(opacity=1)'}, 300).siblings('[class^="scene"]').hide();
            layerClose.find('img').attr('src' , '/img_new/main/topbnnr_170704/btn_close_layer.png');
            e.stopPropagation();
            quickMenuUI();
        });
        bnnrScene02();
    }
}

/**
 * @module [공통] user agent check
 * @description (적용된 예)<html class="ie10">
 * @example
 *  (적용된 예)<html class="ie10">
 */
function userAgentCheck(){
    var ua = navigator.userAgent.toString().toLowerCase();
    var agent = {};
    var $html = document.getElementsByTagName('html')[0];
    var addClassName = '';

    agent = {
            ie : (/msie/i).test(ua) || (/trident/i).test(ua),
            msedge : (/edge/i).test(ua), // MS edge(applewekit,chrome,safari)
            firefox: (/firefox/i).test(ua),
            webkit: (/applewebkit/i).test(ua),
            chrome: (/chrome/i).test(ua)
    };

    agent.safari = (agent.webkit) && (!agent.chrome);

    // ie 버전 체크
    if(agent.ie){
        var ieVersion = ua.match(/(msie |trident.*rv[ :])([0-9]+)/)[2];
        ieVersion = Math.floor(ieVersion);
        agent.ie = "ie"+ieVersion;
    }

    // ms edge, chrome, safari일 경우 중복되는 값 삭제하기
    if(agent.msedge){ agent.webkit = agent.chrome = agent.safari = false; }

    if(agent.chrome || agent.safari){ agent.webkit = false; }

    var reverseFn = function(){
        var classArr = [];
        for(var value in agent){
            if(agent[value]){
                if(value == 'os' || value == 'ie'){
                    classArr.push(agent[value]);
                }else{
                    classArr.push(value);
                }
            }
        }
        addClassName = classArr.reverse().join(' ');
    }();
    $html.className = addClassName;
}

/**
 * @module 텍스트 롤링
 * @description
 * @example
 *     $('.event02 .bxWin .list li').rollingText({'distance':40}); *
 */
$.fn.rollingText  = function(option){
    var settings = $.extend({
        intervalTime : 4000,    // setInterval Time
        moveSpeed : 500,        // animate Speed
        distance : 20           // animate distance
    },option);

    var $this = $(this);
    var countLine;
    var oldLine = 0;
    var currentLine = 0;

    function rollingCnt(){
        currentLine = (oldLine + 1) % countLine;
        $this.eq(oldLine).animate({ 'top': '-' + settings.distance }, settings.moveSpeed, function () {
            $(this).css('top', settings.distance+'px');
        });
        $this.eq(currentLine).show().animate({ 'top': 0 }, settings.moveSpeed);
        oldLine = currentLine;
    }

    countLine = $this.size();
    $this.eq(currentLine).css('top', '0');
    if($this.length > 1){ // 2개 이상부터 롤링시작
        setInterval(rollingCnt, settings.intervalTime);
    }
}

/**
 * @module [이벤트페이지] 본문으로 스크롤
 * @description
 * @example
 *     scrollToEvent(); // default : .wrapEvent로 스크롤
 *     scrollToEvent(600); // 원하는 수치만큼 스크롤
 */
window.scrollToEvent = function(num){
    var wrapEventTop = 0;

    if(num === undefined){
        wrapEventTop = $('.wrapEvent').offset().top;
    }else{
        wrapEventTop = num;
    }
    $('html, body').stop(true,true).animate({scrollTop:wrapEventTop},500);
}

/**
 * @module 말줄임표 만들기(ellipsis)
 * @description
 * @example
 *      charByteSize(ch) : 한글자에 대한 byte를 계산합니다.
		getByteLength(s) : 입력된 글자 전체의 byte를 계산해서 알려줍니다.
		cutByteLength(s) : 원하는 byte 만큼 글자를 잘라서 반환합니다.

        $('.topTitLine').each(function(){
			$(this).text(calByte.cutByteLength($(this).text(),126) );
		});
 */
var calByte = {
	getByteLength : function(s) {
		if (s == null || s.length == 0) {
			return 0;
		}
		var size = 0;
		for ( var i = 0; i < s.length; i++) {
			size += this.charByteSize(s.charAt(i));
		}
		return size;
	},
	cutByteLength : function(s, len) {
		if (s == null || s.length == 0) {
			return 0;
		}
		var size = 0;
		var rIndex = s.length;
		for ( var i = 0; i < s.length; i++) {
			size += this.charByteSize(s.charAt(i));
			if( size == len ) {
				rIndex = i + 1;
				break;
			} else if( size > len ) {
				rIndex = i;
				break;
			}
		}
        //console.log(size, len);
		return (size >= len)? $.trim(s.substring(0, rIndex))+'...':$.trim(s.substring(0, rIndex));
	},
	charByteSize : function(ch) {
		if (ch == null || ch.length == 0) {
			return 0;
		}
		var charCode = ch.charCodeAt(0);
		if (charCode <= 0x00007F) {
			return 1;
		} else if (charCode <= 0x0007FF) {
			return 2;
		} else if (charCode <= 0x00FFFF) {
			return 3;
		} else {
			return 4;
		}
	}
};


/**
 * @module 챗봇 UI
 * @description 챗봇얼굴모션 등(챗봇영역안에서의 스크립트는 chatbot.js에서 제어함)
 * @example
 */
function chatbotUI() {
    var word;
    var version = "N/A";

    var agent = navigator.userAgent.toLowerCase();
    var name = navigator.appName;

    // IE old version ( IE 10 or Lower )
    if (name == "Microsoft Internet Explorer") word = "msie ";

    else {
        if (agent.search("trident") > -1) word = "trident/.*rv:";     // IE 11
        else if (agent.search("edge/") > -1) word = "edge/";    // IE 12  ( Microsoft Edge )
    }

    var reg = new RegExp(word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})");
    if (reg.exec(agent) != null)
        version = RegExp.$1 + RegExp.$2;

    var arr = version.split('.');

    var ifrmChatbot = $('.ifrmChatbot');
    var objMilkyLink = $('.chatbotWrap .objMilky');
    var objMilky = $('.chatbotWrap .objMilky .obj [class^=type]');
    var msg = $('.chatbotWrap .objMilky .msg span');
    var msgArr = ['안녕하세요!','밀키입니다!','질문해 주세요!'];

    if (version == "N/A" || Number(arr[0]) >= 10) {
        $('.wrapQuick .chatbot a').on('click', function () {
            ifrmChatbot.fadeIn(100);
            return false;
        });
    }

    $('.chatbotWrap .btnClose a').on('click',function(){
        $('.chatbotWrap').hide();
        return false;
    });

    // 스크롤시
    $(window).scroll(function(){
        if($(window).scrollTop() > 100){
            ifrmChatbot.addClass('fixed');
        }else{
             ifrmChatbot.removeClass('fixed');
        }
    });

    // 퀵메뉴 밀키 모션
    //function quickMilkyMotion(){
        //console.log('quickMilkyMotionStart');
    //    var milkyMsg = $('.wrapQuick.addChatbot .milkyMsg .msg');
    //    var msgArr = ['챗봇<br />상담', '밀키<br />Beta'];
        //var msgArr = ['\uCC57\uBD07<br />\uC0C1\uB2F4', '\uBC00\uD0A4<br />Beta'];
    //    var milky = $('.wrapQuick.addChatbot .chatbot .objMilky span');
    //    var objGroup = ['obj04','obj01','obj05','obj06','obj05','obj01'];
    //    var i = 0;
    //    var j = 0;
    //    var k = 0;
    //    var z = 0;

        /*
            .obj01   o-o (eyes on center)
            .obj02 >-<
            .obj03 ♥-♥
            .obj04 -_-
            .obj05      o-o (eyes on right)
            .obj06 o-o (eyes on left)
        */

    //    milky.css({'margin-top':'54px'}).attr('class','obj01')
    //        .animate({'margin-top':'18px'},150,
    //            function(){
    //               setInterval(function(){
    //                    objGroupFn();
    //                },500);

    //               function objGroupFn(){
    //                    if(k < (objGroup.length-1)){
    //                        milky.attr('class' , objGroup[k]);
    //                        k = (k + 1) % objGroup.length;

    //                    }else if(k == (objGroup.length-1)){
    //                        milky.attr('class' , objGroup[objGroup.length-1]);
    //                    }
    //               }
    //            }
    //        )
    //        .delay(3500)
    //        .animate({'margin-top':'0'},100,function(){
    //            objGroup = ['obj02','obj03','obj01'];
    //            $('.wrapQuick.addChatbot .milkyMsg').fadeIn(100);

    //            rollingMilky();
    //            function rollingMilky(){
    //                setInterval(function(){
    //                    milky.attr('class' , objGroup[z]);
    //                    z = (z + 1) % objGroup.length;
    //                },1200);
    //            }

    //            loopMilkyMsg();
    //            function loopMilkyMsg(){
    //                setInterval(function(){
    //                    milkyMsg.html(msgArr[j]);
    //                    j = (j + 1) % msgArr.length;
    //                }, 1200);
    //            }
    //    });
    //}
    //$(window).load(function(){
        // 개발에서 common.js를 여러번 불러와서 모션이 중복되므로 아래 코드를 추가함
    //    var quickMilky = $('.wrapQuick.addChatbot .chatbot .objMilky span');
    //    if( !(quickMilky.is(':animated')) ){
    //        quickMilkyMotion();
    //    }
    //});
}

/**
 * @module 커뮤니티 운영 원칙 layer popup
 * @description
 * @example
 */
function mf_PopRule(){
     window.open('/popup/Dalja/frm_pop_WarningRule.aspx?PageType=ucl', '', 'width=500, height=670');
     return false;
}

/**
 * @module 밀크T 브랜드 소개 페이지
 * @description https://mid.milkt.co.kr/TSherpa/main_introd.aspx
 * @example
 */
function introdMidMilkT() {
    // main visual
    var txtTit = $('.introdMidMilkT .visual .tit span');
    txtTit.css({ 'padding-top': '30px', 'opacity': 0, 'filter': 'alpha(opacity=0)'});
    txtTit.each(function(i) {
        $(this).delay(i * 350).animate({'padding-top': '0', 'opacity': 1, 'filter': 'alpha(opacity=100)' }, 350, 'easeOutQuad');
    });
    // mainVisualThumb
    var mainVisualThumb = $('.introdMidMilkT .sctn02 .wrapThumb .slides').bxSlider({
        slideWidth: 550,
        minSlides: 1,
        maxSlides: 5,
        moveSlides: 1,
        auto: true,
        autoHover: true,
        randomStart: false,
        adaptiveHeight: true,
        speed:500,
        controls: false,
        pager:false
    });
    // mainVisualSlide
    var mainVisualSlide = $('.introdMidMilkT .sctn02 .wrapSlide .slides').bxSlider({
        auto: true,
        autoHover: true,
        randomStart: false,
        adaptiveHeight: true,
        speed:500,
        controls: false,
        infiniteLoop: true,
        pager:false,
        captions:true,
        onSlideBefore: function(){
            var currunt = mainVisualSlide.getCurrentSlide();
            mainVisualThumb.goToSlide(currunt);
        }
    });
    $('.introdMidMilkT .sctn02 .wrapper .btnPrev').click(function () {
        mainVisualSlide.clearQueue().goToPrevSlide();
        mainVisualThumb.clearQueue().goToPrevSlide();
        return false;
    });
    $('.introdMidMilkT .sctn02 .wrapper .btnNext').click(function () {
        mainVisualSlide.clearQueue().goToNextSlide();
        mainVisualThumb.clearQueue().goToNextSlide();
        return false;
    });
}

/**
 * @module 강좌안내 > Bridge Pages > wing banner control
 * @description
 * @example
 * http://test-mid.milkt.co.kr/Lesson/BridgeNew/20190326_exam/frm_Bridge_Exam_20190326.aspx
 */
var lastScrollY = 0;
function wingBnnrScrollFn(){
    var currentY = $(window).scrollTop();
    var $wingBnnr = $('.wrapBridge .wingBnnr');
    var bridgeHeight = $('.wrapBridge .container').outerHeight();
    bridgeHeight = bridgeHeight - $wingBnnr.outerHeight();

    if(currentY != lastScrollY){
        var percent = .1 * (currentY - lastScrollY);
        percent = percent > 0 ? Math.ceil(percent) : Math.floor(percent);
        if (parseInt($wingBnnr.css('top')) + percent <= bridgeHeight) {
            $wingBnnr.css('top', parseInt($wingBnnr.css('top')) + percent);
            lastScrollY = lastScrollY + percent;
        }
    }
}

function scrollToLecture(){
    var posY = '0';
    posY = $('.wrapBridge .lecListWrap').position();
    if (posY != '0') {
        $('html,body').stop(true,true).animate({scrollTop: posY.top}, 300);
    }
}

/**
 * @module 드림스쿨 > 내신학습정보/시험정보/자격증정보 tab Control
 * @description
 * @example
 */
function drmSchoolTabCtrl(){
    var el;
    el = $('.dreamInfoWrap [class*=tabType]');
    if(el.length == 0){
        return false;
    }
    el.find('a').on('click',function(){
        var idx =$(this).parent().index();

        $(this).closest('[class*=tabType]').find('li').removeClass('on');
        $(this).parent().addClass('on');
        $(this).closest('[class*=tabType]').parent().find('.cntArea').hide();
        $(this).closest('[class*=tabType]').parent().find('.cntArea').eq(idx).show();
        if($(this).find('img').length > 0){
            imgToggle($(this));
        }
        return false;
    });
}

/**
 * @module Image src replace
 * @description
 * @example
 */
function imgToggle(el){
    el.find('img').attr('src', function () {
        var src = $(this).attr('src');
        return src.replace('off', 'on');
    }).end().parent().siblings('li').find('img').attr('src', function () {
        var src = $(this).attr('src');
        return src.replace('on', 'off');
    });
}

/**
 * @module 강좌리스트(강좌안내 > 선생님홈 > 진행강좌, 브릿지)
 * @description
 * @example
 */
function listClassWrapCtrl(){
    // 강좌 정보(강좌소개,교재소개,선생님소개,수강평 등) 레이어 열기
    $('.listClassWrap li .listInfo li a').off().on('click',function(){
        var idx = $(this).parent().index();

        //console.log(11)

        if($(this).parent().is('.on')){
            $('.listClassWrap li .listInfo li').removeClass('on');
            $('.popClassInfo._embed').hide();
        }else{
            $('.listClassWrap li .listInfo li').removeClass('on');
            $(this).parent().addClass('on');
            $('.popClassInfo._embed').hide();
            $(this).closest('article').next('.popClassInfo._embed').show().find('.cnt').hide();
            $(this).closest('article').next('.popClassInfo._embed').find('.cnt').eq(idx).show();
        }

        return false;
    });

    // 강좌 정보(강좌소개,교재소개,선생님소개,수강평 등) 레이어 닫기
    $('.popClassInfo._embed .layerPop > .btnClose').on('click',function(){
        $('.popClassInfo._embed').hide();
        $('.listClassWrap li .listInfo li').removeClass('on');
        return false;
    });

    //// 강좌 담기 레이어 열기
    //$('.listClassWrap li .btnSaveLec').on('click',function(e){
    //    var $targetLayer = $(this).parent().next('.layerFolder');
    //    if($targetLayer.is(':hidden')){
    //        $('.layerFolder').hide();
    //        $(this).parent().next('.layerFolder').show();
    //    }else{
    //        $('.layerFolder').hide();
    //    }
    //    return false;
    //});
    //
    //// 강좌 신청 레이어 열기
    //$('.listClassWrap li .btnPurClass').on('click',function(){
    //    if($(this).is(':checked')){
    //        $('.ask.layerAsk').hide();
    //        $(this).closest('.btnGroup').next('.ask.layerAsk').show();
    //    }else{
    //        $('.ask.layerAsk').hide();
    //    }
    //});
    //
    //// 강좌 신청 레이어 닫기
    //$('.ask.layerAsk .btnClose').on('click',function(){
    //    $('.ask.layerAsk').hide();
    //    return false;
    //});

    // 강좌리스트 전체 선택
    $('.selectAllWrap .selectAllChk').on('click',function(){
        if($(this).is(':checked')){
            $('.listClassWrap li > .selectClass input').prop('checked',true);
        }else{
            $('.listClassWrap li > .selectClass input').prop('checked',false);
        }
    });

    // 강좌리스트 단일 선택
    $('.listClassWrap li > .selectClass input').on('click',function(){
        if( !$(this).is(':checked')){
            $('.selectAllWrap .selectAllChk').prop('checked',false);
        }
    });

    //contest 아래 lnbWrap가 없으면 라인 삭제
    $("#contents:not(:has(#lnbWrap))").css( "background", "none" );


}

///////// 공통 준비 실행
$(function(){
    // 폼 콘트롤
    formControl();

    // 탭
    tabUI();

    // 아코디언
    accodianUI();

    // 기본 슬라이드
    rollingSlideUI();

    quickMenuUI();

    // 퀵메뉴
    // $(window).on('load',function(){
        // quickMenuUI();
    // });

    //전체 메뉴
    allMenuUI();


	/*$('.allmenuClose').click(function(){
		$('.allMenuWrap').slideToggle();
		$('.allMenu').show();
	});*/


    //헤더 검색 레이어
    searchLayerUI();

    //헤더 MY Menu 레이어
    headerMyMenuUI();

    //유저 에이전트 체크
    userAgentCheck();

    // 챗봇
    chatbotUI();

    // 드림스쿨 > 내신학습정보/시험정보/자격증정보 tab Control
    drmSchoolTabCtrl();

    // 강좌리스트(강좌안내 > 선생님홈 > 진행강좌, 브릿지) Control
    listClassWrapCtrl();
    $(document).on('click',function(e){
        //console.log($(e.target));
        if($(e.target).is('.div_FullMaster_Contents') || $(e.target).is('#container')){
            $('body').find('.layerFolder:visible').hide();
            $('body').find('.layerVodSample:visible').hide();
        }

    });

	//$('.allMenuPopClose').click(function(){
	//	$('.allMenuWrap').slideToggle(500);
	//	$('.allMenu').removeClass('allmenuClose');
	//	$('.dimPop').hide();
	//});

	//var dimBox = $('.dimPop');

	$('.allMenu').click(function(){
		$('.dimPop').show();
	});

	// 2022-05-02 고등 브랜드웹 UI개선 header 밀크티 셀렉트박스
	var $txtMilktTSelected = $('.header .headerCon .txtSelected');
	var $linkMilkT = $('.header .headerCon .listMilkT a');
	var $btnCloseWrapListMilkt = $('.header .headerCon .linkMenu .siteMilkT .btnClose');
	$txtMilktTSelected.on('click',function(){
		$(this).toggleClass('active');
		return false;
	});
	$linkMilkT.add($btnCloseWrapListMilkt).on('click',function(){
		$txtMilktTSelected.toggleClass('active');
	});
	$(document).on('click', function(e){
		if($(e.target).is('.wrapListMilkt:visible')){
			$txtMilktTSelected.toggleClass('active');
		}
	});
});


//탭
jQuery.fn.imgSwap = function(src_in,src_out){
	if(typeof src_out != "string") src_out="_on";
	$(this).each(function(){
		var that=$(this);
		var imgSrc=that.attr("src");
		if(imgSrc==undefined) return;
		var imgType=imgSrc.match(/.gif$|.jpg$|.png$/);
		if(imgSrc.indexOf(src_in+imgType) == -1) return;
		that.attr("src",imgSrc.replace(src_in+imgType,src_out+imgType));
	});
	return this;
}
jQuery.fn.tabUI = function(options){
	var opt = {
		tab : ".tabUI_tab" //탭
		,con : ".tabUI_con" //컨텐츠
		,tabSrcOn : "_on" //이미지 replace src on (a_on.gif)
		,tabSrcOff : "" //이미지 replace src off (a.gif)
		,tabHover : "on" //탭 오버시 클래스
		,eventHandler : "mouseenter focus" //이벤트핸들러
		,imgHover : true //이미지 온오프 true | false
		,href : false //click 이벤트일때 href 실행 true | false
		,fn : "" //탭 활성화될 때 실행할 함수
		,titAttr : "selected" //탭 활성화될 때 title 값 끝에 추가할 문구
	};
	var opt = $.extend(opt, options || {});
	function init(wrap){
		var
		el = {
			tab : wrap.find(opt.tab)
			,con : wrap.find(opt.con)
			,currTab : null
		}
		,att = {
			title : []
		}
		,prevIdx = 1
		,currTit = "";
		el.tab.each(function(i){
			att.title.push($(this).attr("title"));
			$(this).bind(opt.eventHandler,function(){
				var o = $(this);
				if(opt.fn != ""){
					opt.fn(i);
				}
				el.currTab = el.tab.filter("."+opt.tabHover);
				if(opt.imgHover){
					el.currTab.find("img").imgSwap(opt.tabSrcOn,opt.tabSrcOff);
					if(o.find("img").length){
						$(this).find("img").imgSwap(opt.tabSrcOff,opt.tabSrcOn);
					}
				}
				if(att.title[prevIdx] === ""){
					el.currTab.removeAttr("title");
				}else{
					el.currTab.attr("title",att.title[prevIdx]);
				}
				if(!att.title[i]){
					currTit = opt.titAttr;
				}else{
					currTit = att.title[i] + " - " + opt.titAttr;
				}
				o.attr("title",currTit);
				el.tab.removeClass(opt.tabHover);
				o.addClass(opt.tabHover);
				el.con.hide();
				el.con.eq(i).show();
				prevIdx = i;
				if(!opt.href){
					return false;
				}
			});
		});

		el.tab.eq(0).trigger(opt.eventHandler.split(" ")[0]);

	}
	$(this).each(function(){
		init($(this));
	});
	return this;
}

