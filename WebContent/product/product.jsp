<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../main/header.jsp" />

<div id="titletext" class="menu1">물가 정보</div>

<div class="row">
	<div class="col-sm-2 side_search">
		<h4>상세검색</h4>
		<hr />
		<form class="ml-1">
			<div class="form-group">
				<label for="sel1">나라선택</label>
				<select class="form-control" id="sel1">
					<option>태국</option>
					<option>베트남</option>
					<option>라오스</option>
					<option>싱가포르</option>
					<option>말레이시아</option>
				</select>
			</div>
			<div class="form-group">
				<label for="sel1">지역선택</label>
				<select class="form-control" id="sel1">
					<option>나라를 선택시 지역로드</option>
					<option>나라를 선택시 지역로드</option>
					<option>나라를 선택시 지역로드</option>
					<option>나라를 선택시 지역로드</option>
					<option>나라를 선택시 지역로드</option>
				</select>
			</div>
		</form>
		<div class="form-group">
			<label for="sel1">시장선택</label>
			<select class="form-control" id="sel1">
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
				<jsp:include page="map_ex.html" />
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