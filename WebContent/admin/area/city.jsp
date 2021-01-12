<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.ArrayList, com.example.libs.model.CityVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../main/header.jsp" />

<style>
	/* hr{
		border: 5px; color: black;} */
	thead{
		background-color: white;
	}
	tbody{
		background-color:white;
	}
</style>
<script src="../../js/jquery-3.5.1.js"></script>
<script>
$(document).ready(function(){  	//삭제시 자식테이블도 같이 지워야됨 ----------이슈1
	//삭제
	$('#btnDelete').on('click',function(){
		var checkbox = $('input[id=checkedBox]:checked');
		var tr = checkbox.parent().parent();
		var td = tr.children();
		var code = td.eq(0).children().val();
		var array = [];
		checkbox.each(function(i){
			tr = checkbox.parent().parent().eq(i);
			td = tr.children();
			city_number = td.eq(0).children().val();
			array.push(city_number);
		});
		var i;
		if(checkbox != null){  //체크안된 경우 처리해야됨 ----------이슈 3
		if(confirm("도시번호 "+array+"번을 정말 삭제하시겠습니까?")){
			for(i = 0; i<array.length; i++){
				location.href = "citydelete.jsp?city_number="+array[i];  //지워지긴 하는데 체크 맨마지막만 지워짐 -------------이슈 2
			}
		}else{
			history.go(0);
		}
		}else{
			alert("체크박스를 선택해주세요.");
		}	
		//location.href = "cityDelete.jsp";
	});	
	$('#btnInsert').on('click',function(){
		location.href = "cityinsert.jsp";
	});	
	
});
function cityupdate(){
	
	location.href = "cityupdate.jsp";
}
</script>
<jsp:useBean id="cities" class="com.example.libs.service.CityServiceImpl"/>
<%
	ArrayList<CityVO> list = cities.readAll();
%>
<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">

		</div>
	</div>

	<div id="titletext">지역관리 | 국가관리</div>
		<div class="container">
			<div class="page-header"><h1>도시관리</h1></div>
			<hr>
			<div class="row">
				<div class="table-responsive">
				<form >
					<table class="table table-hover" >
						<thead>
							<th>전체</th>
							<th>도시 번호</th>
							<th>한글 도시명</th>
							<th>영어 도시명</th>
							<th>국가 코드</th>
							<th>관리</th>
						</thead>
						<tbody>
							<%if(list==null){ 
							%><tr><td colspan="6" class="text-center" > NO DATA</td></tr>
							<% }else{ 
								for(int i = 0; i<list.size();i++){
									int count = i+1;
									CityVO city = list.get(i);
									%>
									 <tr>
									 	<td><input type="checkbox" id="checkedBox" value="<%=city.getCity_number()%>"></td>
									 	<td><%=city.getCity_number()%></td>
									 	<td><%=city.getCity_kr_name()%></td>
									 	<td><%=city.getCity_en_name()%></td>
									 	<td><%=city.getCountry_code()%></td>
									 	<td><a id="ahnchor<%=count++%>" onclick="cityupdate()" >수정</a></td>
									 </tr> 
							<%	}
							   }
							%>
						</tbody>
					</table>
					<div style="float: right;">
						<input type="button" class="btn btn-danger" id="btnDelete" value="삭제" >
						&nbsp;&nbsp;
						<input type="button" class="btn btn-success" id="btnInsert" value="등록">
					</div>
					</form>
				</div>
			</div>
			<span>
				<div>
					<form class="col-xs-3" style="float: left;" method="post" action="citysearch.jsp">
						<input type="text" placeholder="도시명으로 검색하세요" name="input_search">
						<input type="submit" value="검색">
					</form>
				</div>
			</span>
		</div> 
</div>
<jsp:include page="../main/footer.jsp" />