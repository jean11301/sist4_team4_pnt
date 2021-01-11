<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="user_id" value="${param.user_id}" />
<c:set var="user_password" value="${param.user_password}" />
<jsp:useBean id="select" class="com.example.libs.service.MemberService" />
<c:set var="key" value="${select.loginMember(user_id, user_password)}" />


<jsp:useBean id="member" class="com.example.libs.model.MemberVO" /> 
<jsp:setProperty property="*" name="member"/>

<jsp:useBean id="insert" class="com.example.libs.service.MemberService" />
<c:set var="row" value="<%=insert.insertMember(member) %>" />
<%-- <c:if test="${row eq 1}">
    <c:set var="user_id" value="${member.user_id}" scope="session" />
	<c:redirect url="login.jsp" />
</c:if> --%>
<c:if test="${row eq 1}">
	<c:set var="user_id" value="${member.user_id}" scope="session" /> 
	<c:set var="member" value="${select.selectMember(user_id)}" />
	<c:redirect url="thankyoumember.jsp"/>
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("회원가입 실패");
		history.back();
	</script>
</c:if>