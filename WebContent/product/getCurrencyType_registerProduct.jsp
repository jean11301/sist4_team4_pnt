<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8" />
<c:set var="country" value="${param.country}" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />

<sql:query dataSource="${conn}" var="cities">
	SELECT city_kr_name 
	FROM COUNTRY NATURAL JOIN city
	WHERE country_kr_name = ?
	ORDER BY city_kr_name
	<sql:param value="${country}" />
</sql:query>


<select id="selCity" name="city_kr_name">
	<option value="">도시명</option>
	<c:forEach items="${cities.rows}" var="city">
		<option value="${city.city_kr_name}"   >${city.city_kr_name}</option>
	</c:forEach>
</select>

//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
<c:if test="${country eq '태국' }">
	<td><input type="number" style="width: 8vw;" class="exchange" id="THB" onkeyup="convert('THB');" required></td>
				
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
	<td>바트</td>
</c:if>
<c:if test="${country eq '베트남' }">
	<td><input type="number" style="width: 8vw;" class="exchange" id="VND" onkeyup="convert('VND');" required></td>
				
				<script type="text/javascript">
				function convert(currency_type){
					//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
					var kr_e = 0;
					var other_e = 0;
					if (currency_type == 'VND') {
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
					        $('#VND').val((val / e).toFixed(2));
							}), (jqXHR, textStatus, errorThrown) => {
								console.log('실패')
							};   
				        } else{
				        	$('#VND').val("");
	
				        }
					}
				
				}
				</script>
	<td>바트</td>
</c:if>
<c:if test="${country eq '태국' }">
	<td><input type="number" style="width: 8vw;" class="exchange" id="VND" onkeyup="convert('VND');" required></td>
				
				<script type="text/javascript">
				function convert(currency_type){
					//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
					var kr_e = 0;
					var other_e = 0;
					if (currency_type == 'VND') {
						var str = "USD/" + currency_type;
				        var val = $("#VND").val();
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
					        $('#VND').val((val / e).toFixed(2));
							}), (jqXHR, textStatus, errorThrown) => {
								console.log('실패')
							};   
				        } else{
				        	$('#VND').val("");
	
				        }
					}
				
				}
				</script>
	<td>동</td>
</c:if>
<c:if test="${country eq '라오스' }">
	<td><input type="number" style="width: 8vw;" class="exchange" id="LAK" onkeyup="convert('LAK');" required></td>
				
				<script type="text/javascript">
				function convert(currency_type){
					//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
					var kr_e = 0;
					var other_e = 0;
					if (currency_type == 'LAK') {
						var str = "USD/" + currency_type;
				        var val = $("#LAK").val();
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
					        $('#LAK').val((val / e).toFixed(2));
							}), (jqXHR, textStatus, errorThrown) => {
								console.log('실패')
							};   
				        } else{
				        	$('#LAK').val("");
	
				        }
					}
				
				}
				</script>
	<td>킵</td>
</c:if>
<c:if test="${country eq '싱가포르' }">
	<td><input type="number" style="width: 8vw;" class="exchange" id="SGD" onkeyup="convert('SGD');" required></td>
				
				<script type="text/javascript">
				function convert(currency_type){
					//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
					var kr_e = 0;
					var other_e = 0;
					if (currency_type == 'SGD') {
						var str = "USD/" + currency_type;
				        var val = $("#SGD").val();
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
					        $('#SGD').val((val / e).toFixed(2));
							}), (jqXHR, textStatus, errorThrown) => {
								console.log('실패')
							};   
				        } else{
				        	$('#SGD').val("");
	
				        }
					}
				
				}
				</script>
	<td>싱가포르 달러</td>
</c:if>