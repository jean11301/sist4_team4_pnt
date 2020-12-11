<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8" />
<c:set var="country" value="${param.country}" />
<sql:setDataSource dataSource="jdbc/myoracle" var="conn" />
<sql:query dataSource="${conn}" var="cities">
	SELECT city_kr_name 
	FROM COUNTRY NATURAL JOIN city
	WHERE country_kr_name = ?
	ORDER BY city_kr_name
	<sql:param value="${country}" />
</sql:query>

<script>
$(document).ready(function() {
	$('#selCity').on('change',function() {
		$('#txtMarketKr').attr("disabled", "true");
		$('#txtMarketEn').attr("disabled", "true");
		var selectedCity = $(this).val();
		if(selectedCity == "도시명"){
			$('#txtCity').val("");
			$('#txtCity').attr("disabled", "true");
			selectedCity = "";
			$('#txtMarketKr').attr("disabled", "true");
			$('#txtMarketEn').attr("disabled", "true");
		}else if(selectedCity == "신규 도시 입력"){	
			$('#txtCity').val("");
			$('#txtCity').removeAttr("disabled");
			selectedCity = "";
			$('#txtMarketEn').removeAttr("disabled");
			$('#txtMarketKr').removeAttr("disabled");
		}else{
			$('#txtCity').val(selectedCity); 
			$('#txtCity').attr("disabled", "true");
			$('#txtMarketEn').removeAttr("disabled");
			$('#txtMarketKr').removeAttr("disabled");
			
			
		}
		
		console.log(selectedCity);
	});
});
</script>

<select id="selCity" name="selCity">
	<option value="">도시명</option>
	<c:forEach items="${cities.rows}" var="city">
		<option value="${city.city_kr_name}">${city.city_kr_name}</option>
	</c:forEach>
	<option>신규 도시 입력</option>
</select>