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
						<table class="table">
							<tbody>
							</tbody>
						</table>
						<a href="javascript:goMore()">더보기</a>
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
			
			var startIndex = 1; //가장 기본 값 1부터 시작해서 n번째 까지 보여준다.
			var step = 3; //몇개 보여줄 것인가? 3개씩 보여주겠다.
			
			listMoreAjax(startIndex); /*화면이 열리자마자 function이 실행되게한다.*/
			// listMoreAjax()에 var의 값을 넣어준다. = listMoreAjax(var = 1)
			// listMoreAjax(startIndex)로 받아온걸 function listMoreAjax(index)으로 사용 한다. (startIndex)를 listMoreAjax(index)란 이름으로 사용한다.
			
			function goMore(){ // 더보기 버튼을 눌렀 을땐 이 funtion이 실행되게 한다.
				startIndex = startIndex + step; //startIndex에 step값을 더해 다시 startIndex에 넣는다 startIndex += step과 같다.
				listMoreAjax(startIndex); //이 값을 다시 아래 funtion에 넣어서 돌린다.
			}
				
			function listMoreAjax(index) { //첫 화면이 열릴땐 이 function이 실행 된다.
				var endIndex = index + step -1; 
			//alert("index :"+index) 값 출력 확인용
				
				var urlLocation="ManagerListMore"; //member servlet 요청 
			    var params="t_start="+index+"&t_end="+endIndex;  // t_start,t_end 라는 변수를 만들어 값을 넘긴다.
			    
				$.ajax({
					type : "POST",
					url : urlLocation, // "ManagerListMore" 직접 값을 넣어도 된다.
					data: params, // 
					dataType : "json", //json은 하나의 값만 받는게 아닌 arraylist같은 큰것을 받을때 json을 사용한다. 
										//json을 사용하려면 json과 관련된 jar 파일이 필요하다 json-simple.
					error : function(){
						alert('통신실패!!');
					},
					success : function(data){
					//	alert("통신데이터 값 : "+ data);
						var nodeList="";
						for(k=0; k<data.length; k++){
							var newNode="<tr>";
							newNode += "<td>"+data[k].no+"</td>";
							newNode += "<td></td>";
							newNode += "<td></td>";
							newNode += "<td></td>";
							newNode += "<td></td>";
							newNode += "<td></td>";
							newNode += "</tr>";
							nodeList += newNode;
						}
						$(nodeList).appendTo($(".table tbody")).slideDown(); //appendTo는 추가한다 의 뜻. 출력할 장소 위치에 .slideDown으로 밑으로 내려오게 추가하겠다.
					}
				});
			}
		</script>
        

</body>
<!--footer -->
<%@ include file = "../common_footer.jsp" %>