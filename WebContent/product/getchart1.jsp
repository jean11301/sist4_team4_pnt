<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="utf-8" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<c:set var="product_name" value="${param.product_name}" />
<c:set var="market_name" value="${param.marketname}" />
<c:if test="${product_name ne null}">
	<sql:query dataSource="${conn}" var="rs"> 
	SELECT ROUND(product_price,-2) AS price ,count(*) AS count
	FROM product JOIN market on product.market_number = market.market_number
	WHERE  check_status = 1  AND product_name = ? AND market.market_kr_name = ?
	AND TRUNC(MONTHS_BETWEEN(SYSDATE,product_date)) <= 6
    GROUP BY ROUND(product_price,-2)
    ORDER BY ROUND(product_price,-2)
		<sql:param value="${product_name}" />
		<sql:param value="${market_name}" />
	</sql:query>
</c:if>
{
	"code" : "success",
	"data" : [
				<c:forEach items = "${rs.rows}" var="row">
				{
				"price" : "${row.price}",
				"count" : ${row.count}
				},
				</c:forEach>
	]
}	
