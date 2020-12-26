<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8" />
<c:set var="product_number" value="${param.product_number}" />
<c:set var="check_status" value="${param.check_status}" />

<jsp:useBean id="service" class="com.example.libs.service.PopularService" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<c:if test="${check_status eq 0}" >
<sql:update dataSource="${conn}" >
	UPDATE product
	SET check_status = '0'
	WHERE product_number = ?
	<sql:param value="${product_number}"/>
</sql:update>
</c:if>
<c:if test="${check_status eq 1}" >
<sql:update dataSource="${conn}" >
	UPDATE product
	SET check_status = '1'
	WHERE product_number = ?
	<sql:param value="${product_number}"/>
</sql:update>
</c:if>

<script>
	alert("상태가 변경되었습니다.");
	location.href="product.jsp?page=1";
</script>
