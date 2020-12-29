<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.example.libs.model.CountryVO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:requestEncoding value="utf-8" />
<%
	int fr = Integer.parseInt(request.getParameter("country_code"));
	String se = request.getParameter("country_kr_name");
	String th = request.getParameter("country_kr_name");
	String fo = request.getParameter("country_flag_img");

	CountryVO country = new CountryVO(fr,se,th,fo);
%>
<jsp:useBean id="service" class="com.example.libs.service.CountryServiceImpl"/>
<c:set var="row" value="<%=service.create(country)%>" />
<c:if test="${row eq 1 }"> 
	<script>
		alert("등록 성공");
		location.href = "country.jsp";
	</script>
</c:if>
<c:if test="${row ne 1 }">
		<script>
		alert("등록 실패");
		history.go(-1);
	</script>
</c:if>

