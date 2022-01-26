<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet"> <!--CDN 링크 -->
<link rel="shortcut icon" href="#">
  <%@ include file="../common_header.jsp" %>
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${empty t_tell}">
 <script>
	Swal.fire({
		title: '접근할 수 없는 페이지 입니다',
		icon: 'warning',
		confirmButtonColor: "#A9A9A9",
		confirmButtonText: '돌아가기'})
		.then(function(){
		location.href='/';
	})
 </script>
 </c:if>
 

<style>
  .modal2 {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 10; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
         background: rgba(0, 0, 0, 0.8);
		overflow-y: auto;
    }

    /* Modal Content/Box */
    .modal-content2 {
   		 overflow-y: initial !important;
     	z-index: 10;
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 50%; /* Could be more or less, depending on screen size */
    }
    
   .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 10; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
         background: rgba(0, 0, 0, 0.8);
		overflow-y: auto;
    }

    /* Modal Content/Box */
    .modal-content {
   		 overflow-y: initial !important;
     	z-index: 10;
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 50%; /* Could be more or less, depending on screen size */
    }
    
@import url('https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap');

*{margin:0; padding:0; box-sizing: border-box;}

#sub_content{
	width:100%;
}
section{
    font-family: 'Dongle';
    display:flex;
    justify-content:center;
    align-items: center;
    background-size:cover;
    background: url("pastel2.jpg") no repeat center;
    animation:image_change 10s infinite;
    width:100%;
    position: relative;
    margin: 0 auto;
    width: 1200px;
    padding-left: 128px;
}


section::before{
    position: absolute; z-index: 1;
    top:0; right:0; bottom:0; left:0;
}

.location {
	width:100%;
	font-family: 'Dongle';
    display:flex;
	padding-top:5px;
	padding-bottom:5px;
	position:relative;
    background-color: #636363;
}
.wrap {
    position: relative;
    height:20px;
    width: 1200px;
}

.location .wrap span{
	color:white;
	font-size:30px;
	margin-left:20px;
    width: 15px;
    height:30px;
    text-indent: -9999px;
    background-position: -253px -161px;
}


.wrap a{
	color:white;
	font-size:30px;
	padding-top:50x;
	margin-left:20px;
	
	}
	

	
.head_area{
	 font-family: 'Dongle';
    position: relative; z-index:2;
    margin-top:20px;
    margin-bottom:10px;
    
}

.head_area h1{
	padding-top:10px;
    font-size: 70px; color:gray;
   margin-left:190px;
}

.int_area{width:650px; position:relative;}
.int_area input{
    width:80%;
    margin-right: -79px;
    padding: 24px 10px 10px;
    background-color: transparent;
    border:none;
    border-bottom: 1px solid #999;
    font-size: 21px; color: lightslategray;
    outline:none;
}

.int_area label{
    size:1px;
    position: absolute; left:15px; top:21px;
    font-size:40px; 
    color:#999;
    transition: top .1s ease;
}

.int_area input:focus+label,
.int_area input:valid + label{
    top: -2px;
    font-size:20px; color:lightgray;
}
<!--구분-->
.int_area_2{width:650px; position:relative;}
.int_area_2 input{
    width:80%;
    margin-right: -79px;
    padding: 24px 10px 10px;
    background-color: transparent;
    border:none;
    border-bottom: 1px solid #999;
    font-size: 21px; color: lightslategray;
    outline:none;
}

.int_area_2 label{
    size:1px;
    position: absolute; left:150px; top:191px;
    font-size:20px; 
    color:#999;
    transition: top .1s ease;
    color:lightgray;
}

.int_area_2 input:focus+label,
.int_area_2 input:valid + label{
    top: -2px;
    font-size:20px; color:lightgray;
}


.int_area_email{width:650px; position:relative;}
.int_area_email input{
    width:80%;
    margin-right: -56px;
    padding: 20px 10px 10px;
    background-color: transparent;
    border:none;
    border-bottom: 1px solid #999;
    font-size: 21px; color: lightslategray;
    outline:none;
}

.int_area_email label{
    size:1px;
    position: absolute; left:15px; top:21px;
    font-size:40px; 
    color:#999;
    transition: top .1s ease;
}

