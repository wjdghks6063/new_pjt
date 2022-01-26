<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ include file="../common_header.jsp" %>

     <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle:wght@300&display=swap');

body{

    justify-content:center;
    align-items: center;
    background-size:cover;
    background: url("pastel2.jpg") no repeat center;
    animation:image_change 10s infinite;
}

section{
    font-family: 'Dongle';
    box-shadow: 1px 3px 19px 4px lightgray; 
    width:700px; 
    height:700px;
    margin-top:22px; 
    padding-top:30px;
    padding-bottom:20px;
}
body::before{
    position: absolute; z-index: 1;
    top:0; right:0; bottom:0; left:0;
}

.login_form{
    margin-top: 83px;
    position: relative; z-index:2;margin-inline: auto;
}

.login_form h1{
	margin-bottom: 31px;
    font-size: 106px;
    margin-top: 44px; color:lightslategray;
    text-align: center;
}

.int_area{width:400px; margin-left:50px; position:relative; }
.int_area input{
    width:90%;
    height:90px;
    margin-left:117px;
    padding: 50px 10px 10px;
    background-color: transparent;
    border:none;
    border-bottom: 1px solid #999;
    font-size: 28px; color: lightslategray;
    outline:none;
}

.id_label{
    position: absolute; 
    left: 121px;
    top: 65px;
    font-size:41px; 
    color:#999;
    transition: top .1s ease;
}

.pw_label{
    position: absolute;     
    left: 121px;;
    top: 53px;
    font-size:38px; 
    color:#999;
    transition: top .1s ease;
}


.int_area input:focus+label,
.int_area input:valid + label{
    top: 20px;
    font-size:28px; color:lightgray;
}

.btn_area {margin-top:30px;}
.btn_area button{
    width:55%;
    margin-left: 156px;
    height:56px;
    background:lightgray;
    color:white;
    padding-top: 13px;
    font-size: 45px;
    border: none;
    border-radius:25px;
    font-family: 'Dongle';
    
}
.login_img{
	margin-top:17px;
    width:55%;
    height:50px;
    border-radius: 25px;
}

.caption{
    margin-top:60px;
    text-align:center;
    
}

.caption a{
    font-size: 28px; color: lightslategray;
    text-decoration: none;
}
</style>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script type="text/javascript" src="/js/common.js"></script>
</head>
<script>
function check(){
	var k = event.keyCode;
	if(k==13){
		if(checkValue(member.t_id,"아이디를 입력하시오!")) return;
		member.t_id.focus();
	}
}

	function goLogin(){
		if(!member.t_id.value){ 
			Swal.fire({
				icon:'warning',
				title: '<div style="font-size:35px;font-family:Dongle;color:#A9A9A9;"> 아이디를 확인해주세요 </div>',
				  width: 400,
				  padding: '3em',
				  color: '#A9A9A9',
				  confirmButtonColor: '#A9A9A9',
				  confirmButtonText: '확인',
				}); 
				member.t_id.focus();
			return;
			
		}
		if(!member.t_pw.value){ 
			Swal.fire({
				icon:'warning',
				title: '<div style="font-size:35px;font-family:Dongle;color:#A9A9A9;">비밀번호를 확인해주세요</div>',
				  width: 400,
				  padding: '3em',
				  color: '#A9A9A9',
				  confirmButtonColor: '#A9A9A9',
				  confirmButtonText: '확인',
				
				})
				member.t_pw.focus();
			return;
			
		}
  		member.method="post";
  		member.action="MemberLogin";
  		member.submit();
  	}

</script>

<body>
	<!--서브 헤더 -->
	<div class="sub-header sub-header-give">
		<h1 class="sub-title"><span class="text">기 부</span></h1>
		<span class="deco-box"><i class="deco-1"></i><i class="deco-2"></i></span>

		<div class="sub-menu">
			<div class="menu-in">
				<div class="menu-form">
					<li class="home"><a href="/" class="home-in"><span class="pos i-home">홈</span></a></li>
					<li class="dep" data-dropdown=''><button type="button" data-act='title' data-addtitle="this">큰 메뉴 이름</button>
						
					</li>
					<li class="dep" data-dropdown=''><button type="button" data-act='title' data-addtitle="this">소메뉴</button>
					
					</li>
				</div>
			</div>
		</div>
	</div>

    
    <section class="login_form">
        <h1>로그인</h1>
        <form name="member">
            <div class="int_area">
                <input type="text" name="t_id" id="id" 
                  <c:choose>
							    <c:when test="${not empty t_found_id}"> value="${t_found_id}"
							    </c:when>
							      <c:when test="${not empty t_found_id_2}"> value="${t_found_id_2}"
							    </c:when>
							    <c:otherwise>
							       value="${t_id}"
							    </c:otherwise>
					</c:choose> onkeypress="check()" autocomplete="off" required>
                <label class="id_label" for="id" onclick="id"> 아이디</label>
            </div>
            <div class="int_area">
                <input type="password" name="t_pw" id="pw" autocomplete="off" required>
                <label class="pw_label" for="pw" onclick="password"> 비밀번호</label>
            </div>
            <div class="btn_area">
                <button type="submit" onclick="goLogin()">로그인</button><br>
                <a href="https://kauth.kakao.com/oauth/authorize?client_id=ec4801dd314be6e382293141807e4025&redirect_uri=https://fa19-115-93-111-2.ngrok.io/Callback&response_type=code">
                <img style="margin-left:156px; height:56px;" class="login_img" src="img/login/kakao_login_medium_wide.png"></a>
            </div>
        </form>
        <div class="caption">
            <a href="Find_id">아이디를 잊어버리셨나요?</a><br><br>
            <a href="Find_pw_1">비밀번호를 잊어버리셨나요?</a><br><br><br>
            <a style="color:gray; font-size:50px;" href="bunho2">회원가입</a>
        </div>
    </section>
  </div>
   <%@ include file="../common_footer.jsp" %>
</body>
  
</html>