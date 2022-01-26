<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="../css/member_update.css">
<link href="css/mypage-menu.css" rel="stylesheet">
<link href="css/mypage-home.css" rel="stylesheet">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script>
$(document).ready(function(){
	$('#delete_input_pw_1').click(function(){ 
		$("#delete_input_pw_1").val(null);
	})});
	
$(document).ready(function(){
	$('#delete_input_pw_2').click(function(){ 
		$("#delete_input_pw_2").val(null);
	})});
	
//온니넘버 연락처
function onlyNumber(obj) {
	  obj.value = obj.value.replace(/[^0-9]/g, "");
	}

<!--주소찾기-->
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress; 
            var extraRoadAddr = '';
        
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            document.getElementById("jibunAddress").value = data.jibunAddress;
            document.getElementById("engAddress").value = data.addressEnglish;
            if(roadAddr !== ''){
                document.getElementById("extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}



//폰체크
$(document).ready(function(){
	$("#cellphone").on("propertychange change keyup paste input", function(){ 
	    var urlLocation="MemberTellCheck2"; 
	    var tell = member.t_tell.value;
	    var id = member.t_id.value;
	    if(tell ==""){
	    	alert("tell 입력 후 눌러주세요 ");
	    	member.t_tell.focus();
	    	return;
	    }
	    function tell_check() { 
		    var tell = $("#cellphone").val(); 
		    var regex=/01[016789][^0][0-9]{3}[0-9]{4}/;
		    return(tell != '' && tell != 'undefined' && regex.test(tell)); 
		    }
		$.ajax({
			type : "POST",
			url : urlLocation,
			data: {"t_id":id,"t_tell":tell},
			dataType : "text",
			error : function(){
				alert('통신실패!!');
			},
			success : function(data){
				//alert("통신데이터 값 : " + data);
				$(".result-check_tell").html(data);
				if(! tell_check() ) {
			        $(".result-check_tell").text('연락처 형식이 맞지 않습니다. 확인해해주세요.');
			        $(".result-check_tell").css("color","red");
			        $(".result-check_email").css("font-size","10px");
			        $(this).focus();
			        return false;
			        }
					if($.trim(data) =="연락처가 중복됩니다"){
					$(".result-check_tell").css("color","red");
					$(".result-check_tell").css("font-size","10px");
					member.tellCheck_yn.value ="no";
					member.tellCheck_value.value ="";
				} else {
					$(".result-check_tell").css("color","blue");
					$(".result-check_tell").css("font-size","10px;");
					member.tellCheck_yn.value ="yes";
					member.tellCheck_value.value =tell;
				}	    
				}
				
		})
})
});


//이메일체크
$(document).ready(function(){
	$("#emailcheck").change(function(){ 
	    var urlLocation="MemberEellCheck2"; 
	    var email = member.t_email.value;
	    var id = member.t_id.value;
	    	function email_check(email) { 
	    	var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    	return(email != '' && email != 'undefined' && regex.test(email)); 
	    }
	    
		$.ajax({
			type : "POST",
			url : urlLocation,
			data: {"t_id":id,"t_email":email},
			dataType : "text",
			error : function(){
				alert('통신실패!!');
			},
			success : function(data){
				//alert("통신데이터 값 : " + data);
				$(".result-check_email").html(data);
				if(!email_check(email)){
					$(".result-check_email").css("color","red");
					$(".result-check_email").css("font-size","10px");
					$(".result-check_email").text("이메일 형식 오류");
					$(this).focus();
					return false;
				}
				if($.trim(data) =="이메일이 중복됩니다"){
					$(".result-check_email").css("color","red");
					$(".result-check_email").css("font-size","10px");
					member.emailCheck_yn.value ="no";
					member.emailCheck_value.value ="";
					$(this).focus();
					return false;
				} else {
					$(".result-check_email").css("color","blue");
					$(".result-check_email").css("font-size","10px");
					$(".result-check_email").text('사용가능');
					member.emailCheck_yn.value ="yes";
					member.emailCheck_value.value =email;
				}	
			}
		});
	});
});

function goUpdate(){
	if(checkValue(member.t_name,"성함을 입력해주세요")) return;
	//if(checkValue(member.t_name,"성함을 입력해주세요")) return;
	if(checkValue(member.t_tell,"핸드폰 번호를 입력해주세요")) return;
	if(checkValue(member.t_tell.value.length < 11 ,"핸드폰 번호를 확인해주세요")) return;
	if(checkValue(member.t_pw,"비밀번호를 입력해주세요")) return;
	if(checkValue(member.t_pw_check,"확인 비밀번호를 입력해주세요")) return;
	if(checkValue(member.t_email,"이메일을 입력해주세요")) return;
	if(checkValue(member.t_address_1,"주소를 입력해주세요")) return;
	if(checkValue(member.t_address_2,"상세주소를 입력해주세요")) return;
	
	if(member.emailCheck_yn.value=="no"){
        alert("사용불가 이메일입니다.");
        member.t_email.focus();
        return;
     }
	
	if(member.tellCheck_yn.value=="no"){
        alert("사용불가 연락처입니다.");
        member.t_tell.focus();
        return;
     }
	
	if(member.t_pw.value != member.t_pw_check.value){
		alert("비밀번호가 같지 않습니다.");
		member.t_password_confirm.focus();
		return;
	}

	var pwcheck="";

	if(member.t_origin_password.value==member.t_pw.value){
	  	Swal.fire({
			 title: '수정하시겠습니까?',
			 text: '비밀번호 입력',
			  input: 'password',
			  inputPlaceholder: '비밀번호를 입력해주세요',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: 'gray',
			  showCancelButton: true,
			  confirmButtonText: '수정하기',
			  cancelButtonText: '닫기',
			  cancelButtonColor: '#A9A9A9',
			  reverseButtons: true
		
			
				}) .then((password) =>{
					pwcheck=password.value;
				}).then((isConfirm) => {
		  			$.ajax({
		  				type : "POST",
		  				url : "/SHA256",
		  				data: {"t_password":pwcheck},
		  				dataType : "text",
		  				error : function(){
		  					//alert('통신실패!!');
		  				},
		  				success : function(data){
		  					//alert("통신데이터 값 : " + data);
		  					
		  					if(member.t_origin_password.value==data){
		  						member.method="post";
		  						member.action="MemberUpdate";
		  						member.submit();
		  						
		  					}else{
		  						alert("기존 비밀번호가 맞지 않습니다. 확인 후 다시 시도해주세요"); 
		  					}} 	
		  					
		  				})});
				

	}else{
		Swal.fire({
			 title: '수정하시겠습니까?',
			 text: '비밀번호 입력',
			  input: 'password',
			  inputPlaceholder: '비밀번호를 입력해주세요',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: 'gray',
			  showCancelButton: true,
			  confirmButtonText: '수정하기',
			  cancelButtonText: '닫기',
			  cancelButtonColor: '#A9A9A9',
			  reverseButtons: true
		
			
				}) .then((password) =>{
					pwcheck=password.value;
				}).then((isConfirm) => {
		  			$.ajax({
		  				type : "POST",
		  				url : "/SHA256",
		  				data: {"t_password":pwcheck},
		  				dataType : "text",
		  				error : function(){
		  					//alert('통신실패!!');
		  				},
		  				success : function(data){
		  					//alert("통신데이터 값 : " + data);
		  					
		  					if(member.t_origin_password.value==data){
		  						member.method="post";
		  						member.action="MemberUpdate_2";
		  						member.submit();
		  						
		  					}else{
		  						alert("기존 비밀번호가 맞지 않습니다. 확인 후 다시 시도해주세요"); return;
		  					}} 	
		  					
		  				})});

}
}

function goBack(){
	member.method="post";
	member.action="/Mypage_home";
	member.submit();
}
</script>
<div id="wrap_2">
	<!-- 스킵네비게이션 : 웹접근성대응-->


<style>
.input_box_password{
	margin-top:20px;
	width:150px;
}
</style>
	<div id="container_2">
		<!-- CONTENTS -->
		<div id="content">
    <div class="c_header">
        <h2>개인정보 수정</h2>
        <p class="contxt"><strong>${session_name}</strong>님의 개인정보입니다.<br>
		회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다. 
    </div>
    <form name="member">
     	<input type="hidden" name="t_id" value="${session_id}">
     	<input type="hidden" name="t_origin_password" value="${t_dto.getPassword()}">
	<div class="container_2">
	  <div class="my-list-left" style="margin-right: 34px;">
            <div class="my-profile">
                <div class="my_profile_nickname">
                    <span class="ellipsis" id="nickNameArea">${session_name}</span>
                </div>
                <div class="my_profile_id" id="maskingIdArea">${session_id}</div>
                <div class="setting_button" style="float:right;"><a href="javascript:location.reload();" title="정보수정"><i class="fas fa-cog"></i></a></div>
            </div>
            <div id="lnb" class="my_lnb" role="menu">
                <a href="Mypage_home" role="menuitem" class="my_lnb_item" id="lnb_my_home" aria-current="false">MY홈</a> 
                <a href="Mypage_news" role="menuitem" class="my_lnb_item" id="lnb_my_notification" aria-current="false">내 소식</a>
                <a href="Mypage_activity" role="menuitem" class="my_lnb_item" id="lnb_my_activity" aria-current="false">활동내역</a> 
                <a href="Mypage_regular_payment role="menuitem" id="my_lnb_item" class="my_lnb_item" aria-current="false">정기결제관리</a>
                <a href="Mypage_year"role="menuitem" class="my_lnb_item" id="lnb_my_tax" aria-current="false">연말정산</a>
            </div>
        </div>
        <fieldset>
            <table border="0" class="tbl_model">
                <caption><span class="blind"></span></caption>
                <colgroup>
                    <col style="width:22%"><col>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  사용자 <span class="word_br">이름</span>
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <input type="text" name="t_name" class="input_box" value="${t_dto.getName()}">
                            <p class="contxt_desc"></p>
                          
                        </div>
                    </td>
                </tr>
                  <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  사용자 <span class="word_br">비밀번호</span><br><br><br>
						     	  비밀번호<span class="word_br">확인</span>
						     	  
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                             <input type="password" name="t_pw" class="input_box_password" id="delete_input_pw_1" value="${t_dto.getPassword()}"><br>
                               <input type="password" name="t_pw_check" class="input_box_password" id="delete_input_pw_2" value="${t_dto.getPassword()}">
                            <p class="contxt_desc">비밀번호나 핸드폰번호, 이메일 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">연락처</div>
                    </th>
                    <td>
                        <div class="tdcell">
                              <input type="tel" id="cellphone" name="t_tell" onKeyup="onlyNumber(this)" maxlength="11" class="input_box" value="${t_dto.getTell()}">
                               <div class="result-check_tell"  style="font-size:8px;margin-top:2px; color:red;"><p style="width:40px;"></p></div>
                               		<input type="hidden" name="tellCheck_yn">
									<input type="hidden" name="tellCheck_value">
                           	 <p class="contxt_desc">비밀번호나 핸드폰번호, 이메일 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.</p>
                        </div>
                    </td>
                </tr>

               
                <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  연락처 <span class="word_br">이메일</span>
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <input type="text" id="emailcheck" name="t_email" style="width:200px;"class="input_box" value="${t_dto.getEmail()}">
                            <div class="result-check_email"  style="font-size:8px;margin-top:2px; color:red;"><p style="width:40px;"></p></div>
                               		<input type="hidden" name="emailCheck_yn">
									<input type="hidden" name="emailCheck_value">
                            <p class="contxt_desc">비밀번호나 핸드폰번호, 이메일 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.</p>
                            </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">
						     	  사용자 <span class="word_br">주소</span>
						     </div>
                    </th>
                    <td>
                        <div class="tdcell">
                                <input type="hidden" id="postcode" onclick="execDaumPostcode()" readonly required placeholder="우편번호">
				                <input type="text" style="margin-top:10px;" name="t_address_1" style="cursor: pointer;" value="${t_dto.getAddress_1()}" id="roadAddress" onclick="execDaumPostcode()" required placeholder="도로명주소"  size="60" ><br>
				                <input type="hidden" id="jibunAddress" placeholder="지번주소"  size="60">
				                <span id="guide" style="color:#999;display:none;font-size:35px;margin-top:5px;"></span>
				                <input type="text" style="margin-top:5px; margin-bottom:-20px;" name="t_address_2" id="detailAddress" value="${t_dto.getAddress_2()}" placeholder="상세주소" required size="60"><br>
				                <input type="hidden" id="extraAddress" placeholder="참고항목"  size="60">
				                <input type="hidden" id="engAddress" placeholder="영문주소"  size="60" ><br>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell">
								 정보 <span class="word_br">수신 동의</span>
							</div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <div class="ad_wrap">
                                <div class="ad_check" style="padding-top:25px;">
                                        <input type="radio" name="t_info_yn" value="y" id="adMobileCheck" <c:if test="${t_dto.getInfo_yn() eq 'y'}"> checked </c:if> class="ad_checkbox">
                                            <span>동의</span>
                                        <input type="radio"  name="t_info_yn" value="n" style="margin-left:30px;" id="adEmailCheck" <c:if test="${t_dto.getInfo_yn() eq 'n'}"> checked </c:if> class="ad_checkbox" >
                                            <span>미동의</span>
                                </div>
                               
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </fieldset>
        </div>
        <p class="btn_area_btm" style="text-align:center;margin-left:320px;">
          <a href="javascript:goUpdate();" class="btn_model"><b class="btn2">수정</b></a>  <a href="javascript:goBack();" style="margin-right:55px;" class="btn_model"><b class="btn2">돌아가기</b></a>
          <input type="reset" style="float:right; margin-right:20px; border:1px solid #bfbfbf;; cursor:pointer; padding:5px 10px 3px 7px; font-weight: 900; font-size: 12px; width: 52px; color: #333; text-align:center;" class="btn2_button" value="초기화">
          </p>
    </form>
       
         
</div>


	</div>

    <%@ include file="../common_footer.jsp" %>
</div>

</div>
</body>
</html>