.int_area_email input:focus+label,
.int_area_email input:valid + label{
    top: -2px;
    font-size:20px; color:lightgray;
}

.result-check_tell{
    color:red;
    font-size:25px;
}
.result-check_email{
    color:red;
    font-size:25px;
}
.agree_area p{
    font-weight: 100;
    font-size:24px;
    color:gray;
    margin-bottom:3px;
}


.agree_area li{
	 list-style:disc;
	 color:gray;
    margin-left:20px;
}

.agree_area input{
    color:gray;
}

<!-- -->
.agree_area input[type="radio"] {
    display: none;
}



.agree_area input[type="radio"] + span {
    display: inline-block;
    padding: 0px 5px;
    font-size:20px;
    border: 1px solid #dfdfdf;
    background-color: #ffffff;
    text-align: center;
    cursor: pointer;
}

.agree_area input[type="radio"]:checked + span {
    background-color:lightgray;
    color: #ffffff;
}



.agree_area a{
    text-decoration-line : none;
}


.btn_area {margin-top:30px;}

.btn_area button{
    width:200px;
    margin-left:160px;
    height:50px;
    background:lightgray;
    color:white;
    font-size:40px;
    border: none;
    border-radius:25px;
    font-family: 'Dongle';
    
}


.info_agree{
    font-size:20px;
}

.agree_area input[type="radio"]:checked + span {
    background-color:lightgray;
    color: #ffffff;
}
.agree_area a{
    text-decoration-line : none;
}


.caption{
    margin-top:20px;
    text-align:center;
}

.caption a{
    font-size: 15px; color: lightslategray;
    text-decoration: none;
}
</style>

<!-- 무결성검사 -->
<script>
function goJoin(){
	if(checkValue(member.t_name,"성함을 입력해주세요")) return;
	//if(checkValue(member.t_name,"성함을 입력해주세요")) return;
	if(checkValue(member.t_tell,"핸드폰 번호를 입력해주세요")) return;
	if(checkValue(member.t_tell.value.length < 11 ,"핸드폰 번호를 확인해주세요")) return;
	if(checkValue(member.t_id,"아이디를 입력해주세요")) return;
	if(member.t_id.value.length < 4 ){
		alert("아이디는 4자 이상이여야 합니다");
		member.t_id.focus();
		return;
	}
	
	if(checkValue(member.t_pw,"비밀번호를 입력해주세요")) return;
	if(checkValue(member.t_pw_check,"확인 비밀번호를 입력해주세요")) return;
	if(checkValue(member.t_tell,"연락처를 입력해주세요")) return;
	if(checkValue(member.t_email,"이메일을 입력해주세요")) return;
	if(checkValue(member.t_address_1,"주소를 입력해주세요")) return;
	if(checkValue(member.t_address_2,"주소를 입력해주세요")) return;
    if(member.t_id.value != member.idCheck_value.value){
         alert("아이디 중복검사를 해주세요 ");
         member.t_id.focus();
         return;
      }
	
	if(member.idCheck_yn.value=="no"){
         alert("사용불가 아이디입니다.");
         member.t_id.focus();
         return;
      }
	
	if(member.emailCheck_yn.value=="no"){
        alert("사용불가 이메일입니다.");
        member.t_email.focus();
        return;
     }

	
	if(member.t_pw.value != member.t_pw_check.value){
		alert("비밀번호가 같지 않습니다.");
		member.t_password_confirm.focus();
		return;
	}
	if(member.t_yak1.checked == false) {
		  alert('이용약관 동의를 해주셔야합니다.');
		return;
		}
	if(member.t_yak2.checked == false) {
		  alert('개인정보활용 동의를 해주셔야합니다.');
		return;
		}
	member.method="post";
	member.action="MemberSave";
	member.submit();
}
</script>

