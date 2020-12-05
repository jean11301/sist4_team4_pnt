<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.example.libs.model.ProductVO"%>
<jsp:useBean id="popular"
	class="com.example.libs.service.PopularService" />
<%
	ArrayList<ProductVO> list = popular.populist();
%>
<jsp:include page="../main/header.jsp" />


<div id="titletext" class="menu1">물가 정보</div>
<div class="row">
	<div class="col-sm-2 side_search">
		<form class="ml-1">
			<div class="form-group pd-5">
				<label for="sel1">나라선택</label> <select class="form-control"
					id="sel1">
					<option>태국</option>
					<option>싱가포르</option>
					<option>베트남</option>
					<option>ex1</option>
					<option>ex2</option>
				</select>
			</div>
		</form>
	</div>

	<div class="col-sm-10">
		<div id="titletext" class="menu1">물가 정보</div>
	</div>
</div>




<!--  인기 검색 종목 물가, 급변동 물가 -->
<div class="col-sm-5 pnt_hit">
	<div class="row">
		<h4>
			<strong>인기 검색 종목 물가</strong>
		</h4>
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr class="info">
						<th>국가</th>
						<th>도시</th>
						<th>시장</th>
						<th>물품명</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
					<%
						if (list == null) {
					%>
					<tr>
						<td colspan="5" class="text-center">No Data</td>
					</tr>
					<%
						} else {
					for (int i = 0; i < 3; i++) {
						ProductVO pop = list.get(i);
					%>
					<tr>
						<td><%=pop.getCountry_kr_name()%></td>
						<td><%=pop.getCity_kr_name()%></td>
						<td><%=pop.getMarket_kr_name()%></td>
						<td><%=pop.getProduct_name()%></td>
						<td><%=pop.getProduct_price()%></td>
					</tr>
					<%
						} //for end
					} //if end
					%>
			</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<h4>
			<strong>급변동 물가</strong>
		</h4>
		<div class="table-responsive">
			<table class="table">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
	</div>
</div>


<jsp:include page="../main/footer.jsp" />

