<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="rs">
	SELECT country_kr_name 
	FROM country
	ORDER BY country_code
</sql:query>	
{
	"code" : "success",
	"data" : [
		<c:forEach items = "${rs.rows}" var="row">
			{
				"country_kr_name" : "${row.country_kr_name}"
			},
		</c:forEach>
	]
}	