<!--중복검사  -->
<script type="text/javascript" language="javascript">
$(document).ready(function(){
	$("#checkID").click(function(){ 
	    var urlLocation="MemberIdCheck"; 
	    var id = member.t_id.value;
	    var params="t_id="+id;  
	    
	    if(id ==""){
	    	alert("ID 입력 후 눌러주세요 ");
	    	member.t_id.focus();
	    	return;
	    }
	    
		$.ajax({
			type : "POST",
			url : urlLocation,
			data: params,
			dataType : "text",
			error : function(){
				alert('통신실패!!');
			},
			success : function(data){
				//alert("통신데이터 값 : " + data);
				$("#idResult").html(data);
				if($.trim(data) =="<i class=\"fas fa-times\"></i>"){
					$("#idResult").css("color","red");
					$("#idResult").css("font-size","15px");
					member.idCheck_yn.value ="no";
					member.idCheck_value.value ="";
				} else {
					$("#idResult").css("color","blue");
					$("#idResult").css("font-size","15px");
					member.idCheck_yn.value ="yes";
					member.idCheck_value.value =id;
				}	
				
				
			}
		});
	});
});

//이메일 중복
$(document).ready(function(){
	$("#checkEMAIL").change(function(){ 
	    var urlLocation="MemberEmailCheck"; 
	    var email = member.t_email.value;
	    var params="t_email="+email;  
		    
	    	function email_check(email ) { 
	    	var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    	return(email != '' && email != 'undefined' && regex.test(email)); 
	    }
	    if(id ==""){
	    	member.t_email.focus();
	    	return;
	    }
	    
		$.ajax({
			type : "POST",
			url : urlLocation,
			data: params,
			dataType : "text",
			error : function(){
				alert('통신실패!!');
			},
			success : function(data){
				//alert("통신데이터 값 : " + data);
				$("#emailResult").html(data);
				if(!email_check(email)){
					$("#emailResult").css("color","red");
					$("#emailResult").css("font-size","20px");
					$("#emailResult").text("이메일 오류");
					$(this).focus();
				}else{
				if($.trim(data) =="이메일 중복"){
					$("#emailResult").css("color","red");
					$("#emailResult").css("font-size","25px");
					member.emailCheck_yn.value ="no";
					member.emailCheck_value.value ="";
					$(this).focus();
					return false;
				} else {
					$("#emailResult").css("color","blue");
					$("#emailResult").css("font-size","25px");
					$(".result-check_email").text('');
					member.emailCheck_yn.value ="yes";
					member.emailCheck_value.value =email;
				}	
			}}
		});
	});
});

//폰중복
$(document).ready(function(){
	$("#checkTELL").click(function(){ 
	    var urlLocation="MemberTellCheck"; 
	    var tell = member.t_tell.value;
	    var params="t_tell="+tell;  
	    
	    if(tell ==""){
	    	alert("tell 입력 후 눌러주세요 ");
	    	member.t_tell.focus();
	    	return;
	    }
	    
		$.ajax({
			type : "POST",
			url : urlLocation,
			data: params,
			dataType : "text",
			error : function(){
				alert('통신실패!!');
			},
			success : function(data){
				//alert("통신데이터 값 : " + data);
				$("#tellResult").html(data);
				if($.trim(data) =="<i class=\"fas fa-times\"></i>"){
					$("#tellResult").css("color","red");
					$("#tellResult").css("font-size","15px");
					member.tellCheck_yn.value ="no";
					member.tellCheck_value.value ="";
				} else {
					$("#tellResult").css("color","blue");
					$("#tellResult").css("font-size","15px;");
					member.tellCheck_yn.value ="yes";
					member.tellCheck_value.value =tell;
				}	
				
				
			}
		});
	});
});
</script>  
<script>
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


    

        //번호 체크
        
        $(document).ready(function(){
            $(".int_area #cellphone").change(function(){
            function tell_check() { 
                var tell = $(".int_area #cellphone").val(); 
            var regex=/01[016789][^0][0-9]{2,3}[0-9]{3,4}/;
            return(tell != '' && tell != 'undefined' && regex.test(tell)); 
            }

            // valid check
            if(! tell_check() ) {
            $(".result-check_tell").text('연락처 형식이 맞지 않습니다. 확인해해주세요.');
            $(this).focus();
            return false;
            }else{
            $(".result-check_tell").text('');
            }
        });
        });

    // $(document).ready(function(){
    //     $(".int_area_email input").change(function(){
    //     alert("z");
    //     });
    // });
    //번호만
	function onlyNumber(obj) {
		  obj.value = obj.value.replace(/[^0-9]/g, "");
		}
    
    
    //전문보기 모달
	  $(document).ready(function(){
		    $("#a_btn").click(function(){
		        $("#myModal").show();
		    })})
		    //팝업 Close 기능
		    function close_pop1(flag) {
		         $("#myModal").hide();
		    };
		    
		    //개인정보
			  $(document).ready(function(){
				    $("#a_btn2").click(function(){
				        $("#myModal2").show();
				    })})
				    //팝업 Close 기능
				    function close_pop2(flag) {
				         $('#myModal2').hide();
				    };
				
