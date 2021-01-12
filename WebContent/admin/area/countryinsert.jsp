<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../main/header.jsp" />
<div class="content-wrapper">
	<div class="content-header">
		<div class="container-fluid">
		</div>
	</div>
<div class="container">
	<div class="row">
		<form action="countryinserting.jsp" method="POST">
		<br>
		<h1>국가 등록</h1>
		<hr>
			<div class="form-group">
				<label>국가코드</label>
			  <input type="text" class="form-control" name="country_code" >
			</div>
			<div class="form-group">
				<label>한글 국가명</label>
			  <input type="text" class="form-control"  name="country_kr_name">
			</div>
			<div class="form-group">
				<label>영어 국가명</label>
			  <input type="text" class="form-control"  name="country_en_name" >
			</div>
			<div class="form-group">
				<label>국기 이미지</label>
			  <input type="text" class="form-control"  name="country_flag_img" >
			</div>
			<button type="submit" class="btn btn-primary">등록</button>
			
			<button type="reset" class="btn btn-primary">취소</button>
		  </form>
	</div>
</div>
</div>
<jsp:include page="../main/footer.jsp" />