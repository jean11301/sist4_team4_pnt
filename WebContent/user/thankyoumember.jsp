<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="select" class="com.example.libs.service.MemberService" />
<c:if test="${not empty user_id}">
	<c:set var="member" value="${select.selectMember(user_id)}" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입을 환영합니다.</title>
<link rel="stylesheet" href="../css/bootstrap-theme.css">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/style.css">
<!--<link rel="stylesheet" href="css/header.css">-->
<script src="https://kit.fontawesome.com/5fa9fbc7d7.js"
	crossorigin="anonymous"></script>
<script src="../js/jquery-3.5.1.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/script.js?ver=3"></script>
<style>
	.thankyoubox{margin:0 auto; float:none; text-align:center;}
	img{width:20vw;margin:0 auto; display:block;}
	h4{color:#007bff; font-weight:bold; margin:7vh 0 0 0;}
	.thankyoubox1{font-size: 2.2rem; font-weight: bold; margin: 3vh 0 2vh 0;}
	.thankyoubox1 strong{color:#007bff;}
	.thankyoubox2{font-size: 1.5rem;    color: #9a9a9a; line-height: 25px;}
	.thankyoubox3{margin:3vh 0;}
</style>
</head>
<body>
	<div class="container">
	<div class="col-xs-12 col-sm-12 col-md-7  col-lg-6 thankyoubox">
		<div class="row"><h4>People N Tour</h4></div>
		<div class="row"><h2>환영합니다</h2></div>
		<div class="row"><img src="../images/thankyoumember.png"></div>
		
		<div class="row thankyoubox1"><strong>${member.user_id}</strong>님의 회원가입을 축하합니다.</div>
		<div class="row thankyoubox2">PNT의 물가 데이터를 통해 전세계의 물가 지표를 확인하세요.</div>
		<div class="row thankyoubox2">데이터를 등록하면 포인트를 통해 현금으로 환전할 수 있습니다.</div>
		<div class="row thankyoubox3" onclick="changeView(1)"><button type="button" class="btn btn-primary btn-lg btn-block">시작하기</button></div>
		<div class="row"><a href="#">마이페이지로</a></div>
	</div>
	</div>
</body>
</html>

