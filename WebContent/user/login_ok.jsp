<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="user_id" value="${param.user_id}" />
<c:set var="user_password" value="${param.user_password}" />
<jsp:useBean id="select" class="com.example.libs.service.MemberService" />
<c:set var="key" value="${select.loginMember(user_id, user_password)}" />
<c:choose>
<c:when test="${key eq -1}">
	<script>
		alert("존재하지 않는 아이디입니다. \n확인 후 다시 로그인해 주세요.");
		history.back();
	</script>
</c:when>
<c:when test="${key eq 0}">
	<script>
		alert("비밀번호가 일치하지 않습니다. \n확인 후 다시 로그인해 주세요.");
		history.back();
	</script>
</c:when>
<c:when test="${key eq 1}">
	<c:set var="user_id" value="${user_id}" scope="session" />
	<c:set var="member" value="${select.selectMember(user_id)}" />
	<!--<c:set var="flag" value="${member.flag}" scope="session"/> -->  
	<c:redirect url="../index.html"/>
</c:when>
</c:choose>
