<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>

	<script>
		var projectGridList, projectGridCost, projectGridCostDet;

		$(document).ready(function () {
			init();

			/**
			 * 조회 엔터 기능
			 * */
			document.getElementById('searchForm').addEventListener('keyup', async ev=>{
				var id = ev.target.id;
				if(ev.keyCode === 13){
					await doAction('projectGridList', 'search');
				}
			});
		});

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "project");
			edsUtil.setForm(document.querySelector("#projectGridListForm"), "project");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
			<%--document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';--%>
			<%--document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';--%>

			/* 권한에 따라 회사, 사업장 활성화 */
			var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
			if(authDivi === "03" || authDivi === "04"){
				document.getElementById('busiCd').disabled = true;
				document.getElementById('btnBusiCd').disabled = true;
			}

			/* Button 셋팅 */
			await edsUtil.setButtonForm(document.querySelector("#projectGridListButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridCostButtonForm"));

			/**********************************************************************
			 * editor 영역 START
			 ***********************************************************************/

			// editor.getMarkdown();
			/**********************************************************************
			 * editor 영역 END
			 ***********************************************************************/

			/*********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/

			/* 그리드 초기화 속성 설정 */
			projectGridList = new tui.Grid({
				el: document.getElementById('projectGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight: 'auto',
				minRowHeight:40,
				rowHeaders: [/*'rowNum', *//*'checkbox'*/],
				header: {
					height: 40,
					minRowHeight: 40,
					complexColumns: [
					],
				},
				columns:[],
				columnOptions: {
					resizable: true,
					frozenCount: 1,
					frozenBorderWidth: 2, // 컬럼 고정 옵션
				},
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						conTotAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						salTotAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						costTotAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						profitAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						profitRate: { template: function(valueMap) { return edsUtil.addComma(Math.round(valueMap.filtered.avg*10)/10);}},
						colTotAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						colTotRate: { template: function(valueMap) { return edsUtil.addComma(Math.round(valueMap.filtered.avg*10)/10);}},
					}
				}
			});

			projectGridList.setColumns([
				{ header:'프로젝트코드',	name:'projCd',		width:95,		align:'center',	filter: { type: 'text'},	sortable: true},
				{ header:'거래처',		name:'custNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'분류',			name:'clas',		width:80,		align:'center'},
				{ header:'품목',			name:'item',		width:120,		align:'center' },
				{ header:'사업장',		name:'busiNm',		minWidth:90,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'프로젝트명',	name:'projNm',		width:160,		align:'left',	defaultValue: '',	filter: { type: 'text'},whiteSpace:'pre-line',
					formatter: function (value) {
						var num = Number(value.row.edmsMargin);
						var rst = ''
						if(num < 21) rst = '<b style="color:red">'+value.value+'</b>'
						else rst = value.value
						return rst
					}},
				{ header:'계약금액',		name:'conTotAmt',	width:90,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},sortable: true},
				{ header:'매출금액',		name:'salTotAmt',	width:90,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},sortable: true},
				{ header:'매입원가',		name:'costTotAmt',	width:90,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},sortable: true},
				{ header:'영업이익',		name:'profitAmt',	width:90,		align:'right',	defaultValue: '',	formatter: function (value){return '<a href="javascript:void(0);" style="font-size: 14px;text-decoration: underline;"><b>'+edsUtil.addComma(value.value)+'</b></a>';},sortable: true},
				{ header:'영업이익률',	name:'profitRate',	width:70,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value)+'%';},sortable: true},
				{ header:'예상이익률',	name:'edmsMargin',	width:70,		align:'right',	defaultValue: '',
					formatter: function (value) {
						var num = Number(value.row.edmsMargin);
						var rst = '';
						if(num < 21) rst = '<b style="color:red">'+value.value+'%'+'</b>'
						else rst = value.value+'%'
						return edsUtil.addComma(rst)
					}
					,sortable: true
				},
				{ header:'수금액',		name:'reColTotAmt',	width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
				{ header:'미수금액',		name:'colTotAmt',	width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},
				{ header:'수금율',		name:'colTotRate',	width:50,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value)+'%';},sortable: true},
				{ header:'계약특기사항',	name:'note1',		minWidth:150,	align:'left',	defaultValue: '' 	},
				{ header:'진행상태',		name:'endDivi',		width:60,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'종료일자',		name:'endDt',		width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'계약일자',		name:'cntDt',		width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'착수일자',		name:'initiateDt',	width:80,		align:'center',	defaultValue: '',	sortable: true},
				{ header:'납기일자',		name:'dueDt',		width:80,		align:'center',	defaultValue: '',	sortable: true	},
				{ header:'성공',			name:'sccDivi',		width:40,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM026")}},	formatter: 'listItemText',	filter: { type: 'text'}},
				{ header:'구분',			name:'projDivi',	width:40,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM029")}},	formatter: 'listItemText',	filter: { type: 'text'}},
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적일자',		name:'estDt',		width:80,		align:'center',	hidden:true },
				{ header:'유효기간',		name:'validDt',		width:80,		align:'center',	hidden:true },
				{ header:'마감',			name:'deadDivi',	width:55,		align:'center',	hidden:true },
				{ header:'결제조건',		name:'payTm',		width:80,		align:'center',	hidden:true },
				{ header:'결재자보고내용',name:'note2',		minWidth:150,	align:'left',	hidden:true },
				{ header:'부서',			name:'depaNm',		width:80,		align:'center',	hidden:true },
				{ header:'담당자',		name:'manNm',		width:50,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'담당자코드',	name:'manCd',		width:100,		align:'center',	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'공급가액',		name:'supAmt3',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt3',		width:100,		align:'right',	hidden:true },
			]);

			projectGridCost = new tui.Grid({
				el: document.getElementById('projectGridCostDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ /*'checkbox'*/],
				header: {
					height: 56,
					minRowHeight: 56,
					complexColumns: [
						{
							header: '계정과목',
							name: 'account',
							childNames: ['accountCd','accountNm']
						},
					],
				},
				columns:[],
				columnOptions: {
					resizable: true,
					/*frozenCount: 1,
					frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
				},
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						supAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			projectGridCost.setColumns([
				{ header:'구분',			name:'accountDivi',	width:70,		align:'center',	defaultValue: '',
					formatter: function (value){
						var rst = '';
						if(value.value === '01') rst = '매출금액';
						if(value.value === '02') rst = '매입원가';
						return rst;
					}
				},
				{ header:'코드',			name:'accountCd',	width:70,		align:'center',	defaultValue: '',	},
				{ header:'명',			name:'accountNm',	width:100,		align:'center',	defaultValue: '',	},
				{ header:'합계금액',		name:'totAmt',		minWidth:100,	align:'right',	defaultValue: '',	formatter: function (value){return '<a href="javascript:void(0);" style="font-size: 14px;text-decoration: underline;"><b>'+edsUtil.addComma(value.value)+'</b></a>';}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
			]);

			projectGridCostDet = new tui.Grid({
				el: document.getElementById('projectGridCostDetDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ /*'checkbox'*/],
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
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						supAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			projectGridCostDet.setColumns([
				{ header:'일자',			name:'costDt',		width:80,		align:'left',	defaultValue: ''	},
				{ header:'거래처명',		name:'custNm',		width:140,		align:'left',	defaultValue: '',	},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'합계금액',		name:'totAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}	},
				{ header:'입력자',		name:'inpNm',		width:60,		align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:60,		align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'계정과목코드',	name:'accountCd',	width:100,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'카드/계좌',	name:'credCd',		width:150,		align:'left',	hidden:true },
				{ header:'지출유형',		name:'expeDivi',	width:80,		align:'center',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			projectGridList.disableColumn('sccDivi');
			projectGridList.disableColumn('projDivi');
			projectGridCostDet.disableColumn('expeDivi');

			/*필터 이후 포커스*/
			projectGridList.on('afterFilter', async ev => {
				if(ev.instance.store.data.filteredIndex.length>0){
					projectGridList.focusAt(0,0,true)
				}
			});

			projectGridList.on('focusChange', async ev => {
				if(ev.rowKey !== ev.prevRowKey){
					setTimeout(async (ev)=>{
						await fn_CopyProjectGridList2Form(projectGridList, document.projectGridListForm);
					},200);
				}
			});

			projectGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='profitAmt'){
						await doAction('projectGridCost','costPopup');
					}
					if(colNm==='note1') {
						await edsUtil.sheetData2Maldal(projectGridList);
					}
				}else{
					// projectGridList.finishEditing();
				}
			});

			projectGridCost.on('focusChange', async ev => {
				if(ev.rowKey !== ev.prevRowKey){
					setTimeout(async (ev)=>{
						await doAction('projectGridCostDet','search');
					},200);
				}
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			// document.getElementById('projectGridList').style.height = (innerHeight)*(1-0.11) + 'px';
			// document.getElementById('projectGridCost').style.height = (innerHeight)*(1-0.6) + 'px';
			// document.getElementById('projectGridCostDet').style.height = (innerHeight)*(1-0.6) + 'px';
			doAction('projectGridList', 'search');
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm === 'projectGridList') {
				switch (sAction) {
					case "search":// 조회

						projectGridList.finishEditing(); // 데이터 초기화
						projectGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						var data = edsUtil.getAjax("/PROJECT_MGT/selectProjSchList", param)
						projectGridList.resetData(data); // 데이터 set
						break;
				}
			}else if (sheetNm === 'projectGridCost') {
				switch (sAction) {
					case 'costPopup':
						document.getElementById('btnCostPopEv').click();
						setTimeout(async ev =>{
							await doAction('projectGridCost','search');
							if(projectGridCost.getRowCount() > 0 ){
								projectGridCost.focusAt(0, 0, true);
							}
						},200)
						break;
					case "search":// 조회

						projectGridCost.refreshLayout(); // 데이터 초기화
						projectGridCost.finishEditing(); // 데이터 마감
						projectGridCost.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						projectGridCost.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjCostTot", param)); // 데이터 set

						if(projectGridCost.getRowCount() > 0 ){
							projectGridCost.focusAt(0, 0, true);
						}
						break;
				}
			}else if (sheetNm === 'projectGridCostDet') {
				switch (sAction) {
					case 'costDetPopup':
						document.getElementById('btnCostDetPopEv').click();
						setTimeout(async ev =>{
							await doAction('projectGridCostDet','search');
						},200)
						break;
					case "search":// 조회

						projectGridCostDet.refreshLayout(); // 데이터 초기화
						projectGridCostDet.finishEditing(); // 데이터 마감
						projectGridCostDet.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var costRow = projectGridCost.getFocusedCell();

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						param.accountCd = projectGridCost.getValue(costRow.rowKey, 'accountCd');
						param.accountDivi = projectGridCost.getValue(costRow.rowKey, 'accountDivi');
						projectGridCostDet.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjCostDet", param)); // 데이터 set

						if(projectGridCostDet.getRowCount() > 0 ){
							projectGridCostDet.focusAt(0, 0, true);
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

		async function popupHandler(name,divi,callback){
			var row = projectGridList.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'busi':
					if(divi==='open'){
						var param={}
						param.corpCd= $("#searchForm #corpCd").val(),
								param.busiCd= document.getElementById('busiCd').value
						param.name= name;
						await edsIframe.openPopup('BUSIPOPUP',param)
						document.querySelector('form[id="searchForm"] input[id="busiCd"]').value = '';
						document.querySelector('form[id="searchForm"] input[id="busiNm"]').value = '';
					}else{
						document.querySelector('form[id="searchForm"] input[id="busiCd"]').value = callback.busiCd;
						document.querySelector('form[id="searchForm"] input[id="busiNm"]').value = callback.busiNm;
					}
					break;
			}
		}

		async function fn_CopyProjectGridList2Form(sheet,form){
			var rows = sheet.getRowCount();
			if(rows > 0){
				var row = sheet.getFocusedCell();
				var param = {
					sheet: sheet,
					form: form,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
			}
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
<div class="row" style="position:relative">
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
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group-prepend" style="min-width: 15rem;">
								<select class="form-control select2" style="width: 100%;" name="busiCd" id="busiCd" >
								</select>
							</div>
<%--							<label for="busiCd">사업장 &nbsp;</label>--%>
<%--							<div class="input-group-prepend">--%>
<%--								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">--%>
<%--							</div>--%>
<%--							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>--%>
<%--							<div class="input-group-append">--%>
<%--								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>--%>
<%--							</div>--%>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="stDt">계약일자 &nbsp;</label>
							<div class="input-group-prepend">
								<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="stDt" id="stDt" title="끝">
							</div>
							<span>&nbsp;~&nbsp;</span>
							<div class="input-group-append">
								<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="edDt" id="edDt" title="끝">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="projNm">프로젝트 &nbsp;</label>
							<input type="text" class="form-control" name="projNm" id="projNm" title="프로젝트명">
							<div class="form-group-append">
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-primary btn-flat" name="btnProjCd" id="btnProjCd" onclick="doAction('projectGridList','search'); return false;">검색</button></span>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" id="projectGridList" style="height: calc(100vh - 6rem); width: 100%;">
				<!-- 시트가 될 DIV 객체 -->
				<div id="projectGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="projectGridListButtonForm" id="projectGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"			id="btnSearch"				onclick="doAction('projectGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnCostPopEv"		id="btnCostPopEv"			data-toggle="modal" data-target="#modalCart"  style="display: none"></button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalCart" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header bg-dark font-color text-white">
				<h4 class="modal-title" style="color:#4d4a41!important;">원가 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<div class="col-md-12" style="height: 100%;">
					<form name="projectGridListForm" id="projectGridListForm">
						<div class="form-row">
							<div class="col-md-1 mb-3">
								<label for="sccDivi"><b>성공</b></label>
								<select type="text" class="form-control text-center" name="sccDivi" id="sccDivi" title="성공" disabled></select>
							</div>
							<div class="col-md-1 mb-3">
								<label for="projDivi"><b>구분</b></label>
								<select type="text" class="form-control text-center" name="projDivi" id="projDivi" title="구분" disabled></select>
							</div>
							<div class="col-md-2 mb-3">
								<label for="cntDt"><b>계약일자</b></label>
								<input type="text" class="form-control text-center" id="cntDt" name="cntDt" placeholder="계약일자" value="계약일자" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="dueDt"><b>납기일자</b></label>
								<input type="text" class="form-control text-center" id="dueDt" name="dueDt" placeholder="납기일자" value="납기일자" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="endDt"><b>종료일자</b></label>
								<input type="text" class="form-control text-center" id="endDt" name="endDt" placeholder="종료일자" value="종료일자" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="depaNm"><b>부서</b></label>
								<input type="text" class="form-control text-center" id="depaNm" name="depaNm" placeholder="부서" value="부서" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="manNm"><b>담당자</b></label>
								<input type="text" class="form-control text-center" id="manNm" name="manNm" placeholder="담당자" value="담당자" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-6 mb-3">
								<label for="projNm"><b>프로젝트</b></label>
								<input type="text" class="form-control" id="projNm" name="projNm" placeholder="프로젝트" value="프로젝트" readonly="readonly">
							</div>
							<div class="col-md-6 mb-3">
								<label for="custNm"><b>거래처</b></label>
								<input type="text" class="form-control" id="custNm" name="custNm" placeholder="거래처" value="거래처" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-4 mb-3">
								<label for="salTotAmt"><b>매출금액</b></label>
								<input type="text" class="form-control text-right" id="salTotAmt" style="background-color: yellow" name="salTotAmt" placeholder="매출금액" value="매출금액" readonly="readonly">
							</div>
							<div class="col-md-4 mb-3">
								<label for="costTotAmt"><b>매입원가</b></label>
								<input type="text" class="form-control text-right" id="costTotAmt" style="background-color: yellow" name="costTotAmt" placeholder="매입원가" value="매입원가" readonly="readonly">
							</div>
							<div class="col-md-4 mb-3">
								<label for="profitAmt"><b>영업이익</b></label>
								<input type="text" class="form-control text-right" id="profitAmt" style="background-color: yellow" name="profitAmt" placeholder="영업이익" value="영업이익" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-4" id="projectGridCost" style="height: calc(30vh); width: 100%;">
								<!-- 시트가 될 DIV 객체 -->
								<div id="projectGridCostDIV" style="width:100%; height:100%;"></div>
							</div>
							<div class="col-md-8" id="projectGridCostDet" style="height: calc(30vh); width: 100%;">
								<!-- 시트가 될 DIV 객체 -->
								<div id="projectGridCostDetDIV" style="width:100%; height:100%;"></div>
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
							<form class="form-inline" role="form" name="projectGridCostButtonForm" id="projectGridCostButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch1"	id="btnSearch1"	onclick="doAction('projectGridCost', 'search')"><i class="fa fa-search"></i> 조회</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose1"	id="btnClose1"	onclick="doAction('projectGridCost', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>