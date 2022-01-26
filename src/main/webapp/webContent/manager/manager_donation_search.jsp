<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common_header_ljh.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>	<!-- 날짜 형식 변경을 위해 넣음 -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--페이지 css-->
<link href="css/css_ljh/mypage-menu.css" rel="stylesheet">
<link href="css/css_ljh/manager-donation-search.css" rel="stylesheet">

<!-- 달력기능 css,js-->
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="css/daterangepicker-master/daterangepicker.css">
    <!-- js -->
    <script type="text/javascript" src="css/daterangepicker-master/moment.min.js"></script>
    <script type="text/javascript" src="css/daterangepicker-master/daterangepicker.js"></script>

<form name="goPage">
	<input type="hidden" name="t_gubun">
</form>

<form name="view">
	<input type="hidden" name="t_no">
	<input type="hidden" name="t_gubun">
</form>

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
        
        <!-- 내용 창 -->
            <div role="main" id="content" class="my_content">
                <h3 class="my_title">기부 내역</h3>
                    <div class="my_npaybanner_wrap" style="display:none"></div>

                    <!-- 달력 -->
                    <div class="my_activity_calendar_wrap">
                    <p class="my_activity_calendar_p">*검색 조건은 종료일 기준으로 출력됩니다.</p>
                    <form name="goSearch">
						<input type="hidden" name="t_gubun">
                        <div class="sorting_area" id="paymentStatus">
                            <select name="t_select" class="select">
                                <option value="">전체</option>
                                <option value="senior" <c:if test="${t_select eq 'senior'}">selected</c:if>>노인</option>
                                <option value="child" <c:if test="${t_select eq 'child'}">selected</c:if>>아동</option>
                                <option value="disabled" <c:if test="${t_select eq 'disabled'}">selected</c:if>>장애</option>
                                <option value="disaster" <c:if test="${t_select eq 'disaster'}">selected</c:if>>재난</option>
                            </select>
                        </div>

                        <div class="sorting_area" id="paymentStatus">
                            <select name="t_search" class="select">
                                <option value="">전체</option>
                                <option value="ing" <c:if test="${t_search eq 'ing'}">selected</c:if>>진행중</option>
                                <option value="end" <c:if test="${t_search eq 'end'}">selected</c:if>>기간 종료</option>
                                <option value="goal" <c:if test="${t_search eq 'goal'}">selected</c:if>>달성 완료</option>
                            </select>
                        </div>
                     </form>

                        <button type="button" onClick="location.href='javascript:doSearch()'" class="activity_calendar_search" id="searchButton">검색</button>
                    </div>

                    <!-- 노인,아동... 카테고리에 따라 이미지 변경 예정, 달성완료시 불 들어오는 색상-->
                    <div class="my_recent_activity_wrap" id="myActivityAll" aria-hidden="false">
                        <h3 class="blind">선택한 내역</h3>
                        
                    <!-- 검색 결과가 없을 경우 -->    
                         <c:choose>
							<c:when test="${DAS_list_num eq 0}">
								<div class="my_recent_activity_wrap" id="searchNothing"><!--기본을 none 처리후 결과에 따라 block 처리해아함-->
			                        <div class="none_message">
			                            <p class="none_message_inner">검색 결과가 없습니다. 
			                            	<span class="small_text">조건을 확인해주세요.</span>
			                            </p>
			                        </div>
		                    	</div>
							</c:when>
						</c:choose>
						<c:set var="disLine" value=""></c:set>	<!-- 전역 변수 느낌으로 선언 해준다. -->
                        <c:forEach items="${DAS_list}" var="das_list" varStatus="status"><!-- foreach문에 varStatus를 선언하면 여러가지 조건을 가져올수 있다. -->
                        <c:set var="gage" value="${das_list.getDo_total() / das_list.getDo_goal() *100}" />
						<!-- gage로 처리하면 99.9647 이런식이라 100%가 적용되지 않기 때문에 gage+((gage%1>0.5)?(1-(gage%1))%1:-(gage%1))로 반올림 처리한다 -->
						<fmt:parseNumber var="gage1" value="${gage}" integerOnly="true" />
						<!-- gage의 값을 var=gage1 로 선언한다. gage1의 소숫점을버리고 출력한다. 사용하기위해선 taglib으로 jstl을 선언해야함 -->
						
						 <fmt:parseDate value="${das_list.getDo_end_date()}" var="noticePostDate" pattern="yyyy-MM-dd"/>
						 <!-- ${das_list.getDo_end_date()} 라는 변수에 String형으로 '2016-11-11' 이런식으로 값이 들어있을 때 pattern에 값을 똑같이 입력 해준다.--> 
						 <!--변수값이 20161111 이런식인 경우에는 parttern 값을 yyyyMMdd 이런식으로 해준다. -->
                        <div id="timelineArea">
                        	<c:set var="TextValue" value="${das_list.getDo_end_date()}"/>
                            <c:if test="${status.index == 0}"><!-- status의 index는 배열의 0번째부터 순서를 의미한다. 처음 arraylist 항목 -->
                            	<c:set var="disLine" value="${fn:substring(TextValue,0,7)}"></c:set>
                            	<!-- disLine은 db의 날짜값 중 yyyy-MM-dd 에서 yyyy-MM 까지만 잘라서 사용한다. -->
	                            <div class="my_activity_month"><span class="number">
	                            	<fmt:formatDate value="${noticePostDate}" pattern="yyyy.MM"/></span>
	                            	<!-- 위에서 pasrsedate로 string type인 날짜를 데이터로 변환 시킨걸 다시 데이터 표기값 변경으로 yyyy-MM-dd를 yyyy.MM으로 바꿔준다. -->
	                            	<!-- disLine 처럼 잘라서 사용하지 않은 이유는 yyyy-MM 대신 yyyy.MM 으로 표기해야 하기 때문 -->
	                            </div>
                            </c:if>
                            <c:if test="${status.index != 0}"> 
                            	<c:set var="disLineSecond" value="${fn:substring(TextValue,0,7)}"></c:set>
                            	<!-- 배열의 첫번째가 아닌 경우 disLineSecond 라는 변수를 선언한다. 예)2022-01 -->
								<c:if test="${disLine ne disLineSecond}">
								<!-- disLine = 2021.12, disLineSecond =2022.01 로 일치하지 않는 경우 다시 2022.01로 새로 리스트가 시작된다. -->
		                            <div class="my_activity_month"><span class="number">
		                            	<fmt:formatDate value="${noticePostDate}" pattern="yyyy.MM"/></span>
		                            </div>								
								</c:if>	
								<c:set var="disLine" value="${fn:substring(TextValue,0,7)}"></c:set>
								<!-- 이게 없으면 월별로 묶이지 않는다. -->
                            </c:if>

                            <ul class="my_activity_list" id="timeline202201">
                                <li class="my_activity_cong timeline_root">
                                    <div class="my_activity_inner">
                                        <div class="my_activity_left">
                                        	<c:choose>
											<c:when test="${gage1 >= 100}">
												<div class="my_activity_ing ${das_list.getDo_category()}"> </div>
											</c:when>
											<c:otherwise>
												<div class="my_activity_end ${das_list.getDo_category()}"> </div>
											</c:otherwise>	
										</c:choose>
                                            
                                        </div>
                                        <a href="javascript:goView('${das_list.getNo()}')" class="my_activity_center">
                                            <strong class="my_activity_date">${das_list.getDo_name()}</strong>
                                            <strong class="my_activity_text2">${das_list.getDo_title()}</strong>
                                            <span class="my_activity_title">[${das_list.getDo_start_date()} ~ ${das_list.getDo_end_date()}]</span>
                                        </a>
                                        <div class="my_activity_right"><!--진행 상황 표시를 위해  퍼센트 표시 -->
										<c:choose>
											<c:when test="${das_list.getDo_end_date() eq das_list.getDo_today()}">
												<div class="my_activity_price"><strong class="number_today">오늘 마감</strong></div>
											</c:when>
											<c:when test="${das_list.getDo_end_date() < das_list.getDo_today()}">
												<div class="my_activity_price"><strong class="number_end">종료</strong></div>
											</c:when>
											<c:otherwise>
												<div class="my_activity_price"><strong class="number_com">진행 중</strong></div>
											</c:otherwise>
										</c:choose>	
										</div>
										<div class="my_activity_right"><!--진행 상황 표시를 위해  퍼센트 표시 -->
											<div class="my_activity_price">
												<strong class="number">${gage1}</strong>%
											</div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        </c:forEach>
            </div>
            
        </div><!-- 활동 내용 div-->


        </div>
    </div>

        <script>
       
        </script>
        <script>
			function doSearch(){
				goSearch.t_gubun.value="Dona_Search";
				goSearch.method="post";
				goSearch.action="Manager";
				goSearch.submit();
			}
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
			function goView(no){
				view.t_no.value=no;
				view.t_gubun.value="View";
				view.method="post";
				view.action="Donation";
				view.submit();
			}
		</script>
        

</body>
<!--footer -->
<%@ include file = "../common_footer.jsp" %>