<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8" />
<c:set var="list" value="${param.list}" />

<c:set var="total" value="${fn:length(list)}" />
<fmt:requestEncoding value="utf-8" />

<jsp:useBean id="service" class="com.example.libs.service.PopularService" />
<c:forEach items="${list}" var="product_number">
	<c:set var="row" value="${service.deleteProduct(product_number)}" />
</c:forEach> 

<c:if test="${row eq 1}">
	<script>
		alert("상품이 삭제되었습니다.");
		location.href="product.jsp?page=1";
	</script>
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("상품 삭제를 실패하였습니다.");
		history.back();
	</script>
</c:if>