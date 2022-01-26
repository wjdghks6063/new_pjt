<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> <!-- 배열의 크기를 구하기 위해 넣음 -->
<%@ include file="../common_header_ljh.jsp"%>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--페이지 css-->
<link href="css/css_ljh/mypage-menu.css" rel="stylesheet">
<link href="css/css_ljh/manager-home.css" rel="stylesheet">
<!--script 밑에 body와 </div> 있음-->

<form name="goPage">
	<input type="hidden" name="t_gubun">
</form>

<form name="view">
	<input type="hidden" name="t_no">
	<input type="hidden" name="t_gubun">
</form>

<script>
function goHome(){
	goPage.t_gubun.value="Home";
	goPage.method="post";
	goPage.action="Manager";
	goPage.submit();
}
function goDona(){
	goPage.t_gubun.value="Dona";
	goPage.method="post";
	goPage.action="Manager";
	goPage.submit();
}
function goVol(){
	goPage.t_gubun.value="Vol";
	goPage.method="post";
	goPage.action="Manager";
	goPage.submit();
}

function goSearch(){
	goPage.t_gubun.value="Dona_Search";
	goPage.method="post";
	goPage.action="Manager";
	goPage.submit();
}
function goView(no){
	view.t_no.value=no;
	view.t_gubun.value="View";
	view.method="post";
	view.action="Donation";
	view.submit();
}
</script>
	
	<body>
		<div id="containar">
			<div class="my-page-box">
				<div class="my-list-left">
					<div class="my-profile">
						<img src="../홈페이지_기본_레이아웃/img/heart.png" width="72" height="72"
							alt="유저 프로필 사진" class="my-profile-img"
							style="background-color: white;" id="profileImageArea">
						<div class="my_profile_nickname">
							<span class="ellipsis" id="nickNameArea">${session_name}</span>
						</div>
						<div class="my_profile_id" id="maskingIdArea">${session_id}</div>
					</div>
					 <div id="lnb" class="my_lnb" role="menu">
		             	<a href="javascript:goHome()" role="menuitem" class="my_lnb_item" id="lnb_my_home" aria-current="true">MY홈</a> 
		                <a href="javascript:goDona()" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="false">기부</a>
		                <a href="javascript:goVol()" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="false">봉사</a> 
		                <a href="../홈페이지_기본_레이아웃/manager-Year-end-settlement.html"role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">회원 관리</a>
		            </div>
				</div>

				<!--후원 금액 표시 -->
				<div role="main" id="content" class="my_content">
					<div class="my_summary_wrap" id="mySummaryAll">
						<div class="my_summary_box">
							<div class="my_summary_title">
								<h3 class="title">오늘의 후원금액</h3>
								<span class="number_donation"><span class="big_number"
									id="myCashTotal"></span> 원</span>
							</div>
							<c:set var="total_money" value="0"></c:set>
							<!-- 모든 금액을 더하여 오늘의 후원금액을 표시한다. 기본값을  0으로 둔다.-->
							<c:forEach items="${list}" var="list">
								<a href="" class="my_summary_item"> <span class="title">${list.getSearch_name()}</span>

									<span class="number_wrap"> <strong class="number">
										<fmt:formatNumber value="${list.getItem_money()}" pattern="#,###" /> </strong> 원
								</span> <c:set var="total_money"
										value="${total_money + list.getItem_money()}" /> <!-- total_money에 리스트의 값을 더한다-->
							</c:forEach>
							</a>

							<!--a href="" class="my_summary_item"><span class="title">노인</span><span class="number_wrap"><strong class="number" id="myProject">0</strong> 원</span></a> 
                    <a href="" class="my_summary_item"><span class="title">장애</span><span class="number_wrap"><strong class="number" id="myProject">0</strong> 원</span></a> 
                    <a href="" class="my_summary_item"><span class="title">재난</span><span class="number_wrap"><strong class="number" id="myProject">0</strong> 원</span></a-->
						</div>
						<div class="my_summary_box">
							<div class="my_summary_title">
								<h3 class="title">오늘의 봉사 일정</h3>
								<c:forEach items="${vol_list}" var="vol_list">
									<c:set var="total_vol" value="${vol_list.getEnd_vol()}" />
									<!-- javascript에 넣기 위해 변수를 선언한다.-->
									<span class="number_volunteer"><strong
										class="big_number" id="myVolTotal"></strong> 건</span>
							</div>
							<a href="" class="my_summary_item">
								<span class="title">오늘의 봉사 참여 인원</span>
								<span class="number_wrap">
									<strong class="number"><fmt:formatNumber value="${vol_list.getTotal_vol()}" pattern="#,###" /></strong>
								명</span></a> 
							<a href="" class="my_summary_item">
									<span class="title">오늘 작성된 봉사 게시글</span>
									<span class="number_wrap">
										<strong class="number"><fmt:formatNumber value="${vol_list.getStart_vol()}" pattern="#,###" /></strong> 건
									</span>
							</a>
							</c:forEach>
						</div>
					</div>

					<!-- 내 소식 -->
					<div class="my_recent_news_wrap" id="my_notification">
						<c:set var="today_dona" value="${PWD_list}"></c:set>
						<!--게시글의 총 갯수를 표시하기위해  arraylist를 today_dona라는 변수로 선언한다. 그 뒤에 ${fn:length(today_dona)}로 리스트의 크기를 계산한다. fn:length를 사용하기 위해선-->
						<!--taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"를 위쪽에 써주어야 사용가능하다.-->
						<h3 class="my_recent_news_title">이번 주  기부 일정</h3>
						<span class="my_recent_news_count">총<span class="number"
							id="my_notification_count">${fn:length(today_dona)}</span>건
						</span>
						<div class="my_recent_news_feed">
							<!--전체 보기-->
							<ol class="list_news" id="my_notification_list">
								<!-- 마감일이 가까워지는 순서대로 보여져야 함-->
								<c:forEach items="${PWD_list}" var="pwd_list">
									<li class="item_news type_donation">
										<div class="card_news">
											<a href="javascript:goView('${pwd_list.getNo()}')" class="link"></a>
											<p class="text_content">${pwd_list.getDo_title()} (날짜:
												${pwd_list.getDo_start_date()} ~ ${pwd_list.getDo_end_date()})</p>
											<span class="text_information">${pwd_list.getDo_name()}</span>
											<!--진행 상황 표시를 위해  퍼센트 표시 -->
											<c:set var="gage" value="${pwd_list.getDo_total() / pwd_list.getDo_goal() *100}" />
											<!-- gage로 처리하면 99.9647 이런식이라 100%가 적용되지 않기 때문에 gage+((gage%1>0.5)?(1-(gage%1))%1:-(gage%1))로 반올림 처리한다 -->
												<span class="text_information">
													<fmt:parseNumber var="gage1" value="${gage}" integerOnly="true" />
													<!-- gage의 값을 var=gage1 로 선언한다. gage1의 소숫점을버리고 출력한다. 사용하기위해선 taglib으로 jstl을 선언해야함 -->
													${gage1}% &nbsp달성
												</span>
												<c:choose>
													<c:when test="${gage-(gage%1) >= 100}">
														<span class="text_complete">달성 완료</span>
													</c:when>
												</c:choose>
												<c:choose>
													<c:when test="${pwd_list.getDo_end_date() eq pwd_list.getDo_today()}">
														<span class="text_fail">오늘 마감</span>
													</c:when>
												</c:choose>
											<button class="button_delete"
												data-id="61d7a8bc2c5ccf943ae43321">
												<span class="blind">삭제</span>
											</button>
										</div>
									</li>
								</c:forEach>
							</ol>
						</div>
						<a href="../홈페이지_기본_레이아웃/manager-donation.html"
							class="my_recent_news_link">전체보기 <i
							class="fas fa-chevron-right"></i></a>

					</div>

					<!-- 내 소식 -->
					<div class="my_recent_news_wrap" id="my_notification">
						<c:set var="today_vol" value="${PWV_list}"></c:set>
						<!--게시글의 총 갯수를 표시하기위해  arraylist를 today_dona라는 변수로 선언한다. 그 뒤에 ${fn:length(today_dona)}로 리스트의 크기를 계산한다. fn:length를 사용하기 위해선-->
						<!--taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"를 위쪽에 써주어야 사용가능하다.-->
						<h3 class="my_recent_news_title">이번 주 봉사 일정</h3>
						<span class="my_recent_vol_count">총<span class="number"
							id="my_notification_count">${fn:length(today_vol)}</span>건
						</span>
						<div class="my_recent_news_feed">
							<!--전체 보기-->
							<ol class="list_news" id="my_notification_list">
								<c:forEach items="${PWV_list}" var="pwv_list">
								<li class="item_news type_funding">
									<div class="card_news">
										<a href="" class="link"></a>
										<p class="text_content">${pwv_list.getVol_title()} (장소: ${pwv_list.getVol_site()})</p>
										<span class="text_information">${pwv_list.getVolname()}</span> 
										<span class="text_information">참여인원 : ${pwv_list.getVol_total()} / ${pwv_list.getVol_goal()} 명</span>
										<span class="text_information">모집기간 : ${pwv_list.getVol_start_date()} ~ ${pwv_list.getVol_end_date()}</span>
										<button class="button_delete"
											data-id="61d7a8bc2c5ccf943ae43321">
											<span class="blind">삭제</span>
										</button>
									</div>
								</li>
								</c:forEach>
							</ol>
						</div>
						<a href="../홈페이지_기본_레이아웃/manager-volunteer.html"
							class="my_recent_news_link">전체보기 <i
							class="fas fa-chevron-right"></i></a>
					</div>

				</div>
				<!-- 활동 내용 div-->


			</div>
		</div>


