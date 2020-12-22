<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="../css/bootstrap.css" />
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../js/jquery-3.5.1.js"></script>
<fmt:requestEncoding value="utf-8" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="countries">
	SELECT country_kr_name FROM country ORDER BY country_kr_name
</sql:query>


<%-- <jsp:useBean id="service" class="com.example.libs.service.MarketService" />
<sql:query dataSource="${conn}" var="cities">
	SELECT city_kr_name 
	FROM COUNTRY NATURAL JOIN city
	WHERE country_kr_name = ?
	ORDER BY city_kr_name
	<sql:param value="${}" />
</sql:query> --%>	
	
<script>
	var xhr = null;
	$(document).ready(function() {
		xhr = new XMLHttpRequest();
		$("#selCountry").val($('#country').val()).prop("selected", true);
		selCity();
		//selMarket();
		$('.openModal').on('click', function() {
			$("#selCity").val($('#city').val()).prop("selected", true);
			selMarket();
			//$("#selMarket").val($("#market").val()).prop("selected", true)
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
		$('.btn').on('click', function() {
			$('.modal').css({"display" : "none"});
		});
		
		
		$('#selCountry').on('change', function() {
			selCity();
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
			if(!(($('#selCountry:selected').val() != $('#country').val()) || ($('#selCity:selected').val() != $('#city').val()) ||
					($('#selMarket:selected').val() != $('#market').val()) || ($('#product_name').val() != $('#product').val()) )){
				if(confirm("정보가 변경되어 기존 상품이 아닌 새 상품으로 등록됩니다. 계속하시겠습니까?")){
					alert("!!!!관리자에게 정보 넘겨야함!!!!");
				}else {
					alert("기존값으로 변경되었습니다.")
					$('#selCountry:selected').val($('#country').val());
					$('#selCity:selected').val($('#city').val());
					$('#selMarket:selected').val($('#market').val());
					$('#product_name').val($('#product').val());
				}
			}else if (($('#selCountry:selected').val() == "국가명") || ($('#selCity:selected').val() =="도시명") || ($('#selMarket:selected').val() == "시장명") || 
						($('#product_name').val() = null) || ($('.exchange').val() == ull) ){
				alert("정보를 모두 입력해주세요.");
			}else{
				alert("!!!!관리자에게 정보 넘겨야함!!!!");
			}
		})
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


국가<input type="text" id="country" value="베트남"><br>
도시<input type="text" id="city" value="달랏"><br>
시장<input type="text" id="market" value="달랏"><br>
상품명 <input type="text" id="product" value="바나나"><br>

<button type="button" class="openModal">modal</button>
<div class="modalBehind"></div>
<div class="modal">
	<div class="row"></div>
	<div class="row">
		<div class="col-sm-10">
			<p class="product">상품 등록</p>
		</div>
		<div class="col-sm-2">
			<h4 class="closeModal">X</h4>
		</div>
	</div>
	<div class="row">
		<table class="table tavle-bordered">
			<tr>
				<th>국가(한글)</th>
				<td><select id="selCountry" name="country_kr_name">
						<option>국가명</option>
						<c:forEach items="${countries.rows}" var="country">
							<option value="${country.country_kr_name}">${country.country_kr_name}</option>
						</c:forEach>
				</select></td>
				<th>도시(한글)</th>
				<td>
					<span id="citySpan">
						<select id="selCity" name="city_kr_name">
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
					<input type="text" id="product_name">
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
				<td><input type="number" style="width: 8vw;" class="exchange" id="KRW" onkeyup="convert('KRW');"></td>
				<th>원(한화)</th>
				<td><input type="number" style="width: 8vw;" class="exchange" id="THB" onkeyup="convert('THB');"></td>
				
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
				
				
				
				<th>
					<c:forEach items="${countries.rows}" var="country">
						<c:if test="${country_kr_name eq country.country_kr_name }">
						
						</c:if>
					</c:forEach>
				</th>
				<td></td>
			</tr>
			<tr rowspan="4">
				<td colspan="6"><textarea class="description" rows="5">
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
		<button id="register" class="btn">완료</button>
	</div>
</div>