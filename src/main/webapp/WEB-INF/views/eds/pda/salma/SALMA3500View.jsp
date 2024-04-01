<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>

	<style>
		.tui-grid-cell-header {
			font-size: 12px;
		}

		.tui-grid-cell-content {
			font-size: 12px;
		}

		.tui-grid-cell-summary {
			font-size: 12px;
		}
	</style>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
	<!-- Navbar -->
	<header class="main-header">
		<!-- Header Navbar: style can be found in header.less -->
		<nav class="navbar navbar-static-top">
			<!-- Sidebar toggle button-->
			<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
				<span class="sr-only">Toggle navigation</span>
			</a>

			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav">
					<!-- User Account: style can be found in dropdown.less -->
					<li class="dropdown user user-menu">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<img src="/AdminLTE_main/dist/img/edsLogo_small.png" class="user-image" alt="User Image">
							<span class="hidden-xs">${LoginInfo.corpNm}</span>
						</a>
						<ul class="dropdown-menu">
							<!-- User image -->
							<li class="user-header">
								<img src="/AdminLTE_main/dist/img/edsLogo_small.png" class="img-circle" alt="User Image">

								<p>
									${LoginInfo.busiNm} - ${LoginInfo.empNm}
								</p>
							</li>
							<li class="user-footer">
								<div class="pull-left">
<%--									<a href="/LOGIN/RESET" class="btn btn-default btn-flat">비밀번호재설정</a>--%>
								</div>
								<div class="pull-right">
									<a href="/LOGIN/LOGOUT" class="btn btn-default btn-flat">로그아웃</a>
								</div>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
	</header>
	<!-- /.navbar -->

	<!-- Main Sidebar Container -->
	<!-- Left side column. contains the logo and sidebar -->
	<aside class="main-sidebar" style="padding-top: 50px;">
		<!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar">
			<!-- Sidebar user panel -->
			<div class="user-panel">
				<div class="pull-left image">
					<img src="/AdminLTE_main/dist/img/avatar5.png" class="img-circle" alt="User Image">
				</div>
				<div class="pull-left info">
					<p>${LoginInfo.empNm} / ${LoginInfo.respDiviNm}</p>
					<p>${LoginInfo.busiNm}</p>
					<!-- <a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
				</div>
			</div>
			<!-- sidebar menu: : style can be found in sidebar.less -->
			<ul class="sidebar-menu" data-widget="tree" id="documents">
				<li class="header">MAIN NAVIGATION</li>
				<li class="active"><a href="/eds/pda/salma/selectSALMA3500View"><i class="fa fa-circle-o"></i> 출고등록</a></li>
				<li><a href="/eds/pda/salma/selectSALMA4500View"><i class="fa fa-circle-o"></i> 반품등록</a></li>
			</ul>
		</section>
		<!-- /.sidebar -->
	</aside>
	<!-- /.Main Sidebar Container -->

	<div class="content-wrapper">
		<!-- Main content -->
		<section class="content" style="margin: 0; padding: 0;">
			<div class="row">
				<div class="col-md-12">
					<!-- 검색조건 영역 -->
					<div class="row">
						<div class="col-md-12" style="border-bottom:2px solid; border-bottom-color:#E9E7E2;">
							<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
								<!-- form start -->
								<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
									<!-- input hidden -->
									<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
									<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
									<input type="hidden" name="busiNm" id="busiNm" title="사업장명">
									<input type="hidden" name="custCd" id="custCd" placeholder="거래처코드" disabled>
									<input type="hidden" name="deleteStatus" id="deleteStatus" title="삭제상태">
									<script type="text/javascript">
										const interval = setInterval(ev => {
											if(document.getElementById("deleteStatus").value === "running"){
												if(document.getElementById("btnDelete1").className == "btn btn-sm btn-danger"){
													document.getElementById("btnDelete1").className = "btn btn-sm btn-default"
												}else{
													document.getElementById("btnDelete1").className = "btn btn-sm btn-danger"
												}
											}else{
												document.getElementById("btnDelete1").className = "btn btn-sm btn-danger"
											}
										}, 500);
									</script>

									<%--                                    <label style="margin-bottom: 0;">거래처 &nbsp;</label>--%>
									<div class="form-group input-group input-group-sm" style="margin-bottom: 2px;">
										<input type="text" class="form-control" style="font-size: 14px;" name="custNm" id="custNm" placeholder="거래처명" disabled>
										<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnCustCd" id="btnCustCd" onclick="fn_custPopup(); return false;"><i class="fa fa-search"></i></button></span>
									</div>

									<div class="form-group input-group input-group-sm" style="margin-bottom: 0px;">
										<input type="text" class="form-control" style="font-size: 14px;" name="lotNo" id="lotNo" placeholder="바코드" inputmode="none">
										<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnLotNo" id="btnLotNo"><i class="fa fa-barcode"></i></button></span>
										<input type="date" class="form-control" style="font-size: 18px;" name="exDt" id="exDt" title="출고일자">
									</div>
								</form>
								<!-- ./form -->
							</div>
						</div>
					</div>
					<!-- 그리드 영역 -->
					<div class="row">
						<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
							<div class="pull-left" style="padding: 5px 0 0 5px">
								<i class="fa fa-file-text-o"></i> 출고 목록
							</div>
							<div class="btn-group pull-right">
								<form class="form-inline" role="form" name="SALMA3500ButtonForm" id="SALMA3500ButtonForm" method="post" onsubmit="return false;">
									<button type="button" class="btn btn-sm btn-default" name="btnSearch" id="btnSearch" onclick="doAction('SALMA3500Sheet', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('SALMA3500Sheet', 'input')" ><i class="fa fa-plus"></i> 신규</button>
