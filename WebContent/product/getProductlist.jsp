<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<fmt:requestEncoding value="utf-8" />
<c:set var="count" />
<c:set var="country" value="${param.country}" />
<c:set var="city" value="${param.city}" />
<c:set var="market" value="${param.market}" />
<c:set var="product" value="${param.product}" />

<sql:setDataSource dataSource="jdbc/myoracle" var="conn"/>
<c:if test="${empty country and empty city and empty market}">  <%--나라와 도시, 시장 모두 널일때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name, product_price, product_img, product_number
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND product_name LIKE CONCAT(CONCAT('%', ?), '%') AND check_status = 1
		ORDER BY SEQUENCE DESC
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
		<p>전체 최신순</p>
	</div>
</c:if>
<c:if test="${not empty country and empty city and empty market}">  <%-- 나라는 널이 아니고 도시, 시장이 널일때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price, product_img, product_number
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND country_kr_name = ? AND product_name LIKE CONCAT(CONCAT('%', ?), '%') AND check_status = 1
		ORDER BY SEQUENCE DESC
		<sql:param value="${country}"/>
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
	<c:set var="co" value="0" />
	<c:if test="${product eq ''}">
		<p>${country}의 검색결과는 <c:forEach var="countt" items="${rs.rowsByIndex}"> <c:set var="co" value="${co + 1}" /> </c:forEach><c:out value="${co}"/>개 입니다.</p>
	</c:if>
	<c:if test="${product ne ''}">
		<p>${country}의 '${product}' 검색결과는 <c:forEach var="countt" items="${rs.rowsByIndex}"> <c:set var="co" value="${co + 1}" /> </c:forEach><c:out value="${co}"/>개 입니다.</p>
	</c:if>
	</div>
</c:if>
<c:if test="${not empty country and not empty city and empty market}">  <%-- 나라, 도시 널이 아니고 시장이 널일때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price, product_img, product_number
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND country_kr_name = ? AND city_kr_name = ? AND product_name LIKE CONCAT(CONCAT('%', ?), '%') AND check_status = 1
		ORDER BY SEQUENCE DESC
		<sql:param value="${country}"/>
		<sql:param value="${city}"/>
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
	<c:set var="co" value="0" />
		<c:if test="${product eq ''}">
		<p>${country} > ${city}의 검색결과는 <c:forEach var="countt" items="${rs.rowsByIndex}"> <c:set var="co" value="${co + 1}" /> </c:forEach><c:out value="${co}"/>개 입니다.</p>
	</c:if>
	<c:if test="${product ne ''}">
		<p>${country} > ${city}의 '${product}' 검색결과는 <c:forEach var="countt" items="${rs.rowsByIndex}"> <c:set var="co" value="${co + 1}" /> </c:forEach><c:out value="${co}"/>개 입니다.</p>
	</c:if>
	</div>
</c:if>
<c:if test="${not empty country and not empty city and not empty market}"><%-- 나라, 도시, 시장 셋 다 널이 아닐 때 --%>
	<sql:query var="rs" dataSource="${conn}">
		SELECT country_kr_name, city_kr_name, market_kr_name, product_name,product_price, product_img, product_number
		FROM country, city, market, product
		WHERE country.country_code = city.country_code AND city.city_number = market.city_number AND market.market_number = product.market_number
		AND country_kr_name = ? AND city_kr_name = ? AND market_kr_name = ? AND product_name LIKE CONCAT(CONCAT('%', ?), '%') AND check_status = 1
		ORDER BY SEQUENCE DESC
		<sql:param value="${country}"/>
		<sql:param value="${city}"/>
		<sql:param value="${market}"/>
		<sql:param value="${product}"/>
	</sql:query>
	<div class="container">
	<c:set var="co" value="0" />
	<c:if test="${product eq ''}">
		<p>${country} > ${city} > ${market}의 검색결과는 <c:forEach var="countt" items="${rs.rowsByIndex}"> <c:set var="co" value="${co + 1}" /> </c:forEach><c:out value="${co}"/>개 입니다.</p>
	</c:if>
	<c:if test="${product ne ''}">
		<p>${country} > ${city} > ${market}의 '${product}' 검색결과는 <c:forEach var="countt" items="${rs.rowsByIndex}"> <c:set var="co" value="${co + 1}" /> </c:forEach><c:out value="${co}"/>개 입니다.</p>
	</c:if>
	</div>
