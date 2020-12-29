<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../main/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<sql:query dataSource="${conn}" var="rs">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="../js/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">

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
			//console.log(param);
			xhr.send(param);   //3. send()
			//==========================
			let product_name = $('#txtProduct').val().trim();
			//console.log(product_name);
			let marketname = $('#selmarket_kr_name').val().trim();
			console.log(marketname);
			if(product_name == ""){   //검색어 없이 검색을 눌렀을때 선택한 시장의 좌표에 마커 
			    $.ajax({
			      method : 'POST',
			      contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			      url : 'getlatlon.jsp',
			      data : {
			    	  marketname : marketname
			      },
			      success : function(data){
			          drawMarkers(data);
			      }
			    });
			    
			}else if(marketname != "" && product_name != ""){  //지역선택까지 하고 검색을 눌렀을때 검색어가 있는 시장만
				$.ajax({
				      method : 'POST',
				      contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
				      url : 'getlatlonifsearchwithcity.jsp',
				      data : {
				    	  marketname : marketname,
				    	  product_name : product_name
				      },
				      success : function(data){
				          drawMarkers(data);
				      }
				    });
			}
			else{   //검색어가 있을 경우 검색한 물품이 있는 시장에 마커
				console.log(product_name);
				$.ajax({
				      method : 'POST',
				      contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
				      url : 'getlatlonifsearchin.jsp',
				      data : {
				    	  product_name : product_name
				      },
				      success : function(data){
				          drawMarkers(data);
				      }
				    });
			}
		});   

	$('#btnSearch').trigger('click'); 
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

</head>
<body>

	<div class="container-fluid" style="margin:25px 0px 0px 0px">
	<form id="frmZip" name="frmZip">
	
	<div class="row">
		<div class="col-sm-2 side_search">
			<form>
				<div class="form-group pd-5">
				<label for="sel1" style="font-size:20px;">나라선택</label>
					<select name="country_kr_name" id="selcountry_kr_name" class="form-control">
						<option value="">나라 선택 </option>
						<c:forEach items="${rs.rows}" var="row">
							<option value="${row.country_kr_name}">${row.country_kr_name}</option>
						</c:forEach>
					</select><br>
					<div id="city_kr_nameDiv">
						<select name="city_kr_name" id="selcity_kr_name" class="form-control">
							<option value="">지역선택</option>
						</select>
					</div><br>
				<div id="market_kr_nameDiv">
						<select name="market_kr_name" id="selmarket_kr_name" class="form-control">
							<option value="">시장선택</option>
						</select>
					</div><br><br><br>
					
				<div>
				상품명 : &nbsp;&nbsp;<input type="text" name="product" id="txtProduct" style="color:black; width:220px; height:35px;" placeholder="상품명을 입력하세요." />
				</div><br>
				<div align="right">
					<input class="btn btn-primary"type="button" value="상품검색" id="btnSearch" />
				</div>	
				
			</div>
			</form>
			</div>
			<c:import url="product.jsp"></c:import>
			</div>
			
	 	</form>
	
			
	<div id="result"></div>
</div>


<jsp:include page="../main/footer.jsp" />