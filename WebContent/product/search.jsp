<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
$( document ).ready(function(){
   
	//테스트용 데이터
	var sel1 = {
    	" ":"성별선택",
    	"F":"여성",
        "M":"남성"
    };
    
    //sel1이 여성일경우
    var sel2_1 = {
    	" ":"여성검진항목 선택",
    	"C01": "여성검진1",
        "C02": "여성검진2",
        "C03": "여성검진3",
        "C04": "여성검진4"
    };
    
    //sel1이 남성일경우
    var sel2_2 = {
    	" ":"남성검진항목 선택",
    	"D01": "남성검진1",
        "D02": "남성검진2",
        "D03": "남성검진3",
        "D04": "남성검진4"
    };
    
   //sel1에 서버에서 받아온 값을 넣기위해..
   // map배열과 select 태그 id를 넘겨주면 option 태그를 붙여줌.
   // map[키이름] = 그 키에 해당하는 value를 반환한다.
   //retOption(데이터맵, select함수 id)
   function retOption(mapArr, select){
    	var html = '';
    	var keys = Object.keys(mapArr);
    	for (var i in keys) {
    	    html += "<option value=" + "'" + keys[i] + "'>" + mapArr[keys[i]] + "</option>";
    	}
        
        $("select[id='" + select +"']").html(html);
   }
   
   $("select[id='sel1']").on("change", function(){
    	var option = $("#sel1 option:selected").val();
        var subSelName = '';
    	if(option == "F") {
        	subSelName = "sel2_1";
        } else if(option == "M"){
        	subSelName = "sel2_2";
        } else{
        	$("#sel2").hide();
        	return;
        }
        $("#sel2").show();
        retOption(eval(subSelName), "sel2");
    })
   retOption(sel1, "sel1");
});

</script>
성별을 선택하세요
<select name="sel1" id="sel1">
</select>

<select name="sel2" id="sel2" style="display: none">
</select> --%>
