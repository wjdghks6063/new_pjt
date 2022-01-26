<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common_header.jsp" %>
    

    <link rel="stylesheet" href="/css/find_id.css">

<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

function injung_check(){
        
            var target = document.getElementById('hiding_1');
           
            var target2 = document.getElementById('hiding_2');

            //alert(nmember.t_custom_number.value);
            //alert(nmember.t_identify_number.value);
            if(member.t_find_id.value=="phone"){
                 target.style.display="block";
                 target2.style.display="none";
             }else if(member.t_find_id.value=="email"){
                target2.style.display="block";
                target.style.display="none";
            }
            }
            
function bunho(){
	if(member.t_name_tell.value==""){ 
		alert("성함을 입력하세요"); member.t_name_tell.focus(); 
		return;}
	if(member.t_tell.value==""){ 
		alert("번호를 입력하세요"); member.t_tell.focus(); 
		return;}
	if(member.t_tell.value.length<11 || member.t_tell.value.length>11){ 
		alert("11자리를 입력하세요"); member.t_tell.focus(); 
		return;}
	
		member.method="post";
		member.action="Bunho_find_id";
		member.submit();
}

function email_find(){
	if(member.t_name_email.value==""){ 
		alert("성함을 입력하세요"); member.t_name_email.focus(); 
		return;}
	if(member.t_email.value==""){ 
		alert("이메일을를 입력하세요"); member.t_email.focus(); 
		return;}
	
	member.method="post";
	member.action="Email_find_id";
	member.submit();
}
	
//번호검증
function bunho_check(){
	var found_id = member.t_found_id.value;
	if(member.t_custom_number.value=="" || member.t_custom_number.value==null){ 
		Swal.fire({
			icon:'warning',
			 title: '인증번호를 입력해주세요',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: '#A9A9A9',
			  confirmButtonText: '확인',
			
			}) 
		return;
		}
	
	var target = document.getElementById('identify_butt_2');

	alert(member.t_custom_number.value);
	alert(member.t_identify_number.value);
	if(member.t_custom_number.value != member.t_identify_number.value){
		Swal.fire({
			icon:'warning',
			 title: '인증번호를 확인해주세요',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: '#A9A9A9',
			  confirmButtonText: '확인',
			
			}) 
		member.t_custom_number.focus();

		return;
		
	}else{
		Swal.fire({
			icon:'success',
			 title: '인증확인',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: '#A9A9A9',
			  confirmButtonText: '확인',
			
			})
		target.disabled = true;
		//member.method="post";
		//member.action="bunho3";
		//member.submit();
		
		  	Swal.fire({
		  		icon: 'success',
				 title: '인증 완료.<br><br> 회원님의 아이디: '+member.t_found_id.value,
				  padding: '3em',
				  color: '#A9A9A9',
				  confirmButtonColor: 'gray',
				  showCancelButton: true,
				  confirmButtonText: '로그인하러 가기',
				  cancelButtonText: '비밀번호 찾으러 가기',
				  cancelButtonColor: '#A9A9A9',
				  reverseButtons: true
				  
				
		  		}).then((result) => {
					if (result.isConfirmed) { 
						
						member.method="post";
						member.action="/Login";
						member.submit();
					  }else{
						  
							member.method="post";
							member.action="/Find_pw_1";
							member.submit();
						        }
						}) 
					
			        };
}


function bunho_check_email(){
	var found_id_2 = member.t_found_id_2.value;
	if(member.t_custom_number_2.value=="" || member.t_custom_number_2.value==null){ 
		Swal.fire({
			icon:'warning',
			 title: '인증번호를 입력해주세요',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: '#A9A9A9',
			  confirmButtonText: '확인',
			
			}) 
		return;
		}
	
	var target = document.getElementById('identify_butt_4');

	alert(member.t_custom_number_2.value);
	alert(member.t_identify_number_2.value);
	if(member.t_custom_number_2.value != member.t_identify_number_2.value){
		Swal.fire({
			icon:'warning',
			 title: '인증번호를 확인해주세요',
			  padding: '3em',
			  color: '#A9A9A9',
			  confirmButtonColor: '#A9A9A9',
			  confirmButtonText: '확인',
			
			}) 
		member.t_custom_number_2.focus();

		return;
		
	}else{
		alert("인증확인");
		target.disabled = true;
		//member.method="post";
		//member.action="bunho3";
		//member.submit();
		
		  	Swal.fire({
		  		icon: 'success',
				 title: '인증 완료.<br><br> 회원님의 아이디: '+member.t_found_id_2.value,
				  padding: '3em',
				  color: '#A9A9A9',
				  confirmButtonColor: '#A9A9A9',
				  confirmButtonText: '로그인하러가기',
				
				}).then(function(){
					member.method="post";
					member.action="/Login";
					member.submit();
			        });
		
	}
}

