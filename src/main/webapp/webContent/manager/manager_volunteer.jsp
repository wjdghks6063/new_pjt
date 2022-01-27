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
<link href="css/css_ljh/manager-volunteer.css" rel="stylesheet">

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
		menu.t_gubun.value="Vol";
		menu.method="post";
		menu.action="Manager";
		menu.submit();
	}
	function goSearch(){
		goPage.t_gubun.value="Vol_Search";
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
		goPageSelect.t_gubun.value="Vol_Search";
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
                <a href="javascript:goDona()" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="false">기부</a>
                <a href="javascript:goVol()" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="true">봉사</a> 
                <a href="../홈페이지_기본_레이아웃/manager-Year-end-settlement.html"role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">회원 관리</a>
            </div>
        </div>
        
            <!--후원 금액 표시 -->
        <div role="main" id="content" class="my_content">

            <h3 class="my_title">봉사 내역</h3>
                <form name="menu">
                	<input type="hidden" name="t_search">
                	<input type="hidden" name="t_gubun">
                    <fieldset>
                        <legend class="blind">활동내역 필터</legend>
                        <div class="activity_category" aria-hidden="false"> <!-- aria-pressed="true" 면 색 들어옴 -->
                            <a href="javascript:goMenu('')" role="button"class="activity_category_item" id="all" <c:if test="${t_search eq ''}">aria-pressed='true'</c:if>>전체 조회</a> 
                            <a href="javascript:goMenu('dong-gu')" role="button" class="activity_category_item" id="dong-gu"  <c:if test="${t_search eq 'dong-gu'}">aria-pressed='true'</c:if>>동구</a> 
                            <a href="javascript:goMenu('jung-gu')" role="button" class="activity_category_item" id="jung-gu" <c:if test="${t_search eq 'jung-gu'}">aria-pressed='true'</c:if>>중구</a> 
                            <a href="javascript:goMenu('seo-gu')" role="button" class="activity_category_item" id="seo-gu" <c:if test="${t_search eq 'seo-gu'}">aria-pressed='true'</c:if>>서구</a>
                            <a href="javascript:goMenu('yuseong')" role="button" class="activity_category_item" id="yuseong" <c:if test="${t_search eq 'yuseong'}">aria-pressed='true'</c:if>>유성구</a>
                            <a href="javascript:goMenu('daedeok')" role="button" class="activity_category_item" id="daedeok" <c:if test="${t_search eq 'daedeok'}">aria-pressed='true'</c:if>>대덕구</a>
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
                        <h3 class="title">오늘의 봉사 일정</h3>
                    <c:forEach items="${VT_list}" var="vt_list">   
                        <span class="number_wrap"><span class="number" id="myCashTotal">${vt_list.getEnd_vol()}</span> 건</span>
                    </div>
                    <a href="" class="my_summary_item"><span class="title">달성 완료</span><span class="number_wrap"><strong class="number" id="myProject">${vt_list.getTotal_vol()}</strong> 건</span></a>
                    <a href="" class="my_summary_item"><span class="title">달성 미달</span><span class="number_wrap"><strong class="number" id="myProject">${vt_list.getStart_vol()}</strong> 건</span></a>
                    </c:forEach>  
                </div>
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">이번 주 봉사 일정</h3>
                    <c:forEach items="${VW_list}" var="vw_list">  
                        <span class="number_wrap"><span class="number" id="myCashTotal">${vw_list.getDo_total()}</span> 건</span>
                    </div>
                    <a href="" class="my_summary_item"><span class="title">진행 중</span><span class="number_wrap"><strong class="number" id="myProject">${vw_list.getDo_pro()}</strong> 건</span></a>
                    <a href="" class="my_summary_item"><span class="title">달성 완료</span><span class="number_wrap"><strong class="number" id="myProject">${vw_list.getDo_com()}</strong> 건</span></a> 
                    <a href="" class="my_summary_item"><span class="title">마감</span><span class="number_wrap"><strong class="number" id="myProject">${vw_list.getDo_end()}</strong> 건</span></a>
                    </c:forEach>    
                </div>
                <div class="my_summary_box">
                    <div class="my_summary_title">
                        <h3 class="title">이번 달 봉사 일정</h3>
                    <c:forEach items="${VM_list}" var="vm_list"> 
                        <span class="number_wrap"><span class="number" id="myCashTotal">${vm_list.getDo_total()}</span> 건</span>
                    </div>
                    <a href="" class="my_summary_item"><span class="title">진행 중</span><span class="number_wrap"><strong class="number" id="myProject">${vm_list.getDo_pro()}</strong> 건</span></a>
                    <a href="" class="my_summary_item"><span class="title">달성 완료</span><span class="number_wrap"><strong class="number" id="myProject">${vm_list.getDo_com()}</strong> 건</span></a> 
                    <a href="" class="my_summary_item"><span class="title">마감</span><span class="number_wrap"><strong class="number" id="myProject">${vm_list.getDo_end()}</strong> 건</span></a>
                    </c:forEach>   
                </div>
            </div>
        
                <!-- 진행중 기부 -->
			<div class="my_recent_news_wrap" id="my_notification">
				<c:set var="Month_vol" value="${PMV_list}"></c:set>
				<!--게시글의 총 갯수를 표시하기위해  arraylist를 today_dona라는 변수로 선언한다. 그 뒤에 ${fn:length(today_dona)}로 리스트의 크기를 계산한다. fn:length를 사용하기 위해선-->
				<!--taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"를 위쪽에 써주어야 사용가능하다.-->
				<h3 class="my_recent_news_title">이달의 진행 봉사 현황</h3>
				<span class="my_recent_news_count">총<span class="number"
					id="my_notification_count">${fn:length(Month_vol)}</span>건
				</span>
				<!-- 검색 결과가 없을 경우 -->    
                <c:choose>
					<c:when test="${PMV_list_num eq 0}">
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
							<c:forEach items="${PMV_list}" var="pmv_list">
								<li class="item_news type_funding">
									<div class="card_news">
										<a href="javascript:goView('${pmv_list.getNo()}')" class="link"></a>
										<p class="text_content">${pmv_list.getDo_title()} (장소: ${pmv_list.getDo_category()})</p>
										<span class="text_information">${pmv_list.getDo_name()}</span> 
										<span class="text_information">참여인원 : ${pmv_list.getDo_total()} / ${pmv_list.getDo_goal()} 명</span>
										<span class="text_information">모집기간 : ${pmv_list.getDo_start_date()} ~ ${pmv_list.getDo_end_date()}</span>
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
					class="fas fa-chevron-right"></i>
				</a>

			</div>

            <!-- 달성 완료 봉사 -->
			<div class="my_recent_news_wrap" id="my_notification">
				<c:set var="Month_vol" value="${CMV_list}"></c:set>
				<!--게시글의 총 갯수를 표시하기위해  arraylist를 today_dona라는 변수로 선언한다. 그 뒤에 ${fn:length(today_dona)}로 리스트의 크기를 계산한다. fn:length를 사용하기 위해선-->
				<!--taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"를 위쪽에 써주어야 사용가능하다.-->
				<h3 class="my_recent_news_title">이달의 목표 달성</h3>
				<span class="my_recent_news_count">총<span class="number"
					id="my_notification_count">${fn:length(Month_vol)}</span>건
				</span>
				<!-- 검색 결과가 없을 경우 -->    
                <c:choose>
					<c:when test="${CMV_list_num eq 0}">
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
							<c:forEach items="${CMV_list}" var="cmv_list">
								<li class="item_news type_funding">
									<div class="card_news">
										<a href="javascript:goView('${cmv_list.getNo()}')" class="link"></a>
										<p class="text_content">${cmv_list.getDo_title()} (장소: ${cmv_list.getDo_category()})</p>
										<span class="text_information">${cmv_list.getDo_name()}</span> 
										<span class="text_information">참여인원 : ${cmv_list.getDo_total()} / ${cmv_list.getDo_goal()} 명</span>
										<span class="text_information">모집기간 : ${cmv_list.getDo_start_date()} ~ ${cmv_list.getDo_end_date()}</span>
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
					class="fas fa-chevron-right"></i>
				</a>
			</div>
			
        </div><!-- 활동 내용 div-->


        </div>
    </div>

        <script>
        

        </script>
        
        

</body>
<!--footer -->
<%@ include file = "../common_footer.jsp" %>