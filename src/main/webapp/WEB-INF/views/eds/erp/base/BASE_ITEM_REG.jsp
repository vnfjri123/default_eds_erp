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
		var baseItemGridList
		$(document).ready(function () {
			init();

			//	이벤트
			$('#searchForm #itemNm, #searchForm #useYn').on('change', function(e) {
				doAction("baseItemGridList", "search");
			});
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");
			// edsUtil.setForm(document.querySelector("#baseItemGridListForm"), "basma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = ${LoginInfo.corpCd};
			document.getElementById('busiCd').value = ${LoginInfo.busiCd};

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#baseItemButtonForm"));

			/* 이벤트 셋팅 */
			/*edsUtil.addChangeEvent("baseItemGridListForm", fn_CopyForm2baseItemGridList);*/

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			baseItemGridList = new tui.Grid({
				el: document.getElementById('baseItemGridListDIV'),
				// data: treeData,
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				treeColumnOptions: {
					name: 'itemCd',
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

			baseItemGridList.setColumns([
				{ header:'품목코드',		name:'itemCd',		width:100,		align:'center',	defaultValue: '',	editor:{type:'text'},	validation:{required:true}},
				{ header:'품목명',		name:'itemNm',		width:200,		align:'left',	defaultValue: '',	editor:{type:'text'}},
				{ header:'자재분류',		name:'mateClas',	width:100,		align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("COM004")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true }},
				{ header:'상위품목명',	name:'pareItemNm',	width:200,		align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'규격',			name:'standard',	width:150,		align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'단위',			name:'unit',	width:150,		align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'사용구분',		name:'useYn',	width:100,		align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true }},
				{ header:'개요',			name:'note1',		width:200,		align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'비고',			name:'note2',		minWidth:150,	align:'center',	defaultValue: '',	editor:{type:'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
				{ header:'상위품목코드',	name:'pareItemCd',	width:100,		align:'center',	hidden:true },
				{ header:'기초순번',		name:'baseSeq',		width:100,		align:'center',	hidden:true },
				{ header:'부모순번',		name:'pareSeq',		width:100,		align:'center',	hidden:true },
				{ header:'깊이',			name:'depth',		width:100,		align:'center',	hidden:true },
			]);
			baseItemGridList.disableColumn('itemCd');
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseItemGridList.on('expand', ev => {
			
			});

			baseItemGridList.on('collapse', ev => {

			});
			            // Get the input box
			let input = document.getElementById('itemNm');

			// Init a timeout variable to be used below
			let timeout = null;

			// Listen for keystroke events
			input.addEventListener('keyup', function (e) {
				// Clear the timeout if it has already been set.
				// This will prevent the previous task from executing
				// if it has been less than <MILLISECONDS>
				clearTimeout(timeout);

				// Make a new timeout set to go off in 1000ms (1 second)
				timeout = setTimeout(function () {
					console.log('Input Value:', input.value);
				}, 1000);
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */

			/* 그리드생성 */
			document.getElementById('baseItem').style.height = window.innerHeight - 90 + 'px';

			/* 조회 */
			doAction("baseItemGridList", "search");
		}

		async function fnMkTree(data) {
			const itemDict = {};
			const rootItems = [];

			for (const item of data) {
                itemDict[item.itemCd] = item;
			}

			for (const item of data) {
                const pareItemCd = item.pareItemCd;
                if (pareItemCd=='' || pareItemCd==null) {
					rootItems.push(item);
				} else {
                    const parent = itemDict[pareItemCd];
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
			await baseItemGridList.resetData(rootItems);
		}
		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseItemGridList') {
				switch (sAction) {
					case "search":// 조회

						baseItemGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						var test = await fnMkTree(edsUtil.getAjax("/BASE_ITEM_REG/selectItemList", param));
						// console.log()
					

						// if(baseItemGridList.getRowCount() > 0 ){
						// 	baseItemGridList.focusAt(0, 0, true);
						// }

						break;
					case "input":// 신규
						var appendedData = {};
						const selectRow=baseItemGridList.getFocusedCell();
						console.log(selectRow);
						let rowKey;
						appendedData.corpCd = $("#searchForm #corpCd").val();
						if(selectRow.rowKey)
						{
							const parentRow=baseItemGridList.getRow(selectRow.rowKey);
							appendedData.pareItemCd = parentRow.itemCd;
							rowKey=selectRow.rowKey;
							baseItemGridList.expand(selectRow.rowKey)//그리드 확장
							await baseItemGridList.appendTreeRow (appendedData, { focus:true ,parentRowKey:rowKey}); // 마지막 ROW 추가
							
						}
						else
						{
							appendedData.pareItemCd = '';
							await baseItemGridList.appendRow(appendedData, { focus:true}); // 마지막 ROW 추가
						}
						const appendRow=baseItemGridList.getFocusedCell();
						const rows=baseItemGridList.getRow(appendRow.rowKey);
						baseItemGridList.enableCell(rows.rowKey, 'itemCd');


						break;
					case "save"://저장
						$('#daonTable').trigger("click");
						setTimeout(function(){
							edsUtil.doCUD("/BASE_ITEM_REG/cudItemList", "baseItemGridList", baseItemGridList);// 저장
						},100);

						break;
					case "delete"://삭제
						let checkRow=baseItemGridList.getCheckedRowKeys();
						for(const row of checkRow)
						{
							let data=baseItemGridList.getChildRows(row);//하위항목검색
							if(data.length>0) return edsUtil.toast({ width:500,position: "center", title: "하위 품목이 있어서 삭제가 불가능합니다.\n 하위 품목을 먼저 삭제하세요. ", icon: "error" });//하위항목존재시 경고

						}
						const checkDelete=await baseItemGridList.removeCheckedRows(true);
						if(checkDelete) await edsUtil.doCUD("/BASE_ITEM_REG/cudItemList", "baseItemGridList", baseItemGridList);// 삭제
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
		function baseItemMSPPop()
		{
			var param = {
				corpCd: document.getElementById('corpCd').value,
				busiCd: document.getElementById('busiCd').value
			};
			edsPopup.util.openPopup(
					"MSTPOPUP",
					param,
					function (Value) {
						document.getElementById('mcateCd').value = Value||this.returnValue.mcateCd;
						document.getElementById('mcateNm').value = Value||this.returnValue.mcateNm;
						document.getElementById('scateCd').value = Value||this.returnValue.scateCd;
						document.getElementById('scateNm').value = Value||this.returnValue.scateNm;
						document.getElementById('tcateCd').value = Value||this.returnValue.tcateCd;
						document.getElementById('tcateNm').value = Value||this.returnValue.tcateNm;
					},
					false,
					true
			);
		}
		function baseItemITEMPop()
		{
			var param = {
				corpCd: document.getElementById('corpCd').value
			};
			edsPopup.util.openPopup(
					"ITEMDIVIPOPUP",
					param,
					function (Value) {
						document.getElementById('itemDiviCd').value = Value||this.returnValue.itemDiviCd;
						document.getElementById('itemDiviNm').value = Value||this.returnValue.itemDiviNm;
					},
					false,
					true
			);
		}
		function testswal()
		{
			Swal.fire({
			position: 'top-end',
			icon: 'success',
			title: 'Your work has been saved',
			showConfirmButton: false,
			timer: 1500
			})
		}
		/**********************************************************************
		 * 화면 팝업 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 함수 영역 START
		 ***********************************************************************/
		/*async function fn_CopyForm2baseItemGridList(){
			setTimeout(async function(){
				var rows = baseItemGridList.getRowCount();
				if(rows > 0){
					var row = baseItemGridList.getFocusedCell();
					var param = {
						sheet: baseItemGridList,
						form: document.baseItemGridListForm,
						rowKey: row.rowKey
					};
					edsUtil.eds_CopyForm2Sheet(param);// Form -> Sheet복사
				}
			}, 100);
		}*/

		/*async function fn_CopybaseItemGridList2Form(){
			setTimeout(async function(){
				var rows = baseItemGridList.getRowCount();
				if(rows > 0){
					var row = baseItemGridList.getFocusedCell();
					var param = {
						sheet: baseItemGridList,
						form: document.baseItemGridListForm,
						rowKey: row.rowKey
					};
					edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
				}
			}, 100);
		}*/
		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>

<div class="row">
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="corpCd" id="corpCd">
				<input type="hidden" name="busiCd" id="busiCd">
				<!-- ./input hidden -->
				<div class="form-group">
					<label for="itemNm">품목명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="itemNm" id="itemNm" title="품목명">
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
	<div class="col-md-12">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="baseItem">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseItemGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="baseItemButtonForm" id="baseItemButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('baseItemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('baseItemGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('baseItemGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('baseItemGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%--<div class="col-md-7">
		<!-- Form 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;">
				<!-- form start -->
				<form class="form-inline" role="form" name="baseItemGridListForm" id="baseItemGridListForm" method="post" onsubmit="return false;">
					<!-- input hidden -->

					<!-- .input hidden -->
					<table class="table table-bordered" name="daonTable" id="daonTable" >
						<tr>
							<td>품목코드</td>
							<td><input type="text" name="itemCd" id="itemCd" style="width: 100%;" title="품목코드" /></td>
							<td>품목명</td>
							<td style="display: none">자재분류</td>
							<td style="display: none"><select name="mateClas" id="mateClas" title="자재분류" style="width: 100%"></select></td>
						</tr>
						<tr>
							<td>상위품목명</td>
							<td>
								<input type="hidden" name="pareItemCd" id="pareItemCd" style="width: 100%;" title="상위품목코드"/>
								<input type="text" name="pareItemNm" id="pareItemNm" style="width: 100%;" title="상위품목명"/>
							</td>
							<td>규격</td>
							<td><input type="text" name="standard" id="standard" style="width: 100%;" title="규격"/></td>
							<td>개요</td>
							<td ><input type="text" name="note1" id="note1" style="width: 100%;"/></td>
						</tr>
						<tr>
							<td>비고</td>
							<td colspan="5"><input type="text" name="note2" id="note2" style="width: 100%;"/></td>
						</tr>
					</table>
				</form>
				<!-- ./form -->
			</div>
		</div>
	</div>--%>
</div>
</body>
</html>