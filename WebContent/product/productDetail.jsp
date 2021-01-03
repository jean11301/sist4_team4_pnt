<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="../js/script.js"></script>

<c:set var="product_number" value="${param.product_number}" />
<c:set var="product_number2" value="${param.product_number}" />

<link rel="stylesheet" href="../css/bootstrap.css" />
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../js/jquery-3.5.1.js"></script>
<fmt:requestEncoding value="utf-8" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="countries">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>
<sql:query dataSource="${conn}" var="products">
	SELECT country_kr_name, city_kr_name, market_kr_name, product_name, product_img
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country 
	WHERE product_number = ?
	<sql:param value="${product_number}" />
</sql:query>
<c:forEach items="${products.rows}" var="product" begin="0" end="1">
	<c:set var="country" value="${product.country_kr_name }" />
	<c:set var="city" value="${product.city_kr_name }" />
	<c:set var="market" value="${product.market_kr_name }" />
	<c:set var="product_name" value="${product.product_name }" />
	<c:set var="product_image" value="${product.product_img }" />
</c:forEach>


<!-- 시장가 -->
<sql:query dataSource="${conn}" var="productview">
select avg(PRODUCT_PRICE)  as product_price, max(PRODUCT_PRICE) as topprice
from product NATURAL JOIN MARKET
where MARKET_NUMBER = (SELECT MARKET_NUMBER
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country 
        WHERE product_number = ?)
    AND product_name like (SELECT product_name
        FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country 
        WHERE product_number = ?) 
	<sql:param value="${product_number}" />
	<sql:param value="${product_number2}" />
</sql:query>
<c:forEach items="${productview.rows}" var="product">
	<c:set var="product_price" value="${product.product_price }" />
</c:forEach>

<!-- 최근한달 최저가-최고가 MIN-MAX / 값이 하나일경우 MIN과 MAX가 같다 / 값이 없을경우 0 처리 -->
<sql:query dataSource="${conn}" var="productprice">
select NVL(max(PRODUCT_PRICE), 0)as topprice, NVL(min(PRODUCT_PRICE), 0) as rowprice
from product NATURAL JOIN MARKET
where MARKET_NUMBER = (SELECT MARKET_NUMBER
	FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country 
        WHERE product_number = ?)
    AND product_name like (SELECT product_name
        FROM product NATURAL JOIN MARKET NATURAL JOIN city NATURAL JOIN country 
        WHERE product_number = ?)
    AND product_date>=TO_CHAR((SELECT MAX(product_date) FROM product)-30, 'YYYYMMDD')
    <sql:param value="${product_number}" />
	<sql:param value="${product_number2}" />
</sql:query>
<c:forEach items="${productprice.rows}" var="product">
	<c:set var="topprice" value="${product.topprice }" />
	<c:set var="rowprice" value="${product.rowprice }" />
</c:forEach>

<jsp:include page="../main/header.jsp" />


