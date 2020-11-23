<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>People N Tour</title>
    <script src="js/jquery-3.5.1.js"></script>
    <link rel="stylesheet" href="css/bootstrap-theme.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/header.css">
</head>
<style>
	.body3{
		margin-left: auto; margin-right: auto;
		align-content: center;
		  width: 800px;
		  border: 3px solid #73AD21;
		  padding: 10px;
	}
	.menu-table{
		margin-left: auto; margin-right: auto;
		text-align: center;
		width: 600px ;
		height: 400px;
		border: 10px black;
		background-color: white;
	}
</style>
<body>
			<div class="container ">
				<div class="row">
					<jsp:include page="header.jsp"></jsp:include>
				</div>
			</div>
	<div class="container text-center">
		<div class="row">

		    <!-- header -->
		    <div class="body1">
		            <h3>body1</h3>
		            <img alt="" src="images/main_map.png">
		    </div>
		    <div class="body2">
					<h3>body2</h3>
					<form action="#" method="POST">
						<button>검색</button>
						<input type="text" placeholder="검색어를 입력하세요">

					</form>
		    </div>
		    <div class="body3 text-center">
					<h3>body3</h3>
					<table class="menu-table">
						<tr>
							<td colspan="2"><a href="#">인기 검색 종목 물가</a></td>
							<td><a href="#">급변동 물가</a></td>
							<td><a href="#">환전 고시 환율</a></td>
					</tr>
						<tr>
							<td colspan="3"><a href="#">교통</a></td>
							<td><a href="#">뉴스</a></td>
						</tr>
						<tr>
							<td colspan="3"><a href="#">여행리뷰</a></td>
							<td><a href="#">대사관 정보</a></td>
						</tr>
					</table>
			</div>
		    <!-- footer-->
		    <div class="foooter">
					<h1>여긴 footer</h1>
					<img src="" alt="">
		    </div>
		</div>
	</div>
</body>
</html>