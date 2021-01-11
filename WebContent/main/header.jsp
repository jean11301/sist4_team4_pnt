<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="select" class="com.example.libs.service.MemberService" />
<c:if test="${not empty user_id}">
	<c:set var="member" value="${select.selectMember(user_id)}" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
       
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/style.css">  
<!--<link rel="stylesheet" href="css/header.css">-->
    <script src="../js/jquery-3.5.1.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/script.js"></script>
</head>
<body>
  <nav class="navbar navbar-default navbar-fixed-top">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar" ></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#" onclick="changeView(0)">People N Tour</a>
      </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <!-- <li class="active"><a href="#">물가 정보</a></li> -->
          <li><a href="#" onclick="changeView(1)">물가 정보</a></li>
         <!--  <li><a href="#">교통 정보</a></li>
          <li><a href="#">여행리뷰</a></li>
          <li><a href="#">뉴스</a></li> -->
          <!-- <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li role="separator" class="divider"></li>
              <li class="dropdown-header">Nav header</li>
              <li><a href="#">Separated link</a></li>
              <li><a href="#">One more separated link</a></li>
            </ul>
          </li> -->
        </ul>
        <ul class="nav navbar-nav navbar-right">
				<%--login 안했을 때, 로그인 --%>
				<c:if test="${empty user_id}">
					<button type="button" class="btn btn-primary navbar-btn"
						onclick="changeView(2)" style="margin-right: 30px">로그인</button>
				</c:if>

				<%-- login 했다면 --%>
				<!-- 관리자일경우 관리자페이지, 회원일 경우 마이페이지 -->
				<c:if test="${not empty user_id}">
					<c:if test="${flag eq 0}">
						<i class="fas fa-user usdrinfoicon"></i>
						<div class="userinfo">${member.user_id}</div>
						<button type="button" class="btn btn-primary navbar-btn"
							onclick="changeView(5)" style="margin-right: 10px">PNT 계정 관리</button>
					</c:if>
					<c:if test="${flag eq 1}">
						<%--관리자라면 --%>
						<div class="userinfo">${member.user_id}</div>
						<button type="button" class="btn btn-primary navbar-btn"
							onclick="changeView(4)" style="margin-right: 10px">관리자페이지</button>
					</c:if>
				</c:if>

				<!-- 로그인 상태라면, 로그아웃 -->
				<c:if test="${not empty user_id}">
					<button id="btnLogout" class="btn navbar-btn buttonlogout" onclick="changeView(3)">Log
						Out</button>
				</c:if>
        </ul>
      </div><!--/.nav-collapse -->
  </nav>
<div class="container-fluid">