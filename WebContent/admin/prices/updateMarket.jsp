<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="../js/jquery-3.5.1.js"></script>
<fmt:requestEncoding value="utf-8" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="countries">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>

<c:set var="market_number" value="${param.market_number}"	/>

<jsp:useBean id="service" class="com.example.libs.service.MarketService" />
<c:set var="market" value="${service.selectMarket(market_number)}" />
<sql:query dataSource="${conn}" var="cities">
	SELECT city_kr_name 
	FROM COUNTRY NATURAL JOIN city
	WHERE country_kr_name = ?
	ORDER BY city_kr_name
	<sql:param value="${market.country_kr_name}" />
</sql:query>

<script>
	var xhr = null;
	$(document).ready(function() {
		$('#selCountry').on('change',function() {
			$('#txtMarketKr').val("");
			$('#txtMarketEn').val("");
			$("#txtLatitude").val("");
			$("#txtLongitude").val("");
			var selectedCountry = $(this).val();
			if(selectedCountry == "국가명"){
				$('#txtCountry').val("");
				$('#txtCountry').attr("disabled", "true");
				selectedCountry = "";
				
				$('#selCity').html("<option>도시명</option>");
				$('#txtCity').val("국가를 먼저 선택해주세요.");
				$('#txtCity').attr("disabled", "true");
				
				$('#txtMarketKr').attr("disabled", "true");
				$('#txtMarketEn').attr("disabled", "true");
				
				$("#txtLatitude").attr("disabled", "true");
				$("#txtLongitude").attr("disabled", "true");
			}else{
				$('#txtCountry').val(selectedCountry);
				$('#txtCountry').attr("disabled", "true");
				
				$('#txtCity').val("");
				$('#txtCity').attr("disabled", "true");
				xhr.onreadystatechange = getCity;     //4
				xhr.open('POST', 'getCitylist.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + $(this).val());     //3.
			}
			console.log(selectedCountry);
		});
		$('#selCity').on('change',function() {
			$('#txtCity').val("");
			$('#txtMarketKr').val("");
			$('#txtMarketEn').val("");
			$("#txtLatitude").val("");
			$("#txtLongitude").val("");
			var selectedCity = $(this).val();
			if(selectedCity == "도시명"){
				$('#txtCity').attr("disabled", "true");
				selectedCity = "";
				
				$('#txtMarketKr').attr("disabled", "true");
				$('#txtMarketEn').attr("disabled", "true");
				
				$("#txtLatitude").attr("disabled", "true");
				$("#txtLongitude").attr("disabled", "true");
			}else{
				$('#txtCity').val(selectedCity); 
				$('#txtCity').attr("disabled", "true");
				
				$('#txtMarketEn').removeAttr("disabled");
				$('#txtMarketKr').removeAttr("disabled");
				
				$("#txtLatitude").removeAttr("disabled");
				$("#txtLongitude").removeAttr("disabled");
			}
			
			console.log(selectedCity);
		});
		
		function getCity() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#citySpan').html(xhr.responseText.trim());
			}
		}
		
		
		$('#updateMarket').on('click', function(){
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
					<h1 class="m-0">시장 관리 > 시장 수정</h1>
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
								<form action="changeMarket.jsp" method="POST">
								<input type="text" value="${market_number}" name="market_number" hidden="true"/>
								<div class="row">
									<div class="col-sm-12">
										<table id="example2"
											class="table table-bordered dataTable dtr-inline" role="grid"
											aria-describedby="example2_info">
											<tr role="row">
												<th>국가명</th>
												<td colspan="2">
												<label> 
												<input type="text" class="form-control form-control-sm" id="txtCountry" name="country_kr_name"
														aria-controls="example1" disabled="true"  value="${market.country_kr_name}"/>
												</label>
													<select id="selCountry" name="country_kr_name">
														<option>국가명</option>
														<c:forEach items="${countries.rows}" var="country">
															<option value="${country.country_kr_name}" 
																<c:if test="${market.country_kr_name eq country.country_kr_name}">selected</c:if>>
																${country.country_kr_name}
															</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr role="row">
												<th>한글 도시명</th>
												<td colspan="2">
												<label>
												<input type="text" class="form-control form-control-sm" id="txtCity" name="city_kr_name"
														aria-controls="example1" disabled="true" value="${market.city_kr_name }" />
												</label>
												<span id="citySpan">
													<select id="selCity" name="city_kr_name">
														<option value="">도시명</option>
														<c:forEach items="${cities.rows}" var="city">
															<option value="${city.city_kr_name}" <c:if test="${market.city_kr_name eq city.city_kr_name}">selected</c:if>>
															${city.city_kr_name}</option>
														</c:forEach>
													</select>
												</span>
												</td>
											</tr>
											<tr role="row">
												<th>한글 시장명</th>
												<td colspan="2">
												<label>
												<input type="text" class="form-control form-control-sm" id="txtMarketKr" name="market_kr_name"
														aria-controls="example1" value="${market.market_kr_name}">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>영어 시장명</th>
												<td colspan="2">
												<label>
												<input type="text" class="form-control form-control-sm" id="txtMarketEn" name="market_en_name"
														aria-controls="example1" value="${market.market_en_name }">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th rowspan="2">좌표</th>
												<th>위도</th>
												<td>
												<label>
												<input type="text" class="form-control form-control-sm" id="txtLatitude" name="latitude"
														aria-controls="example1" value="${market.latitude}">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>경도</th>
												<td>
												<label>
												<input type="text" class="form-control form-control-sm" id="txtLongitude" name="longitude"
														aria-controls="example1" value="${market.longitude}">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>시장 설명</th>
												<td colspan="2">
												<label>
												<textarea name="market_info" class="form-control" rows="5" value="${market.market_info}"></textarea>
												</label>
												</td>
											</tr>
										</table>
									</div>
								</div>
								<!-- /.table -->
								<div class="row">
									<div class="col-sm-12 col-md-5">
										<button type="submit" id="updateMarket" class="btn btn-success">수정</button>
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
