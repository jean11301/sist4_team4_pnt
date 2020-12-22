<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="krw" value="null" />
<c:set var="thb" value="null" />
<c:set var="krw" value="${param.priceKr}" />
<c:set var="thb" value="${param.priceViet }" />

<!DOCTYPE html>
<html>
<head>
      <title>Live Currency Converter</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	alert("${krw}");
	alert("${thb}");
</script>
</head>
<body>
<form>
       <p>THB:</p>
       <input type="number" step="0.01" id="thb" name="Thai" placeholder="Enter in Thai" onkeyup="convert('thb');">
       <p>krw</p>
       <input type="number" step="0.01" id="krw" name="Krw" placeholder="Enter in Krw" onkeyup="convert('krw');">
       
</form>
<script type="text/javascript">
       function convert(currency_type){
       var currency_type = currency_type;
       $.ajax({
       url: 'http://apilayer.net/api/live?access_key=be0be446f9ecb6ef5aef9d663fe5a513',   
       dataType: 'json',
       
       success: function(json) {
       if (json.success == true) {
       if (currency_type == 'thb') {
               var val = document.getElementById("thb").value;
               if (val) {
                   var val = parseFloat(val).toFixed(2);
                   var to_usd = (json.quotes.USDTHB/json.quotes.USDKRW)*val;
                   document.getElementById("krw").value=to_usd.toFixed(2);
                
               }
               else{
                   document.getElementById("krw").value='Enter in Krw';

               }
           }
       if (currency_type == 'krw') {
               var val = document.getElementById("krw").value;
               if (val) {
                   var val = parseFloat(val).toFixed(2);
                   var to_afn = val*(1/json.quotes.USDTHB);
                   document.getElementById("thb").value=to_afn.toFixed(2);
                
               }
               else{
                   document.getElementById("thb").value='Enter in Thai';
          
               }
           }
    
       }
       }
       });}
</script>
</body>
</html>

<c:set var="krw" value="${}" />
<c:set var="thb" value="${}" />