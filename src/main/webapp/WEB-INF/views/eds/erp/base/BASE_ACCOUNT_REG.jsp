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
		var baseAccountGridList
		$(document).ready(function () {
			init();

			//	이벤트
			$('#searchForm #accountNm, #searchForm #useYn').on('change', function(e) {
				doAction("baseAccountGridList", "search");
			});
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");
			// edsUtil.setForm(document.querySelector("#baseAccountGridListForm"), "basma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = ${LoginInfo.corpCd};
			document.getElementById('busiCd').value = ${LoginInfo.busiCd};

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#baseAccountButtonForm"));

			/* 이벤트 셋팅 */
			/*edsUtil.addChangeEvent("baseAccountGridListForm", fn_CopyForm2baseAccountGridList);*/

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			baseAccountGridList = new tui.Grid({
				el: document.getElementById('baseAccountGridListDIV'),
				// data: treeData,
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				treeColumnOptions: {
					name: 'accountCd',
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

			baseAccountGridList.setColumns([
				{ header:'계정코드',		name:'accountCd',		width:100,		align:'center',	defaultValue: '',editor:{type:'text'},	validation:{required:true}},
				{ header:'계정과목명',		name:'accountNm',		width:200,		align:'left',	defaultValue: '',	editor:{type:'text'}},
				{ header:'재무재표코드',	name:'financialCd',	width:150,		align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'재무재표명',		name:'financialNm',		width:200,		align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'사용구분',		name:'useYn',	width:100,		align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true }},
				{ header: '적요',			name:'note1',		minWidth:150,	align:'center',	defaultValue: '',	editor:{type:'text'}},
				{ header:'비고',			name:'note2',		minWidth:150,	align:'center',	defaultValue: '',	editor:{type:'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
				{ header:'상위계정코드',	name:'pareAccountCd',	width:100,		align:'center',	hidden:true },

			]);
			baseAccountGridList.disableColumn('accountCd');
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseAccountGridList.on('expand', ev => {
			
			});

			baseAccountGridList.on('collapse', ev => {

			});
			baseAccountGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='custNm') await popupHandler('cust','open');
					else if(colNm==='manNm') await popupHandler('user','open');
					else if(colNm==='itemPopup') await popupHandler('itemPopup','open');
					else if(colNm==='accountPopup') await popupHandler('account','open');
				}else{
					baseAccountGridList.finishEditing();
				}
			});

			            // Get the input box
			let input = document.getElementById('accountNm');

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

			console.log(window.innerHeight);
			document.getElementById('baseAccount').style.height = window.innerHeight - 90 + 'px';

			/* 조회 */
			doAction("baseAccountGridList", "search");
		}

		async function fnMkTree(data) {
			const accountDict = {};
			const rootAccounts = [];

			for (const account of data) {
                accountDict[account.accountCd] = account;
			}

			for (const account of data) {
                const pareAccountCd = account.pareAccountCd;
                if (pareAccountCd=='' || pareAccountCd==null) {
					rootAccounts.push(account);
				} else {
                    const parent = accountDict[pareAccountCd];
                    if (parent) 
                    {
                        if(!parent._children)parent._children=[];
                        parent._children.push(account);
					}
					else
					{
						rootAccounts.push(account);
					}
			}
			}
			await baseAccountGridList.resetData(rootAccounts);
		}
		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseAccountGridList') {
				switch (sAction) {
					case "search":// 조회

						baseAccountGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						var test = await fnMkTree(edsUtil.getAjax("/BASE_ACCOUNT_REG/selectAccountList", param))
						break;
					case "input":// 신규
					var appendedData = {};
						const selectRow=baseAccountGridList.getFocusedCell();
						console.log(selectRow);
						let rowKey;
						appendedData.corpCd = $("#searchForm #corpCd").val();
						if(selectRow.rowKey)
						{
							const parentRow=baseAccountGridList.getRow(selectRow.rowKey);
							appendedData.pareAccountCd = parentRow.accountCd;
							rowKey=selectRow.rowKey;
							baseAccountGridList.expand(selectRow.rowKey)//그리드 확장
							await baseAccountGridList.appendTreeRow (appendedData, { focus:true ,parentRowKey:rowKey}); // 마지막 ROW 추가
							
						}
						else
						{
							appendedData.pareAccountCd = '';
							await baseAccountGridList.appendRow(appendedData, { focus:true}); // 마지막 ROW 추가
						}
						const focusRow=baseAccountGridList.getFocusedCell();
						const rows=baseAccountGridList.getRow(focusRow.rowKey);
						baseAccountGridList.enableCell(rows.rowKey, 'accountCd');

						break;
					case "save"://저장
						$('#daonTable').trigger("click");
						setTimeout(function(){
							edsUtil.doCUD("/BASE_ACCOUNT_REG/cudAccountList", "baseAccountGridList", baseAccountGridList);// 저장
						},100);

						break;
					case "delete"://삭제
					{
						let checkRow=baseAccountGridList.getCheckedRowKeys();
						for(const row of checkRow)
						{
							let data=baseAccountGridList.getChildRows(row);//하위항목검색
							if(data.length>0) return edsUtil.toast({width:500, position: "center", title: "하위 품목이 있어서 삭제가 불가능합니다.\n 하위 품목을 먼저 삭제하세요. ", icon: "error" });//하위항목존재시 경고

						}
						// getChildRows(rowKey)
					    // if()
						const checkDelete=await baseAccountGridList.removeCheckedRows(true);
						if(checkDelete) await edsUtil.doCUD("/BASE_ACCOUNT_REG/cudAccountList", "baseAccountGridList", baseAccountGridList);// 삭제
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
		function baseAccountMSPPop()
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

		/**********************************************************************
		 * 화면 팝업 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 함수 영역 START
		 ***********************************************************************/
		 async function popupHandler(name,divi,callback){
			var row = baseAccountGridList.getFocusedCell();
			switch (name) {
				case 'cust':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.custNm= baseAccountGridList.getValue(row.rowKey, 'custNm');
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						baseAccountGridList.setValue(row.rowKey,'custCd',callback.custCd);
						baseAccountGridList.setValue(row.rowKey,'custNm',callback.custNm);
					}
				break;
				case 'user':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
						param.name= name;
						await edsIframe.openPopup('USERPOPUP',param)
					}else{
						baseAccountGridList.setValue(row.rowKey,'manCd',callback.empCd);
						baseAccountGridList.setValue(row.rowKey,'manNm',callback.empNm);
					}
				break;
				case 'item':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ITEMPOPUP',param)
					}else{

						var rst = callback.param;
						if(rst === undefined) return;
						var rstLen = rst.length;
						var maiRow = baseAccountGridList.getFocusedCell();
						var subRow = yeongEobGridItem.getFocusedCell();
						if(rstLen > 0){
							for(var i=0; i<rstLen; i++){
								var data = edsUtil.cloneObj(yeongEobGridItem.getData());
								var itemRow = edsUtil.getMaxObject(data,'rowKey');
								rst[i].rowKey = itemRow.rowKey+i+1;
								rst[i].corpCd = baseAccountGridList.getValue(maiRow.rowKey, "corpCd");
								rst[i].busiCd = baseAccountGridList.getValue(maiRow.rowKey, "busiCd");
								rst[i].estCd = baseAccountGridList.getValue(maiRow.rowKey, "estCd");
								rst[i].vatDivi = '01';
								rst[i].taxDivi = '01';
								rst[i].qty = 0;
								rst[i].cost = 0;
								rst[i].supAmt = 0;
								rst[i].vatAmt = 0;
								rst[i].totAmt = 0;
								rst[i].cost2 = 0;
								rst[i].supAmt2 = 0;
								rst[i].vatAmt2 = 0;
								rst[i].totAmt2 = 0;
								rst[i].cost3 = 0;
								rst[i].supAmt3 = 0;
								rst[i].vatAmt3 = 0;
								rst[i].totAmt3 = 0;
								rst[i].saleDivi = '01';
								rst[i].saleRate = 0;
								rst[i]._attributes.checked = false;
								yeongEobGridItem.appendRow(rst[i])
							}
							yeongEobGridItem.removeRow(subRow.rowKey);// 추가된 row 삭제
						}else{
							// baseAccountGridList.setValue(row.rowKey,'itemCd',callback.itemCd);
							// baseAccountGridList.setValue(row.rowKey,'itemNm',callback.itemNm);
						}
					}
				break;
				case 'itemPopup':
					if(divi==='open'){
						document.getElementById('btnItemPopup').click();
						setTimeout(async ev =>{
							await doAction('yeongEobGridItem','search')
						},200)
					}else{

					}
				break;
				case 'account':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ACCOUNTPOPUP',param)
					}else{
						baseAccountGridList.setValue(row.rowKey,'manCd',callback.empCd);
						baseAccountGridList.setValue(row.rowKey,'manNm',callback.empNm);
					}
				break;
			}
		}
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
					<label for="accountNm">계정이름 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="accountNm" id="accountNm" title="품목명">
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
			<div class="col-md-12" style="height: 100%;" id="baseAccount">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseAccountGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="baseAccountButtonForm" id="baseAccountButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('baseAccountGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('baseAccountGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('baseAccountGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('baseAccountGridList', 'delete')"><i class="fa fa-trash-o"></i> 삭제</button>
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
				<form class="form-inline" role="form" name="baseAccountGridListForm" id="baseAccountGridListForm" method="post" onsubmit="return false;">
					<!-- input hidden -->

					<!-- .input hidden -->
					<table class="table table-bordered" name="daonTable" id="daonTable" >
						<tr>
							<td>품목코드</td>
							<td><input type="text" name="accountCd" id="accountCd" style="width: 100%;" title="품목코드" /></td>
							<td>품목명</td>
							<td style="display: none">자재분류</td>
							<td style="display: none"><select name="mateClas" id="mateClas" title="자재분류" style="width: 100%"></select></td>
						</tr>
						<tr>
							<td>상위품목명</td>
							<td>
								<input type="hidden" name="pareAccountCd" id="pareAccountCd" style="width: 100%;" title="상위품목코드"/>
								<input type="text" name="pareAccountNm" id="pareAccountNm" style="width: 100%;" title="상위품목명"/>
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