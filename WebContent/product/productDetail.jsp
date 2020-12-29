<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="product_number" value="${param.product_number}" />

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
	<sql:param value="${product_number}"/>
</sql:query>
<c:forEach items="${products.rows}" var="product" begin="0" end="1">
	<c:set var="country" value="${product.country_kr_name }" />
	<c:set var="city" value="${product.city_kr_name }" />
	<c:set var="market" value="${product.market_kr_name }" />
	<c:set var="product_name" value="${product.product_name }" />
	<c:set var="product_image" value="${product.product_img }" />
</c:forEach>

<script>
	var xhr = null;
	$(document).ready(function() {
		xhr = new XMLHttpRequest();
		
		$("#selCountry").val($('#country').val()).prop("selected", true);
		selCity();
		$('.openModal').on('click', function() {
			var country = $('#country').val();
			if(country == '라오스'){
				$('#currency').html("킵");
			}else if(country == '말레이시아'){
				$('#currency').html("링깃");
			}else if(country == '베트남'){
				$('#currency').html("동");
			}else if(country == '싱가폴'){
				$('#currency').html("싱가포르 달러");
			}else if(country == '태국'){
				$('#currency').html("바트");
			}
			
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
			var country = $(this).val();
			if(country == '라오스'){
				$('#currency').html("킵");
			}else if(country == '말레이시아'){
				$('#currency').html("링깃");
			}else if(country == '베트남'){
				$('#currency').html("동");
			}else if(country == '싱가폴'){
				$('#currency').html("싱가포르 달러");
			}else if(country == '태국'){
				$('#currency').html("바트");
			}
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
				//$(this).submit();
				xhr.onreadystatechange = function(){
						alert("가격정보가 등록되었습니다.");    //4
						history.back();
				}
				xhr.open('POST', 'registerProductPrice.jsp', true);  //2. open()
				xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
				xhr.send('country=' + + country + "&city=" + city + "&market=" + market + "&productName=" + Pname + "&productPrice=" + price + "&userid=admin");     //3.
				 
			 }
			
		});
		
		//검색어 더보기 눌렀을때------------------------------------------
		$('#btnMoredata').on('click',function(){
			let product_name = $('#product').val().trim();
			let marketname = $('#market').val().trim();
			location.href = "exportExcel.jsp?product_name="+product_name+"&marketname="+marketname;
		});
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
.product{
	padding: 0.5vw;
	padding-left: 1vw;
	font-size: 2vw; 
}
.description {
	width: 100%;
	height: 36vh;
	font-size: 1vw;
	resize:none;
}

th {
	text-align: center;
	font-size: 1.1vw;
}
th,td{
	border: 1px solid black;
}

table {
	width: 40%;
	padding:0;
	margin-left: auto; margin-right: auto;
	border: 1px solid black;

}
.closeModal{
	text-align:center;
}
.btn{
	bottom: 1vw;
}
.modalBehind{
	width:100%; height:100%; background: #b0b0b0; display: none; position:absolute; top:0; left:0; z-index:999; opacity:0;
}
</style>

${product_image }
국가<input type="text" id="country" value="${country}"><br>
도시<input type="text" id="city" value="${city}"><br>
시장<input type="text" id="market" value="${market}"><br>
상품명 <input type="text" id="product" value="${product_name }"><br>


<button type="button" class="openModal">가격 올리기</button>
<button id="btnMoredata" > 데이터더보기</button> <!--     ===================================데이터 더보기 버튼 ================================== -->

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
	<!-- <form action="registerProductPrice.jsp" method="POST"> -->
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
					<input type="file" name="product_img" >
				</td>
			</tr>
			<tr>
				<th>상품가격</th>
				<td><input type="number" style="width: 8vw;" step="0.0001" class="exchange" id="KRW" onkeyup="convert('KRW');"  name="product_price" required></td>
				<th>원(한화)</th>
				<span class="currencySpan">
				<td><input type="number" style="width: 8vw;" step="0.0001" class="exchange" id="THB" onkeyup="convert('THB');" required></td>
				
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
				
				<th colspan="2"><span id="currency"></span></th>
				</span>
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
		<button type="button" id="register" class="btn">완료</button>
	</div>
	<!-- </form> -->
</div>