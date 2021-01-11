<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<jsp:useBean id="select" class="com.example.libs.service.MemberService" />

<c:if test="${empty user_id}"><%--login을 하지 않았다면 --%>
	<c:redirect url="login.jsp" />
</c:if>
<c:if test="${not empty user_id}">
	<c:set var="member" value="${select.selectMember(user_id)}" />
	<%-- <c:set var="point" value="${select.exchangeView(user_id)}" /> --%>
</c:if>

<jsp:include page="../main/header.jsp" />

<style>
.mybox{padding: 4vh 0 0 0;}
.roline{border-bottom: 1px solid; margin: 1vh 0 4vh 0;}
.myboxtitle{text-indent: 15px;}
.sidebox{padding: 0;}
.sidemenu{height: 5vh; text-align: center; line-height: 5vh; font-size: 1.8rem; cursor: pointer; }
.sideon{font-weight: 300; color:#FFF; background-color: #064acb;}
</style>

<div id="titletext">MyPage</div>

	<div class="container mybox">
		<div class="row roline"><h3 class="myboxtitle">MyPage | 포인트</h3></div>
		<div class="col-xs-12 col-sm-12 col-md-2  col-lg-2 sidebox">
			<div class="sidemenu" onclick="location.href='mypage.jsp'">회원정보</div>
			<div class="sidemenu sideon" >포인트</div>
		</div>
		

	<div class="col-xs-12 col-sm-12 col-md-10  col-lg-10 sidebox">
	<h3 class="text-primary text-left" style="text-indent: 2vw;">
		<h4>준비중입니다.</h4>
		<%-- <c:out value="${user_id}"/>님의 포인트 현황
		<c:out value="${user_point}"/>님의 포인트 현황 --%>
	</h3>
		<div class="row">
		
		</div>
		
		
		<div class="row">
			<div class="text-center">
				<button type="button" id="btnHome" class="btn btn-success">홈으로</button>
				<button type="button" id="btnUpdate" class="btn btn-info">정보변경하기</button>
				<button type="button" id="btnDelete" class="btn btn-warning">탈퇴하기</button>
			</div>
		</div>

		</div><!-- ENd 우측박스-->
	</div><!-- End 전체 박스 -->

<jsp:include page="../main/footer.jsp" />