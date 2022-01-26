
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <script src="/webapp/js/common.js"></script>
  <link rel="stylesheet" type="text/css"  href="css/non_member_donate.css">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<script>

//주소
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


//새로고침 F5방지

function noEvent() {
	if (event.keyCode == 116) {
	event.keyCode= 2;
	return false;
	}
	else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
	{
	return false;
	}
	}
	document.onkeydown = noEvent;

	//번호생성
	function bunho(){
		if(nmember.t_bunho_1.value==""){ 
			alert("번호를 입력하세요"); nmember.t_bunho_1.focus(); 
			return;}
		if(nmember.t_bunho_1.value.length<3 || nmember.t_bunho_1.value.length>3){ 
			alert("3자리를 입력하세요"); nmember.t_bunho_1.focus(); 
			return;}
		if(nmember.t_bunho_2.value=="") {
			alert("번호를 입력하세요"); nmember.t_bunho_2.focus(); 
			return;}
		if(nmember.t_bunho_2.value.legnth<4 || nmember.t_bunho_2.value.length>4) {
			alert("4자리를 입력하세요 "); nmember.t_bunho_2.focus(); 
			return;}
		if(nmember.t_bunho_3.value==""){
			alert("번호를 입력하세요"); nmember.t_bunho_3.focus(); 
			return;}
		if(nmember.t_bunho_3.value.length<4 || nmember.t_bunho_3.value.length>4){
			alert("4자리를 입력하세요"); nmember.t_bunho_3.focus(); 
			return;}
		nmember.method="post";
		nmember.action="bunho";
		nmember.submit();
	}
	
	//번호검증
	function bunho_check(){
		if(nmember.t_custom_number.value=="" || nmember.t_custom_number.value==null){ 
			alert("인증번호를 입력하세요"); 
			return;
			}
		
		var target = document.getElementById('identify_butt');
		var target2 = document.getElementById('email');
		var target2_1 = document.getElementById('email2');
		var target3 = document.getElementById('email3');
		var target4 = document.getElementById('name');
		var target5 = document.getElementById('donate_form');
		//alert(nmember.t_custom_number.value);
		//alert(nmember.t_identify_number.value);
		if(nmember.t_custom_number.value != nmember.t_identify_number.value){
			alert("번호를 확인해주세요"); 
			member.t_custom_number.focus();
			target.disabled = false;
			target2.readOnly = true;
			target2_1.readOnly = true;
			target3.disabled= true;
			target4.readOnly = true;
			return;
		}else{
			alert("인증확인");
			target.disabled = true;
			target2.readOnly=false;
			target2_1.readOnly=false;
			target3.disabled= false;
			target4.readOnly=false;
			target5.style.display="block";
		}
	}
	
	//이메일
	function emailChange(){
		var aa = nmember.t_email3.value;
		if(aa != ""){
			nmember.t_email2.value = aa;
		}else{
			nmember.t_email2.value = "";
			nmember.t_email2.focus();
		}
		
	}
	//번호만
	function onlyNumber(obj) {
		  obj.value = obj.value.replace(/[^0-9]/g, "");
		}
	
</script>

