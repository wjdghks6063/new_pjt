<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common_header.jsp" %>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="/css/find_pw_1.css">
    

<script>
function onlyNumber(obj) {
	  obj.value = obj.value.replace(/[^0-9]/g, "");
	}


	//패스워드 메일보내기
	$(document).ready(function(){
		$(".injung_button").click(function(){ 
			   if(member.t_id.value ==""){
				   alert("아디 입력");
			    	member.t_id.focus();
			    	return;
			    }
			    
			   if(member.t_email.value ==""){
				   alert("이메일 입력");
			    	member.t_email.focus();
			    	return;
			    }
			    
			   if(member.t_tell.value ==""){
				   alert("연락처 입력");
			    	member.t_tell.focus();
			    	return;
			    }
			   if(member.t_tell.value.length <11){
				   alert("연락처는 11자리를 입력해주세요");
			    	member.t_tell.focus();
			    	return;
			    }
		    var urlLocation="MemberEmailFindpw"; 
		    var email = member.t_email.value;
		    var id = member.t_id.value;
		    var tell = member.t_tell.value;
		    var after_injung_box = document.getElementById("injung_button");
		    
	    	function email_check(email ) { 
		    	var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		    	return(email != '' && email != 'undefined' && regex.test(email)); 
		    }
		 
			$.ajax({
				type : "POST",
				url : urlLocation,
				data: {"t_email":email, "t_id":id,"t_tell":tell},
				dataType : "text",
				error : function(){
					alert('통신실패!!');
				},
				success : function(data){
					//alert("통신데이터 값 : " + data);
					$("#Result").html(data);
					$("#emailResult").html(data);
					if(!email_check(email)){
						$("#emailResult").css("color","red");
						$("#emailResult").css("font-size","31px");
						$("#emailResult").css("margin-left","93px");
						$("#emailResult").css("margin-top","10px");
						$("#emailResult").text("이메일 형식 오류");
						$("#Result").text("");
						$(this).focus();
					}else{
						$("#emailResult").text("");
						
							if($.trim(data) =="가입된 정보가 없습니다"){
							$("#Result").css("color","red");
							$("#Result").css("font-size","31px");
							$("#Result").css("margin-left","93px");
							$("#Result").css("margin-top","10px");
						
							$(this).focus();
							return false;
						} else {
							$("#Result").css("color","blue");
							$("#Result").css("font-size","31px");
							$("#Result").css("margin-left","93px");
							$("#Result").css("margin-top","10px");
							after_injung_box.disabled="true";
							
							Swal.fire({
						  		icon: 'success',
								  title: '<div style="font-size:35px;font-family:Dongle;color:#A9A9A9;"> 가입된 이메일로<br><br> 비밀번호 발송완료 </div>',
								  padding: '3em',
								  color: '#A9A9A9',
								  confirmButtonColor: 'gray',
								  showCancelButton: true,
								  confirmButtonText: '로그인하러 가기',
								  cancelButtonText: '닫기',
								  cancelButtonColor: '#A9A9A9',
								  reverseButtons: true
						  		}).then((result) => {
									if (result.isConfirmed) { 
										
										member.method="post";
										member.action="/Login";
										member.submit();
									  }else{
										        }
										}) 
							
						}	
					}}
			});
		});
		if(event.stopPropagation) event.stopPropagation();});
</script>
<body>
<!--서브 헤더 -->
    <section class="find_id_form">
        <h1>비밀번호 찾기</h1>
        <form name="member">
            <div class="find_id_form_2">
                  <div class="int_area">
                    <label for="id" onclick="id"> 아이디</label>
                  <input type="text" style="margin-bottom:15px;" name="t_id" id="id"  <c:choose>
							    <c:when test="${not empty t_found_id}"> value="${t_found_id}"
							    </c:when>
							      <c:when test="${not empty t_found_id_2}"> value="${t_found_id_2}"
							    </c:when>
							    <c:otherwise>
							       value="${t_id}"
							    </c:otherwise>
					</c:choose> autocomplete="off"><br>
                    <label for="email" style="width:55px;">이메일</label> 
                    <input type="text" name="t_email" id="emailcheck" value="${t_email}" autocomplete="off">
                     <div id="emailResult"><span></span></div><br>
					<label for="tell" style="width:55px;"onclick="tell">연락처</label> 
					 <input type="text" name="t_tell" id="tell" onKeyup="onlyNumber(this)" value="${t_tell}" autocomplete="off">
					 <button class="injung_button" id="injung_button" type="button" >인증하기</button>
                   <div id="Result"><span></span></div><br>
                  </div>
                  <div class="btn_area">
                   <button type="button" onClick="history.go(-1)">뒤로가기</button>
                </div>
            </div>
                </form>
      
    </section>
</div>
        <%@ include file="../common_footer.jsp" %>
</body>
</html>