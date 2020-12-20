<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/bootstrap.css" />
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('.openModal').on('click', function() {
			$('.modal').css({
				"display" : "block"
			})
		});
		$('.closeModal').on('click', function() {
			$('.modal').css({
				"display" : "none"
			})
		});
		$('.btn').on('click', function() {
			$('.modal').css({
				"display" : "none"
			})
		});
	});
</script>
<style>
.modal {
	display: none;
	position: absolute;
	width: 50vw;
	height: 80vh;
	border: 2px solid black;
	left: 20%;
}
.description{
	width: 8vw;
	height:8vh;
}
th{
text-align: "center";
}
table{
width: 100%

}
</style>
<button type="button" class="openModal">modal</button>
<div class="modal">
	<div class="row"></div>
	<div class="row">
		<div class="col-sm-10">
			<h4>상품 등록</h4>
		</div>
		<div class="col-sm-1">
			<h4 class="closeModal">X</h4>
		</div>
	</div>
	<div class="row">
	<table class="table tavle-bordered">
		<tr>
			<th>국가(한글)</th>
			<td></td>
			<th>도시(한글)</th>
			<td></td>
			<th>시장</th>
			<td></td>
		</tr>
		<tr>
			<th>상품명</th>
			<td colspan="5"></td>
		</tr>
		<tr>
			<th>이미지</th>
			<td colspan="6"></td>
		</tr>
		<tr>
			<th>상품가격</th>
			<td></td>
			<th>원(한화)</th>
			<td></td>
			<th>바트(베트남)</th>
			<td></td>
		</tr>
		<tr rowspan="3">
			<td colspan="6" ><textarea class="description" rows="5"
					placeholder="!포인트 > 올리면 100원
이미지를 올리면 추가로 100원
그럼 이미지랑 같이 올리게 되면 = 200원 을 적립해드려요.
						
데이터는 한화를 기준으로 저장됩니다.
타국 각가격의 시세는 환율을 기준으로 변동되어 저장되니 유의해주세요.
						
※ 상품 작성시 유의 사항
1개 혹은 kg단위로 입력 해야합니다.
상품은 한글로 입력해야 합니다.
조건 미충족시 포인트 지급되지 않습니다.
이미지를 올리면 추가 포인트를 드려요.">
			</textarea></td>
		</tr>
	</table>
	</div>
	<div class="row">
			<button class="btn">완료</button>
	</div>
</div>