<script>
	var xhr = null;
	$(document).ready(function() {
		xhr = new XMLHttpRequest();
		
		$("#selCountry").val($('#country').val()).prop("selected", true);
		selCity();
		$('.openModal').on('click', function() {
			$("#selCity").val($('#city').val()).prop("selected", true);
			selMarket();
			$("#product_name").val($("#product").val()).prop("selected", true);
			
			$('.modal').css({ "display" : "block"});
			$('.modalBehind').css({"display" : "block"});
			
		});
		
		$('.modalBehind').on('click', function() {
			$('.modal').css({"display" : "none"});
			$('.modalBehind').css({"display" : "none"});
		});
		
		$('.closeModal').on('click', function() {
			$('.modal').css({"display" : "none"});
		});
		
		$('#selCountry').on('change', function() {
			selCity();
			/* selCurrencyType(); */
		});

		function selCity(){
			var selectedCountry = $('#selCountry:selected').val();
			if(selectedCountry == "국가명"){
				$('#selCity').html("<option>도시명</option>");
			}else{
				xhr.onreadystatechange = getCity;     //4
				xhr.open('POST', 'getCitylist_registerProduct.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + selectedCountry);     //3.
			}
		}
		function getCity() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#citySpan').html(xhr.responseText.trim());
			}
		}
		function selCurrencyType(){
			var selectedCountry = $('#selCountry:selected').val();
			if(selectedCountry == "국가명"){
				$('#currencySpan').html("<td><input type='number' disabled='true'/></td><td></td>");
			}else{
				xhr.onreadystatechange = getCity;     //4
				xhr.open('POST', 'getCurrencyType_registerProduct.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + selectedCountry);     //3.
			}
		}
		function getCurrencyType() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#currencySpan').html(xhr.responseText.trim());
			}
		}
		function selMarket(){
			var selectedCity = $('#selCity:selected').val();
			if(selectedCity == "도시명"){
				$('#selMarket').html("<option>시장명</option>");
			}else{
				xhr.onreadystatechange = getMarket;     //4
				xhr.open('POST', 'getMarketlist_registerProduct.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('city=' + selectedCity + '&market=' + $('#market').val());     //3.
			}
		}
		function getMarket() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				$('#marketSpan').html(xhr.responseText.trim());
			}
		}
		
		$('#register').on('click', function(){
			
			
			
			
			 var country = $('#selCountry:selected').val();
			 var city = $('#selCity:selected').val();
			 if(city == $('#selCity').find(':selected').val()) {city = $('#city').val();
			 } else {city = $('#selCity').find(':selected').val();}
			 var market = $('#selMarket:selected').val();
			 if(market == $('#selMarket').find(':selected').val()) {market = $('#market').val();
			 } else {market = $('#selMarket').find(':selected').val();}
			 var Pname = $('#product_name').val();
			 var price = $('#KRW').val();
			
			 if(confirm("입력하신 정보가 [" + country + " , " + city + " , " + market + " , " + Pname + " , " + price +"]이 맞습니까?")){
				$(this).submit();
				 alert("가격정보가 등록되었습니다.");
			 }
			
		});
		//======================================================데이터 더보기
		$('#btnMoredata').on('click',function(){
			let product_name = $('#product').val().trim();
			let marketname = $('#market').val().trim();
			location.href = "exportExcel.jsp?product_name="+product_name+"&marketname="+marketname;
		});
			

	//======================================== 차트
			
	
		getchart2();
		getchart1();
		//차트 1에 필요한 DB
		function getchart1(){
			let product_name = $('#product').val().trim();
			let marketname = $('#market').val().trim()
			$.ajax({
			      method : 'POST',
			      contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			      url : 'getchart1.jsp',
			      data : {
			    	  marketname : marketname,
			    	  product_name : product_name
			      },
			      success : function(data){
			          chart1(data);}
			    });
		}
		//차트 2에 필요한 DB
		function getchart2(){
			let product_name = $('#product').val().trim();
			let marketname = $('#market').val().trim()
			
			$.ajax({
			      method : 'POST',
			      contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
			      url : 'getchart2.jsp',
			      data : {
			    	  marketname : marketname,
			    	  product_name : product_name
			      },
			      success : function(data){
			    	  //$("#chartContainer2").CanvasJSChart(data);
			          chart2(data);}
					//}
			    });
		}
	
		
		function chart1(serverdata){
			let idx = serverdata.lastIndexOf(",");
			let location = null;
			if(idx > -1) location = serverdata.substring(0, idx) + "] }"; 
			else location = serverdata;
			location = location.trim();		
			//console.log(location);
			var obj = JSON.parse(location);
			var array = obj.data;
			//불러온 데이터 json으로 변환 후 map형식으로 키 : 값으로 변환
			const addData = array.map(item => ({
		        y: item.count,
			    label: item.price
			    }));
			//console.log(addData);
			//canvas js에 변환한 map형식의 데이터를 넣기
			
			var chart = new CanvasJS.Chart("chartContainer1",
					{
						animationEnabled: true,
						theme: "light2",
						title:{
							text: "6개월 간 가격대별 구매자 분포도"
						},
						axisY:{
							valueFormatString: " "		
						},
						axisX:{
							suffix: "KRW~"				
						},
						toolTip: {
							shared: true
						},
						legend:{
							verticalAlign: "top",
							horizontalAlign: "center"
						},
						data: [
						{     
							type: "stackedBar",
							showInLegend: true,
							name: "구매인원",
							axisYType: "secondary",
							color: "#62C9C3",
							dataPoints: addData
						}
						]
					});
			chart.render();
		};
		
		

		function chart2(serverdata){
			
			let idx = serverdata.lastIndexOf(",");
			let location = null;
			if(idx > -1) location = serverdata.substring(0, idx) + "] }"; 
			else location = serverdata;
			location = location.trim();		
			//console.log(location);
			var obj = JSON.parse(location);
			var array = obj.data;
			//불러온 데이터 json으로 변환 후 map형식으로 키 : 값으로 변환
			const addData = array.map(item => ({
		        x: new Date(item.product_date),
			    y: item.product_price
			    }));
			//console.log(addData);
			//canvas js에 변환한 map형식의 데이터를 넣기
			var chart = new CanvasJS.Chart("chartContainer2",
				    {
			      	  title:{
			          text:  "최근 6개월 간 가격 변동 추이"
			          },
				 	 axisX:{
					 valueFormatString:  "YYYY MM DD"   // move comma to change formatting
					 },
					 axisY: {
							suffix: "KRW"
					 },
				     data: [
				     {

						type: "spline",

				        dataPoints: addData
				      }
				      ]
				    });

		    chart.render();
		
		}
	});
	
	
	