</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap');
    input::placeholder {
  color: lightgray;
  font-family: 'Dongle';
  font-size:25px;
}
</style>

	

		
	<!--##### contents // #####-->
	<!--메뉴 -->
	<!--##### contents // #####-->
	<div class="contents">
		<div class="tab-3 swipe-initialized swipe-off swipe-first swipe-last" data-swipe="{&quot;type&quot;:&quot;case1&quot;,&quot;start&quot;:&quot;.active&quot;}" tabindex="0">
			<ul class="swipe-cont" style="left: 0px;">
				<li data-act="tab" class="item"><a href="/hope/index"><span class="in">Smile Give</span></a></li>
				<li data-act="tab" class="item active"><a href="/hope/give"><span class="in">Give</span></a></li>
				<li data-act="tab" class="item"><a href="/hope/whatwedo"><span class="in">What we do</span></a></li>
				<li data-act="tab" class="item"><a href="/hope/story"><span class="in">Story</span></a></li>
			</ul>
		</div>
<body class="join_body">
	
	<fieldset style="border:none;">
    <section class="login_form" style="box-shadow: 2px 1px 5px 5px lightgray; width:800px; margin-top:22px; padding-top:30px; padding-bottom:20px;">
        <form name="member">
        <input type="hidden" name="t_tell" value="${t_tell}">
        <div class="head_area"><h1>회원가입</h1></div><br><br>
            <div class="int_area">
                <input type="text" name="t_name" id="name" autocomplete="off" required>
                <label for="name">성함</label>
            </div>
            <div class="int_area_2">
                <input type="text" id="cellphone" disabled value="${t_tell}" required>
                <label for="cellphone" onclick="tel">연락처(-없이)</label>
                <div class="result-check_tell"><p></p></div>
            </div>
            <div class="int_area">
                <input type="text" name="t_id" id="id" autocomplete="off" required>
                <label for="id">아이디</label> 
					<a id="checkID" style="font-size:20px; color:lightgray;cursor:pointer;border:1px solid lightgray; border-radius:20px; padding: 4px 4px 4px 4px; margin-left: 12px;margin-block-end: auto;"><b>ID 중복검사</b></a>
					<span id="idResult"></span>
					<input type="hidden" name="idCheck_yn">
					<input type="hidden" name="idCheck_value">
            </div>
            <div class="int_area">
                <input type="password" name="t_pw" id="pw" autocomplete="off" required>
                <label for="pw" onclick="password"> 비밀번호</label>
            </div>
            <div class="int_area">
                <input type="password" name="t_pw_check" id="pw_check" autocomplete="off" required>
                <label for="pw_check" onclick="password"> 비밀번호 확인</label>
            </div>
            <div class="int_area_email">
                <input type="text" onKeydown="checkEMAIL" id="checkEMAIL" name="t_email" class="input-check-email"
                    autocomplete="off" id="email" required>
                <label for="checkEMAIL" onclick="email"> 이메일</label><span id="emailResult"></span>
                <div class="result-check_email"><p></p></div>
					<input type="hidden" name="emailCheck_yn">
					<input type="hidden" name="emailCheck_value">
                
            </div>
            <div class="int_area">
                <input type="hidden" id="postcode" onclick="execDaumPostcode()" readonly required placeholder="우편번호">
                 <label style=" cursor:pointer;" for ="address" onclick="execDaumPostcode()">주소</label> <br>
                <input type="text" name="t_address_1" style="cursor: pointer;" id="roadAddress" onclick="execDaumPostcode()" required placeholder="도로명주소"  size="60" ><br>
                <input type="hidden" id="jibunAddress" placeholder="지번주소"  size="60">
                <span id="guide" style="color:#999;display:none;font-size:35px;margin-top:5px;"></span>
                <input type="text" name="t_address_2" id="detailAddress" placeholder="상세주소" required size="60"><br>
                <input type="hidden" id="extraAddress" placeholder="참고항목"  size="60">
                <input type="hidden" id="engAddress" placeholder="영문주소"  size="60" ><br>
                </div>
              <div class="agree_area">
                <ul class="check">
                    <p>문자, 이메일을 통한 정보 수신에 동의 하시면 체크해주세요</p>
                    <li>
                        <label for="agree">
                            <input type="radio" name="t_info_yn" value="y" id="agree" checked><span>동의</span></label>
                        <label for="agree2">
                            <input type="radio" name="t_info_yn" value="n" id="agree2"> <span>거부</span></label>
                    </li>
                    <br>
                     <p style="margin-bottom:1px;">이용약관 동의<span style="font-size:25px;color:red;"><필수></span></p>
                    <li>
                        <label for="yak1"><span class="info_agree">이용약관 동의
                        <a id="a_btn" data-toggle="modal" href="#myModal">전문보기</a></span>
                        <input type="checkbox" style="margin-left:2px;width:17px;height:17px;" required name="t_yak1" class="t_yak1"></label>
                    <li>
                        <label for="yak1"><span class="info_agree">개인정보활용 동의
                        <a id="a_btn2" data-toggle="modal2" href="#myModal2">전문보기</a></span>
                        <input type="checkbox"  style="margin-left:2px;width:17px;height:17px;" required name="t_yak2" class="t_yak2"></label>
                    </li>
                </ul>
            </div>
            <div class="btn_area">
                <button type="button" onclick="goJoin()">가입하기</button>
            </div>
        </form>
        <div class="caption">
            <!-- <a href="">Forgot Password?</a> -->
        </div>
    </section>
   </fieldset>
   </div>
     <%@ include file="../common_footer.jsp" %>
