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
	SELECT     product_price,  product_date 
	FROM    product  p  JOIN   market  m  on   p.market_number   =   m.market_number
	WHERE    check_status = 1  AND   TRUNC(MONTHS_BETWEEN(SYSDATE,product_date))   <=  6    AND    product_name = ?    AND    market_kr_name = ?
	ORDER BY   product_date   asc  
		<sql:param value="${product_name}" />
		<sql:param value="${market_name}" />
	</sql:query>
</c:if>
{
	"code" : "success",
	"data" : [
				<c:forEach items = "${rs.rows}" var="row">
				{
				"product_date" : "${row.product_date}",
				"product_price" : ${row.product_price}
				
				},
				</c:forEach>
	]
}	
