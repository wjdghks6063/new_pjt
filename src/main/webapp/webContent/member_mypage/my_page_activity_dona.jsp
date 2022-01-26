<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common_header.jsp" %>

    <!--페이지 css-->
    <link href="css/mypage-menu.css" rel="stylesheet">
    <link href="css/mypage-activity.css" rel="stylesheet">

    <!-- 달력기능 css,js-->
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="css/daterangepicker-master/daterangepicker.css">
    <!-- js -->
    <script type="text/javascript" src="css/daterangepicker-master/moment.min.js"></script>
    <script type="text/javascript" src="css/daterangepicker-master/daterangepicker.js"></script>

<script>
$(function () {
    $('#calendar_1').daterangepicker({
        "singleDatePicker": true, /*달력 한개 사용여부 기본은 달력 2개*/
        "showDropdowns": true, /*년 일 수동으로 선택 가능 여부*/
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인", /*확인 버튼 이름*/
            "cancelLabel": "취소", /*취소 버튼 이름*/
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
     
        "startDate": my_page.calendar_1.value, /*달력 시작 일자*/
        "endDate":  my_page.calendar_1.value,  /*달력 끝나는 일자*/
        /*"maxDate": "2022/2/22", 달력 최대 값 설정*/
        /* 달력 옆에 선택 버튼 생성
        ranges: {
            '오늘': [moment(), moment()],
            '어제': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '일주일 전': [moment().subtract(6, 'days'), moment()],
            '30일 전': [moment().subtract(29, 'days'), moment()],
            '이번 달': [moment().startOf('month'), moment().endOf('month')],
            '저번 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },*/
        "opens": "left", /*달력 열리는 위치 기본값 right, left, center*/
        "drops": "auto" /*기본값 달력 아래로 내려옴 "down" 위로 "up"*/
    }, function (start, end, label) {
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
});

$(function () {
	
    $('#calendar_2').daterangepicker({
        "singleDatePicker": true, /*달력 한개 사용여부 기본은 달력 2개*/
        "showDropdowns": true, /*년 일 수동으로 선택 가능 여부*/
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인", /*확인 버튼 이름*/
            "cancelLabel": "취소", /*취소 버튼 이름*/
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "startDate": my_page.calendar_2.value, /*달력 시작 일자*/
        "endDate": my_page.calendar_2.value,  /*달력 끝나는 일자*/
        /*"maxDate": "2022/2/22", 달력 최대 값 설정*/
        /* 달력 옆에 선택 버튼 생성
        ranges: {
            '오늘': [moment(), moment()],
            '어제': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '일주일 전': [moment().subtract(6, 'days'), moment()],
            '30일 전': [moment().subtract(29, 'days'), moment()],
            '이번 달': [moment().startOf('month'), moment().endOf('month')],
            '저번 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },*/
        "opens": "right", /*달력 열리는 위치 기본값 right, left, center*/
        "drops": "auto" /*기본값 달력 아래로 내려옴 "down" 위로 "up"*/
    }, function (start, end, label) {
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
});

	
	function goSearch(){
		my_page.t_more.value="0";
		my_page.method="post";
		my_page.action="Mypage_activity_dona";
		my_page.submit();
	}
	

	
	$(document).ready(function(){
		$("#more_bottun").click(function(){
		    var urlLocation="Mypage_activity_dona"; 
		    var more = my_page.t_more.value;
		    var dayone = my_page.calendar_1.value;
		    var daytwo = my_page.calendar_2.value;
		    var id = my_page.t_id.value;
		    var objDiv = document.getElementById("more_bottun");
			$.ajax({
				type : "POST",
				url : urlLocation,
				data: {"t_id":id,"calender_1":dayone,"calender_2":daytwo,"t_more":more},
				dataType : "text",
				error : function(){
					alert('통신실패!!');
				},
				success : function(data){
					//alert("통신데이터 값 : " + data);
					my_page.method="post";
					my_page.action="Mypage_activity_dona";
					my_page.submit();
				}
				})
		})
	});

	


</script>

    <div id="containar">
        <!--script 밑에 body와 </div> 있음-->
        <div id="warp" class="warp">
       
        </div>

        <!-- 마이 페이지 메뉴-->
        <div class="my-page-box">
            <div class="my-list-left">
             <div class="my-profile">
                <div class="my_profile_nickname">
                    <span class="ellipsis" id="nickNameArea">${session_name}</span>
                </div>
                <div class="my_profile_id" id="maskingIdArea">${session_id}</div>
            </div>
                <div id="lnb" class="my_lnb" role="menu">
                    <!-- aria-current="#" 여부에 따라 색상 불 들어옴-->
                    <a href="Mypage_home?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_home" aria-current="false">MY홈</a>
                    <a href="Mypage_news?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="false">내 소식</a>
                    <a href="Mypage_activity?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="true">활동내역</a>
                    <a href="Mypage_regular_payment?t_id=${session_id}" role="menuitem" id="my_lnb_item" class="my_lnb_item" aria-current="false">정기결제관리</a>
                    <a href="Mypage_year?t_id=${session_id}" role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">연말정산</a>
                </div>
            </div>


            <!-- 내용 창 -->
            <div role="main" id="content" class="my_content">
                <h3 class="my_title">활동내역 </h3>
                <form name="my_page">
                	<input type="hidden" name="t_id" value="${session_id}">
                    <fieldset>
                        <legend class="blind">활동내역 필터</legend>
                        <div  class="activity_category" aria-hidden="false"> <!-- aria-pressed="true" 면 색 들어옴 -->
                            <a href="Mypage_activity?t_id=${session_id}" role="button"class="activity_category_item" id="all" aria-pressed="false" data-type="all">전체 내역</a> 
                            <a href="Mypage_activity_dona?t_id=${session_id}" role="button" class="activity_category_item" id="donation" aria-pressed="true" data-type="donation">기부 내역</a> 
                            <a href="Mypage_activity_vol?t_id=${session_id}" role="button" class="activity_category_item" id="deposit" aria-pressed="false" data-type="deposit">참여 내역</a>

                        </div>
                    </fieldset>
             
                    <div class="my_npaybanner_wrap"></div>

                    <!-- 달력 -->
                    <div class="my_activity_calendar_wrap">
                        <div class="activity_calendar_btn_wrap" id="prevCalendar">
                            <input type="text" id="calendar_1" name="calendar_1" value="${t_day_1}">
                        </div>
                        ~
                        <div class="activity_calendar_btn_wrap" id="prevCalendar">
                            <input type="text" id="calendar_2" name="calendar_2" value="${t_day_2}">
                        </div>

                        <button type="button" class="activity_calendar_search" onclick="goSearch()" id="searchButton">검색</button>
                    </div>
 				
                           <div class="my_summary_donation class_my_summary">
					<div class="my_summary_donation_box">
						<span class="title">후원한 총 모금함</span>
						<span class="amount"><span class="number">${t_search_count}</span>번</span>
					</div>
					<div class="my_summary_donation_box">
						<span class="title">총 기부 금액</span>
						<span class="amount"><span class="number"><fmt:formatNumber value="${t_search_amount}" pattern="#,###"/></span>원</span>
					</div>
				</div>
					<c:forEach items="${t_dtos}" var ="dtos" varStatus="StatusNm">
                    <div style="margin-top:-8px;" class="my_recent_activity_wrap" id="myActivityAll" aria-hidden="false">
                        <h3 class="blind">선택한 내역 </h3>
                        <div id="timelineArea">
                       
                            <ul class="my_activity_list" id="timeline202201">
                                <li class="my_activity_cong timeline_root">
                                    <div class="my_activity_inner">
                                        <div class="my_activity_left">
                                            <div>
                                            	<c:choose> 
                                            	<c:when test="${fn:substring(dtos.getDona_no(),0,1) eq 'D'}">
                                            		<div>기부</div>
                                            	</c:when>
                                            	</c:choose>
                                            </div>
                                        </div>
                                        <div class="my_activity_center">
                                            <strong class="my_activity_date">${dtos.getDona_date()}</strong>
                                            <!-- <strong class="my_activity_text2">${dtos.getDona_date()}</strong> -->
                                            <span class="my_activity_title">${dtos.getDona_title() }</span>
                                        </div>
                                        <div class="my_activity_right">
                                            <div class="my_activity_price"><strong class="number"><c:if test="${dtos.getDona_amount() >= 5}"> <fmt:formatNumber value="${dtos.getDona_amount()}" pattern="#,###"/> 원</c:if></strong></div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
						
                        </div>
                         </div>
                        </c:forEach>
                        <!-- 내용이 많은 경우 더보기 버튼 활성화 -->
                        <c:if test="${t_total_count ne t_dtos.size()}">
                        <button type="button" class="btn_horizontal_more" id="more_bottun">더보기</button>
                        </c:if>
                         <input type="hidden" name="t_more" value="${t_more}">
                   

                   
                      <c:if test="${empty t_dtos}">
                    <div class="my_recent_activity_wrap" id="searchNothing">
                        <div class="none_message">
                            <p class="none_message_inner">조회내역이 없습니다. <span class="small_text">조회 기간 또는 조건을 확인해
                                    주세요.</span></p>
                        </div>
                    </div>
                     </c:if>
                </form>
            </div>


        </div>
        <!--my-page-box-->



        <script>
            /*메인 header 따라 오기 */
            let header = document.querySelector(".header-header-1");
            let headerHeight = header.offsetHeight;

            window.onscroll = function () {
                let windowTop = window.scrollY;
                if (windowTop >= headerHeight) {
                    header.classList.add("is-scroll");
                } else {
                    header.classList.remove("is-scroll");
                }
            };
            // 

            var kkeys = [],
                konami = "38,38,40,40,37,39,37,39,66,65";
            $(document).keydown(function (e) {
                kkeys.push(e.keyCode);
                if (kkeys.toString().indexOf(konami) >= 0) {
                    kkeys = [];
                    alert('안녕하세요');
                }
            });

    
        </script>

    </div>
</body>
<!--footer -->
<footer class="footer-box">
    <div class="footer-top">
        <dl class="footer-top-box">
            <dt class="footer-top-notice"><a href="">공지사항</a></dt>
            <dd class="foorer-top-notice-text">
                <a href="">회원 가입시 개인정보 관리 내역에 대해 안내해드립니다.<i class="icon-n"><i class="fab fa-envira"></i></i></a>
            </dd>
        </dl>
        <div class="service-info-box" aria-hidden="false">
            <dl class="service-info-first-line">
                <dt class="service-info-first-line-title">해피빈 안내</dt>
                <dd class="service-info-first-line-item"><a href="">해피빈 소개</a></dd>
                <dd class="service-info-first-line-item"><a href="">콩받기 안내</a></dd>
                <dd class="service-info-first-line-item"><a href="">해피빈 현황</a></dd>
                <dd class="service-info-first-line-item"><a href="">콩구폰 입력</a></dd>
            </dl>
            <dl class="service-info-first-line">
                <dt class="service-info-first-line-title">제휴∙단체안내</dt>
                <dd class="service-info-first-line-item"><a href="">해피로그 가입</a></dd>
                <dd class="service-info-first-line-item"><a href="">기업제휴 문의</a></dd>
                <dd class="service-info-first-line-item"><a href="">펀딩 개설 신청</a></dd>
            </dl>
        </div>
    </div>

    <div class="footer-info-box">
        <div class="footer-info-inner">
            <ul class="footer-info-list">
                <li class="footer-info-item"><a href="" target="해피빈 이용약관">해피빈 이용약관</a></li>
                <li class="footer-info-item"><a href="" target="개인정보처리방침"><strong>개인정보처리방침</strong></a></li>
                <li class="footer-info-item"><a href="" target="책임의 한계와 법적고지">책임의 한계와 법적고지</a></li>
                <li class="footer-info-item"><a href="" target="고객센터">고객센터</a></li>
                <li class="footer-info-item"><a href="" target="공익제보(행정안전부)">공익제보(행정안전부)</a></li>
            </ul><br>
            <!--ul 끼리 붙어 있어 줄바꿈이 생기지 않아서 넣어줌-->
            <ul class="footer-info-list">
                <li class="footer-info-item">제단법인 굿아이디어</li>
                <li class="footer-info-item">대표 : 최정우</li>
                <li class="footer-info-item">사업자 등록번호 :199-40-91928</li>
                <li class="footer-info-item">통신판매업신고 : 2015-대전충남-1994호</li>
            </ul><br>
            <address class="footer-info-address">대전 충남 대덕대로 150 11층 (갈마동,창원빌딩) 대표전화 : 1588-8282</address>
            <small class="footer-info_notice">
                재능 기부 및 직접기부의 진행과 리워드 제공의 책임은 해당 프로젝트의 개설자에게 있습니다. 굿아이디어는 해당 프로젝트의 당사자가 아니며, 리워드 제공에 대한 책임을 지지 않습니다.
            </small>
            <div class="footer-info-copyright">
                <a href="" class="footer-info-logo">
                    <img src="img/company.png" class="company-logo" alt="LOGO">
                </a> <br>
                <span class="Copyright">Copyright © G&I Corp. All Rights Reserved.</span>
            </div>
        </div>
    </div>

</footer>

</div>
</div>
</div>

</html>