</c:if>
	<style>
	.imgcontrol{}
	.imgcontrol img{width:100%;overflow: hidden;}
	.listbox{ overflow: hidden;    min-height: 215px; margin: 0 0 1% 0;padding: 0 0.5vw;}
	.product{overflow: hidden;display: grid;}
	.productlist{display: block;text-overflow:ellipsis;overflow: hidden;white-space: nowrap; width:95%; padding:2%}
	.productname{color:#091a3c;     font-size: 1.8rem; font-weight: bold; padding: 0 0 0 3%;}
	.stylebox{border:1px solid #CCC; overflow: hidden; border-radius: 5px;}
	</style>
	<!-- 	<div class="container" style="margin-right:0; margin-left:300px;"> -->
		<!-- <div class="row" style="margin-right:0;"> -->
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-2" style="margin:0; padding:0"></div>
		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-8" style="margin:0; padding:0">
		<c:forEach items="${rs.rows}" var="row"> 
			<div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 listbox" id="count">
			<div class="stylebox">
			<a href="productDetail2.jsp?product_number=${row.product_number}" >
				<table class="table-responsive" >
					<tr>
						<td class="imgcontrol">${row.product_img}</td>
					</tr>
					<tr class="product">
						<td class="productlist">${row.country_kr_name} > ${row.city_kr_name} > ${row.market_kr_name}</td>
					</tr>
					<tr>
						<td class="productname">${row.product_name}</td>
					</tr>
					
						<c:if test="${row.country_kr_name eq '태국' }">
							<div id="test">${row.product_price}</div>밧
						</c:if>
						<c:if test="${row.country_kr_name eq '라오스'}">
							<div id="test1">${row.product_price}</div>킵
						</c:if>
						<c:if test="${row.country_kr_name eq '말레이시아'}">
							<div id="test2">${row.product_price}</div>링깃
						</c:if>
						<c:if test="${row.country_kr_name eq '베트남'}">
							<div id="test3">${row.product_price}</div>동
						</c:if>
						<c:if test="${row.country_kr_name eq '싱가폴'}">
							<div id="test4">${row.product_price}</div>달러
						</c:if>
							
				</table>
				</a>
			</div>
		</div>
		
		
	
		
		</c:forEach>
		<script>
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
					           // $('#change1').append(eqValue);                                        
					        });
					       
 							$("div#test1").each(function(idx){   
					           
					           // 해당 체크박스의 Value 가져오기
					           // var value = $(this).find($('#test')).text();
					            var eqValue = $("div#test1:eq(" + idx + ")").text() ;
					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
					            $("div#test1:eq(" + idx + ")").after(test11);;
					           console.log(eqValue) ;
					           // $('#change1').append(eqValue);                                        
					        });
 							
 							
 							$("div#test2").each(function(idx){   
 					           
 					           // 해당 체크박스의 Value 가져오기
 					           // var value = $(this).find($('#test')).text();
 					            var eqValue = $("div#test2:eq(" + idx + ")").text() ;
 					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
 					            $("div#test2:eq(" + idx + ")").after(test11);;
 					           console.log(eqValue) ;
 					           // $('#change1').append(eqValue);                                        
 					        });
 							
 							$("div#test3").each(function(idx){   
 					           
 					           // 해당 체크박스의 Value 가져오기
 					           // var value = $(this).find($('#test')).text();
 					            var eqValue = $("div#test3:eq(" + idx + ")").text() ;
 					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
 					            $("div#test3:eq(" + idx + ")").after(test11);;
 					           console.log(eqValue) ;
 					           // $('#change1').append(eqValue);                                        
 					        });
					       
 							$("div#test4").each(function(idx){   
  					           
  					           // 해당 체크박스의 Value 가져오기
  					           // var value = $(this).find($('#test')).text();
  					            var eqValue = $("div#test4:eq(" + idx + ")").text() ;
  					            var test11 = Math.round((eqValue/mmm2*e11)* 100) / 100;
  					            $("div#test4:eq(" + idx + ")").after(test11);;
  					           console.log(eqValue) ;
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
									
				</script>
		</div><!-- END col-sm-8 -->
<!-- 		</div>
</div> -->



