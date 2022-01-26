<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
너의 이메일: ${t_kakao_dto.getKakao_account().getEmail()} <br>
너의 이름: ${t_kakao_dto.properties.nickname} <br>
<a href="${t_kakao_dto.properties.getProfile_image()}">너의 사진 </a><br>

</h1>

</body>
</html>