<body oncontextmenu="return false">
<h1>
</h1>
<form name="nmember">
    <div class="donate-page-frame">
        <div class="donate-intro-box">
            <div class="donate-page-box-title">
                <h2>후원하기</h2>
            </div>
            <div class="donate-page-box-description">
                <p>여러분의 작은 후원으로
                    어려운 이웃을 구할 수 있습니다.<br>
            </div>
        </div>
        <div class="bunho_injung" style="border:1px solid black;">
			<label for ="phone"> 번호</label>
			<input type="text" name="t_bunho_1" onKeyup="onlyNumber(this)" value="${t_bunho_1}" size="3" id="phone">
			<input type="text" name="t_bunho_2" onKeyup="onlyNumber(this)" value="${t_bunho_2}" size="4" id="phone">
			<input type="text" name="t_bunho_3" onKeyup="onlyNumber(this)" value="${t_bunho_3}" size="4" id="phone">
			<button type="button" onclick="bunho()" <c:if test="${not empty t_bunho_1}"> disabled </c:if> class="identify_butt">인증하기</button>
			<br>
			<label for ="identify_number"> 인증번호 </label>
			<input type="text" onKeyup="onlyNumber(this)" size="3" name="t_custom_number">
			<input type="hidden" name="t_identify_number" value="${t_check_num}">
			<button type="button" onclick="bunho_check()" id="identify_butt">확인</button>
		</div><br>
		<div id="donate_form" style="display:none">
        <div class="donate_form_2">
            <fieldset>
                <h3>후원정보</h3>
                <div class="form-row">
                    <label class="donate-label">후원분야</label>
                    <select>
                        <option value="기부">기부</option>
                        <option value="참여">참여</option>
                    </select>
                </div>

                <div class="donate_way">
                    <label>후원방식</label>
                    <ul>
                        <li>
                            <input type="radio" id="정기" value="정기" name="jgis" checked="checked">
                            <label for="정기"><span>정기</span></label>
                        </li>
                        <li>
                            <input type="radio" value="일시" id="일시" name="jgis">
                            <label for="일시"><span>일시</span></label>
                        </li>
                    </ul>
                </div>
                <div class="donate_amount">
                    <label>후원금액</label>
                    <select>
                        <option value="10000"> 10000</option>
                        <option value="30000"> 30000</option>
                        <option value="50000"> 50000</option>
                        <option value="100000"> 100000</option>
                        <option value="direct"> 직접입력</option>
                    </select>
                </div>
            </fieldset>
            </div>
<br>

                <div class="member">
                    <div class="member_form">
                        <fieldset>
                            <p>후원자 정보</p>
                            <div class="form-row" id="name-row">
                              <label for ="name"> 이름 </label>
								<input type="text" id="name" readonly name="t_name" size="10"> 
								<br>
								<label for ="phone"> 번호</label>
								<input type="text"  value="${t_bunho_1}" readonly size="3" id="phone">
								<input type="text"  value="${t_bunho_2}" readonly size="4" id="phone">
								<input type="text"  value="${t_bunho_3}" readonly size="4" id="phone">
								<br>
                                <label for="email">이메일</label>
                          		  <input type="text" name="t_email1" readonly id="email" class="w150" >@
                          		 	<input type="text" name="t_email2" readonly id="email2" class="w150" >
                           		<select name="t_email3" id="email3" disabled onchange="emailChange();" >
                           	 	<option value="">직접 입력</option>
                        		<option value="hanmail.net">다음</option>
                        		<option value="naver.com">네이버</option>
                        		<option value="gmail.net">구글</option>
                        	</select>
                            </div>
                            <div class="donate_need_info_form">
                                <label>주소</label>
                                <input type="text" id="postcode" readonly placeholder="우편번호">
                                <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>	
                                
                                <input type="text" id="roadAddress" placeholder="도로명주소" readonly  size="60" ><br>
                                <input type="hidden" id="jibunAddress" placeholder="지번주소" readonly  size="60">
                                <span id="guide" style="color:#999;display:none"></span>
                                <input type="text" id="detailAddress" placeholder="상세주소"  size="60"><br>
                                </div>
                        </fieldset>
                    </div>
                </div>
                <!--후원자 한마디-->
                <div id="div-promise" class="">
                        <fieldset>
                            <div class="form-row ">
                                <label>후원자한마디</label><br>
                                <textarea id="contributormemo" class="input-contributormemo"> </textarea>
                            </div>
                            <div class="info-box-container">
                                <ul class="info-box-content hidden">
                                </ul>
                            </div>
                        </fieldset>
                </div>
                  <button type="button" onclick="" id="butt">후원하기</button>
        </div>
        </div>
    	
</form>
</body>
</html>
