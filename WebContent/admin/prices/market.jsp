<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="../js/jquery-3.5.1.js"></script>

<jsp:useBean id="service" class="com.example.libs.service.MarketService" />
<c:set var="marketList" value="${service.selectAllMarket()}" />
<c:set var="count" value="${service.getTotalCount()}" />

<c:set var="currentPage" value="${param.page}" />
<c:set var="pageSize" value="10" />
<c:set var="totalPage" value="${service.getTotalPage(pageSize)}" />

<script>
$(function($){
	xhr = new XMLHttpRequest();
	$('#searchMarket').on('click', function(){
		xhr.onreadystatechange = function(){
			alert("보내기 성공");
			getMarket;     //4
		}
		xhr.open('POST', 'getMarketlist.jsp', true);  //2. open()
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		if($('#searchKeyword').val() == null) $('#searchKeyword').val() =" ";
		let param = 'searchWith=' + $('#searchWith').val() + 
        			'&keyword=' + $('#searchKeyword').val();
        			/* '&page=1'; */
		xhr.send(param);   //3. send()
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
											<c:if test="${marketList.size() == 0 }">
												<tr>
													<td colspan="6" class="text-center">No Data</td>
												</tr>
											</c:if>
											<c:if test="${marketList.size() > 0 }">
												<c:set var="begin" value="${(currentPage - 1) * pageSize}" />
												<c:set var="end" value="${begin + pageSize - 1}" />
												<c:forEach items="${marketList}" var="market" begin="${begin}" end="${end}">
													<tr>
														<td><input type="checkbox" class="selMarket" value="${market.market_number}"/></td>
														<td>${market.country_kr_name}</td>
														<td>${market.city_kr_name}</td>
														<td>${market.market_kr_name}</td>
														<td>${market.market_en_name}</td>
														<td><a href="updateMarket.jsp?market_number=${market.market_number}" >수정하기</a></td>
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
													<a href="market.jsp?page=${currentPage - 1}" aria-controls="example2" data-dt-idx="0" tabindex="0"
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
											               <a href="market.jsp?page=${i}" aria-controls="example2" data-dt-idx="${i}"
																tabindex="0" class="page-link" >${i}</a></li>
													</c:if>
											    </c:forEach>
													
												<!-- <li class="paginate_button page-item active"><a
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
													class="page-link">6</a></li> -->
												<c:if test="${currentPage eq totalPage}">	
												<li class="paginate_button page-item next disable" id="example2_next">
													<a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0"
														class="page-link next" >Next</a></li>
												</c:if>
												<c:if test="${currentPage ne totalPage}">	
												<li class="paginate_button page-item next" id="example2_next">
													<a href="market.jsp?=${currentPage + 1}" aria-controls="example2" data-dt-idx="7" tabindex="0"
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
