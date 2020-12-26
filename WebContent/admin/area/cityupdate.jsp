<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.example.libs.model.CountryVO, com.example.libs.model.CityVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="country"
	class="com.example.libs.service.CountryServiceImpl" />
<jsp:useBean id="city"
	class="com.example.libs.service.CityServiceImpl" />
<jsp:include page="../main/header.jsp" />
<%
	ArrayList<CountryVO> list1 = country.readAll();
	ArrayList<CityVO> list2 = city.readAll();
%>

<div class="container">
	<div class="row">
		<form action="cityupdating.jsp" method="POST">
			<br>
			<h1>도시 수정</h1>
			<hr>
			<div class="form-group">
				<label>도시번호</label> 
				<select class="form-control" id="Select2" name="city_number">
					<option>--수정할 도시 번호를 선택하세요--</option>
					<%
						for (int i = 0; i < list2.size(); i++) {
						CityVO coun = list2.get(i);
					%>
					<option value="<%=coun.getCity_number()%>"><%=coun.getCity_number()%></option>
					<%
						}
					%>
				</select>
			</div>
			<div class="form-group">
				<label>국가선택</label> 
				<select class="form-control" id="Select1" name="country_code">
					<option>--국가를 선택하세요--</option>
					<%
						for (int i = 0; i < list1.size(); i++) {
						CountryVO coun = list1.get(i);
					%>
					<option value="<%=coun.getCountry_code()%>"><%=coun.getCountry_kr_name()%></option>
					<%
						}
					%>
				</select>
			</div>
			<div class="form-group">
				<label>한글도시명</label> <input type="text" class="form-control"
					name="city_kr_name">
			</div>
			<div class="form-group">
				<label>영어도시명</label> <input type="text" class="form-control"
					name="city_en_name">
			</div>

			<button type="submit" class="btn btn-primary">등록</button>

			<button type="reset" class="btn btn-primary">취소</button>
		</form>
	</div>
</div>
<jsp:include page="../main/footer.jsp" />