</body>
 <div id="myModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
            <p>
<h4>제1장 총칙</h4><br>
제1조(목적)<br>
본 약관은 대·중소기업·농어업협력재단 기술보호통합포털(이하 "당 관리시스템")이 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 당 관리시스템의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.<br><br>

제2조(약관의 효력 및 변경)<br>
① 당 관리시스템은 귀하가 본 약관 내용에 동의하는 것을 조건으로 귀하에게 서비스를 제공할 것이며, 귀하가 본 약관의 내용에 동의<br>
    하는 경우, 당 관리시스템의 서비스 제공 행위 및 귀하의 서비스 사용 행위에는 본 약관이 우선적으로 적용될 것입니다.<br>
② 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 당 관리시스템의 초기화면에 그 적용일자 7일 이전부터<br>
    적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을<br>
    두고 공지합니다. 이 경우 당 관리시스템은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.<br>
    이용자가 변경된 약관에 동의하지 않는 경우, 이용자는 본인의 회원등록을 취소(회원탈퇴)할 수 있으며 계속 사용의 경우는 약관<br>
    변경에 대한 동의로 간주됩니다.<br>
제3조(약관 외 준칙)<br>
① 본 약관은 당 관리시스템이 제공하는 서비스에 관한 이용규정 및 별도 약관과 함께 적용됩니다.<br>
② 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보 통신 윤리강령, 컴퓨터 프로<br>
    그램보호법 및 기타 관련 법령의 규정에 의합니다.<br>
제4조 (용어의 정의)<br>
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br>
① 이용자 : 본 약관에 따라 당 관리시스템이 제공하는 서비스를 받는 자<br>
② 가입 : 당 관리시스템이 제공하는 회원가입 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용 계약을 완료시키는 행위<br>
③ 회원 : 당 관리시스템에 개인 정보를 제공하여 회원 등록을 한 자로서, 당 관리시스템의 정보를 제공받으며, 당 관리시스템이 제공하<br>
    는 서비스를 이용할 수 있는 자<br>
④ 비밀번호 : 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의<br>
    조합<br>
⑤ 탈퇴 : 회원이 이용계약을 종료시키는 행위<br>
⑥ 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도 약관 및 이용규정에서 정의합니다<br>
제2장 서비스 제공 및 이용<br>
제5조(이용계약의 성립)<br><br>
① 이용계약은 신청자가 온라인으로 당 관리시스템에서 제공하는 소정의 회원가입 신청양식에서 요구하는 사항을 기록하여 가입을 완<br>
    료하는 것으로 성립됩니다.<br>
