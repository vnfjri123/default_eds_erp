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
		var baseGridList;
		$(document).ready(function () {
			init();
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#baseGridListForm"), "basma");
            $('[data-mask]').inputmask();
			/* 조회옵션 셋팅 */

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#BASMA0000ButtonForm"));
			document.getElementById('btnInput').disabled = true;

			/* 이벤트 셋팅 */
			edsUtil.addChangeEvent("baseGridListForm", fn_CopyForm2baseGridList);

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			baseGridList = new tui.Grid({
				el: document.getElementById('baseGridListDIV'),
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

			baseGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	hidden:true },
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'회사명',		name:'corpNm',		minWidth:200,	align:'left',	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'회사구분',		name:'corpPersDivi',minWidth:100,	align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("COM001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header:'사용여부',		name:'useYn',		minWidth:100,	align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header: "사업자등록번호",	name: "corpNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "법인등록번호",		name: "corpRegNo",	minWidth:100,	align:'center',	hidden:true },
				{ header: "대표자명",		name: "ownerNm",	minWidth:100,	align:'center',	hidden:true },
				{ header: "우편번호",		name: "zipNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "주소",			name: "addr",		minWidth:100,	align:'center',	hidden:true },
				{ header: "주소상세",		name: "addrDetail",	minWidth:100,	align:'center',	hidden:true },
				{ header: "전화번호",		name: "telNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "팩스번호",		name: "faxNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "업태",			name: "busiType",	minWidth:100,	align:'center',	hidden:true },
				{ header: "종목",			name: "busiType",	minWidth:100,	align:'center',	hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			baseGridList.disableColumn('corpPersDivi');
			baseGridList.disableColumn('useYn');

			baseGridList.on('focusChange', async ev => {
				if(ev.rowKey != ev.prevRowKey){
					await fn_CopyForm2baseGridList();
					await fn_CopybaseGridList2Form();
				}
			});

			baseGridList.on('afterChange', ev => {
				for (var i = 0; i < ev.changes.length; i++) {
					$('#baseGridListForm #' + ev.changes[i].columnName).val(ev.changes[i].value);
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 40;
			document.getElementById('BASMA0000').style.height = height + 'px';

			/* 조회 */
			doAction("baseGridList", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseGridList') {
				switch (sAction) {
					case "search":// 조회

						baseGridList.clear(); // 데이터 초기화
						var param = {}; //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_CORP_REG/selectCorpList", param)); // 데이터 set

						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						if(baseGridList.getRowCount() > 0 ){
							toastrmessage("toast-bottom-center", "error", "하나의 회사만 등록할 수 입니다.", "실패", 1500); return;
						}

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.useYn = '01';

						baseGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						await fn_CopybaseGridList2Form();

						break;
					case "save"://저장

						await edsUtil.doCUD("/BASE_CORP_REG/cudCorpList", "baseGridList", baseGridList);// 저장

						break;
					case "delete"://삭제
						await baseGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/BASE_CORP_REG/cudCorpList", "baseGridList", baseGridList);

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
		async function fn_CopyForm2baseGridList(){
			var rows = baseGridList.getRowCount();
			if(rows > 0){
				var row = baseGridList.getFocusedCell();
				var param = {
					sheet: baseGridList,
					form: document.baseGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopyForm2Sheet(param);// Form -> Sheet복사
			}
		}

		async function fn_CopybaseGridList2Form(){
			var rows = baseGridList.getRowCount();
			if(rows > 0){
				var row = baseGridList.getFocusedCell();
				var param = {
					sheet: baseGridList,
					form: document.baseGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
			}
		}
		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>

<div class="row">
	<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;"></form>
	<div class="col-md-5">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 회사 목록
				</div>
				<div class="btn-group float-right">

				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="BASMA0000">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
	<div class="col-md-7">
		<!-- Form 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 회사 목록 상세
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="BASMA0000ButtonForm" id="BASMA0000ButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('baseGridList', 'input')" ><i class="fa fa-plus"></i> 신규</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('baseGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('baseGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;">
				<!-- form start -->
				<form class="form-inline" role="form" name="baseGridListForm" id="baseGridListForm" method="post" onsubmit="return false;">
					<table class="table table-bordered table-sm">
						<tr>
							<td class="table-active"><span class="IBRequired">&nbsp;</span>법인/개인구분</td>
							<td><select name="corpPersDivi" id="corpPersDivi" title="법인/개인구분" style="width: 100%;" ></select></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%"><span class="IBRequired">&nbsp;</span>회사명</td>
							<td><input type="text" name="corpNm" id="corpNm"  style="width: 100%;" ></td>
						</tr>
                        <tr>
                            <td class="table-active" style="width: 15%">사업자등록번호</td>
                            <td><input type="text" name="corpNo" id="corpNo"  style="width: 100%;"  data-inputmask="'mask': '999-99-99999'" data-mask></td>
                        </tr>
                        <tr>
                            <td class="table-active" style="width: 15%">법인등록번호</td>
                            <td><input type="text" name="corpRegNo" id="corpRegNo"  style="width: 100%;"  data-inputmask="'mask': '999999-9999999'" data-mask></td>
                        </tr>
                        <tr>
                            <td class="table-active" style="width: 15%">대표자명</td>
                            <td><input type="text" name="ownerNm" id="ownerNm"  style="width: 100%;" ></td>
                        </tr>
						<tr>
							<td class="table-active">주소&nbsp;<a onclick="edsUtil.showMapPopup(baseGridList)" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
							<td colspan="3">
								<input type="text" name="addr" id="addr" style="width: 100%">
							</td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">전화번호</td>
							<td><input type="text" name="telNo" id="telNo"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">팩스번호</td>
							<td><input type="text" name="faxNo" id="faxNo"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">업태</td>
							<td><input type="text" name="busiType" id="busiType" style="width: 100%"></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">종목</td>
							<td><input type="text" name="busiItem" id="busiItem" style="width: 100%"></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">사용여부</td>
							<td><select name="useYn" id="useYn" title="사용여부"></select></td>
						</tr>
					</table>
				</form>
				<!-- ./form -->
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
</body>
</html>