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

	if (value == "0") // 메인홈
	{
		location.href = "../index.html";
	}
	else if (value == "1") // 물가 정보
	{
		location.href = "../product/localsearch.jsp";
	}

	else if (value == "2") // 로그인
	{
		location.href = "../user/login.jsp";
	}
		
	else if (value == "3") // 로그아웃
	{
	    location.href = "../user/logout.jsp";
	}
	
	else if (value == "4") // 관리자페이지
	{
	    location.href = "../admin/index.html";
	}	
	
	else if (value == "5") // 마이페이지
	{
	    location.href = "../user/mypage.jsp";
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


		$.ajax({
			url: 'https://api.manana.kr/exchange.json',
			type: 'GET',
		}).done((data, textStatus, jqXHR) => {
			//태국 : USD/THB, 베트남 : USD/VND, 라오스 : USD/LAK, 싱가포르 : USD/SGD, 말레이시아 : USD/MYR
	
			//한개씩 뽑는 테스트
			// var kkk = data.filter(function (item) { return item.name == "USD/KRW" });
			// var kkk2 = kkk[0].price;
			// var e =  Math.round(kkk2 * 100) / 100; 
			// console.log(kkk2);
			// alert(kkk2);
			
			
			//시장가(한화)를 가져온다. won =  2920원
			var won = $('#korwon').attr('value'); 
			//달러 환율을 가져온다. e = 1080.30
			var kkk = data.filter(function (item) { return item.name == "USD/KRW" });
			var kkk2 = kkk[0].price;
			var e =  Math.round(kkk2 * 100) / 100; 
			//가져온 한화를 달러로 변환한다. won의 달러 가격은 2.6880235662340053
			var wonexchange = won/e;
			console.log("달러가격" + wonexchange);

			//물품의 해당 나라 ${country}를 가져온다. exchange = 태국
			var exchange = $('#exchange').attr('value');			
			var array = ["USD/THB", "USD/LAK", "USD/MYR", "USD/VND", "USD/SGD"];
			var array2 = ["태국", "라오스", "말레이시아", "베트남", "싱가폴"];
			var array3 = ["밧", "킵", "링깃", "동", "달러"]
			
			//part2. 최고가와 최저가를 변환한다.
			var topprice = $('#topprice').attr('value'); //3920원
			var topprice1 = topprice/kkk2; //3.608579582067569 달러
			console.log("topprice1 " + topprice1);
			var rowprice = $('#rowprice').attr('value'); //1920원
			var rowprice1 = rowprice/kkk2; //1.767467550400442 달러
			console.log("rowprice1 " + rowprice1);

			for(var i=0; i<array2.length; i++){
				if(array2[i] == exchange){
					//alert(array2[i]+"해당있음");//참이라면
					//맞는 배열의 나라를 환율 데이터를 가져온다.
					var excutemoney = data.filter(function (item) { return item.name == array[i] });
					var excutemoney2 = excutemoney[0].price;
					//데이터를 정리한다.
					var excutemoney3 =  Math.round((excutemoney2*wonexchange) * 100) / 100;
					$('#exchange').text(excutemoney3 + array3[i]);

					var topprice2 =  Math.round((excutemoney2*topprice1) * 100) / 100;
					$('#toppricechange').text(topprice2 + array3[i]);

					var rowprice2 =  Math.round((excutemoney2*rowprice1) * 100) / 100;
					$('#rowpricechange').text(rowprice2 + array3[i]);


					break;
				}else{
					console.log("매칭되는 나라 없음");
				}
			}

		}), (jqXHR, textStatus, errorThrown) => {
			console.log('실패')
		};
								
