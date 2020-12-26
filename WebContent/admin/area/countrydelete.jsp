<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="service"
	class="com.example.libs.service.CountryServiceImpl" />
<c:set var="country" value="${param.country_code}" />
<c:set var="row" value="${service.delete(country)}" />
<c:if test="${row eq 1}">
	<script>
		alert("삭제 성공");
	</script>
	<c:redirect url="country.jsp" />
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("삭제 실패");
		history.back();
	</script>
</c:if>