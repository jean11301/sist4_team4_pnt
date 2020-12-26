<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="utf-8" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<c:set var="product_name" value="${param.product_name}" />
<c:if test="${product_name ne null}">
	<sql:query dataSource="${conn}" var="rs">
		SELECT  latitude , longitude, market_info
		FROM product  JOIN market  ON product.market_number = market.market_number
		WHERE  product_name = ?
		<sql:param value="${product_name}" />
	</sql:query>
</c:if>
{
	"code" : "success",
	"data" : [
				<c:forEach items = "${rs.rows}" var="row">
				{
				"latitude" : ${row.latitude},
				"longitude" : ${row.longitude}
				},
				</c:forEach>
	]
}	
