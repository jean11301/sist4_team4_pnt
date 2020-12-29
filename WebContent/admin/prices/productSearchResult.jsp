<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="../js/jquery-3.5.1.js"></script>

<jsp:useBean id="service" class="com.example.libs.service.PopularService" />
<c:set var="beginDate" value="${param.beginDate}" />
<c:set var="endDate" value="${param.endDate}" />
<fmt:formatDate value="${beginDate}"  pattern="yyyy-MM-dd" />
<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" />
<c:set var="searchWithRegion" value="${param.searchWithRegion}" />
<c:if test="${empty searchWithRegion}" ><c:set var="searchWithRegion" value=" " /></c:if>
<c:set var="regionKeyword" value="${param.regionKeyword}" />
<c:if test="${empty regionKeyword}" ><c:set var="regionKeyword" value=" " /></c:if>
<c:set var="searchWithProduct" value="${param.searchWithProduct}" />
<c:if test="${empty searchWithProduct}" ><c:set var="searchWithProduct" value=" " /></c:if>
<c:set var="productKeyword" value="${param.productKeyword}" />
<c:if test="${empty productKeyword}" ><c:set var="productKeyword" value=" " /></c:if>

<c:set var="productList" value="${service.productSearchResult(beginDate, endDate, searchWithRegion, regionKeyword, searchWithProduct, productKeyword)}" />
<%-- <c:set var="count"  value="0"/>
<c:forEach items="${productList}">
	<c:set var="count"
</c:forEach>--%>
<c:set var="count" value="${fn:length(productList)}" /> 

<c:set var="currentPage" value="${param.page}" />
<c:set var="pageSize" value="10" />
<c:set var="totalPage" value="${service.getTotalPage(pageSize)}" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />


<!-- sql 


<c:if test="${searchWithRegion == 'all'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date,
	product.product_price, product_img, sequence, user_id
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country
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
	SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date,
	product.product_price, product_img, sequence, user_id
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country
	WHERE country.country_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="1" />
</c:if>
<c:if test="${searchWith == 'city_kr_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date,
	product.product_price, product_img, sequence, user_id
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country
	WHERE city.city_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="2" />
</c:if>
<c:if test="${searchWith == 'market_kr_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date,
	product.product_price, product_img, sequence, user_id
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country
	WHERE market.market_kr_name LIKE CONCAT(CONCAT('%', ?), '%') 
	ORDER BY country_kr_name, city_kr_name, market_kr_name
	<sql:param value="${keyword}"/>
</sql:query>
<c:set var="i" value="3" />
</c:if>
<c:if test="${searchWith == 'market_en_name'}">
<sql:query dataSource="${conn}" var="rs" >
	SELECT check_status, country_kr_name, city_kr_name, market_kr_name, product_name, product_number, product_date,
	product.product_price, product_img, sequence, user_id
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country
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
	$('#searchWithRegion').on('change', function(){
		$('#regionKeyword').val("");
	});
	
	$('#searchWithProduct').on('change', function(){
		$('#productKeyword').val("");
	});
	
	$("input[name='period']:checked").on('change', function(){
		var v = $(this).val();
		var myDate = newDate();
		if(v == 3){
			myDate.setDate(myDate.getMonth() + 3);
		}else if(v ==6){
			myDate.setDate(myDate.getMonth() + 6);
		}
		var d = myDate.toISOString();
		var d2 = d.subString(0, 10);
		$('#endDate').val(d2);
	});
	
	$('#insertProduct').on('click', function(){
		location.href="insertProduct.jsp";
	});
	
	$('#deleteProduct').on('click', function(){
		var list= new Array();
		 $('.selproduct:checked').each(function(index){
			list.push(this.value);
		});
		if (confirm("상품을 삭제하시겠습니까?")) {
			xhr.onreadystatechange = getProduct;     //4
			xhr.open('POST', 'deleteProduct.jsp', true);  //2. open()
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			let param = 'list=' + list;
			xhr.send(param);   //3. send()
		}
		else history.go(0);
	});
	
	
});	
function getProduct() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		$('#listDiv').html(xhr.responseText.trim());
	}
}
function updateProduct(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		location.href = "updateProduct.jsp";
	}
}

</script>

<style>
#searchFilter{
	border: 1px solid black;
	padding: 0.5vw;
}
</style>

<div id="titletext">물가 관리 | 시장 관리</div>