<script>
            /*메인 header 따라 오기 index.jsp에 넣어둠 
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
            */

            var kkeys = [],
                konami = "38,38,40,40,37,39,37,39,66,65";
            $(document).keydown(function (e) {
                kkeys.push(e.keyCode);
                if (kkeys.toString().indexOf(konami) >= 0) {
                    kkeys = [];
                    alert('안녕하세요');
                }
            });

            /* 후원 금액 숫자 순차적 증가*/
    /* 후원 금액 숫자 순차적 증가*/
    $({ val : 0 }).animate({ val : ${total_money} }, { /*val : 0 /시작 숫자 / val : 150000 종료 숫자 */
        step: function() {
            var num = numberWithCommas(Math.floor(this.val)); 
            $("#myCashTotal").text(num);
        },
        complete: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#myCashTotal").text(num);
        }
    });
    
    $({ val : 0 }).animate({ val : ${total_vol} }, { /*val : 0 /시작 숫자 / val : 150000 종료 숫자 */
        step: function() {
            var num = numberWithCommas(Math.floor(this.val)); 
            $("#myVolTotal").text(num);
        },
        complete: function() {
            var num = numberWithCommas(Math.floor(this.val));
            $("#myVolTotal").text(num);
        }
    });


    //3번째 자리마다 콤마 찍어줌
    function numberWithCommas(x) { //numberWithCommas 3자리마다 콤마
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
        </script>

</body>

<!--footer -->
<%@ include file = "../common_footer.jsp" %>
