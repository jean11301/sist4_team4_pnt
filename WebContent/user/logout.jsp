<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="mylogout" value="${user_id}" scope="page" />
<c:remove var="user_id" scope="session"/>
<script>
	alert('${mylogout} 계정이 로그아웃 되었습니다.');
	location.href = '../index.html';
</script>