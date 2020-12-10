<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<script src="../js/jquery-3.5.1.js"></script>


<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="countries">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>

															
<%-- <c:if test="${country != ''}">
<sql:query dataSource="${conn}" var="cities">
	SELECT city_kr_name 
	FROM COUNTRY NATURAL JOIN city
	WHERE country_kr_name = ?
	ORDER BY city_kr_name;
	<sql:param value="${country}" />
</sql:query>
<c:forEach items="${cities.rows}" var="city">
<option>${city.city_kr_name}</option>
</c:forEach>
</c:if>	 --%>



<script>
	var xhr = null;
	$(document).ready(function() {
		xhr = new XMLHttpRequest();
		$('#selCountry').on('change',function() {
			//xhr.onreadystatechange = getCity;
			var selectedCountry = $(this).val();
			if(selectedCountry == "국가명"){
				$('#txtCountry').val("");
				$('#txtCountry').attr("disabled", "true");
				selectedCountry = "";
				
				$('#selCity').html("<option>도시명</option>");
				$('#txtCity').val("국가를 먼저 선택해주세요.");
				$('#txtCity').attr("disabled", "true");
			}else if(selectedCountry == "신규 국가 입력"){	
				$('#txtCountry').val("");
				$('#txtCountry').removeAttr("disabled");
				selectedCountry = "";
				
				$('#selCity').html("<option>신규 도시 입력</option>");
				$('#txtCity').val("");
				$('#txtCity').removeAttr("disabled");
			}else{
				$('#txtCountry').val(selectedCountry);
				$('#txtCountry').attr("disabled", "true");
				
				<%--var str = "<option selected>도시명</option>" + 
				"<sql:query dataSource='${conn}' var='cities'>" +
				"SELECT city_kr_name FROM COUNTRY NATURAL JOIN city " + 
				"WHERE country_kr_name = ? ORDER BY city_kr_name;" + 
				"<sql:param value='" + selectedCountry + "' /></sql:query>" + 
				"<c:forEach items='${cities.rows}' var='city'>" + 
				"<option value='<c:out value='" + "${city.city_kr_name}' />>" + 
				"${country.country_kr_name}</option></c:forEach>" + 
				"<option>신규 도시 입력</option>";
				${'#selCity'}.html(str); --%>
				
				
				
				
			}
			//xhr.open('POST', 'insertMarket.jsp', true);
			//xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			//xhr.send('country=' + $(this).val());
			console.log(selectedCountry);
			
		});
		/* function getCity() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#cityDiv').html(xhr.responseText.trim());
			}
		} */
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
						<div class="card-header">
							<h3 class="card-title">전체 몇 건</h3>
							::after
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div id="example2_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
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
														aria-controls="example1" disabled="true">
												</label>
													<select id="selCountry" name="selCountry">
														<option selected>국가명</option>
														<c:forEach items="${countries.rows}" var="country">
															<option value="<c:out value='${country.country_kr_name}' />">
																${country.country_kr_name}
															</option>
														</c:forEach>
														<option>신규 국가 입력</option>
													</select>
													<c:out value="${selectedCountry}" />
												</td>
											</tr>
											<tr role="row">
												<th>한글 도시명</th>
												<td colspan="2">
												<label>
												<input type="search" class="form-control form-control-sm" id="txtCity" 
														aria-controls="example1" disabled="true" value="국가를 먼저 선택해주세요." >
												</label>
														<select id="selCity" name="selCity">
															<option selected>도시명</option>
														</select>
												</td>
											</tr>
											<tr role="row">
												<th>한글 시장명</th>
												<td colspan="2"></td>
											</tr>
											<tr role="row">
												<th>영어 시장명</th>
												<td colspan="2"></td>
											</tr>
											<tr role="row">
												<th rowspan="2">좌표</th>
												<th>위도</th>
												<td></td>
											</tr>
											<tr role="row">
												<th>경도</th>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<!-- /.table -->
								<div class="row">
									<div class="col-sm-12 col-md-5">
										<button type="submit" id="deleteMarket" class="btn btn-danger">등록</button>
										<button type="button" id="insertMarket"
											class="btn btn-success">취소</button>
									</div>
									<div class="col-sm-12 col-md-7"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>







</div>





<jsp:include page="../main/footer.jsp" />