function onlyNumber(obj) {
	  obj.value = obj.value.replace(/[^0-9]/g, "");
}


</script>
  
<body>
<!--서브 헤더 -->

    <section class="find_id_form">
        <h1>아이디 찾기</h1>
        <form name="member">
        	<input type="hidden" name="t_msg" value="${t_msg}">
        	 <input type="hidden" name="t_identify_number" value="${t_check_num}">
        	 <input type="hidden" name="t_identify_number_2" value="${t_check_num_2}">
        	 <input type="hidden" name="t_found_id" value="${t_found_id}">
        	 <input type="hidden" name="t_found_id_2" value="${t_found_id_2}">
            <div class="find_id_form_2">
             <input type="radio" name="t_find_id" id="phone"  onclick="injung_check()" checked value="phone"><label for="phone"><span style="font-size:30px; margin-left:5px; color:gray;">등록된 핸드폰 번호로 찾기</span></label>
         		 <div id = "hiding_1" <c:if test="${empty t_msg_2}"> style="display:block" </c:if> <c:if test="${not empty t_msg_2}"> style="display:none" </c:if> >
	                  <div class="int_area">
	                    <label for="name" onclick="name"> 성&nbsp;&nbsp;명</label>
	                  <input type="text" name="t_name_tell" value="${t_name_tell}" id="name" autocomplete="off"><br>
	                
	                  <label for="tell" onclick="tell">핸드폰</label>
	                  <input type="tel" name="t_tell" onKeyup="onlyNumber(this)"  value="${t_tell}"maxlength="12">
	                   <button class="injung_button" type="button" onclick="bunho()"  <c:if test="${t_msg eq'인증번호가 발송되었습니다'}"> disabled </c:if> id="identify_butt">인증번호받기</button>
	                  
	                  
	                       <c:choose>
							    <c:when test="${t_msg eq '인증번호가 발송되었습니다'}">
							       <input type="text" id="no_info" readonly style="border:none; margin-left:45px;color:blue;cursor:default;" value="${t_msg}"><br>
							      <input type="text" style="margin-left:146px;width:54px;" onKeyup="onlyNumber(this)"  maxlength="3" name="t_custom_number">
							       <button class="injung_button" type="button" onclick="bunho_check()" id="identify_butt_2">확인</button>
							    </c:when>
							    <c:otherwise>
							       <input type="text" id="no_info" readonly style="border:none; margin-left:45px;color:red;cursor:default;" value="${t_msg}">
							    </c:otherwise>
							</c:choose>
                	</div>
             	</div><br><br>
                
                    <input type="radio" name="t_find_id" id="find_email" <c:if test="${not empty t_name_email}"> checked </c:if>onclick="injung_check()" value="email"><label for="find_email"><span style="font-size:30px; margin-left:5px; color:gray;">등록된 이메일로 찾기</span></label>
	                    <div id = "hiding_2" <c:if test="${empty t_msg_2}"> style="display:none" </c:if> <c:if test="${not empty t_msg_2}"> style="display:block" </c:if> >
	                   
	                    <div class="int_area">
	                        <label for="email_name" onclick="email_name" > 성&nbsp;&nbsp;명</label>
	                    <input type="text" name="t_name_email" id="email_name" value="${t_name_email}" autocomplete="off"><br>
	                   
	                    <label for="email" onclick="email">이메일 </label>
	                    <input type="text" name="t_email" id="email" value="${t_email}" autocomplete="off">
					     <button class="injung_button" type="button" onclick="email_find()"  <c:if test="${t_msg_2 eq'인증번호가 발송되었습니다'}"> disabled </c:if> id="identify_butt_3">인증번호받기</button>
					       <c:choose>
							    <c:when test="${t_msg_2 eq '인증번호가 발송되었습니다'}">
							       <input type="text" id="no_info_2" readonly style="border:none; margin-left:45px;color:blue;cursor:default;" value="${t_msg_2}"><br>
							      <input type="text" style="margin-left:146px;width:54px;" onKeyup="onlyNumber(this)"  maxlength="3" name="t_custom_number_2">
							       <button class="injung_button" type="button" onclick="bunho_check_email()" id="identify_butt_4">확인</button>
							    </c:when>
							    <c:otherwise>
							       <input type="text" id="no_info_2" readonly style="border:none; margin-left:45px;color:red;cursor:default;" value="${t_msg_2}">
							    </c:otherwise>
							</c:choose>
                  		</div>
                 	 </div>
                
            </div>
                </form>
      <button class="back_button" type="button" onClick="history.go(-1)" >뒤로가기</button>
    </section>
    </div>
    <%@ include file="../common_footer.jsp" %>
</body>
</html>