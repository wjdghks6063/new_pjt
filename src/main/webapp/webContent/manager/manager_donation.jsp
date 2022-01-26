<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common_header_ljh.jsp"%>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--페이지 css-->
<link href="css/css_ljh/mypage-menu.css" rel="stylesheet">
<link href="css/css_ljh/manager-donation.css" rel="stylesheet">

<form name="goPage">
	<input type="hidden" name="t_gubun">
</form>

<form name="goPageSelect">
	<input type="hidden" name="t_gubun">
	<input type="hidden" name="t_select">
	<input type="hidden" name="t_search">
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
	function goMenu(search){
		menu.t_search.value=search;
		menu.t_gubun.value="Dona";
		menu.method="post";
		menu.action="Manager";
		menu.submit();
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
	function goSearchSelect(select1,search){
		goPageSelect.t_gubun.value="Dona_Search";
		goPageSelect.t_select.value=select1;
		goPageSelect.t_search.value=search;
		goPageSelect.method="post";
		goPageSelect.action="Manager";
		goPageSelect.submit();
	}
</script>

<body>
<div id="containar">

    <div class="my-page-box">
        <div class="my-list-left">
            <div class="my-profile">
                <img src="../홈페이지_기본_레이아웃/img/heart.png" width="72" height="72" alt="유저 프로필 사진" class="my-profile-img" 
                    style="background-color: white;" id="profileImageArea">
                <div class="my_profile_nickname">
                    <span class="ellipsis" id="nickNameArea">${session_name}</span>
                </div>
                <div class="my_profile_id" id="maskingIdArea">${session_id}</div>
            </div>
            <div id="lnb" class="my_lnb" role="menu">
                <a href="javascript:goHome()" role="menuitem" class="my_lnb_item" id="lnb_my_home" aria-current="false">MY홈</a> 
                <a href="javascript:goDona()" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="true">기부</a>
                <a href="javascript:goVol()" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="false">봉사</a> 
                <a href="../홈페이지_기본_레이아웃/manager-Year-end-settlement.html"role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">회원 관리</a>
            </div>
        </div>
        
            <!--후원 금액 표시 -->
        <div role="main" id="content" class="my_content">

            <h3 class="my_title">기부 내역</h3>
                <form name="menu">
                	<input type="hidden" name="t_search">
                	<input type="hidden" name="t_gubun">
                    <fieldset>
                        <legend class="blind">활동내역 필터</legend>
                        <div class="activity_category" aria-hidden="false"> <!-- aria-pressed="true" 면 색 들어옴 -->
                            <a href="javascript:goMenu('')" role="button"class="activity_category_item" id="all" <c:if test="${t_search eq ''}">aria-pressed='true'</c:if>>전체 조회</a> 
                            <a href="javascript:goMenu('senior')" role="button" class="activity_category_item" id="senior"  <c:if test="${t_search eq 'senior'}">aria-pressed='true'</c:if>>노인</a> 
                            <a href="javascript:goMenu('child')" role="button" class="activity_category_item" id="child" <c:if test="${t_search eq 'child'}">aria-pressed='true'</c:if>>아동</a> 
                            <a href="javascript:goMenu('disabled')" role="button" class="activity_category_item" id="disabled" <c:if test="${t_search eq 'disabled'}">aria-pressed='true'</c:if>>장애</a>
                            <a href="javascript:goMenu('disaster')" role="button" class="activity_category_item" id="disaster" <c:if test="${t_search eq 'disaster'}">aria-pressed='true'</c:if>>재난</a>
                        </div>
                            <div class="activity_category_link" data-type="payment"><a href="javascript:goSearch()" class="link" id="activity_category_payment">
                            <i class="fas fa-search"></i>&nbsp;&nbsp;상세 검색</a>
                        </div>
                    </fieldset>
                    <div class="my_npaybanner_wrap" style="display:none"></div>
                </form>


            <div class="my_summary_wrap" id="mySummaryAll">
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">오늘의 기부 일정</h3>
                        <span class="number_wrap"><span class="number" id="myCashTotal">${TD_list_num}</span> 건</span>
                    </div>
                    <a href="" class="my_summary_item"><span class="title">달성 완료</span><span class="number_wrap"><strong class="number" id="myProject">${TDC_list_num}</strong> 건</span></a>
                    <a href="" class="my_summary_item"><span class="title">달성 미달</span><span class="number_wrap"><strong class="number" id="myProject">${TDD_list_num}</strong> 건</span></a> 
                </div>
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">이번 주 기부 일정</h3>
                        <span class="number_wrap"><span class="number" id="myCashTotal">${TW_list_num}</span> 건</span>
                    </div>
                    <a href="" class="my_summary_item"><span class="title">진행 중</span><span class="number_wrap"><strong class="number" id="myProject">${TWP_list_num}</strong> 건</span></a>
                    <a href="" class="my_summary_item"><span class="title">달성 완료</span><span class="number_wrap"><strong class="number" id="myProject">${TWC_list_num}</strong> 건</span></a> 
                    <a href="" class="my_summary_item"><span class="title">마감</span><span class="number_wrap"><strong class="number" id="myProject">${TWD_list_num}</strong> 건</span></a> 
                </div>
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">이번 달 기부 일정</h3>
                        <span class="number_wrap"><span class="number" id="myCashTotal">${TM_list_num}</span> 건</span>
                    </div>
                    <a href="" class="my_summary_item"><span class="title">진행 중</span><span class="number_wrap"><strong class="number" id="myProject">${TMP_list_num}</strong> 건</span></a>
                    <a href="" class="my_summary_item"><span class="title">달성 완료</span><span class="number_wrap"><strong class="number" id="myProject">${TMC_list_num}</strong> 건</span></a> 
                    <a href="" class="my_summary_item"><span class="title">마감</span><span class="number_wrap"><strong class="number" id="myProject">${TMD_list_num}</strong> 건</span></a>
                </div>
            </div>
        
                <!-- 진행중 기부 -->
			<div class="my_recent_news_wrap" id="my_notification">
				<c:set var="Month_dona" value="${PMD_list}"></c:set>
				<!--게시글의 총 갯수를 표시하기위해  arraylist를 today_dona라는 변수로 선언한다. 그 뒤에 ${fn:length(today_dona)}로 리스트의 크기를 계산한다. fn:length를 사용하기 위해선-->
				<!--taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"를 위쪽에 써주어야 사용가능하다.-->
				<h3 class="my_recent_news_title">이달의 진행 기부 현황</h3>
				<span class="my_recent_news_count">총<span class="number"
					id="my_notification_count">${fn:length(Month_dona)}</span>건
				</span>
				<!-- 검색 결과가 없을 경우 -->    
                <c:choose>
					<c:when test="${PMD_list_num eq 0}">
						<div class="my_recent_activity_wrap" id="searchNothing"><!--기본을 none 처리후 결과에 따라 block 처리해아함-->
	                        <div class="none_message">
	                            <p class="none_message_inner">진행중인 기부가 없습니다. 
	                            	<span class="small_text">조건을 확인해주세요.</span>
	                            </p>
	                        </div>
                    	</div>
					</c:when>
					<c:otherwise>
					<div class="my_recent_news_feed">
						<!--전체 보기-->
						<ol class="list_news" id="my_notification_list">
							<!-- 마감일이 가까워지는 순서대로 보여져야 함-->
							<c:forEach items="${PMD_list}" var="pmd_list">
								<li class="item_news type_donation">
									<div class="card_news">
										<a href="javascript:goView('${pmd_list.getNo()}')" class="link"></a>
										<p class="text_content">${pmd_list.getDo_title()} (날짜:
											${pmd_list.getDo_start_date()} ~ ${pmd_list.getDo_end_date()})</p>
										<span class="text_information">${pmd_list.getDo_name()}</span>
										<!--진행 상황 표시를 위해  퍼센트 표시 -->
										<c:set var="gage" value="${pmd_list.getDo_total() / pmd_list.getDo_goal() *100}" />
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
												<c:when test="${pmd_list.getDo_end_date() eq pmd_list.getDo_today()}">
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
					</c:otherwise>
				</c:choose>
				<a href="javascript:goSearchSelect('${t_search}','ing')"
					class="my_recent_news_link">전체보기 <i
					class="fas fa-chevron-right"></i></a>

			</div>

            <!-- 달성 완료 기부 -->
			<div class="my_recent_news_wrap" id="my_notification">
				<c:set var="Month_dona" value="${CMD_list}"></c:set>
				<!--게시글의 총 갯수를 표시하기위해  arraylist를 today_dona라는 변수로 선언한다. 그 뒤에 ${fn:length(today_dona)}로 리스트의 크기를 계산한다. fn:length를 사용하기 위해선-->
				<!--taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"를 위쪽에 써주어야 사용가능하다.-->
				<h3 class="my_recent_news_title">이달의 목표 달성</h3>
				<span class="my_recent_news_count">총<span class="number"
					id="my_notification_count">${fn:length(Month_dona)}</span>건
				</span>
				<!-- 검색 결과가 없을 경우 -->    
                <c:choose>
					<c:when test="${CMD_list_num eq 0}">
						<div class="my_recent_activity_wrap" id="searchNothing"><!--기본을 none 처리후 결과에 따라 block 처리해아함-->
	                        <div class="none_message">
	                            <p class="none_message_inner">목표 달성된 기부가 없습니다. 
	                            	<span class="small_text">조건을 확인해주세요.</span>
	                            </p>
	                        </div>
                    	</div>
					</c:when>
					<c:otherwise>
				<div class="my_recent_news_feed">
					<!--전체 보기-->
					<ol class="list_news" id="my_notification_list">
						<!-- 마감일이 가까워지는 순서대로 보여져야 함-->
						<c:forEach items="${CMD_list}" var="cmd_list">
							<li class="item_news type_donation">
								<div class="card_news">
									<a href="javascript:goView('${cmd_list.getNo()}')" class="link"></a>
									<p class="text_content">${cmd_list.getDo_title()} (날짜:
										${cmd_list.getDo_start_date()} ~ ${cmd_list.getDo_end_date()})</p>
									<span class="text_information">${cmd_list.getDo_name()}</span>
									<!--진행 상황 표시를 위해  퍼센트 표시 -->
									<c:set var="gage" value="${cmd_list.getDo_total() / cmd_list.getDo_goal() *100}" />
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
											<c:when test="${cmd_list.getDo_end_date() eq cmd_list.getDo_today()}">
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
				</c:otherwise>
				</c:choose>
				<a href="javascript:goSearchSelect('${t_search}','goal')"
					class="my_recent_news_link">전체보기 <i
					class="fas fa-chevron-right"></i></a>

			</div>

        </div><!-- 활동 내용 div-->


        </div>
    </div>

        <script>
        

        </script>
        
        

</body>
<!--footer -->
<%@ include file = "../common_footer.jsp" %>