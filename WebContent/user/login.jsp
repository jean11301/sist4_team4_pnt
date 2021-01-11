<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PNT Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/style.css">
    <script src="../js/jquery-3.5.1.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/script.js"></script>
<style>
    .container-fluid .loginbox{border: 1px solid #CCC; margin:0 auto; float: none; border-radius: 10px;overflow: hidden;}
    .loginh2{text-align: center; color: #1a73e8; font-weight: bold;padding:13% 0 0 0; font-size: 2.0rem;cursor:pointer;}
    .loginh3{text-align: center;}
    .loginh4{text-align: center; padding: 2% 0 3% 0;}
    .loginboxsub{width:84%; padding:4% 15px; margin:0 auto; display: inherit; border: 1px solid #CCC; border-radius: 5px;}
    .loginboxsub:focus{border:1px solid #1a73e8;}
    .idbox{margin: 6% 8% 3% 8%;}
    .subbox{float:right; padding: 8px 17px; background: #1a73e8; border: none; border-radius: 5px; color: #FFF; margin:4% 8% 3% 0;}
    .quesbox{width: 100%; display: inline-block; padding: 0 0 10% 11%;}
</style>
</head>
<body>
	<div class="container-fluid" style="margin-top: 10vh;">
        <div class="col-xs-12 col-sm-8 col-md-5  col-lg-3 loginbox">
            <h2 class="loginh2" onClick="location.href='../index.html'">People N Tour</h2>
            <h3 class="loginh3">로그인</h3>
            <h4 class="loginh4">PNT 계정 사용</h4>
            
		    <!-- Login Form -->
		    <form action="login_ok.jsp" method="post">
		      <input type="text" id="user_id" class="idbox loginboxsub" name="user_id" placeholder="아이디를 입력하세요" value="${user_id}">
		      <input type="password" id="user_password" class="pwbox loginboxsub" name="user_password" placeholder="password">
		      <input type="submit" class="subbox" value="Log In">
            </form>
            
            <div class="row quesbox">
                <div class="ques">아직 계정이 없으신가요? <br> 지금 가입하여 PNT의 데이터를 확인해보세요.</div>
                <div class="ques1"><a href="register.html">계정 만들기</a></div>
            </div>
		    
        </div> 
	</div><!-- END container-fluid-->
</body>
</html>