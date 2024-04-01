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
		.tui-grid-cell {
			border-width: 1px;
			border-style: none;
			white-space: nowrap;
			padding: 0;
			overflow: hidden;
			background-color: #fff;
			border-color: #ffffff;
			border-left-width: 1px;
			border-right-width: 1px;
			border-top-width: 1px;
			border-bottom-width: 1px;
			color: #333;
		}
		.tui-grid-layer-state {
			border-left: 1px solid #ffffff;
			background: #ffffff;
		}
		.tui-grid-body-area.tui-grid-body-area {
			background-color: #ffffff;
		}

		
	</style>
	<script>
		let baseGridList;
		let insBaseGridList;
		$(document).ready(async function () {
			await init();
			$('#searchFormUser #empNm').on('change', async function(e) {
				await doAction("baseGridList", "search");
			});
		});

		/* 초기설정 */
		async function init() {

			/* 조회옵션 셋팅 */
			await edsIframe.setParams();

			/* 그리드 초기화 속성 설정 */
			baseGridList = new tui.Grid({
				el: document.getElementById('baseGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['checkbox'/*,'rowNum'*/],
				header: {
					height: 40,
					minRowHeight: 40
				},
				treeColumnOptions: {
					name: 'empNm',
					useCascadingCheckbox: true
				},
				columns:[],
				columnOptions: {
					resizable: true
				}
			});
			/* 그리드 초기화 속성 설정 */
			insBaseGridList = new tui.Grid({
				el: document.getElementById('insBaseGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['checkbox'/*,'rowNum'*/],
				header: {
					height: 40,
					minRowHeight: 40
				},
				columns:[],
				columnOptions: {
					resizable: true
				}
			});
			let gridColumns=[
				{ header:'사원명',		name:'empNm',		minWidth:50,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }  },
				{ header:'직책',		name:'respDiviNm',	minWidth:50,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직위',		name:'posiDiviNm',	minWidth:50,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'상태',		name:'sStatus',		minWidth:50,	align:'left',	editor:{type:'text'},hidden:true },
				{ header:'사원코드',	name:'empCd',		minWidth:100,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true },hidden:true  },
				{ header:'아이디',		name:'empId',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } ,hidden:true },

				// hidden(숨김)
			];
			let gridColumns2=[
				{ header:'사원명',		name:'empNm',		minWidth:50,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }  },
				{ header:'직책',		name:'respDiviNm',	minWidth:50,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직위',		name:'posiDiviNm',	minWidth:50,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'상태',		name:'sStatus',		minWidth:50,	align:'left',	editor:{type:'text'},hidden:true },
				{ header:'사원코드',	name:'empCd',		minWidth:100,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true },hidden:true  },
				{ header:'아이디',		name:'empId',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } ,hidden:true },

				// hidden(숨김)
			];

			baseGridList.setColumns(gridColumns);//컬럼설정
			insBaseGridList.setColumns(gridColumns2);//컬럼설정
			
			/* grid 이벤트 */
			
	
			baseGridList.on('dblclick', ev => {
				if(ev.rowKey>=0)
				 appandEvents(ev.rowKey);
				//await doAction("insBaseGridList", "btnUp");
			});
			insBaseGridList.on('dblclick', async ev => {
				if(ev.rowKey>=0)
				 removeEvents(ev.rowKey);
				//await doAction("insBaseGridList", "btnUp");
			});
			
			/* grid 이벤트 끝 */

			/* 조회 */
			await doAction("baseGridList", "search");
		}
			
			/* grid 함수 */
		async function fnMkTree(data) {
			const itemDict = {};
			const rootItems = [];
			for (const item of data) {
				const tempData={depaCd:item.depaCd,empNm:item.depaNm}
				if(!itemDict[item.depaCd])
				{
                	itemDict[item.depaCd] = tempData;
					data.push(tempData);
				}
			}

			for (const item of data) {
                const pareItemCd = item.depaCd;
				const corpCd = item.corpCd;
                if (corpCd=='' || corpCd==null) {
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
			await baseGridList.resetData(rootItems);
			baseGridList.expandAll();//트리확장

		}
		/*사용자 추가*/
		function appandEvents(rowKey) {
			var row=baseGridList.getRow(rowKey);
			if(row.corpCd)
			{
				if(checkGrid(rowKey)) return 	Swal.fire({icon: 'error',title: '실패',text: "<"+row.empNm+">"+'은(는) 이미 추가되어있는 직원입니다.'});
					let data={};
					Object.assign(data,row)
					data.prevRowkey=row.rowKey;
					insBaseGridList.appendRow(data, { focus:true });
			}
			else
			{
				for(const childRow of row._children)
				{
					if(checkGrid(childRow.rowKey)) return 	Swal.fire({icon: 'error',title: '실패',text: "<"+childRow.empNm+">"+'은(는) 이미 추가되어있는 직원입니다.'});
					let data={};
					Object.assign(data,childRow)
					data.prevRowkey=childRow.rowKey;
					insBaseGridList.appendRow(data, { focus:true });
				}
			}
		}
		/*사용자 제거*/
		function removeEvents(rowKey) {
			insBaseGridList.removeRow(rowKey, { focus:true });

		}
		function checkGrid(rowkey)
		{
			var test=insBaseGridList.getData();
			for(const i of test)
			{
				if(i.prevRowkey==rowkey)
				return true;
			}
			return false;
		}
		/* grid 함수 끝 */
		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseGridList') {
				switch (sAction) {
					case "search":	// 조회

						baseGridList.finishEditing();
						baseGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchFormUser")); //조회조건
						param.useYn="01";
						baseGridList.resetData(edsUtil.getAjax("/BASE_USER_MGT_LIST/selectUserMgtList", param))
						var test = await fnMkTree(edsUtil.getAjax("/BASE_USER_MGT_LIST/selectUserMgtList", param));
						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;

					case "close":	// 닫기

						var param = [];
						param.name = document.getElementById('name').value;
						console.log(param.length)
						await edsIframe.closePopup(param);

						break;
				}
			}
			else if (sheetNm == 'insBaseGridList') {
				switch (sAction) {
					case "removeRow":
						if(insBaseGridList.getRowCount()>0){
							var rows = insBaseGridList.getCheckedRowKeys();
							if(rows.length > 0){
								insBaseGridList.removeRows(rows);
							} else {
								alert("선택된 품목이 없습니다.");
							}
						} else {
							alert("품목 목록이 없습니다.");
						}
						break;
					case "addRow":
						if(baseGridList.getRowCount()>0){
							var rows = baseGridList.getCheckedRows();
							if(rows.length > 0){
								for (const row of rows) {
									// rows.getdata
									// var appendedData = {};
									// appendedData.sStatus =  "I";
									if(row.corpCd)
									{
										if(checkGrid(row.rowKey)) return 	Swal.fire({icon: 'error',title: '실패',text: "<"+row.empNm+">"+'은(는) 이미 추가되어있는 직원입니다.'});
										row.prevRowkey=row.rowKey;
										insBaseGridList.appendRow(row, { focus:true });
									}
									//insBaseGridList.appendRow(row, { focus:true });
									// // 체크 풀기
									baseGridList.uncheck(row.rowKey);
								}
								console.log(baseGridList.getData());
								insBaseGridList.refreshLayout()
							} else {
								Swal.fire({icon: 'warning',title: '실패',text: '선택된 품목이 없습니다.'})
							}
						} else {
							Swal.fire({icon: 'warning',title: '실패',text: '품목 목록이 없습니다.'})
						}
						break;
						case "apply"://등록		
						{	
							insBaseGridList.finishEditing();
							var param = insBaseGridList.getData();
							param.name = document.getElementById('name').value;
							await edsIframe.closePopup(param);
						}
						break;
				}
			}
		}
		
	</script>
