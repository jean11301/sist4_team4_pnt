<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="select" class="com.example.libs.service.MemberService" />
<%
	String result = "false";
	String user_id = request.getParameter("user_id");
	boolean check = select.idCheck(user_id);
	if(check){  //사용가능한 아이디라면
		result = "true";
	}else{  //사용 불가능한 아이디라면
		result = "false";
	}
	out.println(result);
%>