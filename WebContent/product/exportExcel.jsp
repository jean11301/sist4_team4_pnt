<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList, com.example.libs.model.ProductVO" %>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="service"
	class="com.example.libs.service.PopularService" />
<!--전달받은 검색어 가져오기  -->
<fmt:requestEncoding value="utf-8" />
<!--product DB에서 검색어 기준 내용 가져오기-->
<%
	String productname = request.getParameter("product_name");
	String marketname = request.getParameter("marketname");
	
	ArrayList<ProductVO> list = service.selectOne(productname, marketname);
	ProductVO pro = new ProductVO();		
%>

<script>
	var xhr = null;
	$(document).ready(function(){

		xhr = new XMLHttpRequest();  //1. 객체 생성
		$('#selcountry_kr_name').on('change', function(){
			xhr.onreadystatechange = getCity;     //4
			xhr.open('POST', 'getlocallist.jsp', true);  //2. open()
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			xhr.send('country_kr_name=' + $(this).val());     //3.
		});
		
		$('#btnSearch').on('click', function(){
			xhr.onreadystatechange = getProduct;    //4.
			xhr.open('POST', 'getProductlist.jsp', true);   //2. open()
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			let param = 'country=' + $('#selcountry_kr_name').val().trim() + 
			            '&city=' + $('#selcity_kr_name').val().trim() +
			            '&market=' + $('#selmarket_kr_name').val().trim() + 
			            '&product=' + $('#txtProduct').val().trim();
		});
	});
	function getCity(){
		if(xhr.readyState == 4 && xhr.status == 200){
			$('#city_kr_nameDiv').html(xhr.responseText.trim());
		}
	}
	function getMarket(){
		if(xhr.readyState == 4 && xhr.status == 200){
			$('#market_kr_nameDiv').html(xhr.responseText.trim());
		}
	}
	function getProduct(){
		if(xhr.readyState == 4 && xhr.status == 200){
			$('#result').html(xhr.responseText.trim());
		}
	}
	
</script>
<jsp:include page="../main/header.jsp" />
<script type="text/javascript" src="../js/jquery.table2excel.js"></script>
<div class="container-fluid" style="margin: 0 0 0 0">
	<form id="frmZip" name="frmZip">

		<div class="row">
			<div class="col-sm-2 side_search">
				<form>
					<div class="form-group pd-5">
						<label for="sel1" style="font-size: 20px;">나라선택</label> <select
							name="country_kr_name" id="selcountry_kr_name"
							class="form-control">
							<option value="">나라 선택</option>
							<c:forEach items="${rs.rows}" var="row">
								<option value="${row.country_kr_name}">${row.country_kr_name}</option>
							</c:forEach>
						</select><br>
						<div id="city_kr_nameDiv">
							<select name="city_kr_name" id="selcity_kr_name"
								class="form-control">
								<option value="">지역선택</option>
							</select>
						</div>
						<br>
						<div id="market_kr_nameDiv">
							<select name="market_kr_name" id="selmarket_kr_name"
								class="form-control">
								<option value="">시장선택</option>
							</select>
						</div>
						<br> <br> <br>

						<div>
							상품명 : &nbsp;&nbsp;<input type="text" name="product"
								id="txtProduct"
								style="color: black; width: 220px; height: 35px;"
								placeholder="상품명을 입력하세요." />
						</div>
						<br>
						<div align="right">
							<input class="btn btn-primary" type="button" value="상품검색"
								id="btnSearch" />
						</div>

					</div>
				</form>
			</div>
			<div class="container"
				style="width:50%; margin-top: 10%;">
				<div class="row">
				<h3><%=marketname%>시장</h3>
				<br>
				<h1>'<%=productname%>' 데이터</h1>
				<br>
				<br>
					<table class="table table-bordered" style="width:100%" id="tblExport">
						<thead>
							<th>No</th>
							<th>나라</th>
							<th>지역</th>
							<th>시장</th>
							<th>품목</th>
							<th>가격</th>
							<th>등록날짜</th>
							<th>등록자</th>
						</thead>
						<tbody>
							<%if(list==null){ 
							%>
								<tr>
									<td colspan="8" class="text-center">No Data</td>
								</tr>

							<% }else{ 
								for(int i = 0; i<list.size();i++){
									int count = i+1;
									pro = list.get(i);
									%>
									<tr>
										<td><%=pro.getSequence() %></td>
										<td><%=pro.getCountry_kr_name()%></td>
										<td><%=pro.getCity_kr_name()%></td>
										<td><%=pro.getMarket_kr_name()%></td>
										<td><%=pro.getProduct_name()%></td>
										<td><%=pro.getProduct_price()%></td>
										<td><%=pro.getProduct_date()%></td>
										<td><%=pro.getUser_id()%></td>
									</tr>
							<%	 }
							   }
							%>
						</tbody>
					</table>
					<button id='btnExport' type='button'>Export</button>

					<script> //-------------------------------------------------------임시

					$(document).ready(function(){ 
						$('#btnExport').click(function(){ 
							$("#tblExport").table2excel({
							    exclude: ".excludeThisClass",
							    name: "Worksheet Name",
							    filename: "productList.xls", // do include extension
							    preserveColors: false // set to true if you want background colors and font colors preserved
							});
							
							
							
							
							//var a = document.createElement('a');
					        //var data_type = 'data:application/vnd.ms-excel';
					        //var table_html = encodeURIComponent($("#tblExport").text());
					        //a.href = data_type + ', ' + table_html;
					        //a.download = 'productList.txt';
					       
					       // a.click();
					        //e.preventDefault();

						});
					}); 
					</script>


				</div>
			</div>
		</div>
	</form>
</div>





		
<jsp:include page="../main/footer.jsp" />