<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../main/header.jsp" />
<script>
$(function(){
	let search = null;
	let country = null;
	let city = null;
	let market = null;
	$.ajax({
		method : 'POST',
		url : 'getcountrylist.jsp', //나라 선택 추가
		success : function(data){  
			myConParsor(data);
		}
	});
	$('#selCountry').on('change', function(){
		search = $(this).val();
		console.log(search);
		$.ajax({
			method : 'POST',
			url : 'getlocallist.jsp', //지역선택
			data : {    
				search : search
			},
			success : function(data){  
				myLocParsor(data);
			}
		});
		//console.log(search);	
	});
	$('#selCity').on('change', function(){
		search = $(this).val();

		console.log(search);
	});
	$('#selmarket').on('change', function(){
		search = $(this).val();
		console.log(search);
		$.ajax({
			method : 'POST',
			url : 'getMarketlist.jsp', //시장선택
			data : {    
				search : search
			},
			success : function(data){  
				myparsor(data);
			}
		});
	});
});
function myConParsor(serverdata){
		let str = "<option>-- 나라선택 --</option>";
		let idx = serverdata.lastIndexOf(",");
		let server = null;
		server = serverdata.substring(0, idx) + "]}";
		console.log(server);
		server = server.trim();
		let obj = JSON.parse(server); 
		let array = obj.data;   //배열데이터
		for(let i = 0 ; i < array.length ; i++){
			str += "<option ";
			str += "value='"+array[i].country_kr_name+"' >"+array[i].country_kr_name
			str += "</option>";
		}
	//console.log(str);
	$('#selCountry').html(str);
}
function myLocParsor(serverdata){
	let str = "<option>-- 지역 선택 --</option>";
	let idx = serverdata.lastIndexOf(",");
	let server = null;
	server = serverdata.substring(0, idx) + "]}";
	console.log(server);
	server = server.trim();
	let obj = JSON.parse(server); 
	let array = obj.data;   //배열데이터
	for(let i = 0 ; i < array.length ; i++){
		str += "<option ";
		str += "value='"+array[i].city_kr_name+"' >"+array[i].city_kr_name
		str += "</option>";
	}
console.log(str);
$('#selCity').html(str);
}
</script>
<div id="titletext" class="menu1">물가 정보</div>
<div class="row">
	<div class="col-sm-2 side_search">
		<h4>상세검색</h4>
		<hr />
		<form class="ml-1">
			<div class="form-group">
				<label for="sel1">나라선택</label>
				<select class="form-control" id="selCountry">
				</select>
			</div>
			<div class="form-group">
				<label for="sel1">지역선택</label>
				<select class="form-control" id="selCity">
				</select>
			</div>
		</form>
		<div class="form-group">
			<label for="sel1">시장선택</label>
			<select class="form-control" id="selmarket">
				<option>나라/지역을 선택시 시장로드</option>
				<option>나라/지역을 선택시 시장로드</option>
				<option>나라/지역을 선택시 시장로드</option>
				<option>나라/지역을 선택시 시장로드</option>
				<option>나라/지역을 선택시 시장로드</option>
			</select>
		</div>
		<label for="sel1">검색</label>
		<input type="text" class="form-control" placeholder="검색어를 입력하세요">
		<button type="submit" class="btn btn-success btn_search">검색</button>
		</form>
	</div>

	<div class="col-sm-10">
		<div class="row">
			<div class="page-header">
				<h2>Price information<small>&nbsp;&nbsp;Latest data</small></h2>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-5 pnt_map">
				<jsp:include page="gmapapi.jsp" />
			</div>
			<div class="col-sm-5 pnt_hit">
				<div class="row">
					<h4><strong>인기 검색 종목 물가</strong></h4>
					<div class="table-responsive">
						<table class="table">
							<tr>
								<td>태국</td>
								<td>호치민</td>
								<td>달랏시장</td>
								<td>바나나</td>
								<td>1,255원</td>
							</tr>
							<tr>
								<td>베트남</td>
								<td>하노이</td>
								<td>하노이시장</td>
								<td>사과</td>
								<td>890원</td>
							</tr>
							<tr>
								<td>태국</td>
								<td>호치민</td>
								<td>달랏시장</td>
								<td>바나나</td>
								<td>1,255원</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="row">
					<h4><strong>급변동 물가</strong></h4>
					<div class="table-responsive">
						<table class="table">
							<tr>
								<td>태국</td>
								<td>호치민</td>
								<td>달랏시장</td>
								<td>바나나</td>
								<td>2,355원</td>
								<td>8% 상승</td>
								<td>▲ 259</td>
							</tr>
							<tr>
								<td>태국</td>
								<td>호치민</td>
								<td>달랏시장</td>
								<td>바나나</td>
								<td>2,355원</td>
								<td>8% 상승</td>
								<td>▲ 259</td>
							</tr>
							<tr>
								<td>태국</td>
								<td>호치민</td>
								<td>달랏시장</td>
								<td>바나나</td>
								<td>2,355원</td>
								<td>8% 상승</td>
								<td>▲ 259</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<jsp:include page="../main/footer.jsp" />