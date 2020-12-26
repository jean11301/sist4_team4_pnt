<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="service"
	class="com.example.libs.service.PopularService" />
<!--전달받은 검색어 가져오기  -->
<fmt:requestEncoding value="utf-8" />
<c:set var="productname" value="${param.product_name}" />
<c:set var="rs" value="${service.selectOne(productname)}" />
<!--product DB에서 검색어 기준 내용 가져오기-->
<style>
table {
	width:400px; height:400px;
}
thead {
	background-color: dodgerblue;
}

tbody {
	background-color: lightcyan;
}
</style>
<jsp:include page="../main/header.jsp" />
<div class="container-fluid" style="margin: 0 0 0 0">
	<form id="frmZip" name="frmZip">

		<div class="row">
			<div class="col-sm-2 side_search">
				<form>
					<div class="form-group pd-5">
						<label for="sel1" style="font-size: 20px;">나라선택</label> <select
							name="country_kr_name" id="selcountry_kr_name"
							class="form-control">
							<option value="">나라 선택</option>
							<c:forEach items="${rs.rows}" var="row">
								<option value="${row.country_kr_name}">${row.country_kr_name}</option>
							</c:forEach>
						</select><br>
						<div id="city_kr_nameDiv">
							<select name="city_kr_name" id="selcity_kr_name"
								class="form-control">
								<option value="">지역선택</option>
							</select>
						</div>
						<br>
						<div id="market_kr_nameDiv">
							<select name="market_kr_name" id="selmarket_kr_name"
								class="form-control">
								<option value="">시장선택</option>
							</select>
						</div>
						<br> <br> <br>

						<div>
							상품명 : &nbsp;&nbsp;<input type="text" name="product"
								id="txtProduct"
								style="color: black; width: 220px; height: 35px;"
								placeholder="상품명을 입력하세요." />
						</div>
						<br>
						<div align="right">
							<input class="btn btn-primary" type="button" value="상품검색"
								id="btnSearch" />
						</div>

					</div>
				</form>
			</div>
			<div class="container" style="width:500px;height:500px; margin-top: 15%;">
				<div class="row">
					<table>
						<thead>
							<th>No</th>
							<th>나라</th>
							<th>지역</th>
							<th>시장</th>
							<th>품목</th>
							<th>가격</th>
							<th>등록날짜</th>
							<th>등록자</th>
						</thead>
						<tbody>
							<c:if test="${rs eq null}">
								<tr>
									<td colspan="8" class="text-center">No Data</td>
								</tr>

							</c:if>
							<c:if test="${rs ne null}">
								<c:forEach var="row" items="${rs.rows}">
									<tr>
										<td>${row.sequence}</td>
										<td>${row.country_kr_name}</td>
										<td>${row.city_kr_name}</td>
										<td>${row.market_kr_name}</td>
										<td>${row.product_name}</td>
										<td>${row.product_price}</td>
										<td>${row.product_date}</td>
										<td>${row.user_id}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</form>
</div>




<jsp:include page="../main/footer.jsp" />