</script>
<style>
.modal {
	background-color: white;
	display: none;
	position: absolute;
	width: 50vw;
	height: 80vh;
	border: 2px solid black;
	left: 20%;
}

.product {
	padding: 0.5vw;
	padding-left: 1vw;
	font-size: 2vw;
}

.description {
	width: 100%;
	height: 36vh;
	font-size: 1vw;
	resize: none;
}

th {
	text-align: center;
	font-size: 1.1vw;
}

th, td {
	border: 1px solid black;
}

table {
	width: 40%;
	padding: 0;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid black;
}

.closeModal {
	text-align: center;
}

.btn {
	bottom: 1vw;
}

.modalBehind {
	width: 100%;
	height: 100%;
	background: #b0b0b0;
	display: none;
	position: absolute;
	top: 0;
	left: 0;
	z-index: 999;
	opacity: 0;
}
.rightbox{padding:2% 0;}
.rightbox-img{overflow: hidden;}
.rightbox-img img{width:100%;}
.style1{font-weight:bold; font-size:2.2rem;}
.style2{    text-align: right;}
.style2-1{    font-weight: bold; color: #e23131; font-size: 2.2rem;}
.style2-2{font-size:1.6rem; color:#666;}
.style3{text-align:right; padding-right:16px;    font-size: 1.3rem;}
.style4{text-align:right; margin:3% 0;}
.style4-1{border:1px solid #CCC; text-align:center; line-height:40px; font-size:1.5rem;}
.style4-2{border:1px solid #CCC; border-left: 0;}
.btnbox{float:right;    }
</style>
<script src="https://kit.fontawesome.com/5fa9fbc7d7.js" crossorigin="anonymous"></script>
<div class="container" style="margin-top: 30px;">
	<!-- title -->
	<title>${product_name }상세정보</title>
	<h5 class="row">
		<strong>${country} > ${city} > ${market} </strong>
	</h5>
	<h3 class="row">
		<strong>${product_name } 상세보기</strong>
		<hr>
	</h3>

	<div class="row">
		<!-- 지도 -->
		<div class="col-xs-12 col-sm-12 col-md-5 col-lg-5 pnt_map pd-5">
			<jsp:include page="map_ex.html" />
		</div>

		<!-- 상품정보 -->
		<div class="col-xs-12 col-sm-12 col-md-7 col-lg-7 rightbox">
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 rightbox-img">
				${product_image }
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
			
					<div style="display:none;">
						  국가<input type="text" id="country"
						value="${country}">
						<br> 도시<input type="text" id="city"
						value="${city}"><br> 시장<input type="text" id="market"
						value="${market}"><br> 상품명 <input type="text"
						id="product" value="${product_name }"><br>
					</div>
					
					<div class="row">
						<div class="col-xs-6 style1">시장가</div>
						<div class="col-xs-6 style2">
							<div class="style2-1" id="korwon" value="${product_price }">${product_price }원</div>
							<div class="style2-2" id="exchange" value="${country}"></div>
						</div>
					</div>
					
					<hr>
					
					<div class="row style3"><i class="fas fa-exclamation-circle" style="padding:0 4px 0 0"></i>최근 한 달 간의 최고가와 최저가</div>
					<div class="row style4">
						<div class="col-xs-4"></div>
						<div class="col-xs-4 style4-1">최고가</div>
						<div class="col-xs-4 style4-2">
							<div id="topprice" value="${topprice }">${topprice }원</div>
							<div id="toppricechange">32.00바트</div>
						</div>
					</div>
					<div class="row style4">
						<div class="col-xs-4"></div>
						<div class="col-xs-4 style4-1">최저가</div>
						<div class="col-xs-4 style4-2">
							<div id="rowprice" value="${rowprice }">${rowprice }원</div>
							<div id="rowpricechange">32.00바트</div>
						</div>
					</div>
				
				<div class="btnbox">
					<button type="button" class="openModal btn btn-primary" style="padding:6px 30px">가격 올리기</button>
					<button id="btnMoredata" class="btn btn-success">데이터 더보기</button>
				</div>
				
			</div>
		</div>

<<<<<<< HEAD
<button type="button" class="openModal">가격 올리기</button>
<button id="btnMoredata" > 데이터더보기</button><!-- ============================================= 데이터 더보기 =============================================== -->
<div>
<div id="chartContainer1" style="height: 370px; width: 50%;"></div>
<div id="chartContainer2" style="height: 370px; width: 50%;"></div>
</div>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
=======
	</div>
	<!-- End row -->
>>>>>>> bd2d40a91df02740db7c8c8252ee018053ebbb5c

<hr>


<style>
	.databox{height:210px;}
</style>


	<!-- ============================================= 데이터 더보기 =============================================== -->
	<div class="row" style="margin-top:20px;">
		<div class="row">
			<div id="chartContainer1"  class="col-sm-12 databox"></div>
		</div>
		<hr />
		<div class="row" style="padding-bottom:20px;">
			<div id="chartContainer2"  class="col-sm-12 databox"></div>
		</div>
	</div>
<<<<<<< HEAD
	<form action="registerProductPrice.jsp" method="POST">
	<div class="row">
		<table class="table tavle-bordered">
			<tr>
				<th>국가(한글)</th>
				<td><select id="selCountry" name="country_kr_name" required="required">
						<option>국가명</option>
						<c:forEach items="${countries.rows}" var="country">
							<option value="${country.country_kr_name}">${country.country_kr_name}</option>
						</c:forEach>
				</select></td>
				<th>도시(한글)</th>
				<td>
					<span id="citySpan">
						<select id="selCity" name="city_kr_name" required="required">
							<option value="">도시명</option>
							<c:forEach items="${cities.rows}" var="city">
								<option value="${city.city_kr_name}">${city.city_kr_name}</option>
							</c:forEach>
						</select>
					</span>
				</td>
				<th>시장</th>
				<td>
					<span id="marketSpan">
						<select id="selMarket" name="market_kr_name">
							<option value="">시장명</option>
						</select>
					</span>
				</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td colspan="5">
					<input type="text" id="product_name" required="required">
				</td>
			</tr>
			<tr>
				<th>이미지</th>
				<td colspan="6">
					<input type="file" name="FileName" >
				</td>
			</tr>
			<tr>
				<th>상품가격</th>
				<td><input type="number" style="width: 8vw;" class="exchange" id="KRW" onkeyup="convert('KRW');" required></td>
				<th>원(한화)</th>
				<td>
				
					<c:if test="${row.country_kr_name eq '태국' }">
						<div id="test"><input type="number" style="width: 8vw;" class="exchange" id="THB" onkeyup="convert('THB');" required></div>
					</c:if>
					<c:if test="${row.country_kr_name eq '라오스'}">
						<div id="test1"><input type="number" style="width: 8vw;" class="exchange" id="LAK" onkeyup="convert('LAK');" required></div>
					</c:if>
					<c:if test="${row.country_kr_name eq '말레이시아'}">
						<div id="test2"><input type="number" style="width: 8vw;" class="exchange" id="MYR" onkeyup="convert('MYR');" required></div>
					</c:if>
					<c:if test="${row.country_kr_name eq '베트남'}">
						<div id="test3"><input type="number" style="width: 8vw;" class="exchange" id="VND" onkeyup="convert('VND');" required></div>
					</c:if>
					<c:if test="${row.country_kr_name eq '싱가폴'}">
						<div id="test4"><input type="number" style="width: 8vw;" class="exchange" id="SGD" onkeyup="convert('SGD');" required></div>
					</c:if>
				</td>
				
				
				<script type="text/javascript">
				function convert(currency_type){
					var val = $("#THB").val();
			        if (val) {
						$.ajax({
							url: 'https://api.manana.kr/exchange.json',
							type: 'GET',
						}).done((data, textStatus, jqXHR) => {
							//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
					
							//한개씩 뽑는 테스트
						     var kkk = data.filter(function (item) { return item.name == "USD/THB" });
							 var kkk2 = kkk[0].price;
							 var e =  Math.round(kkk2 * 100) / 100;
							 
							 var kkk11 = data.filter(function (item) { return item.name == "USD/LAK" });
							 var kkk12 = kkk11[0].price;
							 var e11 =  Math.round(kkk12 * 100) / 100; 
							 
							 var kkk21 = data.filter(function (item) { return item.name == "USD/MYR" });
							 var kkk22 = kkk21[0].price;
							 var e21 =  Math.round(kkk22 * 100) / 100; 
							 
							 var kkk31 = data.filter(function (item) { return item.name == "USD/VND" });
							 var kkk32 = kkk31[0].price;
							 var e31 =  Math.round(kkk32 * 100) / 100; 
							 
							 var kkk41 = data.filter(function (item) { return item.name == "USD/SGD" });
							 var kkk42 = kkk41[0].price;
							 var e41 =  Math.round(kkk42 * 100) / 100; 
							 
							
							 
							 var mmm = data.filter(function (item) { return item.name == "USD/KRW" });
							 var mmm2 = mmm[0].price;      // 1096
							//var mmm3 = $( 'div#count table #test' ).text();
							//var mmm3 = $('#test').text();  //4890 
							 var count = $( 'div#count' ).length;
							 
							
							
						/* 	 // 체크박스 배열 Loop
						       $("div#count").each(function(idx){   
						          
						         // 해당 체크박스의 Value 가져오기
						         var value = $(this).text();
						        //  var eqValue = $("#count:eq(" + idx + ")").text() ;
						         console.log(value) ;
						          
						       }); */
							
							
						       $("div#test").each(function(idx){   
						           
						           // 해당 체크박스의 Value 가져오기
						           // var value = $(this).find($('#test')).text();
						            var eqValue = $("div#test:eq(" + idx + ")").text();
						            var test11 = Math.round((eqValue/mmm2*e)* 100) / 100;
						            $("div#test:eq(" + idx + ")").after(test11);;
						           console.log(eqValue) ;
						           $('#THB').val(test11);
						           // $('#change1').append(eqValue);                                        
						        });
						       
	 							$("div#test1").each(function(idx){   
						           
						           // 해당 체크박스의 Value 가져오기
						           // var value = $(this).find($('#test')).text();
						            var eqValue = $("div#test1:eq(" + idx + ")").text() ;
						            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
						            $("div#test1:eq(" + idx + ")").after(test11);;
						           console.log(eqValue) ;
						           $('#LAK').val(test11);
						           // $('#change1').append(eqValue);                                        
						        });
	 							
	 							
	 							$("div#test2").each(function(idx){   
	 					           
	 					           // 해당 체크박스의 Value 가져오기
	 					           // var value = $(this).find($('#test')).text();
	 					            var eqValue = $("div#test2:eq(" + idx + ")").text() ;
	 					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
	 					            $("div#test2:eq(" + idx + ")").after(test11);;
	 					           console.log(eqValue) ;
						           $('#MYR').val(test11);
	 					           // $('#change1').append(eqValue);                                        
	 					        });
	 							
	 							$("div#test3").each(function(idx){   
	 					           
	 					           // 해당 체크박스의 Value 가져오기
	 					           // var value = $(this).find($('#test')).text();
	 					            var eqValue = $("div#test3:eq(" + idx + ")").text() ;
	 					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
	 					            $("div#test3:eq(" + idx + ")").after(test11);;
	 					           console.log(eqValue) ;
						           $('#VND').val(test11);
	 					           // $('#change1').append(eqValue);                                        
	 					        });
						       
	 							$("div#test4").each(function(idx){   
	  					           
	  					           // 해당 체크박스의 Value 가져오기
	  					           // var value = $(this).find($('#test')).text();
	  					            var eqValue = $("div#test4:eq(" + idx + ")").text() ;
	  					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
	  					            $("div#test4:eq(" + idx + ")").after(test11);;
	  					           console.log(eqValue) ;
						           $('#SGD').val(test11);
	  					           // $('#change1').append(eqValue);                                        
	  					        });
	 							
							 //console.log(mmm2); 
							 /* var tai = Math.round((mmm3/mmm2*e)* 100) / 100; 
							  $('#change1').append(tai);   */
							 
							 //console.log($( 'div#count' ).length);
							 //console.log($( 'div#count table #test' ).text());
							 
							
							/*   $( 'div#count table #test' ).ready(function(){
							        console.log("javaScript의 this"+this);
							    })  */
							//적용▼
							//원JSON대로 읽어와 array의 불러오는 순서영향을 받지 않음.
							/* var array = ["USD/THB", "USD/LAK", "USD/MYR", "USD/VND", "USD/SGD"];
							var array2 = [];
							data.filter(function(item){
									for(var i in array){
										if(item.name === array[i]){
											
										 array2[i] = Math.round(item.price * 100) / 100;
										// console.log(array2[i]);//순서 : 태국, 라오스, 말레이시아, 베트남, 싱가폴
										}
									}							
							}); */
							
				
							/* $('#chebox').append(); */
							
							 //if()
							//$('#change1').append(${row.product_price}*array2[0]/1200 + "밧"); 
								
							/* $('#change1').append(${row.product_price}*array2[0]/1200 + "밧");
							$('#change2').append(${row.product_price}*array2[1]/1200 + "킵");
							$('#change3').append(${row.product_price}*array2[2]/1200 + "링깃");
							$('#change4').append(${row.product_price}*array2[3]/1200 + "동");
							$('#change5').append(${row.product_price}*array2[4]/1200 + "달러"); */
					
							}), (jqXHR, textStatus, errorThrown) => {
							console.log('실패')
						};
			        }
				
				}
				</script>
				
				<th colspan="2">
				<span id="currency"></span>
				 왜 <c:out value="${country }" />
					<c:if test="${country eq '태국' }">바트</c:if>
					<c:if test="${country eq '베트남' }">동</c:if>
					<c:if test="${country eq '라오스' }">킵</c:if>
					<c:if test="${country eq '싱가포르' }">싱가포르 달러</c:if>
					<c:if test="${country eq '말레이시아' }">링깃</c:if>
				</th>
			</tr>
			<tr rowspan="4">
				<td colspan="6"><textarea class="description" rows="5" required="required">
	!포인트 > 올리면 100원
	이미지를 올리면 추가로 100원
	그럼 이미지랑 같이 올리게 되면 = 200원 을 적립해드려요.
						
	데이터는 한화를 기준으로 저장됩니다.
	타국 각가격의 시세는 환율을 기준으로 변동되어 저장되니 유의해주세요.
						
	※ 상품 작성시 유의 사항
	1개 혹은 kg단위로 입력 해야합니다.
	상품은 한글로 입력해야 합니다.
	조건 미충족시 포인트 지급되지 않습니다.
	이미지를 올리면 추가 포인트를 드려요.
			</textarea></td>
			</tr>
		</table>
	</div>
	<div class="row text-center" >
		<button type="submit" id="register" class="btn">완료</button>
=======
	<script type="text/javascript"
		src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
	<script type="text/javascript"
		src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>

	<div class="modalBehind"></div>
	<div class="modal">
		<div class="row"></div>
		<div class="row">
			<div class="col-sm-10">
				<p class="product">가격 정보 등록</p>
			</div>
			<div class="col-sm-2">
				<h4 class="closeModal">X</h4>
			</div>
		</div>
		<form action="registerProductPrice.jsp" method="POST">
			<div class="row">
				<table class="table tavle-bordered">
					<tr>
						<th>국가(한글)</th>
						<td><select id="selCountry" name="country_kr_name"
							required="required">
								<option>국가명</option>
								<c:forEach items="${countries.rows}" var="country">
									<option value="${country.country_kr_name}">${country.country_kr_name}</option>
								</c:forEach>
						</select></td>
						<th>도시(한글)</th>
						<td><span id="citySpan"> <select id="selCity"
								name="city_kr_name" required="required">
									<option value="">도시명</option>
									<c:forEach items="${cities.rows}" var="city">
										<option value="${city.city_kr_name}">${city.city_kr_name}</option>
									</c:forEach>
							</select>
						</span></td>
						<th>시장</th>
						<td><span id="marketSpan"> <select id="selMarket"
								name="market_kr_name">
									<option value="">시장명</option>
							</select>
						</span></td>
					</tr>
					<tr>
						<th>상품명</th>
						<td colspan="5"><input type="text" id="product_name"
							required="required"></td>
					</tr>
					<tr>
						<th>이미지</th>
						<td colspan="6"><input type="file" name="FileName"></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td><input type="number" style="width: 8vw;" class="exchange"
							id="KRW" onkeyup="convert('KRW');" required step="0.0000001"></td>
						<th>원(한화)</th>
						<span class="currencySpan">
							<td><input type="number" style="width: 8vw;"
								class="exchange" id="THB" onkeyup="convert('THB');" required step="0.0000001"></td>

							<script type="text/javascript">
					function convert(currency_type){
						//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
						var kr_e = 0;
						var other_e = 0;
						if (currency_type == 'THB') {
							var str = "USD/" + currency_type;
					        var val = $("#THB").val();
					        if (val) {
								$.ajax({
									url: 'https://api.manana.kr/exchange.json',
									type: 'GET',
								}).done((data, textStatus, jqXHR) => {
											        
						        //한개씩 뽑는 테스트
								var kkk = data.filter(function (item) { return item.name == str });
								var kkk2 = kkk[0].price;
								var e =  Math.round(kkk2 * 100) / 100; 
								console.log(e);
						        $('#KRW').val(( val / e ).toFixed(2));
								}), (jqXHR, textStatus, errorThrown) => {
									console.log('실패')
								};   
					        } else{
					        	$('#KRW').val("");
		
					        }
						}
						if (currency_type == 'KRW') {
							var str = "USD/" + currency_type;
					        var val = $("#KRW").val();
					        if (val) {
								$.ajax({
									url: 'https://api.manana.kr/exchange.json',
									type: 'GET',
								}).done((data, textStatus, jqXHR) => {
											        
						        //한개씩 뽑는 테스트
								var kkk = data.filter(function (item) { return item.name == str });
								var kkk2 = kkk[0].price;
								var e =  Math.round(kkk2 * 100) / 100; 
								console.log(e);
						        $('#THB').val((val / e).toFixed(2));
								}), (jqXHR, textStatus, errorThrown) => {
									console.log('실패')
								};   
					        } else{
					        	$('#THB').val("");
		
					        }
						}
					
					}
					</script>

							<th colspan="2"><span id="currency"></span> 왜 <c:out
									value="${country }" /> <c:if test="${country eq '태국' }">바트</c:if>
								<c:if test="${country eq '베트남' }">동</c:if> <c:if
									test="${country eq '라오스' }">킵</c:if> <c:if
									test="${country eq '싱가포르' }">싱가포르 달러</c:if> <c:if
									test="${country eq '말레이시아' }">링깃</c:if></th>
						</span>
					</tr>
					<tr rowspan="4">
						<td colspan="6"><textarea class="description" rows="5"
								required="required">
		!포인트 > 올리면 100원
		이미지를 올리면 추가로 100원
		그럼 이미지랑 같이 올리게 되면 = 200원 을 적립해드려요.
							
		데이터는 한화를 기준으로 저장됩니다.
		타국 각가격의 시세는 환율을 기준으로 변동되어 저장되니 유의해주세요.
							
		※ 상품 작성시 유의 사항
		1개 혹은 kg단위로 입력 해야합니다.
		상품은 한글로 입력해야 합니다.
		조건 미충족시 포인트 지급되지 않습니다.
		이미지를 올리면 추가 포인트를 드려요.
				</textarea></td>
					</tr>
				</table>
			</div>
			<div class="row text-center">
				<button type="submit" id="register" class="btn">완료</button>
			</div>
		</form>
>>>>>>> 77ba3004592d42eda4e1ffc4df4237ca2c7441dc
	</div>
</div>
<!-- END container -->



<jsp:include page="../main/footer.jsp" />