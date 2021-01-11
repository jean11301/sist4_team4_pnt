<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="update" class="com.example.libs.service.MemberService" />
<jsp:useBean id="member" class="com.example.libs.model.MemberVO" />
<jsp:setProperty name="member" property="user_id" value="${user_id}" />
<jsp:setProperty name="member" property="user_name" param="user_name" />
<jsp:setProperty name="member" property="user_email" param="user_email" />

<c:set var="row" value="${update.updateMember(member)}" />
<c:if test="${row eq 1}">
	<c:redirect url="mypage.jsp" />
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("회원정보 수정 실패");
		history.back();
	</script>
</c:if>