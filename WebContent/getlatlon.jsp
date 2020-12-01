<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<c:set var="code" value="${param.code}" />
<c:if test="${code ne null}">
	<sql:query dataSource="${conn}" var="rs">
		SELECT latitude,longitude 
		FROM market  
		WHERE  city_number = ?
		<sql:param value="${code}" />
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
