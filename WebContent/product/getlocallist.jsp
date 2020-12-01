<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="country_kr_name" value="${param.country_kr_name}" />
<% String param = request.getParameter("country_kr_name");%>
<%=param%>
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="rs">
	SELECT  city_kr_name
	 FROM country join city ON country.COUNTRY_CODE=city.COUNTRY_CODE
	WHERE country_kr_name=?
	<sql:param value="${country_kr_name}" />
</sql:query>
{
	"code" : "success",
	"data" : [
		<c:forEach items = "${rs.rows}" var="row">
			{
				"city_kr_name" : "${row.city_kr_name}"
			},
		</c:forEach>
	]
}	