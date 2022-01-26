<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="common.*,dao.*,dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>homepage</title>
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/base.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet"> <!--CDN 링크 -->

<link href="css/header.css" rel="stylesheet"> <!-- header css-->
<link href="css/sub-header.css" rel="stylesheet"> <!--서브 header css-->

<!-- 임시 서브 헤더-->
<link href="css/view.css" rel="stylesheet"> <!--서브 header css-->
<link href="css/global.css" rel="stylesheet">

<!-- 서머노트를 위해 추가해야할 부분 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<link href="css/summernote-lite.css" rel="stylesheet" >
<script src="js/summernote-lite.js"></script>
<script src="js/summernote-ko-KR.js"></script>
<script src="js/getsummernote.js"></script>
  <script src="/js/common.js"></script>

</head>


<script>
     /*메인 header 따라 오기 */
     let header = document.querySelector(".header-header-1");
     let headerHeight = header.offsetHeight;

     window.onscroll = function () {
         let windowTop = window.scrollY;
         if (windowTop >= headerHeight) {
             header.classList.add("is-scroll");
         } else {
             header.classList.remove("is-scroll");
         }
     };
     // 

</script>

<script>
	function goDashboard(id){
		index.t_gubun.value="Home";
		index.method="post";
		index.action="Manager";
		index.submit();
	}
	function goMypage(id){
		index.t_id.value=id;
		index.method="post";
		index.action="/Mypage_home";
		index.submit();
	}
</script>
<body>
<form name="index">
	<input type="hidden" name="t_id">
	<input type="hidden" name="t_gubun">
</form>
<div id ="containar">
<div id ="warp" class="warp">    
    <header id="header" class="header-header-1">
    <div id ="header-main">
        <div id ="header-top">
            <h1 class="logo-box">
                <a href="/" class="logo-img"></a>
            </h1>
            <!-- 헤드 메뉴 내용 -->
               <div class ="main-top-menu">
                <a class="main-text" href="Donation">기부</a>
                <a class="main-text" href="Volunteer">봉사</a>
                <a class="main-text" href="#">????</a>
                <a class="main-text" href="Localnews">지역 뉴스</a>
                <a class="main-text" href="Missing">실종아동</a>
            </div>
            
            <div class="main-top-login">
                     <c:choose>
  			  <c:when test="${not empty session_name && session_level ne 'top'}">
  			   <a class="login" href="javascript:goMypage('${session_id}')" style="font-size:20px;margin-bottom:5px;">${session_name}님 &nbsp&nbsp</a>
     			   <a class="login" href ="Logout">로그아웃</a>
	  		  </c:when>
	  		  <c:when test="${session_level eq 'top'}">
					 <a class="login" href="javascript:goDashboard()" style="font-size:20px;margin-bottom:5px;">관리자님&nbsp&nbsp&nbsp</a>
     			   <a class="login" href ="Logout">로그아웃</a>  		  
	  		  </c:when>
		      <c:otherwise>
		        <a class="login" href ="Login">로그인</a>
	          </c:otherwise>
			</c:choose>
                <span class="longbar"></span> <!--로그인 돋보기 사이 | 막대기 -->
                <a  class="search-img" href =""><i class="fas fa-search" style="font-size: 22px;"></i></a>
    		</div>
        </div>
    </div>
    </header>
</div>


	<!--##### // Visual & LNB #####-->