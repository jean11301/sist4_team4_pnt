<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
		<div class="col-sm-3">
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
		</div><!--ENd 인기 검색-->

		<!--  급변동 -->
		<div class="col-sm-6">
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
								double p3 = pop2.getProduct_price_P3Data()*100;
								int p31 = (int)Math.abs(p3);
								int p4 = (int)pop2.getProduct_price_P4Data()*10;
								int p5 = (int)pop2.getProduct_price_P5Data()*100;
								if(p5 >= 100){
									p5 = p5/10;
							%>
								<td><%=p5 %>% 하락</td>
								<td style="color:blue">▼<%=p31 %></td>	
							<%
								}else{
									p4 = p4/100;
							%>
								<td><%=p4 %>% 상승</td>
								<td style="color:red">▲<%=p31 %></td>	
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
		</div><!--급변동-->

		<div class="col-sm-3">환전 고시 환율</div>
	</div><!-- End row 인기 검색 종목 물가, 급변동 물가-->
	
	<!-- <div class="row">
		<div class="col-sm-7">인기 교통 정보</div>
		<div class="col-sm-5">나라별 인기 교통 수단</div>
	</div> -->





	<div class="row">
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
	</div><!-- Ene row 대사관정보--> 
</div><!-- End container-->





<jsp:include page="footer.jsp" />