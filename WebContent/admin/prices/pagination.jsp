<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="page" value="${param.page}" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<jsp:useBean id="service" class="com.example.libs.service.MarketService" />

<script>
	alert("paginagion.jsp 실행");
</script>

<c:set var="marketList"
	value="${service.selectPagination((page - 1)*10, 10)}" />
<script>
	alert("${page}");
	alert("${(page-1)*10}");
</script>


<table id="example2"
	class="table tavle-bordered table-hover dataTable dtr-inline"
	role="grid" aria-describedby="example2_info">
	<thead>
		<tr role="row">
			<th>전체</th>
			<th>국가명</th>
			<th>도시명</th>
			<th>한글 시장명</th>
			<th>영어 시장명</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${marketList}" var="market">
			<tr>
				<td><input type="checkbox" class="selMarket"
					value="${market.market_number}" /></td>
				<td>${market.country_kr_name}</td>
				<td>${market.city_kr_name}</td>
				<td>${market.market_kr_name}</td>
				<td>${market.market_en_name}</td>
				<td><a
					href="updateMarket.jsp?market_number=${market.market_number}">수정하기</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>