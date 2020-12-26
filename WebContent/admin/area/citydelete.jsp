<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="service" class="com.example.libs.service.CityServiceImpl" />
<c:set var="city" value="${param.city_number}" />
<c:set var="row" value="${service.delete(city)}" />
<c:if test="${row eq 1}">
	<c:redirect url="city.jsp" />
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("삭제 실패");
		history.back();
	</script>
</c:if>