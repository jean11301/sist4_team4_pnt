<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="utf-8" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<c:set var="marketname" value="${param.marketname}" />
<c:if test="${marketname ne null}">
	<sql:query dataSource="${conn}" var="rs">
		SELECT market_kr_name, latitude,longitude, market_info 
		FROM market  
		WHERE  market_kr_name = ?
		<sql:param value="${marketname}" />
	</sql:query>
</c:if>
{
	"code" : "success",
	"data" : [
				<c:forEach items = "${rs.rows}" var="row">
				{
				"market_kr_name" : "${row.market_kr_name}",
				"latitude" : ${row.latitude},
				"longitude" : ${row.longitude},
				"market_info" : "${row.market_info}"
				},
				</c:forEach>
	]
}	
   