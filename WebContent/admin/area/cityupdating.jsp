<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.example.libs.model.CityVO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:requestEncoding value="utf-8" />
<%
	int fr = Integer.parseInt(request.getParameter("country_code"));
	String se = request.getParameter("city_kr_name");
	String th = request.getParameter("city_en_name");
	int fo = Integer.parseInt(request.getParameter("city_number"));
	
	CityVO city = new CityVO(fo,se,th,fr);
%>
<jsp:useBean id="service" class="com.example.libs.service.CityServiceImpl"/>
<c:set var="row" value="<%=service.update(city)%>" /> 
<c:if test="${row eq 1 }"> 
	<script>
		alert("수정성공");
		location.href = "city.jsp";
	</script>
</c:if>
<c:if test="${row eq 0 }">
		<script>
		alert("수정 실패");
		history.go(-1);
	</script>
</c:if>
