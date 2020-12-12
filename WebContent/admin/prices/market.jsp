<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<script src="../js/jquery-3.5.1.js"></script>

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="rs">
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	ORDER BY country_kr_name, city_kr_name, market_kr_name
</sql:query>

<script>
$(function($){
	xhr = new XMLHttpRequest();
	$('#searchMarket').on('click', function(){
		xhr.onreadystatechange = getMarket;     //4
		xhr.open('POST', 'getMarketlist.jsp', true);  //2. open()
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		let param = 'searchWith=' + $('#searchWith').val() + 
        			'&keyword=' + $('#searchKeyword').val();
		xhr.send(param);   //3. send()
	});
	
	$('#insertMarket').on('click', function(){
		location.href="insertMarket.jsp";
	});
	
	
	$('a').on('click', function(){
		var country = $(this).parent().siblings()[1].innerHTML;
		var city = $(this).parent().siblings()[2].innerHTML;
		var marketKr = $(this).parent().siblings()[3].innerHTML;
		var marketEn = $(this).parent().siblings()[4].innerHTML;
		xhr.onreadystatechange = updateMarket;     //4
		xhr.open('POST', 'getMarketlist.jsp', true);  //2. open()
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		let param = 'country=' + country + '&city=' + city + 
        			'&marketKr=' + marketKr + '&marketEn=' + marketEn;
		xhr.send(param);   //3. send()
	});
});	
function getMarket() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		$('#listDiv').html(xhr.responseText.trim());
	}
}
function updateMarket(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		location.href = "updateMarket.jsp";
	}
}

</script>

<div id="titletext">물가 관리 | 시장 관리</div>

<jsp:include page="../main/header.jsp" />
<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">시장 관리</h1>
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
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div id="example2_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-12 col-md-6">
										<div id="example1_filter" class="dataTables_filter">
											<select id="searchWith" name="selSearch">
												<option value="all" selected>전체</option>
												<option value="country_kr_name">국가명</option>
												<option value="city_kr_name">도시명</option>
												<option value="market_kr_name">한글 시장명</option>
												<option value="market_en_name">영어 시장명</option>
											</select> 
											<label><input type="text" id="searchKeyword"
												class="form-control form-control-sm" placeholder=""
												aria-controls="example1">
											</label>
											<button type="button" id="searchMarket">검색</button>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
									<div id="listDiv">
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
												<c:forEach items="${rs.rows}" var="row">
													<tr>
														<td><input type="checkbox" class="selMarket"></td>
														<td>${row.country_kr_name}</td>
														<td>${row.city_kr_name}</td>
														<td>${row.market_kr_name}</td>
														<td>${row.market_en_name}</td>
														<td><a href="#">수정하기</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										</div>
									</div>
								</div>
								<!-- /.table -->
								<div class="row">
									<div class="col-sm-12 col-md-6"></div>
									<div class="col-sm-12 col-md-6">
										<button type="button" id="deleteMarket" class="btn btn-danger float-right" >삭제</button>
										<button type="button" id="insertMarket" class="btn btn-success float-right" >등록</button>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-5">
										<div class="dataTables_info" id="example2_info" role="status"
											aria-live="polite">Showing 1 to 10 of 57 entries</div>
									</div>
									<div class="col-sm-12 col-md-7">
										<div class="dataTables_paginate paging_simple_numbers"
											id="example2_paginate">
											<ul class="pagination">
												<li class="paginate_button page-item previous disabled"
													id="example2_previous"><a href="#"
													aria-controls="example2" data-dt-idx="0" tabindex="0"
													class="page-link">Previous</a></li>
												<li class="paginate_button page-item active"><a
													href="#" aria-controls="example2" data-dt-idx="1"
													tabindex="0" class="page-link">1</a></li>
												<li class="paginate_button page-item "><a href="#"
													aria-controls="example2" data-dt-idx="2" tabindex="0"
													class="page-link">2</a></li>
												<li class="paginate_button page-item "><a href="#"
													aria-controls="example2" data-dt-idx="3" tabindex="0"
													class="page-link">3</a></li>
												<li class="paginate_button page-item "><a href="#"
													aria-controls="example2" data-dt-idx="4" tabindex="0"
													class="page-link">4</a></li>
												<li class="paginate_button page-item "><a href="#"
													aria-controls="example2" data-dt-idx="5" tabindex="0"
													class="page-link">5</a></li>
												<li class="paginate_button page-item "><a href="#"
													aria-controls="example2" data-dt-idx="6" tabindex="0"
													class="page-link">6</a></li>
												<li class="paginate_button page-item next"
													id="example2_next"><a href="#"
													aria-controls="example2" data-dt-idx="7" tabindex="0"
													class="page-link">Next</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							::after
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>







</div>





<jsp:include page="../main/footer.jsp" />
