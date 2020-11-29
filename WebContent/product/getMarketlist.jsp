<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8" />
<c:set var="city" value="${param.city}" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="rs">
	SELECT market_kr_name 
	FROM market join city on market.city_number=city.city_number
	WHERE city_kr_name=?
	<sql:param value="${city}"/>
</sql:query>

<select name="" id="selmarket_kr_name" class="form-control">
	<option value="">시장선택</option>
	<c:forEach items="${rs.rows}" var="row">
		<option value="${row.market_kr_name}">${row.market_kr_name}</option>
	</c:forEach>
</select>
