<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8" />
<c:set var="searchWith" value="${param.searchWith}" />
<c:set var="keyword" value="${param.keyword}" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />

<c:if test="${searchWith == 'all'}">
<sql:query dataSource="${conn}" var="rs">
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    	INNER JOIN market ON(city.city_number = market.city_number)
	WHERE country.country_kr_name LIKE CONCAT(CONCAT('%', ?), '%') or 
        city.city_kr_name LIKE CONCAT(CONCAT('%', ?), '%') or
        market.market_kr_name LIKE CONCAT(CONCAT('%', ?), '%') or
        market.market_en_name LIKE CONCAT(CONCAT('%', ?), '%')
	ORDER BY country_kr_name, city_kr_name, market_kr_name;
	<sql:param value="${keyword}"/>
	<sql:param value="${keyword}"/>
	<sql:param value="${keyword}"/>
	<sql:param value="${keyword}"/>
</sql:query>
</c:if>
<c:if test="${searchWith == 'country_kr_name'}">
<sql:query dataSource="${conn}" var="rs">
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE country.country_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
</c:if>
<c:if test="${searchWith == 'city_kr_name'}">
<sql:query dataSource="${conn}" var="rs">
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE city.city_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
</c:if>
<c:if test="${searchWith == 'market_kr_name'}">
<sql:query dataSource="${conn}" var="rs">
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE market.market_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
</c:if>
<c:if test="${searchWith == 'market_en_name'}">
<sql:query dataSource="${conn}" var="rs">
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE market.market_en_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
</c:if>

<script>
$(document).ready(function() {
	
	
});
</script>
<table id="example2" class="table tavle-bordered table-hover dataTable dtr-inline"
	role="grid" aria-describedby="example2_info">
<thead>
	<tr role="row">
		<th>전체</th>
		<th>국가명</th>
		<th>도시명</th>
		<th>한글 시장명</th>
		<th>영어 시장명</th>
		<th>관리</th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${rs.rows}" var="row">
		<tr>
			<td><input type="checkbox" class="selMarket"></td>
			<td>${row.country_kr_name}</td>
			<td>${row.city_kr_name}</td>
			<td>${row.market_kr_name}</td>
			<td>${row.market_en_name}</td>
			<td><a href="#">수정하기</a></td>
		</tr>
	</c:forEach>
</tbody>
</table>