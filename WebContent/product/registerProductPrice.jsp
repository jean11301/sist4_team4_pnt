<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />

<c:set var="country" value="${param.country}" />
<c:set var="city" value="${param.city}" />
<c:set var="market" value="${param.market}" />
<c:set var="productName" value="${param.productName}" />
<c:set var="productPrice" value="${param.productPrice}" />
<c:set var="userid" value="${param.userid}" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:update dataSource="${conn}" >
	INSERT INTO PRODUCT (product_number, product_name, product_price, product_date, city_number, market_number, user_id  ) 
    VALUES ((SELECT (MAX(product_number) + 1) FROM product), ?, ?, (SELECT SYSDATE FROM DUAL), 
        (SELECT city_number FROM city WHERE city_kr_name = ?), (SELECT market_number FROM market WHERE market_kr_name = ?), ?)
	<sql:param value="${productName}"/>
	<sql:param value="${productPrice}"/>
	<sql:param value="${city}"/>
	<sql:param value="${market}"/>
	<sql:param value="${userid}"/>
</sql:update>

