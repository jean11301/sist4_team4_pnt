<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<jsp:useBean id="product" class="com.example.libs.model.ProductVO" />
<jsp:setProperty property="*" name="product" />

<jsp:useBean id="service" class="com.example.libs.service.PopularService" />
<c:set var="row" value="${service.updateProduct(product)}" />

<c:if test="${row eq 1}">
	<script>
		alert("상품이 수정되었습니다.");
		location.href="product.jsp?page=1";
	</script>
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("상품 수정을 실패하였습니다.");
		history.back();
	</script>
</c:if>

