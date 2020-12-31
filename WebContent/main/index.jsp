<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList, com.example.libs.model.ProductVO"%>
<jsp:useBean id="popular"
	class="com.example.libs.service.PopularService" />
<%
	ArrayList<ProductVO> list = popular.populist();
ArrayList<ProductVO> list2 = popular.variancelist();
%>
<jsp:include page="header.jsp" />

<div id="titletext">타이틀네임을 입력</div>
<jsp:include page="mainpageMap.html" />
<style>
</style>
<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-5  col-lg-3">
			<h4>
				<strong>인기 검색 종목 물가</strong>
			</h4>
			<!--  인기 검색 종목 물가 -->
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="info">
							<th>국가</th>
							<th>물품명</th>
							<th>가격</th>
						</tr>
					</thead>
					<tbody>
						<%
							if (list == null) {
						%>
						<tr>
							<td colspan="3" class="text-center">No Data</td>
						</tr>
						<%
							} else {
						for (int i = 0; i < 3; i++) {
							ProductVO pop = list.get(i);
						%>
						<tr>
							<td><%=pop.getCountry_kr_name()%></td>
							<td><%=pop.getProduct_name()%></td>
							<td><%=pop.getProduct_price()%></td>
						</tr>
						<%
							} //for end
						} //if end
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!--ENd 인기 검색-->

		<!--  급변동 -->
		<div class="col-xs-12 col-sm-12 col-md-7 col-lg-5">
			<h4>
				<strong>급변동 물가</strong>
			</h4>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="info">
							<th>국가</th>
							<th>상품명</th>
							<th>평균가격</th>
							<th>상승/하락</th>
							<th>변동값</th>
						</tr>
					</thead>
					<tbody>
						<%
							if (list2 == null) {
						%>
						<tr>
							<td colspan="5" class="text-center">No Data</td>
						</tr>
						<%
							} else {
						for (int i = 0; i < 3; i++) {
							ProductVO pop2 = list2.get(i);
						%>
						<tr>
							<td><%=pop2.getCountry_kr_name()%></td>
							<td><%=pop2.getProduct_name()%></td>
							<td><%=pop2.getProduct_price_P1Data()%>원</td>
							<%
								/* double p3 = pop2.getProduct_price_P3Data() * 100; */
								double p3 = pop2.getProduct_price_P3Data();
							int p31 = (int) Math.abs(p3);
							int p4 = (int) pop2.getProduct_price_P4Data() * 10;
							int p5 = (int) pop2.getProduct_price_P5Data() * 100;
							if (p5 >= 100) {
								p5 = p5 / 10;
							%>
							<td><%=p5%>% 하락</td>
							<td style="color: blue">▼<%=p31%></td>
							<%
								} else {
							p4 = p4 / 100;
							%>
							<td><%=p4%>% 상승</td>
							<td style="color: red">▲<%=p31%></td>
							<%
								}
							%>
						</tr>
						<%
							} //for end
						} //if end
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!--급변동-->
<style>
	.exchangebox{background:#ecf0f1; padding:15px 25px 10px 25px}
	#exchangelist{
		list-style: none;
		padding: 0;
	}
	#exchangelist .exchangego{display:inline; float: right;}
	
	.infodea{border-top:1px solid #064acb; margin:10px 0; padding: 30px 0;}
	
</style>
		
		<div class="exchangebox col-xs-12 col-sm-12 col-md-12 col-lg-4">
			<h4><strong>환전 고시 환율</strong></h4>
			<h5 style="color:blue; font-weight:bold">※ 1달러 기준</h5>
			<ul id="exchangelist">
				<li>태국</li>
				<li>베트남</li>
				<li>라오스</li>
				<li>싱가폴</li>
				<li>말레이시아</li>
			</ul>
			<script>
				$.ajax({
					url: 'https://api.manana.kr/exchange.json',
					type: 'GET',
				}).done((data, textStatus, jqXHR) => {
					//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
			
					//한개씩 뽑는 테스트
					// var kkk = data.filter(function (item) { return item.name == "USD/THB" });
					// var kkk2 = kkk[0].price;
					// var e =  Math.round(kkk2 * 100) / 100; 
					// console.log(e);
			
					//적용▼
					//원JSON대로 읽어와 array의 불러오는 순서영향을 받지 않음.
					var array = ["USD/THB", "USD/LAK", "USD/MYR", "USD/VND", "USD/SGD"];
					var array2 = [];
					data.filter(function(item){
							for(var i in array){
								if(item.name === array[i]){
								 array2[i] = Math.round(item.price * 100) / 100;
								 console.log(array2[i]);//순서 : 태국, 라오스, 말레이시아, 베트남, 싱가폴
								}
							}							
					});
					$('#exchangelist li:nth-child(1)').append('<div class="exchangego">'+ array2[0] +' 밧</div>');
					$('#exchangelist li:nth-child(2)').append('<div class="exchangego">'+ array2[3] +' 동</div>');
					$('#exchangelist li:nth-child(3)').append('<div class="exchangego">'+ array2[1] +' 킵</div>');
					$('#exchangelist li:nth-child(4)').append('<div class="exchangego">'+ array2[4] +' 달러</div>');
					$('#exchangelist li:nth-child(5)').append('<div class="exchangego">'+ array2[2] +' 링깃</div>');
				}), (jqXHR, textStatus, errorThrown) => {
					console.log('실패')
				};
								
			</script>
		</div>
		<!-- END 환전고시환율 -->
		
	</div>
	<!-- End row 인기 검색 종목 물가, 급변동 물가-->

	<!-- <div class="row">
		<div class="col-sm-7">인기 교통 정보</div>
		<div class="col-sm-5">나라별 인기 교통 수단</div>
	</div> -->





	<div class="infodea row">
		<h4>
			<strong>대사관 정보</strong>
		</h4>
		<p>주 베트남 대한민국 대사관 전화번호 (84-24) 3831-5110~6,(84-24)
			3831-5125,(84-24) 3771-0404 주소 SQ4, Do Nhuan, Diplomatic complex,
			Xuan Tao, Bac Tu Liem, Hanoi, Vietnam</p>
		<p>주 캄보디아 대한민국 대사관 전화번호 (855-23) 211-900 주소 Phum 14. Sangkat Tonle
			Bassac, Khan Chamcamon, Phnom Penh, Cambodia</p>
		<p>주 말레이시아 대한민국 대사관 전화번호 (60-3) 4251-2336 주소 No.9 & 11, Jalan
			Nipah, Off Jalan Ampang 55000 Kuala Lumpur, Malaysia</p>
		<p>주 태국 대한민국 대사관 전화번호 (66-2) 247-7537~39, (66-81) 914-5803 주소
			Embassy of the Republic of Korea 23 Thiam-Ruammit Road,
			Ratchadapisek, Huai-Khwang, Bangkok 10310 Thailand</p>
		<p>주 싱가포르 대한민국 대사관 전화번호 +65-6256-1188 주소 47 Scotts Road Goldbell
			Towers #08-00</p>
	</div>
	<!-- Ene row 대사관정보-->
</div>
<!-- End container-->





<jsp:include page="footer.jsp" />