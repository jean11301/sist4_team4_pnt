<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="../js/jquery-3.5.1.js"></script>
<fmt:requestEncoding value="utf-8" />
<jsp:useBean id="service" class="com.example.libs.service.MarketService" />
<c:set var="searchWith" value="${param.searchWith}" />
<c:set var="keyword" value="${param.keyword}" />

<!-- sql -->

<c:set var="pageSize" value="10" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<c:if test="${searchWith == 'all'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    	INNER JOIN market ON(city.city_number = market.city_number)
	WHERE country.country_kr_name LIKE CONCAT(CONCAT('%', ?), '%') or 
        city.city_kr_name LIKE CONCAT(CONCAT('%', ?), '%') or
        market.market_kr_name LIKE CONCAT(CONCAT('%', ?), '%') or
        market.market_en_name LIKE CONCAT(CONCAT('%', ?), '%')
	ORDER BY country_kr_name, city_kr_name, market_kr_name;
	<sql:param value="${keyword}"/>
	<sql:param value="${keyword}"/>
	<sql:param value="${keyword}"/>
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="0" />
</c:if>
<c:if test="${searchWith == 'country_kr_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE country.country_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="1" />
</c:if>
<c:if test="${searchWith == 'city_kr_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE city.city_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="2" />
</c:if>
<c:if test="${searchWith == 'market_kr_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE market.market_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="3" />
</c:if>
<c:if test="${searchWith == 'market_en_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT country.country_kr_name, city.city_kr_name, market_kr_name, market_en_name
	FROM country INNER JOIN city ON(country.country_code = city.country_code)
    		INNER JOIN market ON(city.city_number = market.city_number)
	WHERE market.market_en_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="4" />
</c:if>
<c:set var="count" value="${service.getTotalCount(i, keyword)}" />
<c:set var="totalPage" value="${service.getTotalPage(pageSize)}" />
<c:set var="currentPage" value="${param.page}" />
<c:set var="pageSize" value="10" />
<c:set var="totalPage" value="${service.getTotalPage(pageSize, i , keyword)}" />

<!-- /sql -->





<script>
$(function($){
	xhr = new XMLHttpRequest();
	$('#searchWith').on('change', function(){
		$('#searchKeyword').val("");
	});
	
	$('#insertMarket').on('click', function(){
		location.href="insertMarket.jsp";
	});
	
	$('#deleteMarket').on('click', function(){
		var list= new Array();
		 $('.selmarket:checked').each(function(index){
			list.push(this.value);
		});
		if (confirm("시장을 삭제하시겠습니까?")) {
			xhr.onreadystatechange = getMarket;     //4
			xhr.open('POST', 'deleteMarket.jsp', true);  //2. open()
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			let param = 'list=' + list;
			xhr.send(param);   //3. send()
		}
		else history.go(0);
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
							<h3 class="card-title">전체 ${count}건</h3>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div id="example2_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<div class="col-sm-12 col-md-6">
										<div id="example1_filter" class="dataTables_filter">
										<form action="marketSearchResult.jsp?" method="POST" >
											<select id="searchWith" name="searchWith">
												<option value="all" selected>전체</option>
												<option value="country_kr_name">국가명</option>
												<option value="city_kr_name">도시명</option>
												<option value="market_kr_name">한글 시장명</option>
												<option value="market_en_name">영어 시장명</option>
											</select> 
											<label><input type="text" id="searchKeyword" name="keyword"
												class="form-control form-control-sm" placeholder=""
												aria-controls="example1">
											</label>
											<input type="text" name="page" value="1" hidden>
											<button type="submit" id="searchMarket">검색</button>
											</form>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
									<div id="listDiv">
										<table id="example2" class="table tavle-bordered table-hover dataTable dtr-inline"
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
											<c:if test="${count == 0 }"> 
												<tr>
													<td colspan="6" class="text-center">No Data</td>
												</tr>
											</c:if>
											<c:if test="${count > 0 }" >
												<c:set var="begin" value="${(currentPage - 1) * pageSize}" />
												<c:set var="end" value="${begin + pageSize - 1}" />
												<c:forEach items="${rs.rows}" var="row" begin="${begin}" end="${end}">
													<tr>
														<td><input type="checkbox" class="selMarket"></td>
														<td>${row.country_kr_name}</td>
														<td>${row.city_kr_name}</td>
														<td>${row.market_kr_name}</td>
														<td>${row.market_en_name}</td>
														<td><a href="updateMarket.jsp?market_number=${market.market_number}">수정하기</a></td>
													</tr>
												</c:forEach>
											</c:if>
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
											aria-live="polite">Showing ${(currentPage - 1) * pageSize + 1} to&nbsp;
											<c:if test="${currentPage eq totalPage }" >${count}</c:if>
											<c:if test="${currentPage ne totalPage }" >${begin + pageSize}</c:if>
											of ${count} 
											entries
										</div>
									</div>
									<div class="col-sm-12 col-md-7">
										<div class="dataTables_paginate paging_simple_numbers"
											id="example2_paginate">
											<ul class="pagination">
											
										    	<c:if test="${currentPage ne 1}" >
												<li class="paginate_button page-item previous" id="example2_previous">
													<a href="marketSearchResult.jsp?page=${currentPage - 1}" aria-controls="example2" data-dt-idx="0" tabindex="0"
														class="page-link pre" >Previous</a></li>
												</c:if>
										    	<c:if test="${currentPage eq 1}" >
												<li class="paginate_button page-item previous disabled" id="example2_previous">
													<a href="#" aria-controls="example2" data-dt-idx="0" tabindex="0"
														class="page-link pre" >Previous</a></li>
												</c:if>
												
												<c:forEach begin="1" end="${totalPage}" var="i">
													<c:if test="${currentPage eq i}" >
														<li id="eqPage" class="paginate_button page-item active">
											               <a href="#" aria-controls="example2" data-dt-idx="${i}"
																tabindex="0" class="page-link" >${i}</a></li>
													</c:if>
													<c:if test="${currentPage ne i}" >
														<li id="eqPage" class="paginate_button page-item">
											               <a href="marketSearchResult.jsp?page=${i}" aria-controls="example2" data-dt-idx="${i}"
																tabindex="0" class="page-link" >${i}</a></li>
													</c:if>
											    </c:forEach>
													
												<c:if test="${currentPage eq totalPage}">	
												<li class="paginate_button page-item next disable" id="example2_next">
													<a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0"
														class="page-link next" >Next</a></li>
												</c:if>
												<c:if test="${currentPage ne totalPage}">	
												<li class="paginate_button page-item next" id="example2_next">
													<a href="marketSearchResult.jsp?=${currentPage + 1}" aria-controls="example2" data-dt-idx="7" tabindex="0"
														class="page-link next" >Next</a></li>
												</c:if>
											</ul>
										</div>
									</div>
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
