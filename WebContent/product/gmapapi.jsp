<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
    <title>Simple Map</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD3xeJ9DUxybWjyRnhzKtZDBYxMwewhelE&callback=initMap&libraries=&v=weekly"
      defer
    ></script> 
    <style>
      #map {
        text-align: center;
        height: 500px;
        width: 500px;
        margin-left: auto;
        margin-right: auto;
      }
    </style>
    <script>
      let map;
      $(function(){
    	    $('#btnSearch').click(function(){
    	      let code = $('#citycode').val().trim();
    	      //alert(code);
    	      $.ajax({
    	        method : 'POST',
    	        url : 'getlatlon.jsp',
    	        data : {
    	          code : code
    	        },
    	        success : function(data){
    	          drawMarkers(data);
    	        }
    	      });
    	    });
    	    
    	    
    	    
    	  });
      function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
          center: { lat: 3.13331, lng: 101.70951 },
          zoom: 11.5,
        });
      }
      function drawMarkers(serverdata){
    	
  		let idx = serverdata.lastIndexOf(",");
  		let server = null;
  		if(idx > -1) server = serverdata.substring(0, idx) + "]}"; 
  		else server = serverdata;
  		//console.log(Object.values(server));
  		server = server.trim();
  		let obj = JSON.parse(server); 
  		let array = obj.data;  
  		
  		for(let i = 0 ; i < array.length ; i++){
  			 //lat: array[i]['latitude'], lng: array[i]['longitude']
  				const marker = new google.maps.Marker({
            	/*position: {latitude: array[i].latitude,
            			   longitude: array[i].longitude},*/
            	position: new google.maps.LatLng(array[i].latitude, array[i].longitude),		   
            	map: map,
          	});
		}
    	}
    </script>
  </head>
  <body>
        <div id="map"></div>

            <div  class="text-center"><input type="text" id="citycode" placeholder="도시코드 입력"><button id="btnSearch">검색하기</button></div>

  </body>
</html>   