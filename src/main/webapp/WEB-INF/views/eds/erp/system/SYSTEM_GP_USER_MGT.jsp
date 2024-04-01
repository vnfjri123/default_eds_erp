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

	<script>
		var systemGridList, systemGridDet;
		$(document).ready(function () {
			init();

			//	이벤트
			$('form input').on('keydown', function(e) {
				if (e.which == 13) {
					doAction("systemGridList", "search");
				}
			});
		});

		/* 초기설정 */
		function init() {

			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "sysma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#SYSMA3000ButtonForm"));
			edsUtil.setButtonForm(document.querySelector("#SYSMA3001ButtonForm"));

			/* 그리드 초기화 속성 설정 */
			systemGridList = new tui.Grid({
				el: document.getElementById('systemGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum'],
				header: {
					height: 40,
					minRowHeight: 40
				},
				columns:[],
				columnOptions: {
					resizable: true
				}
			});

			systemGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
				{ header:'그룹 ID',		name:'groupId',		minWidth:80,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'그룹 명',		name:'groupNm',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'그룹 설명',	name:'groupExp',	minWidth:230,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'메뉴 순서',	name:'groupOrder',	minWidth:100,	align:'Center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사용여부',		name:'useYn',		minWidth:100,	align:'Center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'Center',	hidden:true },

			]);

			systemGridList.disableColumn('useYn');

			systemGridList.on('focusChange', ev => {
				if(ev.rowKey != ev.prevRowKey){
					setTimeout(function(){
						doAction("systemGridDet", "search");
					}, 100);
				}
			});

			systemGridDet = new tui.Grid({
				el: document.getElementById('systemGridDetDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum', 'checkbox'],
				header: {
					height: 40,
					minRowHeight: 40
				},
				columns:[],
				columnOptions: {
					resizable: true
				}
			});

			systemGridDet.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'사원코드',		name:'empCd',		minWidth:110,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사원명',		name:'empNm',		minWidth:130,	align:'left',	validation:{required:true}, filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'권한구분',		name:'authDivi',	minWidth:130,	align:'center',	validation:{required:true},	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS009")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header:'부서명',		name:'depaNm',		minWidth:130,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직책',			name:'respDiviNm',	minWidth:130,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직위',			name:'posiDiviNm',	minWidth:130,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header: "그룹 ID",		name: "groupId",	minWidth:100,	align:'center',	hidden:true },
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'Center',	hidden:true },
			]);

			systemGridDet.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm ==='empCd'||
						colNm ==='empNm'){
						await popupHandler('user','open');
					}
				}else{
					// yeongEobGridItem.finishEditing();
				}
			});

			systemGridDet.on('keydown', ev => {
				var keyCd = ev.keyboardEvent.keyCode;
				var colNm = ev.columnName;
				var rowKey = ev.rowKey;
				if(keyCd == "13"){
					setTimeout(function(){
						systemGridDet.finishEditing(rowKey,colNm);
					}, 100);
					fn_colPopup(colNm, rowKey);
				}else{

				}
			});

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('SYSMA3000').style.height = height + 'px';
			document.getElementById('SYSMA3001').style.height = height + 'px';

			/* 조회 */
			doAction("systemGridList", "search");
		}

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":// 조회

						systemGridDet.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridList.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridDet.clear(); // 데이터 초기화
						systemGridList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_GP_MENU_MGT/selectGpMenuMgtList", param)); // 데이터 set

						if(systemGridList.getRowCount() > 0 ){
							systemGridList.focusAt(0, 0, true);
						}

						break;
				}
			}else if (sheetNm == 'systemGridDet') {
				switch (sAction) {
					case "search":// 조회

						systemGridDet.finishEditing();
						systemGridDet.clear(); // 데이터 초기화

						var row = systemGridList.getFocusedCell();
						var rows = systemGridList.getRowCount();
						if(rows > 0){
							systemGridDet.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
							systemGridDet.clear(); // 데이터 초기화

							var param = {}; //조회조건
							param.corpCd = systemGridList.getValue(row.rowKey, "corpCd");
							param.groupId = systemGridList.getValue(row.rowKey, "groupId");
							systemGridDet.resetData(edsUtil.getAjax("/SYSTEM_GP_USER_MGT/selectGpUserMgtList", param)); // 데이터 set
						}

						break;
					case "input":// 신규

						var row = systemGridList.getFocusedCell();
						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.groupId = systemGridList.getValue(row.rowKey, "groupId");
						appendedData.empNm = "";

						systemGridDet.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/SYSTEM_GP_USER_MGT/cudGpUserMgtList", "systemGridDet", systemGridDet);
						break;
					case "delete"://삭제
						await systemGridDet.removeCheckedRows(true);
						await edsUtil.doCUD("/SYSTEM_GP_USER_MGT/cudGpUserMgtList", "systemGridDet", systemGridDet);

						break;
				}
			}
		}

		async function popupHandler(name,divi,callback){
			var row = systemGridDet.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'user':
					if(divi==='open'){

						var param={}
						param.corpCd= document.getElementById('corpCd').value;
						//param.empCd= systemGridDet.getValue(row.rowKey, "empCd");
						param.name= name;
						await edsIframe.openPopup('USERPOPUP',param)
					}else{
						var rows = systemGridDet.getData();
						for(var i=0; i<rows.length; i++){
							if(rows[i].empCd === callback.empCd){
								toastrmessage("toast-bottom-center", "warning", "이미 등록된 번호 입니다.", "경고", 1500);
								return;
							}
						}

						var param = {};
						param.corpCd = document.getElementById('corpCd').value;
						param.empCd = callback.empCd;
						param.empNm = callback.empNm;

						$.ajax({
							url: "/BASE_USER_MGT_LIST/duplicateUserCheck",
							type: "POST",
							async: false,
							data: param,
							success : function( result ) {
								if (result == '0') {
									systemGridDet.setValue(row.rowKey, "empCd", param.empCd);
									systemGridDet.setValue(row.rowKey, "empNm", param.empNm);
									systemGridDet.setValue(row.rowKey, "authDivi", '04');
									edsUtil.doCUD("/SYSTEM_GP_USER_MGT/cudGpUserMgtList", "systemGridDet", systemGridDet);
								} else {
									toastrmessage("toast-bottom-center", "warning", "이미 등록된 사원 입니다.", "경고", 1500);
									return;
								}
							}
						});
					}
					break;
			}
		}

	</script>
</head>

<body>

<div class="row">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">

						<!-- ./input hidden -->
						<div class="form-group">
							<label for="groupNm">그룹명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="groupNm" id="groupNm" title="그룹명">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px; display: none" ></div>
						<div class="form-group" style="display: none">
							<label for="pgmUrl">URL &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="pgmUrl" id="pgmUrl" title="URL">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="useYn">사용유무 &nbsp;</label>
							<div class="input-group input-group-sm">
								<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="useYn" id="useYn" title="사용여부"></select>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 그룹 목록
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="SYSMA3000ButtonForm" id="SYSMA3000ButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="SYSMA3000">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 사용자 목록
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="SYSMA3001ButtonForm" id="SYSMA3001ButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch1" id="btnSearch1" onclick="doAction('systemGridDet', 'search')"><i class="fa fa-search"></i> 조회</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnInput1" id="btnInput1" onclick="doAction('systemGridDet', 'input')"><i class="fa fa-plus"></i> 신규</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnSave1" id="btnSave1" onclick="doAction('systemGridDet', 'save')"><i class="fa fa-save"></i> 저장</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnDelete1" id="btnDelete1" onclick="doAction('systemGridDet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="SYSMA3001">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridDetDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>