<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.example.libs.model.CountryVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="country"
	class="com.example.libs.service.CountryServiceImpl" />
<jsp:include page="../main/header.jsp" />
<%
	ArrayList<CountryVO> list = country.readAll();
%>
<div class="container">
	<div class="row">
		<form action="cityinserting.jsp" method="POST">
			<div class="form-group">
			<br>
			<h1>도시 등록</h1>
			<hr>
			  <label>국가선택</label>
			  <select class="form-control" id="Select1" name="country_code">
			  	<option>--국가를 선택하세요--</option>
			  	<%for(int i = 0; i<list.size();i++){
			  		CountryVO coun = list.get(i);%>
					<option value="<%=coun.getCountry_code()%>"><%=coun.getCountry_kr_name()%></option>
				<%	 
					}
				%>
			  </select>
			</div>
			<div class="form-group">
				<label>한글도시명</label>
			  <input type="text" class="form-control" name="city_kr_name" >
			</div>
			<div class="form-group">
				<label>영어도시명</label>
			  <input type="text" class="form-control"  name="city_en_name">
			</div>
			<div class="form-group">
				<label>도시번호</label>
			  <input type="number" class="form-control"  name="city_number" >
			</div>
			<button type="submit" class="btn btn-primary">등록</button>
			
			<button type="reset" class="btn btn-primary">취소</button>
		  </form>
	</div>
</div>
<jsp:include page="../main/footer.jsp" />