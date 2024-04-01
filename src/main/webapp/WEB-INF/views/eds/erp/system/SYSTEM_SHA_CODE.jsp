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

			$('#groupCd, #groupCdNm, #groupDivi, #useYn').on('change', function(e) {
				doAction("systemGridList", "search");
			});
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "sysma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';


			/* 권한에 따라 회사, 사업장 활성화 */
			<%--var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';--%>
			// if(authDivi == "03" || authDivi == "04"){
			// 	document.getElementById('busiCd').disabled = true;
			// 	document.getElementById('btnBusiCd').disabled = true;
			// }

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#SYSMA4000ButtonForm"));
			edsUtil.setButtonForm(document.querySelector("#SYSMA4001ButtonForm"));

			/* 그리드 초기화 속성 설정 */
			systemGridList = new tui.Grid({
				el: document.getElementById('systemGridListDIV'),
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

			systemGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
				{ header:'그룹 코드',	name:'groupCd',		minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'그룹 구분',	name:'groupDivi',	minWidth:120,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'그룹 코드 명',	name:'groupCdNm',	minWidth:120,	align:'Left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'그룹 코드 설명',name:'groupCdExp',	minWidth:120,	align:'Left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'순서',			name:'groupOrder',	minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'사용여부',		name:'useYn',		minWidth:120,	align:'Center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems: [
								{ text: '사용', value: '01' },
								{ text: '미사용', value: '02' }
							]
						}
					}, filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'Center',	hidden:true },
				{ header:'그룹번호',		name:'groupNo',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
			]);

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
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
				{ header:'공통 코드',	name:'commCd',		minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'공통 코드 명',	name:'commCdNm',	minWidth:100,	align:'Left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'공통 코드 설명',name:'commCdExp',	minWidth:120,	align:'Left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'예비값1',		name:'reserveVal1',	minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'예비값2',		name:'reserveVal2',	minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'예비값3',		name:'reserveVal3',	minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'순서',			name:'commCdOrder',	minWidth:100,	align:'Center',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }, validation: {required:true} },
				{ header:'사용여부',		name:'useYn',		minWidth:120,	align:'Center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems: [
								{ text: '사용', value: '01' },
								{ text: '미사용', value: '02' }
							]
						}
					}, 	filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'Center',	hidden:true },
				{ header:'그룹번호',		name:'groupNo',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
				{ header:'공통코드번호',	name:'commCdNo',	minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
			]);

			/* 그리드 이벤트 */

			systemGridList.on('focusChange', ev => {
				if(ev.rowKey != ev.prevRowKey){
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.groupNo = systemGridList.getValue(ev.rowKey,'groupNo');
					systemGridDet.resetData(edsUtil.getAjax("/SYSTEM_SHA_CODE/selectShaDet", param));
				}
			});



			document.getElementById('SYSMA4000').style.height = 250 + 'px';
			var height = window.innerHeight - document.getElementById('systemGridListDIV').clientHeight - 130;
			document.getElementById('SYSMA4001').style.height = height + 'px';

			/* 조회 */
			doAction("systemGridList", "search");
		}

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":// 조회

						systemGridDet.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_SHA_CODE/selectShaList", param)); // 데이터 set

						if(systemGridList.getRowCount() > 0 ){
							systemGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.useYn = '01';

						systemGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/SYSTEM_SHA_CODE/cudShaList", "systemGridList", systemGridList);
						break;

					case "delete"://삭제
						await systemGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/SYSTEM_SHA_CODE/cudShaList", "systemGridList", systemGridList);
						break;
				}
			}else if (sheetNm == 'systemGridDet') {
				switch (sAction) {
					case "search":// 조회

						var row = systemGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.groupNo = systemGridList.getValue(row.rowKey, "groupNo");// Key
						systemGridDet.resetData(edsUtil.getAjax("/SYSTEM_SHA_CODE/selectShaDet", param)); // 데이터 set

						if(systemGridDet.getRowCount() > 0 ){
							systemGridDet.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var row = systemGridList.getFocusedCell();
						if(!systemGridList.getValue(row.rowKey, "groupCd")){
							toastrmessage("toast-bottom-center", "error", "공통코드목록 저장후 사용하세요.", "실패", 1500);
							return;
						}

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.groupNo = systemGridList.getValue(row.rowKey, "groupNo");
						appendedData.useYn = '01';

						systemGridDet.prependRow(appendedData, { focus:true }); // 첫번째 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/SYSTEM_SHA_CODE/cudShaDet", "systemGridDet", systemGridDet);
						break;
					case "delete"://삭제
						await systemGridDet.removeCheckedRows(true);
						await edsUtil.doCUD("/SYSTEM_SHA_CODE/cudShaDet", "systemGridDet", systemGridDet);
						break;
				}
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
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
						<div class="form-group">
							<label for="groupCd">그룹코드 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="groupCd" id="groupCd" title="그룹코드">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="groupCdNm">그룹명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="groupCdNm" id="groupCdNm" title="그룹명">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="groupDivi">그룹구분 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="groupDivi" id="groupDivi" title="그룹구분">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="useYn">사용여부 &nbsp;</label>
							<div class="input-group input-group-sm">
								<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="useYn" id="useYn" title="사용여부"></select>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 공통 코드 목록
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="SYSMA4000ButtonForm" id="SYSMA4000ButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('systemGridList', 'input')" ><i class="fa fa-plus"></i> 신규</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('systemGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('systemGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="SYSMA4000">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 공통 코드 상세
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="SYSMA4001ButtonForm" id="SYSMA4001ButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch1" id="btnSearch1" onclick="doAction('systemGridDet', 'search')"><i class="fa fa-search"></i> 조회</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnInput1" id="btnInput1" onclick="doAction('systemGridDet', 'input')" ><i class="fa fa-plus"></i> 신규</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnSave1" id="btnSave1" onclick="doAction('systemGridDet', 'save')"><i class="fa fa-save"></i> 저장</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnDelete1" id="btnDelete1" onclick="doAction('systemGridDet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="SYSMA4001">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridDetDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
