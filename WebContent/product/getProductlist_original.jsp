<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="count" />
<c:set var="country" value="${param.country}" />
<c:set var="city" value="${param.city}" />
<c:set var="market" value="${param.market}" />
<c:set var="product" value="${param.product}" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<c:if test="${empty country and empty city and empty market}">  <%--나라와 도시, 시장 모두 널일때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name, product_price, product_img
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND product_name LIKE CONCAT(CONCAT('%', ?), '%')
		ORDER BY SEQUENCE DESC
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
		<p>전체 최신순</p>
	</div>
</c:if>
<c:if test="${not empty country and empty city and empty market}">  <%-- 나라는 널이 아니고 도시, 시장이 널일때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price, product_img
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND country_kr_name = ? AND product_name LIKE CONCAT(CONCAT('%', ?), '%')
		ORDER BY SEQUENCE DESC
		<sql:param value="${country}"/>
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
		<p>${country}의 '${product}' 검색결과는 0개 입니다.</p>
	</div>
</c:if>
<c:if test="${not empty country and not empty city and empty market}">  <%-- 나라, 도시 널이 아니고 시장이 널일때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price, product_img
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND country_kr_name = ? AND city_kr_name = ? AND product_name LIKE CONCAT(CONCAT('%', ?), '%')
		ORDER BY SEQUENCE DESC
		<sql:param value="${country}"/>
		<sql:param value="${city}"/>
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
		<p>${country} > ${city}의 '${product}' 검색결과는 0개 입니다.</p>
	</div>
</c:if>
<c:if test="${not empty country and not empty city and not empty market}"><%-- 나라, 도시, 시장 셋 다 널이 아닐 때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price, product_img
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND country_kr_name = ? AND city_kr_name = ? AND market_kr_name = ? AND product_name LIKE CONCAT(CONCAT('%', ?), '%')
		ORDER BY SEQUENCE DESC
		<sql:param value="${country}"/>
		<sql:param value="${city}"/>
		<sql:param value="${market}"/>
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
		<p>${country} > ${city} > ${market}의 '${product}' 검색결과는 개 입니다.</p>
	</div>
</c:if>
	
		<div class="container" style="margin-right:0; margin-left:300px;">
		<div class="row" style="margin-right:0;">
		
		<c:forEach items="${rs.rows}" var="row"> 
			<div class="col-sm-4 table-responsive" style="margin-right:0;">
				<table class="table-bordered">
					<tr>
						<td>${row.product_img}</td>
					</tr>
					<tr>
						<td>${row.country_kr_name}>${row.city_kr_name}>${row.market_kr_name}</td>
					</tr>
					<tr>
						<td>${row.product_name}</td>
					</tr>
					<tr>
						<td align="right" style="color: red">${row.product_price}원</td>
					</tr>
				</table>
				
			</div>
		
		</c:forEach>
		
		</div>
</div>