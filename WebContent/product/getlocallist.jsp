<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="country_kr_name" value="${param.country_kr_name}" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="rs">
	SELECT  city_kr_name
	 FROM country join city ON country.COUNTRY_CODE=city.COUNTRY_CODE
	WHERE country_kr_name=?
	<sql:param value="${country_kr_name}" />
</sql:query>
<!-- <select name="city_kr_name" id="selcity_kr_name"> -->
<select name="city_kr_name" id="selcity_kr_name" class="form-control">
	<option value="">지역선택</option>
	<c:forEach items="${rs.rows}" var="row">
		<option value="${row.city_kr_name}">${row.city_kr_name}</option>
	</c:forEach>
</select>
<script>
var xhr = null;
$(document).ready(function(){
	xhr = new XMLHttpRequest();  //1. 객체 생성
	 $('#selcity_kr_name').on('change', function(){
			xhr.onreadystatechange = getMarket;     //4
			xhr.open('POST', 'getMarketlist.jsp', true);  //2. open()
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
			let param = '&city=' + $('#selcity_kr_name').val().trim();
			xhr.send(param);     //3.
		}); 

	});
function getMarket(){
	if(xhr.readyState == 4 && xhr.status == 200){
		$('#market_kr_nameDiv').html(xhr.responseText.trim());
	}
}
</script>
