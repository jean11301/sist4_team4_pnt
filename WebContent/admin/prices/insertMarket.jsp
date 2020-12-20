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
		
		function getCity() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#citySpan').html(xhr.responseText.trim());
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
					<h1 class="m-0">시장 관리 > 신규 시장 등록</h1>
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
										<table id="example2"
											class="table table-bordered dataTable dtr-inline" role="grid"
											aria-describedby="example2_info">
											<tr role="row">
												<th>국가명</th>
												<td colspan="2">
												<label>
												<input type="text" class="form-control form-control-sm" id="txtCountry" 
														aria-controls="example1" disabled="true" name="country_kr_name"/>
												</label>
													<select id="selCountry" name="country_kr_name">
														<option selected>국가명</option>
														<c:forEach items="${countries.rows}" var="country">
															<option value="${country.country_kr_name}" >
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
														aria-controls="example1" disabled="true" value="국가를 먼저 선택해주세요." />
												</label>
												<span id="citySpan">
													<select id="selCity" name="city_kr_name">
														<option selected>도시명</option>
													</select>
												</span>
												</td>
											</tr>
											<tr role="row">
												<th>한글 시장명</th>
												<td colspan="2">
												<label>
												<input type="text" class="form-control form-control-sm" id="txtMarketKr" 
														aria-controls="example1" disabled="true" name="market_kr_name">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>영어 시장명</th>
												<td colspan="2">
												<label>
												<input type="text" class="form-control form-control-sm" id="txtMarketEn" 
														aria-controls="example1" disabled="true" name="market_en_name">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th rowspan="2">좌표</th>
												<th>위도</th>
												<td>
												<label>
												<input type="number" step="0.000000001" class="form-control form-control-sm" id="txtLatitude" 
														aria-controls="example1" disabled="true" name="latitude">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>경도</th>
												<td>
												<label>
												<input type="number" step="0.000000001" class="form-control form-control-sm" id="txtLongitude" 
														aria-controls="example1" disabled="true" name="longitude">
												</label>
												</td>
											</tr>
											<tr role="row">
												<th>시장 설명</th>
												<td colspan="2">
												<label>
												<textarea name="market_info" class="form-control" rows="5" required="required"></textarea>
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
