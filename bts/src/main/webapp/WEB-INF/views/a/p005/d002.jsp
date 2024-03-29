<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/resources/css/admin/style.css"> 
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="${contextPath}/resources/ibsheet/ibsheetinfo.js"></script>
<script src="${contextPath}/resources/ibsheet/ibsheet.js"></script>
<script src="${contextPath}/resources/ibsheet/ibleaders.js"></script>

<script language="javascript">
	//시트 높이 계산용
	var pageheightoffset = 200;
	
	/*Sheet 기본 설정 */
	function LoadPage() {
		mySheet.RemoveAll();
		//아이비시트 초기화
		var initSheet = {};
		initSheet.Cfg = {SearchMode:smLazyLoad,ToolTip:1};
		initSheet.HeaderMode = {Sort:1,ColMove:1,ColResize:1,HeaderCheck:1};
		initSheet.Cols = [
			//SaveName은 보통 VO 속성명과 일치시켜줌.
			//MinWidth를 선언하면 줄여도 그 설정한 값 밑으로 줄어들지 않음.
			//align은 데이터를 정렬하는 방법.
			//MultiLineText설정하면 shift+enter 누를 때 하나의 셀 안에 여러 값을 넣을 수 있음.
			//Wrap은 컬럼 사이즈가 정해져 있지만 데이터 길이가 더 길 때, 뒷 부분은 알아서 줄 바꿈 해줌.
			{Header:"상태",Type:"Status",SaveName:"STATUS",MinWidth:50, Align:"Center"}, //모든 그리드에 들어감
			{Header:"삭제",Type:"DelCheck",SaveName:"DEL_CHK",MinWidth:50}, //모든 그리드에 들어감
			{Header:"ID",Type:"Text",SaveName:"member_id",MinWidth:80,Align:"Center"},
			{Header:"비밀번호",Type:"Text",SaveName:"password",MinWidth:80,KeyField:1 ,MultiLineText:1}, //필수값을 체크하고자 할 때 keyField사용			
			{Header:"이름",Type:"Text",SaveName:"name",MinWidth:150,KeyField:1 ,MultiLineText:1, Wrap:1}, //KeyField는 반드시 입력하고자 하는 값을 설정하고플 때.
			{Header:"이메일",Type:"Text",SaveName:"email",MinWidth:150},
			{Header:"닉네임",Type:"Text",SaveName:"nick_name",MinWidth:100},
		];   
		IBS_InitSheet( mySheet , initSheet);

		mySheet.SetEditableColorDiff(1); // 편집불가능할 셀 표시구분
        //mySheet.ShowSubSum([{StdCol:"Release",SumCols:"price",Sort:"asc"}]);
		//doAction('search');
	}
	
	/*Sheet 각종 처리*/
	function doAction(sAction) {
		switch(sAction) {
			case "search": //조회
			    var param = FormQueryStringEnc(document.frm);
				mySheet.DoSearch("${contextPath}/admin/searchMember", param);
				//mySheet.DoSearch("transaction_data2.json");
				console.log(param);
				break;
			case "reload": //초기화
				mySheet.RemoveAll();
				break;
			case "save": // 저장
				//var tempStr = mySheet.GetSaveString();
				//alert("서버로 전달되는 문자열 확인 :"+tempStr);
				mySheet.DoSave("${contextPath}/admin/saveMember");
				break;			
			case "insert": //신규행 추가
				var row = mySheet.DataInsert();
				break;
		}
	}
	
	// 조회완료 후 처리할 작업
	function mySheet_OnSearchEnd() {
      
	}
	
	// 저장완료 후 처리할 작업
	// code: 0(저장성공), -1(저장실패)
	function mySheet_OnSaveEnd(code,msg){
		if(msg != ""){
			alert(msg);	
			//번호 다시 매기기
            //mySheet.ReNumberSeq();
		}	
	}	
	
</script>
</head>
<body onload="LoadPage()">
  <div class="page_title">
    <span><a class="closeDepth" href="#">closeDepth</a></span> 
    <span class="title">회원관리 > <b>회원 목록 수정</b></span>
  </div>
  <div class="main_content">
    <div class="exp_product">각 행의 데이터를 수정하거나 입력,삭제시 상태컬럼의 변화를
			확인하고,저장 버튼 클릭시 서버로 전송되는 데이터를 확인한다.</div>
    <div class="exp_product">
      <form name='frm'>
        ID: <input type='text' id="p_id" name="p_id" /> 
      </form>
    </div>
    <div class="ib_function float_right">
	  <a href="javascript:doAction('reload')" class="f1_btn_gray lightgray">초기화</a>
	  <a href="javascript:doAction('insert')" class="f1_btn_gray lightgray">추가</a>
	  <a href="javascript:doAction('search')" class="f1_btn_white gray">조회</a>
	  <a href="javascript:doAction('save')" class="f1_btn_white gray">저장</a>
	</div>

	<div class="clear hidden"></div>
	<div><script>createIBSheet("mySheet", "100%", "100%");</script></div>
  </div>
</body>
</html>