</head>

<body>

<div class="row" style="padding: 20px;border: 1px; border-color: aquamarine; margin: 0px; height: 100vh;overflow: auto;">
	<div class="col-md-12" style="height: 100%;">
		<!-- 검색조건 영역 -->
		<div class="row" style="height: 100%;background-color: #ebe9e4; " >
			<div class="col-md-12 d-none" style="padding-right: 15px; background-color: #ebe9e4;height: fit-content;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchFormUser" id="searchFormUser" method="post"onsubmit="return false;">
						<!-- input hidden -->
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">

						<!-- ./input hidden -->
						<div class="form-group" style="margin-left: 20px"></div>
						<div class="form-group">
							<label for="empNm">사원명 &nbsp;</label>
							<div class="input-group input-group-sm" hidden>
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="empNm" id="empNm" title="사원명">
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
			<div class="col-md-12" style=" padding: 5px 15px 0 15px; background-color: #ebe9e4;height: fit-content;"></div>
			<div class="col-md-12" style=" padding: 5px 15px 0 15px; background-color: #ebe9e4;height: fit-content;">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 사원 목록
				</div>
				<div class="btn-group float-right">	
					<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('insBaseGridList', 'apply')"><i class="fa fa-save"></i> 등록</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('baseGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
				</div>
			</div>
			<div class="col-md-5" style="height: calc(100% - 90px); background-color: chocolate; padding: 5px 15px 5px 15px; background-color: #ebe9e4" id="baseGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" ></div>
			</div>
			<div class="col-md-1" style=" text-align: center;padding: 0;align-self: center; margin: auto;">
				<button type="button" style="margin: 5px;" class="btn btn-success" name="btnUp" id="btnUp" onclick="doAction('insBaseGridList', 'addRow')"><i></i> 추가</button>
				<button type="button" style="margin: 5px;" class="btn btn-success" name="btnUp" id="btnUp" onclick="doAction('insBaseGridList', 'removeRow')"><i></i> 제외</button>
			</div>
			<div class="col-md-6" style="height: calc(100% - 90px);padding: 5px 15px 5px 15px; background-color: #ebe9e4" id="insBaseGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="insBaseGridListDIV" ></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>