② 당 관리시스템은 다음 각 호에 해당하는 이용계약에 대하여는 가입을 취소할 수 있습니다.<br>
- 다른 사람의 명의를 사용하여 신청하였을 때<br>
- 이용 계약 신청서의 내용을 허위로 기재하였거나 신청하였을 때<br>
- 사회의 안녕 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때<br>
- 다른 사람의 당 관리시스템 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때<br>
- 당 관리시스템을 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우<br>
- 기타 당 관리시스템이 정한 이용신청요건이 미비 되었을 때<br>
③ 당 관리시스템은 다음 각 항에 해당하는 경우 그 사유가 해소될 때까지 이용계약 성립을 유보할 수 있습니다.<br>
- 서비스 관련 제반 용량이 부족한 경우<br>
- 기술상 장애 사유가 있는 경우<br>
④ 당 관리시스템이 제공하는 서비스는 아래와 같으며, 그 변경될 서비스의 내용을 이용자에게 공지하고 아래에서 정한 서비스를 변경<br>
    하여 제공할 수 있습니다.<br>
- E-mail을 통한 대·중소기업·농어업협력재단의 각종 정보 제공<br>
- 당 관리시스템이 자체 개발하거나 다른 기관과의 협의 등을 통해 제공하는 일체의 서비스<br>
			</p>
           
           
        <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop1();">
            <span class="pop_bt" style="font-size: 13pt;" >
                 닫기
            </span>
        </div>
  </div>

</div>


<div id="myModal2" class="modal2">
  <!-- Modal content -->
  <div class="modal-content2">
            <p>
<h4>개인정보 활용 동의</h4><br>
■ 개인정보 수집 및 이용에 대한 동의 <br>
1. 수집·이용의 목적 <br>
- 지역산업지원사업의 과제 운영 및 지역 기업 기술·경영 컨설팅 지원을 위한 지역 내 대학·연구소의 전문인력 정보 취득으로 지역산업지원사업의 과제 추진 및 기업지원을 위한 기반 마련 <br>
- 지역산업지원사업의 과제 운영에 필요한 전문지식과 기업의 수요기술 및 경영관련 애로사항에 적합한 전문인력을 조사된 정보를 기반으로 중개함으로써 원활한 과제 운영을 도모하고 기업의 애로사항 해결에 기여하고자 함 <br>
2. 수집하는 개인정보의 항목 <br>
- 기본정보 (성명, 소속기관 및 부서, 직책, 전화번호, 휴대폰, 팩스, 이메일) 및 학력, 경력, 전문분야, 상세전공, 주요 연구 분야를 수집하고자 하며 자세한 사항은 조사지 참조  <br>
3. 개인정보의 보유 및 이용기간  <br>
- 본 동의서가 작성된 일로부터 제1항의 사용목적이 종료되는 때까지 <br>

■ 제3자에게 개인정보 제공에 대한 동의  <br>

1. 개인정보를 제공받는 제3자 <br>
- 정부기관 및 지방자치단체, 정부·지자체 출자출연기관, 기타 기업지원을 위하여 (재)충남테크노파크와 MOU를 체결한 기관 <br>
- 기술 사업화에 어려움을 겪고 있는 분야의 전문인력 컨설팅을 요청한 기업 <br>
2. 개인정보를 제공받는 자의 이용 목적 <br>
- 지역사업 관련 기업지원 과제관련 심의, 성과분석 등 기업육성을 위한 전문분야 자문 <br>
- 기술적, 경영적 애로사항 상담 및 애로해소 전문분야 자문 <br>
3. 제공하는 개인정보의 항목 <br>
- 기본정보 (성명, 소속기관 및 부서, 직책, 전화번호, 휴대폰, 팩스, 이메일) 및 학력, 경력, 상세전문분야, 주요업적 <br>
4. 개인정보를 제공받는 자의 보유 및 이용기간 <br>
- 본 동의서가 작성된 일로부터 제1항의 사용목적이 종료되는 때까지 <br>
			</p>
            <br>
           
        <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop2();">
            <span class="pop_bt" style="font-size: 13pt;" >
                 닫기
            </span>
        </div>
  </div>

</div>
</html>