<%--									<button type="button" class="btn btn-sm btn-success" name="btnSave" id="btnSave" onclick="doAction('SALMA3500Sheet', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
									<button type="button" class="btn btn-sm btn-danger" name="btnDelete" id="btnDelete" onclick="doAction('SALMA3500Sheet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
								</form>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12" style="height: 100%;" id="SALMA3500">
							<!-- 시트가 될 DIV 객체 -->
							<div id="SALMA3500SheetDIV" style="width:100%; height:100%;"></div>
						</div>
					</div>
					<!-- 그리드 영역 -->
					<div class="row">
						<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
							<div class="pull-left" style="padding: 5px 0 0 5px">
								<i class="fa fa-file-text-o"></i> 품목 목록
							</div>
							<div class="btn-group pull-right">
								<form class="form-inline" role="form" name="SALMA3501ButtonForm" id="SALMA3501ButtonForm" method="post" onsubmit="return false;">
									<button type="button" class="btn btn-sm btn-default" name="btnSearch1" id="btnSearch1" onclick="doAction('SALMA3501Sheet', 'search')"><i class="fa fa-search"></i> 조회</button>
<%--									<button type="button" class="btn btn-sm btn-primary" name="btnInput1" id="btnInput1" onclick="doAction('SALMA3501Sheet', 'input')" ><i class="fa fa-plus"></i> 신규</button>--%>
<%--									<button type="button" class="btn btn-sm btn-success" name="btnSave1" id="btnSave1" onclick="doAction('SALMA3501Sheet', 'save')"><i class="fa fa-save"></i> 저장</button>--%>
									<button type="button" class="btn btn-sm btn-danger" name="btnDelete1" id="btnDelete1" onclick="doAction('SALMA3501Sheet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
								</form>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12" style="height: 100%;" id="SALMA3501">
							<!-- 시트가 될 DIV 객체 -->
							<div id="SALMA3501SheetDIV" style="width:100%; height:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>

