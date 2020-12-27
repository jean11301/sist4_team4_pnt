<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<script src="../js/jquery-3.5.1.js"></script>

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="countries">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>

<c:set var="product_number" value="${param.product_number}"	/>

<jsp:useBean id="service" class="com.example.libs.service.PopularService" />
<c:set var="product" value="${service.selectProduct(product_number)}" />
<sql:query dataSource="${conn}" var="cities">
	SELECT city_kr_name 
	FROM COUNTRY NATURAL JOIN city
	WHERE country_kr_name = ?
	ORDER BY city_kr_name
	<sql:param value="${product.country_kr_name}" />
</sql:query>
<sql:query dataSource="${conn}" var="markets">
	SELECT market_kr_name 
	FROM city NATURAL JOIN market
	WHERE city_kr_name = ?
	ORDER BY market_kr_name
	<sql:param value="${product.city_kr_name}" />
</sql:query>

<script>
	var xhr = null;
	$(document).ready(function() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		month = month >= 10 ? month : "0" + month;
		date = date >= 10 ? date : "0" + date;
		var today = "" + year + '-' + month + '-' + date;
		console.log(today);
		$('#txtProductDate').val(today);
		$('#txtProductDate').attr("value", today);
		$('#txtUserId2').val($('#txtUserId').val());
		$('#txtUserId2').attr("value", $('#txtUserId').val());
		
		xhr = new XMLHttpRequest();
		
		$('#selCountry').on('change',function() {
			var selectedCountry = $(this).val();
			if(selectedCountry == "국가명"){
				selectedCountry = "";
				
				$('#selCity').html("<option>도시명</option>");
			}else{
				$('#txtCountry').val(selectedCountry);
				xhr.onreadystatechange = getCity;     //4
				xhr.open('POST', 'getCitylist_insertProduct.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + $(this).val());     //3.
				
			}
			console.log(selectedCountry);
		});
		function getCity() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#citySpan').html(xhr.responseText.trim());
			}
		}
		
		$('#updateProduct').on('click', function(){
			if($('#selCountry:selected').val() == "국가명" || $('#selCity:selected').val() == "도시명" || $('#selMarket:selected').val() == "시장명" || 
					$('#txtProductName').val() == "" || $('#txtProductPrice').val() == ""){
				alert("정보를 모두 입력해주세요.");
			}else{
				$(this).submit();
			}
		});
		
		$('#cancel').on('click', function(){
			history.back(-1);
		});
		
	});
</script>


<div id="titletext">물가 관리 | 시장 관리</div>

<jsp:include page="../main/header.jsp" />
<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">물가 리스트 > 상품 수정</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
							<div id="example2_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
								<form action="changeProduct.jsp" method="POST">
								<div class="row">
									<div class="col-sm-12">
										<!-- 상태 정보 입력 테이블 -->
										<label>상태 정보</label>
										<table id="example2" class="table table-bordered dataTable dtr-inline" 
												role="grid" aria-describedby="example2_info">
											<tr role="row">
												<th>상태</th>
												<td>
													<select id="check_status" name="check_status">
														<option value="0" <c:if test="${product.check_status eq 0 }">selected</c:if>>미확인</option>
														<option value="1" <c:if test="${product.check_status eq 1 }">selected</c:if>>확인</option>
														<option value="-1" <c:if test="${product.check_status eq 2 }">selected</c:if>>불가</option>
													</select>
												</td>
											</tr>
											<tr role="row">
												<th>등록 날짜</th>
												<td><label>
												<input type="date" class="form-control form-control-sm" id="txtProductDate" name="product_date"
														aria-controls="example1" disabled="true" ${product.product_date }/>
												</label></td>
											</tr>
											<tr>
												<th>올린이</th>
												<td><label>
												<input type="text" class="form-control form-control-sm" id="txtUserId" 
														aria-controls="example1" disabled="true" value="${product.user_id }" >
												</label></td>
												<input type="text" id="txtUserId2" name="user_id" value="" hidden="true" />
											</tr>
											<tr role="row">
												<th>조회수</th>
												<td>
												<label>
												<input type="number" class="form-control form-control-sm" id="txtSequence" 
														aria-controls="example1" disabled="true" name="sequence" value="${product.sequence }">
												</label>
												</td>
											</tr>
											</table>
									</div>
								</div>
								<!-- 지역 정보 입력 테이블 -->
								<label>지역 정보</label>
								<div class="row">
									<div class="col-sm-12">
										<table id="example2" class="table table-bordered dataTable dtr-inline" 
												role="grid" aria-describedby="example2_info">
											<tr role="row">
												<th>국가명</th>
												<td><select id="selCountry" name="country_kr_name" required="required">
														<option>국가명</option>
														<c:forEach items="${countries.rows}" var="country">
															<option value="${country.country_kr_name}" <c:if test="${product.country_kr_name eq country.country_kr_name}">selected</c:if>>
																${country.country_kr_name}</option>
														</c:forEach>
												</select></td>
											</tr>
											<tr role="row">
												<th>도시명</th>
												<td>
													<span id="citySpan">
														<select id="selCity" name="city_kr_name" required="required">
															<option value="">도시명</option>
															<c:forEach items="${cities.rows}" var="city">
																<option value="${city.city_kr_name}" <c:if test="${product.city_kr_name eq city.city_kr_name}">selected</c:if>>
															${city.city_kr_name}</option>
															</c:forEach>
														</select>
													</span>
												</td>
											</tr>
											<tr role="row">
												<th>시장명</th>
												<td>
													<span id="marketSpan">
														<select id="selMarket" name="market_kr_name">
															<option value="">시장명</option>
															<c:forEach items="${markets.rows}" var="market">
																<option value="${market.market_kr_name}" <c:if test="${product.market_kr_name eq market.market_kr_name}">selected</c:if>>
															${market.market_kr_name}</option>
															</c:forEach>
														</select>
													</span>
												</td>
											</tr>
											</table>
									</div>
								</div>
								<div class="row">
								<!-- 물가 정보 입력 테이블 -->
								<label>물가 정보</label>
									<div class="col-sm-12">
										<table id="example2" class="table table-bordered dataTable dtr-inline" 
												role="grid" aria-describedby="example2_info">
											<tr role="row">
												<th>상품명</th>
												<td>
												<label>
												<input type="text" class="form-control form-control-sm" id="txtProductName" 
														aria-controls="example1" name="product_name" value="${product.product_name}"/>
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>가격(원)</th>
												<td>
												<label>
												<input type="text" class="form-control form-control-sm" id="txtProductPrice" name="product_price"
														aria-controls="example1" value="${product.product_price }"/>
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>사진</th>
												<td>
												<label>
												<input type="file" name="product_img" value="${product.product_img}">
												</label>
												</td>
											</tr>
											</table>
									</div>
								</div>
								<!-- /.table -->
								<div class="row">
									<div class="col-sm-12 col-md-5">
										<button type="submit" id="changeProduct" class="btn btn-success">수정</button>
										<button type="button" id="cancel" class="btn btn-danger">취소</button>
									</div>
									<div class="col-sm-12 col-md-7"></div>
								</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>


<jsp:include page="../main/footer.jsp" />
