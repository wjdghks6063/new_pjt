<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
    
<%@ include file = "../common_header.jsp" %>

<!-- 카카오 맵 사용하기 위한-->		
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=54cc3460bb5ed43170b24051c13fecae"></script>
<style>
	.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:1px solid gray; box-shadow:0px 1px 2px #888;}
	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.customoverlay .maptitle {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>
<!-- 카카오 맵 사용하기 위한-->

<script type="text/javascript">
	function goSearch(search){
		sear.method="post";
		sear.action="Missing";
		sear.submit();
	}
	function goWriteForm(){
		dona.t_gubun.value="WriteForm";
		dona.method="post";
		dona.action="Missing";
		dona.submit();
	}
	function goView(no){
		dona.t_no.value=no;
		dona.t_gubun.value="View";
		dona.method="post";
		dona.action="Missing";
		dona.submit();
	}
	function goPage(pageNumber){
		pageform.t_nowPage.value = pageNumber;
		pageform.method="post";
		pageform.action="Missing";
		pageform.submit();
	}
</script>
<form name="dona">
	<input type="hidden" name="t_no">
	<input type="hidden" name="t_gubun">
</form>
<form name="pageform">
	<input type="hidden" name="t_nowPage">
	<input type="hidden" name="t_list_setup_count" value="${t_total_count}">
	<input type="hidden" name="t_lost_area" value="${t_lost_area}">
	<input type="hidden" name="t_lost_date_start" value="${t_lost_date_start}">
	<input type="hidden" name="t_lost_date_end" value="${t_lost_date_end}">
	<input type="hidden" name="t_gender" value="${t_gender}">

</form>
<div class="tab-3" data-swipe='{"type":"case1","start":".active"}'>
	<ul>
		<li data-act='tab' class="item"><a href="#"><span class="in">기부</span></a></li>
		<li data-act='tab' class="item"><a href="#"><span class="in">봉사</span></a></li>
		<li data-act='tab' class="item"><a href="#"><span class="in">지역뉴스</span></a></li>
		<li data-act='tab' class="item active"><a href="#"><span class="in">실종아동</span></a></li>
	</ul>
</div>
	
<!-- 서브 페이지-->	
<div class="sub-main">
<style>
	.sub-search .box2{
		font: 25px sans-serif;
		color:#5D5D5D;
	}
</style>	
	<div class="sub-search">
		<p class="donation-text-box box2">실종 아동 현황 <i class="fas fa-chevron-right"></i></p>
		<br>
	</div>
	
	
<!--  검색   -->
<style>
	.table{width:100%;margin-bottom:5px; }
	.table tr th label {
	    font: 16px sans-serif;
	}
	.table .tdCss {
	    height: 40px;
	    padding: 3px;
	    margin: 10px;
	    border: none;
	    font-family: 'Dongle';
	    font-size: 15px;
	}
	.table .tdInput{
	    padding: 3px;
		border:1px solid #333333; 
	}
	.table .selectCss {
		width:100px;
		padding: 3px;
		border:1px solid #333333; 
	}
	.table .search{
		padding:30px;
		border:1px solid #D8D8D8; 
		border-radius:5px;
		background:#EAEAEA;
	}
</style>
				<div>    
					<form name="sear">                         
						<table class="table" >
							<colgroup>
			 					<col width="20%">
								<col width="40%">
								<col width="40%">
							</colgroup>
							<tr>
								<th><label for="title">실종지역</label></th>
								<td class="tdCss">
								
									<select name="t_lost_area" class="selectCss">
									    <option value="대전" <c:if test="${t_lost_area eq '대전'}">selected</c:if>>대전</option>
									    <option value="서울" <c:if test="${t_lost_area eq '서울'}">selected</c:if>>서울</option>
									    <option value="대구" <c:if test="${t_lost_area eq '대구'}">selected</c:if>>대구</option>
									    <option value="부산" <c:if test="${t_lost_area eq '부산'}">selected</c:if>>부산</option>
									</select>								
								</td>	
								<td rowspan="3" >
									<a href="javascript:goSearch()" class="search">검&nbsp;색</a>
								</td>								
							</tr>								
							<tr>
								<th><label for="">실종일자</label></th> 
								<td colspan="2" class="tdCss">
									<input type="date" name="t_lost_date_start" class="tdInput"  value="${t_lost_date_start}" style="width:180px;">
									~
									<input type="date" name="t_lost_date_end" class="tdInput"  value="${t_lost_date_end}" style="width:180px;">
								</td>	
							</tr>	
							<tr>
								<th><label for="">성 별</label></th>
								<td colspan="2" class="tdCss">
									<input type="radio"  name="t_gender" value="all" <c:if test="${t_gender eq 'all'}">checked</c:if>> 전체&nbsp&nbsp
									<input type="radio"  name="t_gender" value="f" <c:if test="${t_gender eq 'f'}">checked</c:if> > 여&nbsp&nbsp
									<input type="radio"  name="t_gender" value="m"  <c:if test="${t_gender eq 'm'}">checked</c:if>> 남
								</td>
							</tr>
						</table>
					</form>												
                </div>    
<!--  검색   -->


	
	
<!-- map -->
<style>
	#map{border:1px solid gray;margin-bottom:5px;}
</style>               
<div id="map" style="width:100%;height:700px;"></div> 
               
<script>
//대전JSL 36.32726796209588, 127.40736201995023
//서울시청 37.56592564927031, 126.97804425449569
//대구시청 35.87158715263924, 128.60177155550676
//부산시청 35.179835430196796, 129.07498636436745
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	      center: new kakao.maps.LatLng(${t_mapLat}, ${t_mapLng}), // 지도의 중심좌표
	      level: 6 // 지도의 확대 레벨
	  };
	
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	<c:forEach items="${t_dtos}" var="dtos">
			var imageSrc = '/donaimg/missing/${dtos.getAttach()}', // 마커이미지의 주소입니다    
			imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
			imageOption = {offset: new kakao.maps.Point(27, 75)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
			
			//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
			markerPosition = new kakao.maps.LatLng('${dtos.getLat()}', '${dtos.getLng()}'); // 마커가 표시될 위치입니다
			
			//마커를 생성합니다
			var marker = new kakao.maps.Marker({
			position: markerPosition,
			image: markerImage // 마커이미지 설정 
			});
			
			//마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);  
			
			//커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			var content = '<div class="customoverlay">' +
			'  <a href="javascript:goModal(\'${dtos.getAttach()}\',\'${dtos.getName()}\',\'${dtos.getAge()}\',\'${dtos.getGender()}\',\'${dtos.getLost_date()}\',\'${dtos.getLost_time()}\',\'${dtos.getLost_area()}\',\'${dtos.getLost_place()}\',\'${dtos.getGuardian_tell()}\')">' +
			'    <span class="maptitle">${dtos.getName()}(${dtos.getGender()},${dtos.getAge()})</span>' +
			'  </a>' +
			'</div>';
			
			//커스텀 오버레이가 표시될 위치입니다 
			var position = new kakao.maps.LatLng('${dtos.getLat()}', '${dtos.getLng()}');  
			
			//커스텀 오버레이를 생성합니다
			var customOverlay = new kakao.maps.CustomOverlay({
			map: map,
			position: position,
			content: content,
			yAnchor: 1 
			});
	</c:forEach>
</script>        	
<!-- map -->
	
<!-- 

	**************************** 모달 창 시작   ****************************   

-->			
<script type="text/javascript">
	function goModal(imgAttach,name,age,gender,lost_date,lost_time,lost_area,lost_place,guardian_tell){
		$(".modal").fadeIn();
		$("#img_form_url").attr("src", "/donaimg/missing/"+imgAttach);
		$(".modal_right .s_name").text(name);
		$(".modal_right .s_age").text(age);
		$(".modal_right .s_gender").text(gender);
		$(".modal_right .s_lost_date").text(lost_date+" "+lost_time+"시");
		$(".modal_right .s_lost_area").text(lost_area);
		$(".modal_right .s_lost_place").text(lost_place);
		$(".modal_right .s_guardian_tell").text(guardian_tell);
	}
	$(function(){
		$(".modal_content").click(function(){
			$(".modal").fadeOut(); }); 
		});

</script>						
<style>
	.modal{ 
		position:absolute; 
		width:100%; 
		min-height: 100%;
		background: rgba(255,255,255,0.8); 
 		top:0; 
 		left:0; 
		display:none;
		z-index:1000; 
	}
	.modal_content{
		position:absolute; 
		width:620px; 
		height:500px;
		padding:10px;
 		top:30%; 
 		left:30%; 	
 		background:rgba(140,140,140,0.8);	 
 		
		border-radius:8px;
		-webkit-border-radius:8px;
		-moz-border-radius:8px;
		-o-border-radius:8px;
		-ms-border-radius:8px;
		
		box-shadow:0 0 10px #555555;
		-webkit-box-shadow:0 0 10px #555555;
		-moz-box-shadow:0 0 10px #000;
		-o-box-shadow:0 0 10px #000;
		-ms-box-shadow:0 0 10px #000; 				
	}	
	.modal_title{
		width:600px;
		height:75px;	
		border-bottom:4px dotted #EAEAEA;
	}
	h2.title22{
	    text-align: center;
	    width: 95%;
	    height: 60px;
	    padding-top: 20px;
	    margin: 10px;
	    border: none;
	    font-family: 'galmat';
	    font-size: 45px;
	    color: white;	
	}	
	.modal_left{
		float:left;
		height:395px;
		width:300px;
		margin-top:5px;
		border:1px solid #D8D8D8;
		border-radius:0 0 0 8px;
		background:#EAEAEA;
	}
	#img_form_url{
		width:298px;
		height:393px;
		border:1px solid #EAEAEA;
		border-radius:0 0 0 5px;
	}
	.modal_right{
		width:300px;
		height:400px;
		float:right;
		padding:5px;
	}
	.modal_right p {
		width:290px;
		height:50px;
		padding:10px 5px;
		font: 22px sans-serif;
		color :#EAEAEA;	
	}
	.modal_right .s_cont {
		font:  bold 25px sans-serif;	
		color :white;	
	}	
	.modal_right .s_lost_place, .modal_right .s_lost_date{
		font: 22px sans-serif;
	}
