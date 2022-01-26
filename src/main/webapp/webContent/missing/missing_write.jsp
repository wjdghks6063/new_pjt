<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 
create table missing_find_2(
    no varchar2(5) not null, 			--번호 :M0001
    name varchar2(100) not null,		--성명
    age varchar2(3) not null,           --나이
	gender varchar2(1) not null, 		--성별 f:여 m:남
	lost_date date not null,          	--실종일자
	lost_time varchar2(2) not null,    --실종시간
	lost_area varchar2(20) not null,  	--실종지역
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
<script>
	var form_data =null; //summernote form
	function goSave(){
		
		if(checkValue(dona.t_name,"성명을 입력하세요")) return;
		if(checkValue(dona.t_age,"나이를 입력하세요")) return;
		if(checkValue(dona.t_lost_place,"실종 장소를 입력하세요")) return;
		if(checkValue(dona.t_lat,"지도에서 정확한 위치를 선택하세요")) return;
		var summernoteContent = $('#summernote').summernote('code');
		dona.t_content.value = summernoteContent;		

		if(checkValue(dona.t_attach,"실종아동 이미지파일을 첨부하세요")) return;
		
		//첨부파일 검사
		var fileName = dona.t_attach.value;
		if(fileName !=""){
			var pathFileName = fileName.lastIndexOf(".")+1;    //확장자 제외한 경로+파일명
			var extension = (fileName.substr(pathFileName)).toLowerCase();	//확장자명
			//파일명.확장자
		
			if(extension != "jpg" && extension != "gif" && extension != "png"){
				alert(extension +" 형식 파일은 업로드 안됩니다.이미지 파일만 가능!");
				return;
			}		
		}	
		//위에는 확장자 검사!
		// 첨부 용량 체크	

		var file = dona.t_attach;
		var fileMaxSize  = 5;
		if(file.value !=""){
			// 사이즈체크
			var maxSize  = 1024 * 1024 * fileMaxSize;  
			//var maxSize  = 10;  
			var fileSize = 0;

			// 브라우저 확인
			var browser=navigator.appName;
			// 익스플로러일 경우
			if (browser=="Microsoft Internet Explorer"){
				var oas = new ActiveXObject("Scripting.FileSystemObject");
				fileSize = oas.getFile(file.value).size;
			}else {
			// 익스플로러가 아닐경우
				fileSize = file.files[0].size;
			}
			//alert("파일사이즈 : "+ fileSize);

			if(fileSize > maxSize){
				alert(" 첨부파일 사이즈는 "+fileMaxSize+"MB 이내로 등록 가능합니다. ");
			return;
				}	
			}
		$("#delSummer").remove();  // summernote 삭제:첨부파일 따로 있을때(썸머노트 이미지 첨부에 또 업로드됨)
		
		dona.method="post";
		dona.action="MissingSave";
		dona.submit();
	}
	
	function goList(){
		list.t_gubun.value="List";
		list.method="post";
		list.action="Missing";
		list.submit();
				
	}
//썸머노트
	$(document).ready(function() {
	    $("#summernote").summernote({
	        placeholder:'',
			width:850,
	        height:400,
	        callbacks: {
	            onImageUpload:function(files, editor, welEditable){
	                for(var i = files.length - 1;i>=0;i--){
	                    sendFile(files[i], this);
	                }
	            }
	        }
	    });
	  
	    function sendFile(file, el, welEditable){
	        form_data = new FormData();
	        form_data.append('file', file);
	        $.ajax({
	            data:form_data,
	            type:"POST",
	            url:'MissingSummerNoteImgUpload',
	            cache:false,
	            contentType:false,
	            processData:false,
	            //enctype: 'multipart/form-data',
	            success:function(url){
	                $(el).summernote('editor.insertImage',"/donaimg/missing_summernote/"+$.trim(url));
	            },
	            error: function(data) {
	                console.log(data);
	            }
	        });
	        form_data.delete('file'); // 본문에서 따로 첨부 있을때 삭제 해줘야 다시 업로드 안됨
	    }  
    
	});

// 이미지 미리보기
	$(function(){					
		function readImage(input) {
		    // 인풋 태그에 파일이 있는 경우
		    if(input.files && input.files[0]) {
		        // 이미지 파일인지 검사 (생략)
		        // FileReader 인스턴스 생성
		        const reader = new FileReader()
		        // 이미지가 로드가 된 경우
		        reader.onload = e => {
		            const previewImage = document.getElementById("preview-image");
		            previewImage.src = e.target.result;
		        }
		        // reader가 이미지 읽도록 하기
		        reader.readAsDataURL(input.files[0])
		    } else {
		    	// 이미지 안올렸으면
				$("#preview-image").attr('src','');
				$("#preview-image").css("display","none");
		    }
		}
// input file에 change 이벤트 부여
		const inputImage = document.getElementById("input-image");
		inputImage.addEventListener("change", e => {
			$("#preview-image").css("display","block");
		    readImage(e.target)
		})	
	});	
</script>
<form name="list">
	<input type="hidden" name="t_gubun">
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
	.table .tdInput{
	    padding: 10px;
		border:1px solid #333333; 
	}
	.table .selectCss {
		width:100px;
		padding: 10px;
		border:1px solid #333333; 
	}
	.table .selectCssTime {
		width:100px;
		padding: 12px;
		border:1px solid #333333; 
	}
	.noborder{border:0}
	#map{border:1px solid gray;margin-bottom:5px;}

	#preview-image{display:none;}
	#preview-image{width: 300px; height:400px;border:1px solid gray}
</style>				
	<form name="dona"  enctype="multipart/form-data">
		<h2 class="title2 title22"> 실종아동 정보를 입력해주세요</h2>
	
		<fieldset>
			<table class="table">
				<caption><p style="font-size:25px; margin:20px 0;">실종아동 정보등록</p></caption>
				<colgroup>
 					<col width="20%">
					<col width="20%">
					<col width="*">
				</colgroup>
				
				<tr>
					<th><label for="title">실종아동 성명</label></th>
					<td colspan="2" class="tdCss"><input type="text" maxlength='10' name="t_name" class="tdInput" placeholder="실종아동 성명" style="width:150px;"></td>
				</tr>
				<tr>
					<th><label for="title">나 이</label></th>
					<td colspan="2" class="tdCss"><input type="text" maxlength='2' name="t_age" class="tdInput" placeholder="나이" style="width:100px;"></td>
				</tr>
			
				<tr>
					<th><label for="">성 별</label></th>
					<td colspan="2" class="tdCss">
						<input type="radio"  name="t_gender" value="f" checked>&nbsp 여
						<input type="radio"  name="t_gender" value="m" >&nbsp 남
					</td>
				</tr>
				<tr>
					<th><label for="">실종일시</label></th> 
					<td colspan="2" class="tdCss">
						<input type="date" name="t_lost_date" class="tdInput"  value="<%=CommonUtil.getToday()%>" style="width:180px;">
						<select name="t_lost_time" class="selectCssTime">
						    <option value="1">오전 1시</option>
						    <option value="2">오전 2시</option>
						    <option value="3">오전 3시</option>
						    <option value="4">오전 4시</option>
						    <option value="5">오전 5시</option>
						    <option value="6">오전 6시</option>
						    <option value="7">오전 7시</option>
						    <option value="8">오전 8시</option>
						    <option value="9" selected>오전 9시</option>
						    <option value="10">오전 10시</option>
						    <option value="11">오전 11시</option>
						    <option value="12">오전 12시</option>
						    <option value="13">오후 1시</option>
						    <option value="14">오후 2시</option>
						    <option value="15">오후 3시</option>
						    <option value="16">오후 4시</option>
						    <option value="17">오후 5시</option>
						    <option value="18">오후 6시</option>
						    <option value="19">오후 7시</option>
						    <option value="20">오후 8시</option>
						    <option value="21">오후 9시</option>
						    <option value="22">오후 10시</option>
						    <option value="23">오후 11시</option>
						    <option value="24">오후 12시</option>
						</select>										
					</td>
				</tr>														
				<tr>
					<th><label for="title">실종지역</label></th>
					<td colspan="2" class="tdCss">
						<select name="t_lost_area" class="selectCss" id="t_lost_area" onchange="changeMap(this,'changeArea')">
						    <option value="대전">대전</option>
						    <option value="서울">서울</option>
						    <option value="대구">대구</option>
						    <option value="부산">부산</option>
						</select>								
					</td>	
				</tr>							
				<tr>														
					<th><label for="">실종장소</label></th>
					<td colspan="2" class="tdCss"><input type="text" maxlength='100' name="t_lost_place" class="tdInput"  placeholder="실종장소" style="width:500px;"></td>
				</tr>
<!-- map  -->

				<tr>
					<th ><label for="">실종장소<br>Click!</label></th>
					<td colspan="2" style="padding:5px 10px">
						<div id="map" style="width:850px;height:550px;"></div> 
							<i class="fas fa-expand"></i> 위도 : <input type="text" name="t_lat" readonly class="noborder">&nbsp;
							<i class="fas fa-expand"></i> 경도 : <input type="text" name="t_lng" readonly class="noborder">
					</td>
				</tr>
			
<script>
/* 지역별 지도 중심 위치 좌표
// 대전JSL 36.32726796209588, 127.40736201995023
// 서울시청 37.56592564927031, 126.97804425449569
// 대구시청 35.87158715263924, 128.60177155550676
// 부산시청 35.179835430196796, 129.07498636436745 
*/

function changeMap(obj,gubun){
	
	var area = obj.value;
	var Lat,Lng;
	if(area =="대전"){
		Lat ="36.32726796209588";
		Lng ="127.40736201995023";
	}else if(area =="서울"){
		Lat ="37.56592564927031";
		Lng ="126.97804425449569";
	}else if(area =="대구"){
		Lat ="35.87158715263924";
		Lng ="128.60177155550676";
	}else if(area =="부산"){
		Lat ="35.179835430196796";
		Lng ="129.07498636436745";
	} 
	
	if(gubun =='changeArea'){ // 처음에는 등록된 좌표로 설정해주고 지역이 바뀌면 클릭주소 초기화
	    dona.t_lat.value=Lat; 
	    dona.t_lng.value=Lng;     		
	}	
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
//	 	center: new kakao.maps.LatLng(37.56592564927031, 126.97804425449569), // 지도의 중심좌표
	 	center: new kakao.maps.LatLng(Lat, Lng), // 지도의 중심좌표
	       level: 6 // 지도의 확대 레벨
	};	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    dona.t_lat.value=latlng.getLat(); 
	    dona.t_lng.value=latlng.getLng();     
	});
}

var mapArea = document.getElementById('t_lost_area');
changeMap(mapArea,"");
	
</script>				
<!-- map -->							
					<tr>
						<th><label for="cont">실종당시 상황</label></th>
						<td colspan="2" style="padding:5px 10px">
							<input type="hidden" name="t_content"> 
							<div id="delSummer"><!-- 저장시 삭제하기 위해 -->						
								<div id="summernote"></div>
							</div>							
						</td>
					</tr>
					<tr>
						
						<th><label for="file">실종아동 사진</label></th>
						<td style="padding:10px;">
							<img id="preview-image"><br>
							<input type="file" id="input-image" name="t_attach">									
						</td>
						<td style="padding:10px;"><img style="width: 500px;" id="preview-image"></td>
					</tr>
				</table>
			</fieldset>
		</form>
		<input type="button" onclick="goSave()" value="등 록" class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
		<input type="button" onclick="goList()" value="목 록"class="btn" style="background-color:#f0f0f0;font-family: 'Dongle';">
	</div>
<%@ include file = "../common_footer.jsp" %>
