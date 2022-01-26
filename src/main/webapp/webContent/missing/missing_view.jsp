<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
create table missing_find(
    no varchar2(5) not null, 			--번호 :M0001
    name varchar2(100) not null,		--성명
    age varchar2(3) not null,           --나이
	gender varchar2(1) not null, 		--성별 f:여 m:남
	lost_date date not null,          	--실종일자
	lost_area varchar2(20) not null,  	--실종지력
	lost_place varchar2(100) not null, 	--실종장소
	lat varchar2(20) not null, 			--위도
	lng varchar2(20) not null,  		--경도
    content  CLOB,                     	--내용 
    attach varchar2(100) not null,     	--첨부사진
    reg_info varchar2(20) not null,     --등록자
    reg_date date not null,            	--등록일
    hit number(5) default 0,           	-- 조회수
    CONSTRAINT pk_missing primary key(no)
);

 -->
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
	function goUpdateForm(){
		miss.t_gubun.value="UpdateForm";
		miss.method="post";
		miss.action="Missing";
		miss.submit();
	}
	function goDelete(){
		if(confirm("실종 등록 삭제하겠습니까 ? ")){
			miss.t_gubun.value="Delete";
			miss.method="post";
			miss.action="Missing";
			miss.submit();
		}	
	}
</script>

<form name="miss">
	<input type="hidden" name="t_gubun">
	<input type="hidden" name="t_no" value="${t_dto.getNo()}">
	<input type="hidden" name="t_attach" value="${t_dto.getAttach()}">
</form>
	<div class="tab-3" data-swipe='{"type":"case1","start":".active"}'>
		<ul>
			<li data-act='tab' class="item"><a href="Donation"><span class="in">기부</span></a></li>
			<li data-act='tab' class="item"><a href="Volunteer"><span class="in">봉사</span></a></li>
			<li data-act='tab' class="item"><a href="LocalNews"><span class="in">지역뉴스</span></a></li>
			<li data-act='tab' class="item active"><a href="Missing"><span class="in">실종아동</span></a></li>
		</ul>
	</div>

<div class="sub-write">
<style>
	h2.title22{height:60px;padding-top:20px;width: 97%;}
	.table tr th label{
		font: 16px sans-serif;
	}
	
	.table .tdCss {
	    height: 40px;
	    padding: 10px;
	    margin: 10px;
	    border: none;
	    font-family: 'Dongle';
	    font-size: 15px;
	}

	.noborder{border:0}
	#map{border:1px solid gray;margin-bottom:5px;}

	#preview-image{display:none;}
	#preview-image{width: 300px; height:200px;border:1px solid gray}
	
	.imgMissingView{
		width: 100%; height:510px;
		text-align:center;
	}
	.imgMissingView span{
		display: inline-block;
		width:350px;height:510px;
		padding:5px;
		border:1px solid #EAEAEA;
	}
</style>				
			<form name="dona" enctype="multipart/form-data">
					<h2 class="title2 title22"> "${t_dto.getName()}" 실종아동 정보</h2>
					<div class="imgMissingView">
						<span><img src="/donaimg/missing/${t_dto.getAttach()}" style="width:350px;height:500px;">
						</span>
					</div>
					<fieldset>
						<table class="table">
							<caption><p style="font-size:25px; margin:20px 0;">실종아동 정보</p></caption>
							<colgroup>
			 					<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="*">
							</colgroup>
							
							<tr>
								<th><label for="title">실종아동 성명</label></th>
								<td class="tdCss">${t_dto.getName()}</td>
								<th><label for="title">나 이</label></th>
								<td class="tdCss">${t_dto.getAge()} 세</td>
							</tr>
						
							<tr>
								<th><label for="">성 별</label></th>
								<td class="tdCss">${t_dto.getGender()}</td>
								<th><label for="">실종일시</label></th> 
								<td class="tdCss">${t_dto.getLost_date()} ${t_dto.getLost_time()}시</td>
							</tr>														
							<tr>
								<th><label for="title">실종지역</label></th>
								<td class="tdCss">${t_dto.getLost_area()}</td>	
								<th><label for="">실종장소</label></th>
								<td class="tdCss">${t_dto.getLost_place()}</td>
							</tr>
							<tr>
								<th ><label for="">실종장소</label></th>
								<td colspan="3" style="padding:5px 10px">
									<div id="map" style="width:850px;height:550px;"></div> 
								</td>
							</tr>
<!-- map -->						 
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	      center: new kakao.maps.LatLng(${t_dto.getLat()}, ${t_dto.getLng()}), // 지도의 중심좌표
	      level: 3 // 지도의 확대 레벨
	  };
	
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	var imageSrc = '/donaimg/missing/${t_dto.getAttach()}', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	imageOption = {offset: new kakao.maps.Point(27, 75)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
	//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	markerPosition = new kakao.maps.LatLng('${t_dto.getLat()}', '${t_dto.getLng()}'); // 마커가 표시될 위치입니다
	
	//마커를 생성합니다
	var marker = new kakao.maps.Marker({
	position: markerPosition,
	image: markerImage // 마커이미지 설정 
	});
	
	//마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);  
	
	//커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	var content = '<div class="customoverlay">' +
	'  <a>' +
	'    <span class="maptitle">${t_dto.getName()}(${t_dto.getGender()},${t_dto.getAge()}세)<br>${t_dto.getLost_place()}</span>' +
	'  </a>' +
	'</div>';
	
	//커스텀 오버레이가 표시될 위치입니다 
	var position = new kakao.maps.LatLng('${t_dto.getLat()}', '${t_dto.getLng()}');  
	
	//커스텀 오버레이를 생성합니다
	var customOverlay = new kakao.maps.CustomOverlay({
	map: map,
	position: position,
	content: content,
	yAnchor: 1 
	});
</script>        	
<!-- map -->
<style>
	.viewCont{
		white-space:pre-wrap;
		width:850px;
		height:400px;
		line-height:25px;
		overflow:auto;
	}
</style>
							<tr>
								<th><label for="cont">실종당시 상황</label></th>
								<td colspan="3" style="padding:5px 10px">
									<div class="viewCont">${t_dto.getContent()}</div>
								</td>
							</tr>
							<tr>
								<th><label for="">보호자연락처</label></th>
								<td colspan="3" style="padding:10px;">
									${t_dto.getGuardian_tell()}									
								</td>
							</tr>
							<tr>
								<th><label for="">등록일자</label></th>
								<td colspan="3" style="padding:10px;">
									${t_dto.getReg_date()}									
								</td>
							</tr>
		
						</table>
					</fieldset>
				</form>
				<input type="button" onclick="goDelete()" value="삭 제" class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
				<input type="button" onclick="goUpdateForm()" value="수 정" class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
				<input type="button" onclick="javascript:history.back()" value="목 록"class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
			</div>

<%@ include file = "../common_footer.jsp" %>
