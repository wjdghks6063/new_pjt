<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          <%@ include file="../common_header.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        
    

<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap');

section{
 font-family: 'Dongle';
	margin: auto;
    box-shadow: 1px 3px 19px 4px lightgray; width:700px; 
    margin-top:40px; 
    padding-top:60px;
    padding-bottom:20px;
}
body::before{
    position: absolute; z-index: 1;
    top:0; right:0; bottom:0; left:0;
}

.login_form{
    margin-top: 66px;
    position: relative; z-index:2;

}

.login_form h1{
    font-size: 72px; color:lightslategray;
    text-align: center;
        margin-bottom: 50px;
}
.bunho_injung{
	margin-left:100px;
	width:700px;
}

.int_area{width:400px; margin-left:50px; position:relative; }
.int_area input {
    width: 50%;
    height: 91px;
    padding: 73px 10px 10px;
    background-color: transparent;
    border: none;
    border-bottom: 1px solid #999;
    font-size: 28px;
    color: lightslategray;
    outline: none;
    margin-top: -43px;
}

.btn_area{
	margin-top:30px;
}
.btn_area button{
    margin-left: 298px;
    width: 95px;
    height: 43px;
    background: gray;
    color: white;
    font-size: 32px;
    padding-top: 11px;
    border: none;
    border-radius: 25px;
    font-family: 'Dongle';
    cursor: pointer;
}
.injung_button{
	margin-left:10px;
    width:50px;
    height:40px;
    background:gray;
    color:white;
    font-size:30px;
    border: none;
    border-radius:25px;
    font-family: 'Dongle';
 	 cursor:pointer;
}
.injung_button:disabled,
.injung_button[disabled]{
	margin-left:10px;
    width:50px;
    height:40px;
    background:lightgray;
    color:white;
    font-size:30px;
    border: none;
    border-radius:25px;
    font-family: 'Dongle';
 	 cursor:not-allowed;
}
.btn_area button:disabled,
.btn_area button[disabled]{
    margin-left: 298px;
    width: 95px;
    height: 43px;
    background: lightgray;
    color: white;
    font-size: 30px;
    padding-top: 11px;
    border: none;
    border-radius: 25px;
    font-family: 'Dongle';
    cursor: not-allowed;
}
.caption{
    margin-top:10px;
    text-align:center;
}

.caption a{
    font-size: 32px; color: lightslategray;
    text-decoration: none;
}
</style>

    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
//번호 체크

$(document).ready(function(){
    $("#cellphone").on("propertychange change keyup paste input", function(){
    var target = document.getElementById("identify_butt_1");
	    function tell_check() { 
	    var tell = $(".int_area #cellphone").val(); 
	    var regex=/01[016789][^0][0-9]{3}[0-9]{4}/;
	    return(tell != '' && tell != 'undefined' && regex.test(tell)); 
	    }
    // valid check
    if(! tell_check() ) {
    $(".result-check_tell").text('연락처 형식이 맞지 않습니다. 확인해해주세요.');
    target.disabled = true;
    $(this).focus();
    return false;
    }else{
    $(".result-check_tell").text('');
    target.disabled = false;
    }
});
});
//번호생성
function bunho(){
	if(member.t_tell.value==""){ 
		alert("번호를 입력하세요"); member.t_tell.focus(); 
		return;}
	if(member.t_tell.value.length<11 || member.t_tell.value.length>11){ 
		alert("11자리를 입력하세요"); member.t_tell.focus(); 
		return;}
	member.method="post";
	member.action="bunho3";
	member.submit();
}

	//번호검증
function bunho_check(){
	if(member.t_custom_number.value=="" || member.t_custom_number.value==null){ 
		alert("인증번호를 입력하세요"); 
		return;
		}
	
	var target = document.getElementById('identify_butt_1');
	var target2 = document.getElementById('identify_butt_2');
	var target3 = document.getElementById('join_button');
	var target4 = document.getElementById('btn_area_join');
	var target5 = document.getElementById('t_custom_number');

	if(member.t_custom_number.value != member.t_identify_number.value){
		alert("인증번호를 확인해주세요"); 
		member.t_custom_number.focus();
		target.disabled = false;
		target3.disabled = true;
		return;
		
	}else{
		alert("인증확인");
		target.disabled = true;
		target2.disabled = true;
		target3.disabled = false;
		target4.style.display="block";
		target5.disabled = true;
		//member.method="post";
		//member.action="bunho3";
		//member.submit();
	}
}
	
	function goJoin(){
		member.method="post";
		member.action="Join";
		member.submit();
	}
	function onlyNumber(obj) {
		  obj.value = obj.value.replace(/[^0-9]/g, "");
		}
</script>
<script language='javascript'>
//새로고침방지
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

</script>
<style>
::placeholder{
    font-family: 'Dongle';
	font-size:20px;
	color:lightgray;	
	}
</style>

    <section class="login_form">
        <h1>핸드폰 인증</h1>
        <form name="member">
        	
            <div class="int_area">
                <div class="bunho_injung" style="border:none;">
              	 <input type="tel" name="t_tell" id="cellphone" onKeyup="onlyNumber(this)" <c:if test="${not empty t_check_num}"> readonly </c:if> placeholder ="핸드폰번호입력" value="${t_tell}" maxlength="11" autocomplete="off" required>
                	<button class="injung_button" type="button" onclick="bunho()" <c:if test="${not empty t_tell}"> disabled </c:if> id="identify_butt_1">인증</button>
                	  <div class="result-check_tell"  style="font-size:25px;color:red;"><p>   <c:choose>
							    <c:when test="${t_msg eq '인증번호가 발송되었습니다'}">
							      <span style="margin-left:10px;font-size:25px;color:blue;" >${t_msg}</span>
							    </c:when>
							    <c:otherwise>
							      <span style="margin-left:10px;font-size:25px;color:red;" >${t_msg}</span>
							    </c:otherwise>
							</c:choose></p></div>
                	      <br>
                	      <br>
					<input type="text" onKeyup="onlyNumber(this)" placeholder ="인증번호입력" id="t_custom_number" size="3" name="t_custom_number">
					<input type="hidden" name="t_identify_number" value="${t_check_num}">
					<button class="injung_button" type="button" onclick="bunho_check()" id="identify_butt_2">인증</button>
           		 </div>
            </div>
            <div id ="btn_area_join">
            <div class="btn_area" >
                <button id="join_button" disabled type="button" onclick="goJoin()">가입하기</button><br>
                <button id="back_button" style="margin-top:20px;"type="button" onclick="history.go(-1)">뒤로가기</button><br>
            </div>
            </div>
            <div id="btn_area_join">
             <div class="caption">
            <!-- <a href="">본인인증으로 가입하기</a> -->
        </div>
        </div>
        </form>
       
    </section>
       <%@ include file="../common_footer.jsp" %>
    </div>
   
</body>
</html>