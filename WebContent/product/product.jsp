<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.example.libs.model.ProductVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="popular" class="com.example.libs.service.PopularService" />
<% 
	ArrayList<ProductVO> list = popular.populist(); 
	ArrayList<ProductVO> list2 = popular.variancelist();
%>

<div class="col-xs-12 col-sm-12 col-md-9 col-lg-4 pnt_map pd-5" >
	<jsp:include page="map_ex.html" />
</div>
<!--  인기 검색 종목 물가, 급변동 물가 -->
		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4">
			<h4>
					<strong>인기 검색 종목 물가</strong>
				</h4>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr class="info">
								<th>국가</th>
								<th>도시</th>
								<th>시장</th>
								<th>물품명</th>
								<th>가격</th>
							</tr>
						</thead>
						<tbody>
							<%
								if (list == null) {
							%>
							<tr>
								<td colspan="5" class="text-center">No Data</td>
							</tr>
							<%
								} else {
							for (int i = 0; i < 3; i++) {
								ProductVO pop = list.get(i);
							%>
							<tr>
								<td><%=pop.getCountry_kr_name()%></td>
								<td><%=pop.getCity_kr_name()%></td>
								<td><%=pop.getMarket_kr_name()%></td>
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
		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4">
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
	<!-- End  인기 검색 종목 물가, 급변동 물가-->