<jsp:include page="../main/header.jsp" />
<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">물가 리스트</h1>
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
							<div id="example1_filter" class="dataTables_filter">
								<form action="productSearchResult.jsp" method="POST" id="searchFilter">
								<h3 class="card-title">상세검색</h3><br>
								<div class="row" >
									<div class="col-sm-12 col-md-6">
									<input type="date" id="beginDate" name="beginDate"/>&nbsp;&nbsp;~&nbsp;&nbsp; 
									<input type="date" id="endDate" name="endDate" /><br />
									</div>
								</div>
								<div class="row" >
									<div class="col-sm-12 col-md-6">
									<input type="radio" name="period" id="period" value="3" checked="checked"/>최근 3개월&nbsp;&nbsp;
									<input type="radio" name="period" id="period" value="6"/>최근 6개월&nbsp;&nbsp;
									<input type="radio" name="period" id="period" value="0" />전체보기<br />
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-6">
										<label>지역</label>
										<select id="searchWithRegion" name="searchWithRegion">
											<option value="all" selected>전체</option>
											<option value="country_kr_name">국가명</option>
											<option value="city_kr_name">도시명</option>
											<option value="market_kr_name">한글 시장명</option>
										</select> 
										<label><input type="text" id="regionKeyword" name="regionKeyword"
												class="form-control form-control-sm" placeholder=""
												aria-controls="example1">
										</label>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-6">
										<label>상품</label>
										<select id="searchWithProduct" name="searchWith">
											<option value="all" selected>전체</option>
											<option value="status_check">상태</option>
											<option value="product_name">상품명</option>
											<option value="user_id">올린이</option>
										</select> 
										<label><input type="text" id="productKeyword" name="productKeyword"
												class="form-control form-control-sm" placeholder=""
												aria-controls="example1">
										</label>
										<input type="text" name="page" value="1" hidden>
										<button type="submit" id="searchMarket">검색</button>
									</div>
								</div>
								</form>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div id="example2_wrapper"
								class="dataTables_wrapper dt-bootstrap4">
								<div class="row">
									<h3 class="card-title">전체 ${count}건</h3>
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
													<th>상태</th>
													<th>등록 날짜</th>
													<th>국가명</th>
													<th>도시명</th>
													<th>한글 시장명</th>
													<th>상품명</th>
													<th>가격</th>
													<th>사진 유무</th>
													<th>올린이</th>
													<th>조회수</th>
													<th>관리</th>
												</tr>
											</thead>
											<tbody>
											<c:if test="${productList.size() == 0 }">
												<tr>
													<td colspan="6" class="text-center">No Data</td>
												</tr>
											</c:if>
											<c:if test="${productList.size() > 0 }">
												<c:set var="begin" value="${(currentPage - 1) * pageSize}" />
												<c:set var="end" value="${begin + pageSize - 1}" />
												<c:forEach items="${productList}" var="product" begin="${begin}" end="${end}">
													<tr>
														<td><input type="checkbox" class="selproduct" value="${product.product_number }"/></td>
														
														<c:if test="${product.check_status eq 0}">
															<td style="{font-color:blue;}">미확인</td>
														</c:if>
														<c:if test="${product.check_status eq 1}">
															<td style="{font-color:lime;}">확인</td>
														</c:if>
														<c:if test="${product.check_status eq 2}">
															<td>불가</td>
														</c:if>
														
														<td>${product.product_date}</td>
														<td>${product.country_kr_name}</td>
														<td>${product.city_kr_name}</td>
														<td>${product.market_kr_name}</td>
														<td>${product.product_name}</td>
														<td>${product.product_price}</td>
														<c:set var="str" value="<img src='../images/product/nodata.png'>" />
														<c:if test="${product.product_img ne str}">
															<td>o</td>
														</c:if>
														<c:if test="${product.product_img eq str}">
															<td>x</td>
														</c:if>
														
														<!-- <td>사진 유무</td> -->
														<td>${product.user_id}</td>
														<td>${product.sequence}</td>
														
														<c:if test="${product.check_status eq 0}">
															<td>
															<a href="changeCheckStatus.jsp?product_number=${product.product_number}&check_status=1" >확인처리&nbsp;|&nbsp;</a>
															<a href="changeCheckStatus.jsp?product_number=${product.product_number}&check_status=2" >불가처리&nbsp;|&nbsp;</a>
															<a href="updateProduct.jsp?product_number=${product.product_number}" >수정하기</a>
															</td>
														</c:if>
														<c:if test="${product.check_status eq 1}">
															<td>
															<a href="changeCheckStatus.jsp?product_number=${product.product_number}&check_status=2" >불가처리&nbsp;|&nbsp;</a>
															<a href="updateProduct.jsp?product_number=${product.product_number}" >수정하기</a>
															</td>
														</c:if>
														<c:if test="${product.check_status eq 2}">
															<td>
															<a href="changeCheckStatus.jsp?product_number=${product.product_number}&check_status=1" >확인처리&nbsp;|&nbsp;</a>
															<a href="updateProduct.jsp?product_number=${product.product_number}" >수정하기</a>
															</td>
														</c:if>
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
										<button type="button" id="deleteProduct" class="btn btn-danger float-right" >삭제</button>
										<button type="button" id="insertProduct" class="btn btn-success float-right" >등록</button>
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
													<a href="product.jsp?page=${currentPage - 1}" aria-controls="example2" data-dt-idx="0" tabindex="0"
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
											               <a href="product.jsp?page=${i}" aria-controls="example2" data-dt-idx="${i}"
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
													<a href="product.jsp?=${currentPage + 1}" aria-controls="example2" data-dt-idx="7" tabindex="0"
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
