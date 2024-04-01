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
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
</head>

<body>
<div class="row" style="position:relative">
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<!-- ./input hidden -->
				<div class="form-group">
					<label for="busiCd">사업장 &nbsp;</label>
					<div class="input-group-prepend">
						<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
					</div>
					<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>
					<div class="input-group-append">
						<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
					</div>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<select class="form-control selectpicker" style="width: 200px;" name="procStat" id="procStat" ></select>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<select class="form-control selectpicker" style="width: 200px;" name="riskLevel" id="riskLevel" ></select>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<select class="form-control selectpicker" style="width: 200px;" name="empCd" id="empCd" ></select>
				</div>
			</form>
			<!-- ./form -->
		</div>
	</div>
	<!-- 그리드 영역 -->
	<div class="col-md-12" id="errorLogList" style="height: calc(100vh - 6rem); width: 100%;">
		<!-- 시트가 될 DIV 객체 -->
		<div id="errorLogListDIV" style="width:100%; height:100%;"></div>
	</div>
	<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
		<div class="col text-center">
			<form class="form-inline" role="form" name="errorLogListButtonForm" id="errorLogListButtonForm" method="post" onsubmit="return false;">
				<div class="container">
					<div class="row">
						<div class="col text-center">
							<button type="button" class="btn btn-sm btn-primary" name="btnSearch"			id="btnSearch"				style="background-color: #544e4c" onclick="doAction('errorLogList', 'search')"><i class="fa fa-search"></i> 조회</button>
							<button type="button" class="btn btn-sm btn-primary" name="btnInput"			id="btnInput"				style="background-color: #544e4c" onclick="doAction('errorLogList', 'input')" ><i class="fa fa-plus"></i> 신규</button>

							<button type="button" class="invisible" 			 name="btnInputPopEv"		id="btnInputPopEv"			data-toggle="modal" data-target="#modalErrort"></button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="modal fade" id="modalErrort" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header bg-dark font-color" name="tabs" id="tabs" style="color: #4d4a41">
				<h4 class="modal-title">상세 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="col-md-12" style="height: 100%;" id="log">
					<form name="errorLogListForm" id="errorLogListForm">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<input type="hidden" name="seq" id="seq" title="순번">
						<div class="form-row">
							<div class="col-md-12 mb-3">
								<label for="note1"><b>적요</b></label>
								<input type="text" class="form-control text-left" id="note1" name="note1" placeholder="적요" title="적요">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-3 mb-3">
								<label for="procStat"><b>처리상태</b></label>
								<select class="form-control text-center" name="procStat" id="procStat" title="처리상태"></select>
							</div>
							<div class="col-md-3 mb-3">
								<label for="riskLevel"><b>위험수준</b></label>
								<select class="form-control text-center" name="riskLevel" id="riskLevel" title="위험수준"></select>
							</div>
							<div class="col-md-3 mb-3">
								<label for="modulNm"><b>모듈명</b></label>
								<input type="text" class="form-control text-center" id="modulNm" name="modulNm" placeholder="모듈명" title="모듈명">
							</div>
							<div class="col-md-3 mb-3">
								<label for="mamuNm"><b>메뉴명</b></label>
								<input type="text" class="form-control text-center" id="mamuNm" name="mamuNm" placeholder="메뉴명" title="메뉴명">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-3 mb-3">
								<label for="empNm"><b>담당자</b></label>
								<input type="hidden" name="empCd" id="empCd" title="담당자">
								<input type="text" class="form-control text-center" id="empNm" name="empNm" placeholder="담당자" title="담당자" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3">
								<label for="reqNm"><b>요청자</b></label>
								<input type="hidden" name="reqCd" id="reqCd" title="요청자">
								<input type="text" class="form-control text-center" id="reqNm" name="reqNm" placeholder="요청자" title="요청자" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3">
								<label for="busiNm"><b>사업장</b></label>
								<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
								<input type="text" class="form-control text-center" id="busiNm" name="busiNm" placeholder="사업장" title="사업장" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3">
								<label for="depaNm"><b>부서</b></label>
								<input type="hidden" name="depaCd" id="depaCd" title="부서">
								<input type="text" class="form-control text-center" id="depaNm" name="depaNm" placeholder="부서" title="부서" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-12 mb-3">
								<label for="note2"><b>메모</b></label>
								<textarea type="text" rows="16" class="form-control" id="note2" name="note2" placeholder="메모" value=""></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="errorLogModalButtonForm" id="errorLogModalButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnReset"	id="btnReset"	style="background-color: #544e4c" onclick="doAction('errorLogList', 'reset')"><i class="fa fa-trash"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnSave"		id="btnSave"	style="background-color: #544e4c" onclick="doAction('errorLogList', 'save')"><i class="fa fa-save"></i> 저장</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete"	id="btnDelete"	style="background-color: #544e4c" onclick="doAction('errorLogList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose"	id="btnClose"	style="background-color: #544e4c" onclick="doAction('errorLogList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<script>
	var errorLogList;
	var stDatePicker, edDatePicker;

	$(document).ready(async function () {
		await init();

		await $(".selectpicker").on('change',  async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'riskLevel':
				case 'procStat':
				case 'empCd':
				case 'busiCd': await doAction('errorLogList','search');
			}
		});

		document.getElementById('errorLogListForm').addEventListener('click', async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'empNm' : await popupHandler('user_emp','open'); break;
				case 'reqNm' : await popupHandler('user_req','open'); break;
			}
		});
	});

	/* 초기설정 */
	async function init() {

		class detailButtonRenderer {
			constructor(props) {
				const el = document.createElement('button');
				const text = document.createTextNode('수정하기');

				el.appendChild(text);
				el.setAttribute("class","btn btn-sm btn-primary");
				el.setAttribute("style","width: 78%;" +
						"padding: 0.12rem 0.5rem;" +
						"background-color: #544e4c");

				el.addEventListener('click', async (ev) => {

					var row = errorLogList.getFocusedCell();
					var seq = errorLogList.getValue(row.rowKey,'seq');
					if(seq == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '내역이 없습니다.',
						});
					}else{
						await doAction('errorLogList','inputPopup');
						await doAction('errorLogList','reset');

						document.querySelector('form[id="errorLogListForm"] input[id="corpCd"]').value = errorLogList.getValue(row.rowKey, 'corpCd');
						document.querySelector('form[id="errorLogListForm"] input[id="seq"]').value = errorLogList.getValue(row.rowKey, 'seq');
						document.querySelector('form[id="errorLogListForm"] input[id="modulNm"]').value = errorLogList.getValue(row.rowKey, 'modulNm');
						document.querySelector('form[id="errorLogListForm"] input[id="mamuNm"]').value = errorLogList.getValue(row.rowKey, 'mamuNm');
						document.querySelector('form[id="errorLogListForm"] input[id="busiCd"]').value = errorLogList.getValue(row.rowKey, 'busiCd');
						document.querySelector('form[id="errorLogListForm"] input[id="busiNm"]').value = errorLogList.getValue(row.rowKey, 'busiNm');
						document.querySelector('form[id="errorLogListForm"] input[id="depaCd"]').value = errorLogList.getValue(row.rowKey, 'depaCd');
						document.querySelector('form[id="errorLogListForm"] input[id="depaNm"]').value = errorLogList.getValue(row.rowKey, 'depaNm');
						document.querySelector('form[id="errorLogListForm"] input[id="empCd"]').value = errorLogList.getValue(row.rowKey, 'empCd');
						document.querySelector('form[id="errorLogListForm"] input[id="empNm"]').value = errorLogList.getValue(row.rowKey, 'empNm');
						document.querySelector('form[id="errorLogListForm"] input[id="reqCd"]').value = errorLogList.getValue(row.rowKey, 'reqCd');
						document.querySelector('form[id="errorLogListForm"] input[id="reqNm"]').value = errorLogList.getValue(row.rowKey, 'reqNm');
						document.querySelector('form[id="errorLogListForm"] select[id="riskLevel"]').value = errorLogList.getValue(row.rowKey, 'riskLevel');
						document.querySelector('form[id="errorLogListForm"] select[id="procStat"]').value = errorLogList.getValue(row.rowKey, 'procStat');
						document.querySelector('form[id="errorLogListForm"] input[id="note1"]').value = errorLogList.getValue(row.rowKey, 'note1');
						document.querySelector('form[id="errorLogListForm"] textarea[id="note2"]').value = errorLogList.getValue(row.rowKey, 'note2');
					}
				});

				this.el = el;
				this.render(props);
			}

			getElement() {
				return this.el;
			}

			render(props) {
				this.el.value = String(props.value);
			}
		}

		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#searchForm"), "error");
		edsUtil.setForm(document.querySelector("#errorLogListForm"), "error");

		/* 조회옵션 셋팅 */
		document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
		document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
		document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';

		/* 권한에 따라 회사, 사업장 활성화 */
		var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
		if(authDivi === "03" || authDivi === "04"){
			document.getElementById('busiCd').disabled = true;
			document.getElementById('btnBusiCd').disabled = true;
		}

		/* Button 셋팅 */
		// await edsUtil.setButtonForm(document.querySelector("#errorLogListButtonForm"));
		// await edsUtil.setButtonForm(document.querySelector("#errorLogModalButtonForm"));

		/*********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		/* 그리드 초기화 속성 설정 */
		errorLogList = new tui.Grid({
			el: document.getElementById('errorLogListDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum', /*'checkbox'*/],
			header: {
				height: 40,
				minRowHeight: 40,
				complexColumns: [

				],
			},
			columns:[],
			columnOptions: {
				resizable: true,
				/*frozenCount: 1,
                frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
			},
		});

		errorLogList.setColumns([
			{ header:'처리상태',		name:'procStat',	width:80,		align:'center',	defaultValue: '',	filter: { type: 'select'},	editor:{type:'select',options: {listItems:setCommCode("COM042")}},	formatter: 'listItemText'},
			{ header:'위험수준',		name:'riskLevel',	width:80,		align:'center',	defaultValue: '',	filter: { type: 'select'},	editor:{type:'select',options: {listItems:setCommCode("COM041")}},	formatter: 'listItemText'},
			{ header:'접수일시',		name:'inpDttm',		width:150,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'처리일시',		name:'procDttm',	width:150,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'요청자',		name:'reqNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'담당자',		name:'empNm',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'모듈명',		name:'modulNm',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'메뉴명',		name:'mamuNm',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'적요',			name:'note1',		width:200,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'상세내역',		name:'note2',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'상세등록',		name:'detail',		width:80,		align:'center', renderer: {type: detailButtonRenderer}},
			{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'순번',			name:'seq',			width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'담당자코드',	name:'empCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'요청자',		name:'reqCd',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
		]);

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * DatePicker 이벤트 영역 START
		 ***********************************************************************/

		/**********************************************************************
		 * DatePicker 기본 세팅 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * selectpicker 영역 START
		 ***********************************************************************/

		selectpicker =$('.selectpicker').select2({
			language: 'ko'
		});

		/*********************************************************************
		 * selectpicker 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		errorLogList.disableColumn('procStat');
		errorLogList.disableColumn('riskLevel');

		/*필터 이후 포커스*/
		errorLogList.on('afterFilter', async ev => {
			if(ev.instance.store.data.filteredIndex.length>0){
				errorLogList.focusAt(0,0,true)
			}
		});

		errorLogList.on('click', async ev => {
			var colNm = ev.columnName;
			var target = ev.targetType;
		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		// document.getElementById('errorLogList').style.height = (innerHeight)*(1-0.11) + 'px';

		/* 초기 조회 셋팅 */
		await doAction('errorLogList','search');
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'errorLogList') {
			switch (sAction) {
				case "search":// 조회

					errorLogList.finishEditing(); // 데이터 초기화
					errorLogList.clear(); // 데이터 초기화
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					errorLogList.resetData(edsUtil.getAjax("/ERROR_LOG/selectErrorLogList", param)); // 데이터 set

					if(errorLogList.getRowCount() > 0 ){
						errorLogList.focusAt(0, 0, true);
					}
					break;

				case "reset":// 초기화

					var condition = document.querySelector('form[id="errorLogListForm"] input[id="seq"]').value;

					if(!condition){
						document.querySelector('form[id="errorLogListForm"] input[id="seq"]').value = '';
					}else{

					}

					document.querySelector('form[id="errorLogListForm"] input[id="corpCd"]').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.querySelector('form[id="errorLogListForm"] input[id="seq"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="busiCd"]').value = '<c:out value="${LoginInfo.busiCd}"/>';
					document.querySelector('form[id="errorLogListForm"] input[id="busiNm"]').value = '<c:out value="${LoginInfo.busiNm}"/>';
					document.querySelector('form[id="errorLogListForm"] input[id="empCd"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="empNm"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="reqCd"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="reqNm"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="depaCd"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="depaNm"]').value = '';
					document.querySelector('form[id="errorLogListForm"] select[id="procStat"]').value = '';
					document.querySelector('form[id="errorLogListForm"] select[id="riskLevel"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="modulNm"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="mamuNm"]').value = '';
					document.querySelector('form[id="errorLogListForm"] input[id="note1"]').value = '';
					document.querySelector('form[id="errorLogListForm"] textarea[id="note2"]').value = '';

					break;
				case "input":// 신규

					await doAction('errorLogList','inputPopup');
					await doAction('errorLogList','reset');

					break;
				case "save"://저장
					var param = {};
					var condition = document.querySelector('form[id="errorLogListForm"] input[id="seq"]').value;

					if(!condition){
						param.status = 'C';
						param.corpCd = document.querySelector('form[id="searchForm"] input[id="corpCd"]').value;
						param.busiCd = document.querySelector('form[id="searchForm"] input[id="busiCd"]').value;
					}else{
						param.status = 'U';
						param.corpCd = document.querySelector('form[id="errorLogListForm"] input[id="corpCd"]').value;
						param.busiCd = document.querySelector('form[id="errorLogListForm"] input[id="busiCd"]').value;
						param.seq = condition;
					}

					param.reqCd = document.querySelector('form[id="errorLogListForm"] input[id="reqCd"]').value;
					param.reqNm = document.querySelector('form[id="errorLogListForm"] input[id="reqNm"]').value;
					param.empCd = document.querySelector('form[id="errorLogListForm"] input[id="empCd"]').value;
					param.empNm = document.querySelector('form[id="errorLogListForm"] input[id="empNm"]').value;
					param.depaCd = document.querySelector('form[id="errorLogListForm"] input[id="depaCd"]').value;
					param.depaNm = document.querySelector('form[id="errorLogListForm"] input[id="depaNm"]').value;
					param.riskLevel = document.querySelector('form[id="errorLogListForm"] select[id="riskLevel"]').value;
					param.procStat = document.querySelector('form[id="errorLogListForm"] select[id="procStat"]').value;
					param.modulNm = document.querySelector('form[id="errorLogListForm"] input[id="modulNm"]').value;
					param.mamuNm = document.querySelector('form[id="errorLogListForm"] input[id="mamuNm"]').value;
					param.note1 = document.querySelector('form[id="errorLogListForm"] input[id="note1"]').value;
					param.note2 = document.querySelector('form[id="errorLogListForm"] textarea[id="note2"]').value;

					/**
					 * 그리드 inputModal Form 기준 validation 체크
					 * */
					var ajaxCondition = await edsUtil.checkValidationForForm('errorLogListForm',['riskLevel','procStat','modulNm','mamuNm','reqNm','depaNm','note1','note2']);
					if(!ajaxCondition) { // 저장
						await edsUtil.postAjax('/ERROR_LOG/cudErrorLogList', errorLogList, param);
						await document.getElementById('btnClose').click();
					}else{ // 미저장

					}

					break;
				case "delete"://삭제

					var param = {};
					param.status = 'D';
					param.corpCd = document.querySelector('form[id="errorLogListForm"] input[id="corpCd"]').value;
					param.seq = document.querySelector('form[id="errorLogListForm"] input[id="seq"]').value;

					await edsUtil.postAjax('/ERROR_LOG/cudErrorLogList', errorLogList, param);
					await document.getElementById('btnClose').click();

					break;
				case "inputPopup":// 입력 팝업 보기

					document.getElementById('btnInputPopEv').click();

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

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

	async function popupHandler(name,divi,callback){
		var row = errorLogList.getFocusedCell();
		var names = name.split('_');
		switch (names[0]) {
			case 'user':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.empCd= '';
					param.name= name;
					await edsIframe.openPopup('USERPOPUP',param)
				}else{
					document.querySelector('form[id="errorLogListForm"] input[id="'+names[1]+'Cd"]').value = callback.empCd??'';
					document.querySelector('form[id="errorLogListForm"] input[id="'+names[1]+'Nm"]').value = callback.empNm??'';
					if(names[1] === 'req'){
						document.querySelector('form[id="errorLogListForm"] input[id="busiCd"]').value = callback.busiCd??'';
						document.querySelector('form[id="errorLogListForm"] input[id="busiNm"]').value = callback.busiNm??'';
						document.querySelector('form[id="errorLogListForm"] input[id="depaCd"]').value = callback.depaCd??'';
						document.querySelector('form[id="errorLogListForm"] input[id="depaNm"]').value = callback.depaNm??'';
					}
				}
				break;
			case 'depa': // 부서팝업
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
					param.depaNm= '';
					param.name= name;
					await edsIframe.openPopup('DEPAPOPUP',param)
				}else{
					document.querySelector('form[id="errorLogListForm"] input[id="depaCd"]').value = callback.depaCd??'';
					document.querySelector('form[id="errorLogListForm"] input[id="depaNm"]').value = callback.depaNm??'';
				}
				break;
			case 'busi':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.name= name;
					await edsIframe.openPopup('BUSIPOPUP',param)
				}else{
					document.getElementById('busiCd').value=callback.busiCd;
					document.getElementById('busiNm').value=callback.busiNm;

				}
				break;
		}
	}

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>