</style>				
<div class="modal"> 
	<div class="modal_content" title="클릭하면 창이 닫힙니다."> 
		<div class="modal_title">
			<h2 class="title22"> 실종아동을 찾아주세요~~</h2>
		</div>	
		<div class="modal_left">
			<img id="img_form_url">	
		</div>
		
		<div class="modal_right">
			<p>성 명 : <span class="s_name s_cont"></span></p>
			<p>나 이 : <span class="s_age s_cont"></span></p>
			<p>성 별 : <span class="s_gender s_cont"></span></p>
			<p>실종일시 : <span class="s_lost_date s_cont"></span></p>
			<p>질종지역 : <span class="s_lost_area s_cont"></span></p>
			<p>실종장소 : <span class="s_lost_place s_cont"></span></p>
			<p>연락처 : <span class="s_guardian_tell s_cont"></span></p>
		</div>
	</div> 
</div>
<!-- 

	****************************  모달 창 end  **************************** 

-->				
	
		
	<div class="sub-content">
		<div class="donation-box">
		  <ul class="donation-img-list">
                <li class="donation-card-list">
                    <a href="" class="donation-card-a">
                        <div class="donation-card-pic">
                            <img loading="lazy" src="img/sub_img/thank.jpg" alt="" style="width:265px; height:200px; background-color:#ffb6c1;"> <!--이미지 박스 크기값 설정 및 크기에 맞지않을 경우 알아서 채우기 설정-->
                        </div>
                        <div class="donation-card-content-box" style="background-color:#ffb6c1;">
                            <strong class="donation-card-content-title">오늘 하루 여러분의 관심과 사랑입니다.</strong>
                            <div class="donation-comp">총 모금 달성도</div>
                            <div class="donation-parameter-bar">
                                <span class="donation-parameter-green" style="width: 65%;"></span> <!--width 값 변화에 따라 게이지 량 변경-->
                            </div>
                            <strong class="donation-parameter-num">72%</strong>
                            <strong class="donation-parameter-money">$366,222,230</strong>
                        </div>    
                    </a>
                </li>
                
				<c:forEach items="${t_dtos}" var="dtos">	
	                <li class="donation-card-list">
	                    <a href="javascript:goView('${dtos.getNo()}')" class="donation-card-a">
	                        <div class="donation-card-pic">
	                            <img loading="lazy" src="/donaimg/missing/${dtos.getAttach()}" alt="기부메인" style="width:265px; height:200px;"> <!--이미지 박스 크기값 설정 및 크기에 맞지않을 경우 알아서 채우기 설정-->
	                        </div>
	                        <div class="donation-card-content-box">
	                            <strong class="donation-card-content-title">${dtos.getName()} (${dtos.getGender()}, ${dtos.getAge()}세)</strong>
	                            <div class="donation-comp">실종일시 : ${dtos.getLost_date()}, ${dtos.getLost_time()}시</div>
	                            <div class="donation-comp">${dtos.getLost_area()}, ${dtos.getLost_place()}</div>
	                            <div class="donation-comp">T. ${dtos.getGuardian_tell()}</div>
	                        </div>    
	                    </a>
	                </li>
				</c:forEach>	
			</ul>	
	</div>
	<br>
<style>	
/*게시판 페이지 번호*/
	.paging{
		margin-top:20px;
		text-align:center;
	}
	.paging:after{
		content:""; display:block; clear:both;	
	}	
	.paging a{
		padding:4px;
		font-size:12px;
		border:1px solid #e0e0e0;
	}
	.paging .active{
		background:#81BEF7;
		color:#fff;
	}
	.paging .write{
		float:right;
		padding:5px 10px;
		background:#f3afe7;
		color: #000;
	}
	.paging i{
		color:gray;
	}	
	.paging a:hover, .buttonGroup a:hover{
		color:#fff;	
		background:#424242;
	}	
</style>			
	<div class="paging">
	<%	
		int total_page 				= (int)request.getAttribute("t_total_page");
		int current_page 			= (int)request.getAttribute("t_current_page");
		out.print(CommonUtil.pageListPost(current_page, total_page, 5));
	%>
	<br>
	</div>
		<input type="button" onclick="goWriteForm()" value="글 쓰 기" class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
	</div>	
</div>

</div>
</body>
<%@ include file = "../common_footer.jsp" %>