<script>
	var SALMA3500Sheet, SALMA3501Sheet;

	$(document).ready(async function () {
		if(!checkStorage()) await sStorage();
		init();

		$('#searchForm #exDt').on('change', function(e) {
			doAction("SALMA3500Sheet", "search");
		});

		$("#btnLotNo").click(function(e) {
			if(($("#lotNo").val()).length>0){
				doAction("SALMA3501Sheet", "input");
			}
		});

		$("#lotNo").keyup(function(e) {
			if(e.keyCode == "13"){
				doAction("SALMA3501Sheet", "input");
				doAction("SALMA3501Sheet", "search");
			}
		});

		document.getElementById("btnDelete1").addEventListener("click", ev => {

			$('#lotNo').focus();

			var deleteStatus = document.getElementById("deleteStatus").value
			if(deleteStatus != "running"){
				document.getElementById("deleteStatus").value = "running"
				return toastrmessage("toast-top-center", "error", "삭제모드로 변환합니다.", "삭제", 3000);
			}else{
				document.getElementById("deleteStatus").value = ""
				return toastrmessage("toast-top-center", "success", "입력모드로 변환합니다.", "입력", 3000);
			}
		});
	});

	/* 공통 load */
	async function sStorage() {
		let result = await axios.get('/eds/erp/com/selectCOMMCDENUM');
		sessionStorage.setItem('commonCode',JSON.stringify(result.data) );
		var str = sessionStorage.getItem('commonCode');
		_commonCode = JSON.parse(str);
	}

	/* 초기설정 */
	function init() {
		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#searchForm"), "salma");

		/* 조회옵션 셋팅 */
		document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
		document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
		document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';
		document.getElementById('exDt').value = edsUtil.getToday('%Y-%m-%d');

		/**********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		/* 그리드 초기화 속성 설정 */
		SALMA3500Sheet = new tui.Grid({
			el: document.getElementById('SALMA3500SheetDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum', 'checkbox'],
			header: {
				height: 40,
				minRowHeight: 40,
			},
			columns:[],
			columnOptions: {
				resizable: true,
				/*frozenCount: 1,
				frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
			},
		});

		SALMA3500Sheet.setColumns([
			{ header:'거래처명',		name:'custNm',		minWidth:150,	align:'left', defaultValue: ''},
			{ header:'담당자명',		name:'picNm',		width:100,		align:'center', defaultValue: ''},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'Center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		minWidth:100,	align:'Center',	hidden:true },
			{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	hidden:true },
			{ header:'매출마감구분',	name:'saleCloseDivi',	minWidth:100,	align:'center',	formatter: 'listItemText',
				editor: {
					type: 'select',
					options: {
						listItems:setCommCode("COM010")
					}
				}
				,hidden:true
			},
			{ header:'납품처명',		name:'suppNm',		width:150,	align:'left'
				,formatter:function(value){
					return "<a href='javascript:fn_colPopup(\""+value.column.name +"\","+ value.row.rowKey +");'><i class='fa fa-search'></i></a>" +"<span> "+ value.value +"</span>";
				}
				,defaultValue: ''
				,hidden:true
			},
			{ header:'마감',			name:'closeYn',		minWidth:55,	align:'center'
				,formatter: function (value){
					if(value.value == 1){
						return 'Y'
					}else{
						return 'N'
					}
				}
				,filter: { type: 'select', showApplyBtn: true, showClearBtn: true }
				,hidden:true
			},
			{ header:'출고번호',		name:'exNo',		width:100,		align:'center',	hidden:true },
			{ header:'출고일자',		name:'exDt',		width:120,		align:'center',	hidden:true },
			{ header:'거래처코드',	name:'custCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'공급가액',		name:'supAmt',		minWidth:150,	align:'right',	hidden:true },
			{ header:'세액',			name:'tax',			minWidth:150,	align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt',		minWidth:150,	align:'right',	hidden:true },
			{ header:'납품처코드',	name:'suppCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'담당자코드',	name:'picCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'부서코드',		name:'depaCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'부서명',		name:'depaNm',		minWidth:100,	align:'left',	hidden:true },
			{ header:'사원코드',		name:'empCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'사원명',		name:'empNm',		minWidth:100,	align:'left',	hidden:true },
			{ header:'비고',			name:'remark',		minWidth:200,	align:'left',	hidden:true },
		]);

		SALMA3501Sheet = new tui.Grid({
			el: document.getElementById('SALMA3501SheetDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
			header: {
				height: 40,
				minRowHeight: 40,
			},
			columns:[],
			columnOptions: {
				// frozenCount: 1,
				// frozenBorderWidth: 1,
				// minWidth: '202',
				// resizable: true
			},
		});

		SALMA3501Sheet.setColumns([
			{ header:'품목명',		name:'itemNm',		width:202,	align:'Left'	},
			{ header:'입수량',		name:'boxQty',		width:100,	align:'right'
				,formatter: function (value){
					return edsUtil.addComma(value.value);
				}
				,defaultValue: ''
			},
			{ header:'바코드',		name:'lotNo',		width:202,	align:'Left'	},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'출고번호',		name:'exNo',		minWidth:100,	align:'center', hidden:true },
			{ header:'순번',			name:'seq',			minWidth:100,	align:'left',	hidden:true },
			{ header:'적용수량',		name:'applyQty',	minWidth:100,	align:'left',	hidden:true },
			{ header:'규격',			name:'stan',		minWidth:100,	align:'center',	hidden:true },
			{ header:'납기마감일자',	name:'deliCloseDt',	minWidth:120,	align:'center',	hidden:true },
			{ header:'출고예정일자',	name:'exDueDt',		minWidth:120,	align:'center',	hidden:true },
			{ header:'출고요청번호',	name:'exRequNo',	minWidth:100,	align:'center',	hidden:true },
			{ header:'프로젝트코드',	name:'projCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'프로젝트명',	name:'projNm',		minWidth:150,	align:'left',	hidden:true },
			{ header:'계정구분',		name:'acDiviCd',	width:80,		align:'center',	hidden:true },
			{ header:'단가',			name:'upr',			width:100,		align:'right',	hidden:true },
			{ header:'공급가액',		name:'supAmt',		width:150,		align:'right',	hidden:true },
			{ header:'세액',			name:'tax',			width:120,		align:'right',	hidden:true },
			{ header:'합계금액',		name:'totAmt',		width:150,		align:'right',	hidden:true },
			{ header:'최종단가',		name:'upr2',		width:120,		align:'right',	hidden:true },
			{ header:'최종공급가액',	name:'supAmt2',		width:150,		align:'right',	hidden:true },
			{ header:'최종세액',		name:'tax2',		width:120,		align:'right',	hidden:true },
			{ header:'최종합계금액',	name:'totAmt2',		width:150,		align:'right',	hidden:true },
			{ header:'견적코드',		name:'estiCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'비고',			name:'remark',		minWidth:200,	align:'left',	hidden:true },
			{ header:'품목코드',		name:'itemCd',		width:80,		align:'center',	hidden:true },
			{ header:'규격',			name:'inveUnit',	width:80,		align:'center',	hidden:true },
			{ header:'수량',			name:'qty',			width:80,		align:'right',	hidden:true },
			{ header:'할인할증구분',	name:'dcEcDivi',	minWidth:120,	align:'center',	hidden:true },
			{ header:'할인할증율',	name:'dcEcRate',	minWidth:120,	align:'center',	hidden:true },
			{ header:'창고코드',		name:'storCd',		minWidth:100,	align:'center',	hidden:true },
			{ header:'창고명',		name:'storNm',		minWidth:150,	align:'Left',	hidden:true },
			{ header:'주문번호',		name:'reordNo',		minWidth:100,	align:'center',	hidden:true },
			{ header:'과세구분',		name:'taxDivi',		width:80,		align:'center',	hidden:true },
			{ header:'VAT',			name:'vatDivi',		width:80,		align:'center',	hidden:true },
		]);

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/

		SALMA3500Sheet.on('focusChange', ev => {
			if(ev.rowKey != ev.prevRowKey){
				setTimeout(function(){
					doAction("SALMA3501Sheet", "search");
				}, 100);
			}
		});

		SALMA3501Sheet.on('focusChange', ev => {
			if(ev.rowKey != ev.prevRowKey){
				setTimeout(function(){
					$('#lotNo').focus();
				}, 100);
			}
		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		document.getElementById('SALMA3500').style.height = 120 + 'px';
		var height = window.innerHeight - document.getElementById('SALMA3500SheetDIV').clientHeight - 191;
		document.getElementById('SALMA3501').style.height = height + 'px';

		/* 조회 */
		doAction("SALMA3500Sheet", "search");
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	function doAction(sheetNm, sAction) {
		if (sheetNm == 'SALMA3500Sheet') {
			switch (sAction) {
				case "search":// 조회

					SALMA3501Sheet.finishEditing(); // 데이터 초기화
					SALMA3501Sheet.clear(); // 데이터 초기화

					SALMA3500Sheet.finishEditing(); // 데이터 초기화
					SALMA3500Sheet.clear(); // 데이터 초기화
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.exDt = edsUtil.removeMinus(document.getElementById('exDt').value);
					SALMA3500Sheet.resetData(edsUtil.getAjax("/eds/pda/salma/selectSALMA3500", param)); // 데이터 set

					if(SALMA3500Sheet.getRowCount() > 0 ){
						SALMA3500Sheet.focusAt(0, 0, true);
					}

					setTimeout(function(){
						$('#lotNo').focus();
					}, 100);
					break;
				case "input":// 신규

					if(($("#searchForm #custCd").val()).length != 5){
						$('#lotNo').focus();
						return toastrmessage("toast-top-center", "error", "거래처를 입력하세요.", "경고", 1500);
					}

					var appendedData = {};
					appendedData.sStatus = "I";
					appendedData.corpCd = $("#searchForm #corpCd").val();
					appendedData.busiCd = $("#searchForm #busiCd").val();
					appendedData.custCd = $("#searchForm #custCd").val();
					appendedData.closeYn = '0';
					appendedData.exDt = edsUtil.getToday("%Y-%m-%d");
					appendedData.empCd = '<c:out value="${LoginInfo.empCd}"/>';
					appendedData.empNm = '<c:out value="${LoginInfo.empNm}"/>';
					appendedData.depaCd = '<c:out value="${LoginInfo.depaCd}"/>';
					appendedData.depaNm = '<c:out value="${LoginInfo.depaNm}"/>';

					SALMA3500Sheet.prependRow(appendedData, { focus:true }); // 마지막 ROW 추가

					edsUtil.doSave("/eds/pda/salma/insertSALMA3500", "SALMA3500Sheet", SALMA3500Sheet);

					break;
				case "delete"://삭제
					edsUtil.doDel("/eds/pda/salma/insertSALMA3500", "SALMA3500Sheet", SALMA3500Sheet);
					break;
			}
		}else if (sheetNm == 'SALMA3501Sheet') {
			switch (sAction) {
				case "search":// 조회
					SALMA3501Sheet.finishEditing(); // 데이터 초기화
					SALMA3501Sheet.clear(); // 데이터 초기화

					var row = SALMA3500Sheet.getFocusedCell();
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.exNo = SALMA3500Sheet.getValue(row.rowKey, "exNo");// Key
					SALMA3501Sheet.resetData(edsUtil.getAjax("/eds/pda/salma/selectSALMA3501", param)); // 데이터 set

					$('#lotNo').val('');

					// 마감 처리된 메인 시트에 대한 서브 시트 처리
					edsUtil.setClosedRow(SALMA3500Sheet,SALMA3501Sheet)
					setTimeout(function () {
						$('#lotNo').focus();
					}, 100);

					break;
				case "input":// 신규

					var row = SALMA3500Sheet.getFocusedCell();
					if(!SALMA3500Sheet.getValue(row.rowKey, "exNo")){
						toastrmessage("toast-bottom-center", "error", "출고목록 저장후 사용하세요.", "실패", 1500);
						return;
					}

					var data = new Array();

					var deleteStatus = document.getElementById("deleteStatus").value
					if(deleteStatus != "running"){
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.sStatus = "I";
						param.corpCd = $("#searchForm #corpCd").val();
						param.busiCd = $("#searchForm #busiCd").val();
						param.exNo = SALMA3500Sheet.getValue(row.rowKey, "exNo");
						param.boxQty = 1;
						param.taxDivi = '01';
						param.vatDivi = '01';
						param.storCd = '<c:out value="${LoginInfo.storCd}"/>';
						param.storNm = '<c:out value="${LoginInfo.storNm}"/>';
						param.lotNo = document.getElementById('lotNo').value;

						data.push(param)

						$.ajax({
							url: '/eds/pda/salma/insertSALMA3504',
							headers: {
								'X-Requested-With': 'XMLHttpRequest'
							},
							dataType: "json",
							contentType: "application/json; charset=UTF-8",
							type: "POST",
							async: false,
							data: JSON.stringify({data: data}),
							success: function (result) {
								if (result.IO.Result == 0) { // 정상 저장
									toastrmessage("toast-bottom-center", "success", result.IO.Message, "성공", 1500);
									doAction(SALMA3500Sheet, "search");
								} else if (result.IO.Result == -1) { // 실적처리되지 않은 바코드
									toastrmessage("toast-bottom-center", "error", result.IO.Message, "실패", 1500);
								} else if (result.IO.Result == -2) {  // 중복 바코드
									toastrmessage("toast-bottom-center", "error", result.IO.Message, "실패", 1500);
								} else if (result.IO.Result == -3) {  // 중복 바코드
									toastrmessage("toast-bottom-center", "error", result.IO.Message, "실패", 1500);
								} else { // 저장 실패
									toastrmessage("toast-bottom-center", "error", result.IO.Message, "실패", 1500);
								}

								document.getElementById('lotNo').value = '';
							}
						});

					}else{

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						var data = new Array();
						data.push(param)
						$.ajax({
							url: '/eds/pda/salma/deleteSALMA3503',
							headers: {
								'X-Requested-With': 'XMLHttpRequest'
							},
							dataType: "json",
							contentType: "application/json; charset=UTF-8",
							type: "POST",
							async: false,
							data: JSON.stringify({data: data}),
							success: function (result) {
								if (!result.sess && typeof result.sess != "undefined") {
									alert("세션이 종료되었습니다. 다시 로그인 해주세요.");
									return;
								}

								if (result.IO.Result == 0) {
									toastrmessage("toast-bottom-center", "success", result.IO.Message, "성공", 1500);
									doAction(sheetName, "search");
								} else {
									toastrmessage("toast-bottom-center", "error", result.IO.Message, "실패", 1500);
								}
							}
						});
					}

					break;
			}
		}
	}

	/**********************************************************************
	 * 화면 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 START
	 ***********************************************************************/

	// 거래처 팝업
	function fn_custPopup(){
		var param = {};
		param.custCd = $('#searchForm #custCd').val();
		edsPopup.util.openPopup(
				"CUSTPOPUP",
				param,
				function (value) {
					this.returnValue = value||this.returnValue;
					if(this.returnValue){
						document.getElementById('custCd').value = this.returnValue.custCd;
						document.getElementById('custNm').value = this.returnValue.custNm;
						doAction('SALMASALMA3501', 'search');
					}
				},
				true,
				true
		);
	}

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
</body>
</html>
