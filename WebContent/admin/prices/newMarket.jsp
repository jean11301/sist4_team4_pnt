<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<jsp:useBean id="market" class="com.example.libs.model.MarketVO" />
<jsp:setProperty property="*" name="market" />

<jsp:useBean id="service" class="com.example.libs.service.MarketService" />
<c:set var="row" value="${service.insertMarket(market)}" />

<c:if test="${row eq 1}">
	<script>
		alert("신규 시장이 추가되었습니다.");
		location.href="market.jsp?page=1";
	</script>
</c:if>
<c:if test="${row ne 1}">
	<script>
		alert("신규 시장 등록을 실패하였습니다.");
		history.back();
	</script>
</c:if>

