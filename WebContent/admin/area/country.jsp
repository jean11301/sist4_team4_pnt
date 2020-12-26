<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.ArrayList, com.example.libs.model.CountryVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
thead {
	background-color: dodgerblue;
}

tbody {
	background-color: lightcyan;
}
</style>
<script src="../../js/jquery-3.5.1.js"></script>
<script>
	$(document).ready(function() {
		//삭제
		$('#btnDelete').on('click', function() {
			var checkbox = $('input[id=checkedBox]:checked');
			var tr = checkbox.parent().parent();
			var td = tr.children();
			var code = td.eq(0).children().val();
			var array = [];
			checkbox.each(function(i){
				tr = checkbox.parent().parent().eq(i);
				td = tr.children();
				country_code = td.eq(0).children().val();
				array.push(country_code);
			});
			var i;
			if (confirm("국가번호 " + array + "번을 정말 삭제하시겠습니까?")) {
				for (i = 0; i < array.length; i++) {
					location.href = "countrydelete.jsp?country_code=" + array[i]; //지워지긴 하는데 체크 맨마지막만 지워짐 //자식 테이블에 시장이 있으면 안지워짐
				}
			} else {
				history.go(0);
			}

			//location.href = "cityDelete.jsp";
		});
		$('#btnInsert').on('click', function() {
			location.href = "countryinsert.jsp";
		});
	});
	function countryupdate() {

		location.href = "countryupdate.jsp";
	}
</script>

<jsp:useBean id="countries"
	class="com.example.libs.service.CountryServiceImpl" />
<%
	ArrayList<CountryVO> list = countries.readAll();
%>
<jsp:include page="../main/header.jsp" />
<div id="titletext">지역관리 | 국가관리</div>

	<div class="container">
		<div class="page-header">
			<h1>국가관리</h1>
		</div>
		<hr>
		<div class="row">
			<div class="table-responsive">
				<form>
					<table class="table table-hover">
						<thead>
							<th>전체</th>
							<th>국가코드</th>
							<th>한글 국가명</th>
							<th>영어 국가명</th>
							<th>관리</th>
						</thead>
						<tbody>
							<%
								if (list == null) {
							%><tr>
								<td colspan="5" class="text-center">NO DATA</td>
							</tr>
							<%
								} else {
							for (int i = 0; i < list.size(); i++) {
								CountryVO country = list.get(i);
							%>
							<tr>
								<td><input type="checkbox" value="<%=country.getCountry_code()%>" id="checkedbox"></td>
								<td><%=country.getCountry_code()%></td>
								<td><%=country.getCountry_kr_name()%></td>
								<td><%=country.getCountry_en_name()%></td>
								<td><a onclick="countryupdate()">수정</a></td>
							</tr>
							<%
								}
							}
							%>
						</tbody>
					</table>
					<div style="float: right;">
						<input type="button" class="btn btn-danger" id="btnDelete"
							value="삭제"> 
							&nbsp;&nbsp; 
						<input type="button"
							class="btn btn-success" id="btnInsert" value="등록">
					</div>
				</form>
			</div>
		</div>
		<span>
			<div>
				<div class="col-xs-3" style="float: left;">
					<form class="col-xs-3" style="float: left;" method="post"
						action="countrysearch.jsp">
						<input type="text" placeholder="나라이름으로 검색하세요" name="input_search">
						<input type="submit" value="검색">
					</form>
				</div>

			</div>
		</span>
	</div>

<jsp:include page="../main/footer.jsp" />

