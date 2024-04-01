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
		var BASMA8000Sheet, BASMA8001Sheet;
		$(document).ready(function () {
			init();

			//	이벤트
			$('#busiCd, #storNm, #useYn').on('change', function(e) {
				doAction("BASMA8000Sheet", "search");
			});
		});

			/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
			document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
			document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';

			/* 권한에 따라 회사, 사업장 활성화 */
			var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
			if(authDivi == "03" || authDivi == "04"){
				document.getElementById('busiCd').disabled = true;
				document.getElementById('btnBusiCd').disabled = true;
			}

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#BASMA8000ButtonForm"));
			edsUtil.setButtonForm(document.querySelector("#BASMA8001ButtonForm"));

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			BASMA8000Sheet = new tui.Grid({
				el: document.getElementById('BASMA8000SheetDIV'),
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

			BASMA8000Sheet.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'창고코드',		name:'storCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'창고명',		name:'storNm',		minWidth:300,	align:'left',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'창고구분',		name:'storDivi',	minWidth:100,	align:'Center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("COM008")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header: "사용여부", 	name: "useYn",		minWidth:100,	align: "Center",	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header: "회사코드",	name: "corpCd",		minWidth:70, 	align: "center",	hidden:true },
				{ header: "사업장코드",	name: "busiCd",		minWidth:70, 	align: "center",	hidden:true },
				{ header: "비고",		name: "remark",		minWidth:70, 	align: "center",	hidden:true },
			]);

			BASMA8001Sheet = new tui.Grid({
				el: document.getElementById('BASMA8001SheetDIV'),
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

			BASMA8001Sheet.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'위치코드',		name:'locaCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'위치명',		name:'locaNm',		minWidth:300,	align:'left',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header: "사용여부", 	name: "useYn",		minWidth:100,	align: "Center",	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true }
				},

				// hidden(숨김)
				{ header: "회사코드",	name: "corpCd",		minWidth:70, 	align: "center",	hidden:true },
				{ header: "창고코드",	name: "storCd",		minWidth:70, 	align: "center",	hidden:true },
				{ header: "비고",		name: "remark",		minWidth:70, 	align: "center",	hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			BASMA8000Sheet.on('focusChange', ev => {
				if(ev.rowKey != ev.prevRowKey){
					setTimeout(function(){
						doAction("BASMA8001Sheet", "search");
					}, 100);
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('BASMA8000').style.height = height + 'px';
			document.getElementById('BASMA8001').style.height = height + 'px';

			/* 조회 */
			doAction("BASMA8000Sheet", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		function doAction(sheetNm, sAction) {
			if (sheetNm == 'BASMA8000Sheet') {
				switch (sAction) {
					case "search":// 조회

						BASMA8000Sheet.clear(); // 데이터 초기화
						BASMA8001Sheet.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						BASMA8000Sheet.resetData(edsUtil.getAjax("/eds/erp/basma/selectBASMA8000", param)); // 데이터 set

						if(BASMA8000Sheet.getRowCount() > 0 ){
							BASMA8000Sheet.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = $("#searchForm #corpCd").val();
						appendedData.busiCd = $("#searchForm #busiCd").val();
						appendedData.useYn = "01";

						BASMA8000Sheet.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장

						edsUtil.doSave("/eds/erp/basma/insertBASMA8000", "BASMA8000Sheet", BASMA8000Sheet);// 저장

						break;
					case "delete"://삭제

						edsUtil.doDel("/eds/erp/basma/insertBASMA8000", "BASMA8000Sheet", BASMA8000Sheet);// 삭제

						break;
				}
			}else if (sheetNm == 'BASMA8001Sheet') {
				switch (sAction) {
					case "search":// 조회

						var row = BASMA8000Sheet.getFocusedCell();
						BASMA8001Sheet.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.storCd =  BASMA8000Sheet.getValue(row.rowKey, "storCd");
						BASMA8001Sheet.resetData(edsUtil.getAjax("/eds/erp/basma/selectBASMA8001", param)); // 데이터 set

						if(BASMA8001Sheet.getRowCount() > 0 ){
							BASMA8001Sheet.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var row = BASMA8000Sheet.getFocusedCell();
						if(!BASMA8000Sheet.getValue(row.rowKey, "storCd")){
							toastrmessage("toast-bottom-center", "error", "창고 저장후 사용하세요.", "실패", 1500);
							return;
						}

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = BASMA8000Sheet.getValue(row.rowKey, "corpCd");
						appendedData.storCd = BASMA8000Sheet.getValue(row.rowKey, "storCd");
						appendedData.useYn = "01";

						BASMA8001Sheet.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장

						edsUtil.doSave("/eds/erp/basma/insertBASMA8001", "BASMA8001Sheet", BASMA8001Sheet);// 저장

						break;
					case "delete"://삭제

						edsUtil.doDel("/eds/erp/basma/insertBASMA8001", "BASMA8001Sheet", BASMA8001Sheet);// 삭제

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
		// 사업장 팝업
		function fn_busiPopup(){
			var param = {
				corpCd: $("#searchForm #corpCd").val(),
				busiCd: document.getElementById('busiCd').value
			};
			edsPopup.util.openPopup(
					"BUSIPOPUP",
					param,
					function (value) {
						this.returnValue = value||this.returnValue;
						if(this.returnValue){
							document.getElementById('busiCd').value = this.returnValue.busiCd;
							document.getElementById('busiNm').value = this.returnValue.busiNm;
						}
					},
					false,
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
</head>

<body>

<div class="row">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;"><!--submit 막는 방법 1-->
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
						<div class="form-group">
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="fn_busiPopup(); return false;"><i class="fa fa-search"></i></button></span>
							</div>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="storNm">창고명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="storNm" id="storNm" title="창고명">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="useYn">사용유무 &nbsp;</label>
							<div class="input-group input-group-sm">
								<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="useYn" id="useYn" title="사용여부"></select>
							</div>
						</div>
						<!--<input type="hidden" name="xxxx" id="xxxx" value="xxxx" style="display: none;"/> form submit 막는 방법 2-->
					</form>
					 <!-- ./form -->
				</div>
			</div>

			<div class="col-md-12">
				<!-- 그리드 영역 -->
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="float-left" style="padding: 5px 0 0 5px">
							<i class="fa fa-file-text-o"></i> 창고 목록
						</div>
						<div class="btn-group float-right">
							<form class="form-inline" role="form" name="BASMA8000ButtonForm" id="BASMA8000ButtonForm" method="post" onsubmit="return false;">
								<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('BASMA8000Sheet', 'search')"><i class="fa fa-search"></i> 조회</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('BASMA8000Sheet', 'input')" ><i class="fa fa-plus"></i> 신규</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('BASMA8000Sheet', 'save')"><i class="fa fa-save"></i> 저장</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('BASMA8000Sheet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" style="height: 100%;" id="BASMA8000">
						<!-- 시트가 될 DIV 객체 -->
						<div id="BASMA8000SheetDIV" style="width:100%; height:100%;"></div>
					</div>
				</div>
			</div>
			<div class="col-md-6" style="display:none">
				<!-- 그리드 영역 -->
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="float-left" style="padding: 5px 0 0 5px">
							<i class="fa fa-file-text-o"></i> 위치 목록
						</div>
						<div class="btn-group float-right">
							<form class="form-inline" role="form" name="BASMA8001ButtonForm" id="BASMA8001ButtonForm" method="post" onsubmit="return false;">
								<button type="button" class="btn btn-sm btn-primary" name="btnSearch1" id="btnSearch1" onclick="doAction('BASMA8001Sheet', 'search')"><i class="fa fa-search"></i> 조회</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnInput1" id="btnInput1" onclick="doAction('BASMA8001Sheet', 'input')" ><i class="fa fa-plus"></i> 신규</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnSave1" id="btnSave1" onclick="doAction('BASMA8001Sheet', 'save')"><i class="fa fa-save"></i> 저장</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnDelete1" id="btnDelete1" onclick="doAction('BASMA8001Sheet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" style="height: 100%;" id="BASMA8001">
						<!-- 시트가 될 DIV 객체 -->
						<div id="BASMA8001SheetDIV" style="width:100%; height:100%;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>