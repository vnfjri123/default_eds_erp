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
			edsUtil.setButtonForm(document.querySelector("#systemGridListButtonForm"));
			edsUtil.setButtonForm(document.querySelector("#systemGridDetButtonForm"));

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
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
				{ header:'메뉴 ID',		name:'menuId',		minWidth:80,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'메뉴 명',		name:'menuNm',		minWidth:270,	align:'left',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'메뉴 순서',	name:'menuOrder',	minWidth:100,	align:'center',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'아이콘',		name:'menuIcon',	minWidth:150,	align:'left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
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
				treeColumnOptions: {
					name: 'pgmId',
					useCascadingCheckbox: false
				},
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
				{ header:'프로그램 ID',	name:'pgmId',		minWidth:80,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'프로그램 명',	name:'pgmNm',		minWidth:270,	align:'left',	validation:{required:true},filter: { type: 'text', showApplyBtn: true, showClearBtn: true }},
				{ header:'프로그램 순서',	name:'pgmOrder',	minWidth:100,	align:'center',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'아이콘',		name:'pgmIcon',		minWidth:150,	align:'left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
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
				{ header:'순번',			name:'subSeq',		minWidth:100,	align:'left',	hidden:true },
				{ header:'메뉴 ID',		name:'menuId',		minWidth:100,	align:'center',	hidden:true },
				{ header:'프로그램 ID',	name:'pgmIdDb',		minWidth:80,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			systemGridDet.on('click',ev => {
				var columnName = ev.columnName;
				var rowKey = ev.rowKey;
				switch (columnName) {
					case "pgmId" : case "pgmNm" :// 프로그램 팝업
						var row = systemGridList.getFocusedCell();
						var param = {};
						param.corpCd = systemGridList.getValue(row.rowKey, 'corpCd');
						edsPopup.util.openPopup(
								"PMGPOPUP",
								param,
								function (value) {
									this.returnValue = value||this.returnValue;
									if(this.returnValue){
										systemGridDet.setValue(rowKey, "pgmId", this.returnValue.pgmId);
										systemGridDet.setValue(rowKey, "pgmNm", this.returnValue.pgmNm);
									}
								},
								false,
								true
						);
						break;
				}
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('systemGridList').style.height = height + 'px';
			document.getElementById('systemGridDet').style.height = height + 'px';

			/* 조회 */
			doAction("systemGridList", "search");
		}
		async function fnMkTree(data) {
			const itemDict = {};
			const rootItems = [];

			for (const item of data) {
                itemDict[item.pgmId] = item;
			}

			for (const item of data) {
                const parepgmId = item.parent;
                if (parepgmId=='' || parepgmId==null) {
					rootItems.push(item);
				} else {
                    const parent = itemDict[parepgmId];
                    if (parent) 
                    {
                        if(!parent._children)parent._children=[];
                        parent._children.push(item);
					}
					else
					{
						rootItems.push(item);
					}
			}
			}

			console.log(rootItems)
			await systemGridDet.resetData(rootItems);
		}
		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":// 조회

						systemGridDet.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridList.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridDet.clear(); // 데이터 초기화
						systemGridList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_MENU_MGT/selectManuMgtList", param)); // 데이터 set

						if(systemGridList.getRowCount() > 0 ){
							systemGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.menuIcon = "fa fa-circle-o";
						appendedData.useYn = '01';

						systemGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장

						await edsUtil.doCUD("/SYSTEM_MENU_MGT/cudManuMgtList", "systemGridList", systemGridList);

						break;
					case "delete"://삭제
						await systemGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/SYSTEM_MENU_MGT/cudManuMgtList", "systemGridList", systemGridList);

						break;
				}
			}else if (sheetNm == 'systemGridDet') {
				switch (sAction) {
					case "search":// 조회

						systemGridDet.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridDet.clear(); // 데이터 초기화
						var row = systemGridList.getFocusedCell();
						var param = {}; //조회조건
						param.corpCd = systemGridList.getValue(row.rowKey, "corpCd");
						param.menuId = systemGridList.getValue(row.rowKey, "menuId");
						
						var test = await fnMkTree(edsUtil.getAjax("/SYSTEM_MENU_MGT/selectManuMgtDet", param));
						break;
					case "input":// 신규
						var row = systemGridList.getFocusedCell();
						var appendedData = {};
						const selectRow=systemGridDet.getFocusedCell();
						console.log(selectRow.rowKey)
						let rowKey;
						if(selectRow.rowKey==null)
						{
							return alert('메뉴를 클릭하세요.')
		
						}
						const parentRow=systemGridDet.getRow(selectRow.rowKey);
						console.log(parentRow)
						rowKey=selectRow.rowKey;
						appendedData.parent = parentRow.pgmId;
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.menuId = systemGridList.getValue(row.rowKey, "menuId");
						appendedData.pgmNm = '';
						appendedData.pgmIcon = "fa fa-angle-right";
						appendedData.useYn = '01';
						systemGridDet.expand(selectRow.rowKey)//그리드 확장
						await systemGridDet.appendTreeRow (appendedData, { focus:true ,parentRowKey:rowKey}); // 마지막 ROW 추가
						break;
					case "menuinput":// 매뉴신규
						var row = systemGridList.getFocusedCell();
						var appendedData = {};
						appendedData.corpCd = $("#searchForm #corpCd").val();
						appendedData.parent = null;
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.menuId = systemGridList.getValue(row.rowKey, "menuId");
						appendedData.pgmNm = '';
						appendedData.pgmIcon = "fa fa-angle-right";
						appendedData.useYn = '01';
						await systemGridDet.appendRow(appendedData, { focus:true}); // 마지막 ROW 추가
						break;
					case "save"://저장

						await edsUtil.doCUD("/SYSTEM_MENU_MGT/cudManuMgtDet", "systemGridDet", systemGridDet);

						break;
					case "delete"://삭제
						await systemGridDet.removeCheckedRows(true);
						await edsUtil.doCUD("/SYSTEM_MENU_MGT/cudManuMgtDet", "systemGridDet", systemGridDet);

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
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">

						<!-- ./input hidden -->
						<div class="form-group">
							<label for="menuNm">메뉴명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="menuNm" id="menuNm" title="메뉴명">
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

			<div class="col-md-6">
				<!-- 그리드 영역 -->
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="float-left" style="padding: 5px 0 0 5px">
							<i class="fa fa-file-text-o"></i> 메뉴목록
						</div>
						<div class="btn-group float-right">
							<form class="form-inline" role="form" name="systemGridListButtonForm" id="systemGridListButtonForm" method="post" onsubmit="return false;">
								<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('systemGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('systemGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('systemGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" style="height: 100%;" id="systemGridList">
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
							<i class="fa fa-file-text-o"></i> 하위 메뉴목록
						</div>
						<div class="btn-group float-right">
							<form class="form-inline" role="form" name="systemGridDetButtonForm" id="systemGridDetButtonForm" method="post" onsubmit="return false;">
								<button type="button" class="btn btn-sm btn-primary" name="btnSearch1" id="btnSearch1" onclick="doAction('systemGridDet', 'search')"><i class="fa fa-search"></i> 조회</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnInput1" id="btnInput1" onclick="doAction('systemGridDet', 'menuinput')"><i class="fa fa-plus"></i> 메뉴신규</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnInput1" id="btnInput1" onclick="doAction('systemGridDet', 'input')"><i class="fa fa-plus"></i> 신규</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnSave1" id="btnSave1" onclick="doAction('systemGridDet', 'save')"><i class="fa fa-save"></i> 저장</button>
								<button type="button" class="btn btn-sm btn-primary" name="btnDelete1" id="btnDelete1" onclick="doAction('systemGridDet', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12" style="height: 100%;" id="systemGridDet">
						<!-- 시트가 될 DIV 객체 -->
						<div id="systemGridDetDIV" style="width:100%; height:100%;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>