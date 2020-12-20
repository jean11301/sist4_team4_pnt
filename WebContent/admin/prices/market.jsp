<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="../js/jquery-3.5.1.js"></script>

<jsp:useBean id="service" class="com.example.libs.service.MarketService" />
<c:set var="marketList" value="${service.selectPagination((page - 1)*10, 10)}" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="totalCnt" >
	SELECT count(*) AS cnt FROM market
</sql:query>
<c:forEach var="tot" items="${totalCnt.rows}">
	<c:set var="total" value="${tot.cnt}" />
</c:forEach>

<script>
$(function($){
	xhr = new XMLHttpRequest();
	$('#searchMarket').on('click', function(){
		xhr.onreadystatechange = getMarket;     //4
		xhr.open('POST', 'getMarketlist.jsp', true);  //2. open()
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		if($('#searchKeyword').val() == null) $('#searchKeyword').val() =" ";
		let param = 'searchWith=' + $('#searchWith').val() + 
        			'&keyword=' + $('#searchKeyword').val();
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
	
	 $('.page-link').on('click', function(){
		var page= $(this).data('dtIdx');
		xhr.onreadystatechange = function(){
			$('#listDiv').empty();
			fnPaging(page);
			getMarket();     //4
		}
		xhr.open('POST', 'pagination.jsp', true);  //2. open()
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		let param ='page=' + page;
		xhr.send(param);     //3.  
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
function fnPaging(page) {
    $("#page_select").val(page);
    $("#pagingForm").attr("action", $("#pagingAddr").val()).submit();
}
function getPage() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		$('#pageDiv').html("<tr><td>Nodata<td></tr>");
	}
}
</script>
<c:set var="marketList" value="${service.selectPagination((page - 1)*10, 10)}" />
<form id="pagingForm" action="market.jsp" method="post">
    <input type="hidden" id="page_select" name="page_select"/>
</form>

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
							<h3 class="card-title">전체 ${total}건</h3>
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
												<c:forEach items="${marketList}" var="market">
													<tr>
														<td><input type="checkbox" class="selMarket" value="${market.market_number}"/></td>
														<td>${market.country_kr_name}</td>
														<td>${market.city_kr_name}</td>
														<td>${market.market_kr_name}</td>
														<td>${market.market_en_name}</td>
														<td><a href="updateMarket.jsp?market_number=${market.market_number}" >수정하기</a></td>
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
											aria-live="polite">Showing ${(page) * 10 + 1} to ${(page + 1)*10} of ${total} entries</div>
									</div>
									<div class="col-sm-12 col-md-7">
										<div class="dataTables_paginate paging_simple_numbers"
											id="example2_paginate">
											<ul class="pagination">
											
											<!-- 현재페이지 -->
										    <c:set var="page" value="${pagingResult.page_select + 1}"/> <!-- 폼을 통해 넘겨받은 현재페이지 값을 불러온다. -->
										    <!-- 게시글 수 -->
										    <c:set var="listCount" value="10"/>
										    <!-- 페이지 수 -->
										    <c:set var="listPage" value="10"/>
										    <!-- 전체게시글 수 -->
										    <c:set var="totalCount" value="${total}"/> <!-- 총 게시글 리스트 값을 불러온다. -->
										    <!-- 전체페이지 수 -->
										    <c:set var="cnt1" value="${(totalCount + 0.0) / (10 + 0.0)}" />
										    <c:set var="cnt2" value="${(totalCount) % 10}" />
										    
										    <c:if test="${cnt2 eq 0 }">
										    <c:set var="totalPage" value="${cnt1}"/>
										   	</c:if>
										    <c:if test="${cnt2 ne 0 }"> 
										    <c:set var="totalPage" value="${cnt1 + 1}"/>
										    </c:if>
										    <!-- 페이지 생성 시작값 -->
										    <c:set var="startPage" value="1"/>
										    <!-- 페이지 생성 종료값 -->
										    <c:set var="endPage" value="${totalPage}"/>
										    
										    <!-- 전체 페이지 수가 페이지 수보다 클 때 -->
										    <c:if test="${totalPage gt listPage}">
										        <c:set var="listPage" value="${endPage}"/>
										    </c:if>
										    
										    <!-- 현재페이지가 페이지 수보다 크거나 같을 때 -->
										    <c:if test="${page ge listPage}">
										        <c:set var="startPage" value="${(page / listPage - (page / listPage) % 1) * listPage}"/>
										        <c:set var="endPage" value="${startPage + listPage}"/>
										        
										        <!-- 현재페이지가 끝 페이지일 때 -->
										        <c:if test="${page ge ((totalPage / listPage - (totalPage / listPage) % 1) * listPage)}">
										            <c:set var="endPage" value="${totalPage}"/>
										        </c:if>
										    </c:if>
										    
										    <!-- 현재페이지가 마지막 페이지일 때 -->
										    <c:if test="${page mod listPage eq 0}">
										        <c:set var="startPage" value="${page}"/>
										        <c:set var="endPage" value="${page + listPage}"/>
										        
										        <c:if test="${(page + listPage) ge totalPage}">
										            <c:set var="endPage" value="${totalPage}"/>
										        </c:if>
										    </c:if>
										    
												<li class="paginate_button page-item previous disabled" id="example2_previous">
													<a href="#" aria-controls="example2" data-dt-idx="0" tabindex="0"
														class="page-link pre" <c:if test="${page gt '1'}">onclick="fnPaging(${page - 1});"</c:if>>Previous</a></li>
												
												<c:forEach begin="${startPage}" end="${endPage}" step="1" var="nowPage">
													
											        <c:choose>
											            <c:when test="${nowPage eq page}">
											                <%-- <strong onclick="fnPaging(${nowPage});">${nowPage}</strong> --%>
											                <li id="eqPage" class="paginate_button page-item active">
											                <a href="#" aria-controls="example2" data-dt-idx="${nowPage}"
																tabindex="0" class="page-link" >${nowPage}</a></li>
											            </c:when>
											            <c:otherwise>
											                <%-- <a href="#" onclick="fnPaging(${nowPage});">${nowPage}</a> --%>
											                <li class="paginate_button page-item">
											                <a href="#" aria-controls="example2" data-dt-idx="${nowPage }" tabindex="0"
																class="page-link" >${nowPage}</a></li>
											            </c:otherwise>
											        </c:choose>
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
													
												<li class="paginate_button page-item next" id="example2_next">
													<a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0"
														class="page-link next" <c:if test="${page lt totalPage}">onclick="fnPaging(${page + 1});"</c:if>>Next</a></li>
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
