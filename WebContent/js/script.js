/**
 * 로그인 미리 붙여놓음.
 * 참조 : https://all-record.tistory.com/116
 */

window.addEventListener("load", setup, false);
	
function setup(){
	var k = $('#titletext').attr('class');
	if(k == 'menu1'){
		$('.navbar-nav').children(":eq(0)").addClass('active');
	}
}


function changeView(value) {

	if (value == "0") // HOME 버튼 클릭시 첫화면으로 이동
	{
		location.href = "../index.html";
	}
	else if (value == "1") // go to 물가 정보
	{
		location.href = "../product/localsearch.jsp";
	}
}
	// else if (value == "1") // 로그인 버튼 클릭시 로그인 화면으로 이동
	// {
	// 	location.href = "../product/product.jsp";
	// }	
	// else if (value == "2") // 회원가입 버튼 클릭시 회원가입 화면으로 이동
	// {
	// 	location.href = "signup.jsp";
	// }
	// else if (value == "3") // 로그아웃 버튼 클릭시 로그아웃 처리
	// {
	// 	location.href = "logout.jsp";
	// }

//}

