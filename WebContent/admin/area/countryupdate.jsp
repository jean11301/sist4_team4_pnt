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
		<form action="countryupdating.jsp" method="POST">
			<br>
			<h1>국가 수정</h1>
			<hr>
			<div class="form-group">
				<label>도시번호</label> 
				<select class="form-control" id="Select2" name="country_code">
					<option>--수정할 나라 번호를 선택하세요--</option>
					<%
						for (int i = 0; i < list.size(); i++) {
						CountryVO coun = list.get(i);
					%>
					<option value="<%=coun.getCountry_code()%>"><%=coun.getCountry_code()%></option>
					<%
						}
					%>
				</select>
			</div>
			<div class="form-group">
				<label>한글도시명</label> <input type="text" class="form-control"
					name="country_kr_name">
			</div>
			<div class="form-group">
				<label>영어도시명</label> <input type="text" class="form-control"
					name="country_en_name">
			</div>
			<div class="form-group">
				<label>국기 이미지</label> <input type="text" class="form-control"
					name="country_flag_img">
			</div>

			<button type="submit" class="btn btn-primary">등록</button>

			<button type="reset" class="btn btn-primary">취소</button>
		</form>
	</div>
</div>
<jsp:include page="../main/footer.jsp" />