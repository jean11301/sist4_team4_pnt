<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<script src="../js/jquery-3.5.1.js"></script>

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="countries">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>

<script>
	var xhr = null;
	$(document).ready(function() {
		xhr = new XMLHttpRequest();
		$('#selCountry').on('change',function() {
			var selectedCountry = $(this).val();
			if(selectedCountry == "국가명"){
				selectedCountry = "";
				
				$('#selCity').html("<option>도시명</option>");
			}else{
				$('#txtCountry').val(selectedCountry);
				xhr.onreadystatechange = getCity;     //4
				xhr.open('POST', 'getCitylist.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + $(this).val());     //3.
				$('#selCity').on('change',function() {
					selMarket();
				});
			}
			console.log(selectedCountry);
		});
		function selCity(){
			var selectedCountry = $('#selCountry:selected').val();
			if(selectedCountry == "국가명"){
				$('#selCity').html("<option>도시명</option>");
			}else{
				xhr.onreadystatechange = getCity;     //4
				xhr.open('POST', 'getCitylist.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + selectedCountry);     //3.
			}
		}
		function getCity() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#citySpan').html(xhr.responseText.trim());
			}
		}
		function selMarket(){
			var selectedCity = $('#selCity:selected').val();
			if(selectedCity == "도시명"){
				$('#selMarket').html("<option>시장명</option>");
			}else{
				xhr.onreadystatechange = getMarket;     //4
				xhr.open('POST', 'getMarketlist_registerProduct.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('city=' + selectedCity + '&market=' + $('#market').val());     //3.
			}
		}
		function getMarket() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#marketSpan').html(xhr.responseText.trim());
			}
		}
		
		$('#insertMarket').on('click', function(){
			if($('#txtCountry').val() == "" || $('#txtCity').val() == "" ||
					$('#txtMarketKr').val() == "" || $('#txtMarketEn').val() == "" ||
						$('#txtLatitude').val() == "" || $('#txtLongitude').val() == ""){
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
					<h1 class="m-0">물가 리스트 > 신규 상품 등록</h1>
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
								<form action="newMarket.jsp" method="POST">
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
														<option value="0" selected>미확인</option>
														<option value="1">확인</option>
														<option value="-1">불가</option>
													</select>
												</td>
											</tr>
											<tr role="row">
												<th>등록 날짜</th>
												<td>
												<input type="date" class="form-control form-control-sm" id="txtProductDate" name="product_date"
														aria-controls="example1" disabled="true" />
												</td>
											</tr>
											<tr>
												<th>올린이</th>
												<td>
												<label>
												<input type="text" class="form-control form-control-sm" id="txtUserId" 
														aria-controls="example1" disabled="true" name="user_id">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>조회수</th>
												<td>
												<label>
												<input type="number" class="form-control form-control-sm" id="txtSequence" 
														aria-controls="example1" disabled="true" name="sequence" value="0">
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
															<option value="${country.country_kr_name}">${country.country_kr_name}</option>
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
																<option value="${city.city_kr_name}">${city.city_kr_name}</option>
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
														aria-controls="example1" name="product_name"/>
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>가격(원)</th>
												<td>
												<label>
												<input type="text" class="form-control form-control-sm" id="txtProductprice" name="product_price"
														aria-controls="example1" />
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>사진</th>
												<td>
												<label>
												<input type="file" name="FileName" >
												</label>
												</td>
											</tr>
											</table>
									</div>
								</div>
								<!-- /.table -->
								<div class="row">
									<div class="col-sm-12 col-md-5">
										<button type="submit" id="insertMarket" class="btn btn-success">등록</button>
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
