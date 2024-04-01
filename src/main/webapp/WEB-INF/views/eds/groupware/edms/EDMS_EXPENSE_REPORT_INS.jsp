<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<!-- Select2 -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2/css/select2.min.css">
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css" />
	<script type="text/javascript" src="/AdminLTE_main/plugins/dropzone/dropzone.js"></script>	
	<script type="text/javascript" src='/js/com/eds.edms.js'></script>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
	<!-- adminlte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<style>
				.btn-primary
		{
			color: #fff;
			background-color: #544e4c;
    		border-color: #544e4c;
			box-shadow: none;
		}
		.btn-primary :hover
		{
			color: #fff;
			background-color: #4f5962;
			border-color: #525D6B;
		}
	</style>
</head>

<body>
<div style="position:relative">
	<section class="content-header">
		<div class="container-fluid">
	        <div class="row mb-2">
	          <div class="col-sm-12">
	            <h3 class="m-auto">지출품의서<div class="float-right">
					<div class="container">
						<!-- <button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="popupHandler('apply','open')"><i class="fa fa-plus"></i> 견적내용적용</button> -->
					</div>
				</div></h3>
	        </div>
	    </div>
		
	</section>
	
	<section class="content" >
		<div class="container-fluid">
			<div class="row" >
				<div class="col-md-12">
					<form name="edmsGridItemForm" id="edmsGridItemForm" method="post" onsubmit="return false;">
						<input type="hidden" name="keyCd" id="keyCd" value="">
						<input type="hidden" name="corpCd" id="corpCd" value="">
						<input type="hidden" name="busiCd" id="busiCd" value="">
						<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
						<input type="hidden" id="docDivi">
					<!-- Form 영역 -->
					<div class="card card-lightblue card-outline">
						<div class="card-header">
						<label class="card-title" style=""> 지출정보</label>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12">
									<!-- text input -->
									<div class="form-group" style="text-align: center;">
									<label>아래와 같이 지출내역을 품의하오니, 재가하여 주시기 바랍니다. </label>
									</div>
									<!-- /.form-group -->
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<!-- text input -->
									<div class="form-group" style="text-align: center;">
									<label>- 아&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;래 - </label>
									</div>
								</div>
								<!-- /.form-group -->
							</div>
							<div class="row">
								<div class="col-sm-12">
									<!-- text input -->
									<div class="form-group">
										<i class="fa-solid fa-circle-check"></i><label for="submitNm">문서제목</label>
										<input type="text" class="form-control" placeholder="입력 ..." name="submitNm" id="submitNm" required value="지출품의 - ">
										
									</div>
									<div class="card card-warning card-outline">
										<div class="card-header">
											<label class="card-title">합계금액</label>
										</div>
										<div class="card-body">
											<div class="row">
												<div class="col-sm-4">
												<!-- text input -->
												<div class="form-group">
													<label>합계금액</label>
													<input type="text" class="form-control" placeholder="자동계산 ..." name="totAmt" id="totAmt" readonly>
												</div>
												<!-- /.form-group -->
												</div>
												<div class="col-sm-4">
													<!-- text input -->
													<div class="form-group">
													<label>공급가액</label>
													<input type="text" class="form-control" placeholder="자동계산 ..." name="supAmt" id="supAmt" readonly>
													</div>
													<!-- /.form-group -->
												</div>
												<div class="col-sm-4">
													<!-- text input -->
													<div class="form-group">
													<label>부가세액</label>
													<input type="text" class="form-control" placeholder="자동계산 ..." name="vatAmt" id="vatAmt" readonly>
													</div>
													<!-- /.form-group -->
												</div>
											</div>
										</div>
									</div>
									<div class="card card-lightblue card-outline">
										<div class="card-header">
											<label class="card-title">이슈사항</label>
										</div>
										<div class="card-body">
											<div class="row">
												<div class="col-sm-12">
												<!-- text input -->
													<div class="form-group">
														<textarea class="form-control" rows="8" placeholder="입력 ..." name ="note1" id="note1"></textarea>
													</div>
												<!-- /.form-group -->
												</div>
											</div>
										</div>
									</div>
									<!-- /.form-group -->
								</div>
							</div>
							<!-- ./form -->
						</div>
						<!-- /.card-body -->
					</div>

					<div class="card card card-lightblue card-outline">
						<div class="card-header">
							<label class="card-title">지출내역</label>
							<div class="float-right">
								<div class="container">
									<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="doAction('edmsExpenseGridItem', 'copy')"><i class="fa-regular fa-copy"></i> 지출복사</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput2"	id="btnInput2"	onclick="doAction('edmsExpenseGridItem', 'input')"><i class="fa fa-plus"></i> 지출추가</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"	id="btnDelete1"	onclick="doAction('edmsExpenseGridItem', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
								</div>
							</div>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-sm-12"style="height: calc(60vh)" id="edmsExpenseGridItem">
									<!-- 그리드 영역 -->
									<!-- 시트가 될 DIV 객체 -->
									<div id="edmsExpenseGridItemDIV" style="width:100%; height:100%;"></div>
								</div>
							</div>
						</div>
					</div>		
					<!-- /.row -->
						<button class="btn btn-sm btn-primary" name="submitbtn" id="submitbtn" type="submit" hidden ></button>
					</form>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-12">
						<div class="card card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title">첨부파일 <small><em>파일을 업로드 하세요.</em></small></label>
							</div>
							<div class="card-body">
								<div class="dropzone" style=" min-height: 50px;height: 50px;text-align: center;padding: 0;" >
									<div class="dz-message needsclick" style="margin: 0;">
										<span class="text">
											<img src="http://www.freeiconspng.com/uploads/------------------------------iconpngm--22.png" alt="Camera"  style="width: 50px;"/>
											첨부파일을 마우스로 끌어다 놓으세요.
										</span>
										<span class="plus">+</span>
									</div>
								</div>
								<!-- 포스팅 - 이미지/동영상 dropzone 영역 -->
							<div>
								<div class="wrapper" id="dropzone-preview">
									<div class="test border rounded-3" id="dropzone-preview-list"  style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
									<!-- This is used as the file preview template -->
										<div class="" style=" height: 120px; width: inherit;">
											<img data-dz-thumbnail="data-dz-thumbnail" class="rounded-3 block" src="#" alt="Dropzone-Image" style=" width: inherit;height: inherit ;background-position: -359px -299px; border-radius: 12px 12px 0 0;"/>
										</div>
										<div class="" style="margin-top: 2px; height: 80px;">
											<small class="dataName" data-dz-name="data-dz-name" data-dz-down="data-dz-down" >&nbsp;</small>
											<div class="row" style="margin: 0;">
												<p data-dz-size="data-dz-size" style="margin: 0; padding: 0; text-align:left"></p>
												<div class="col-6"style="padding: 0;">
													<button data-dz-remove="data-dz-remove" class="btn btn-sm btn-danger " >삭제</button>
												</div>
											</div>
											<strong class="error text-danger" data-dz-errormessage="data-dz-errormessage"></strong>
										</div>
									</div>
								</div>
							</div>
							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.card -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script>
	var edmsExpenseGridItem;
	let dropzone;
	let dropzeneRemoveFile=new Array;
	var select
	var test=tui.Grid;
	Dropzone.autoDiscover = false;//dropzone 정의	
	$(document).ready(async function () {
		dropZoneEvent();
		edsEdms.slideEvent();
		await init();
		window.parent.postMessage('complete');
	});

	/* 초기설정 */
	async function init() {

		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#edmsGridItemForm"), "basma");
		select =$('.select2').select2();
		edsUtil.FormValidationEvent($('#edmsGridItemForm'));
		/* 조회옵션 셋팅 param setting*/

		/* searchform 셋팅 */


		/**********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/
		 edmsExpenseGridItem = new tui.Grid({
				el: document.getElementById('edmsExpenseGridItemDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum', 'checkbox'],
				header: {
					Height: 40,
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
				},
				contextMenu: () => [
				[
					{
						name: '엑셀내보내기',
						label: '엑셀다운로드',
						action: () => {
							edmsExpenseGridItem.export('xlsx', { useFormattedValue: true,fileName:'지출품목내역'+'_<c:out value="${LoginInfo.empNm}"/>'});
                    	},
					}
				]
				],
			});

			edmsExpenseGridItem.setColumns([
				{ header:'*일자',			name:'costDt',		minWidth:80,		align:'left',	defaultValue: '',	editor:{type:'datePicker',options:{format:'yyyy-MM-dd'}},validation: {required:true}},
				{ header:'*결제수단',		name:'payDivi',	minWidth:80,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM039")}},	formatter: 'listItemText',validation: {required:true}},
				{ header:'*프로젝트명',		name:'projNm',		minWidth:300,		align:'center',	defaultValue: '' ,validation: {required:true},},
				{ header:'*계정과목명',		name:'accountNm',	minWidth:140,		align:'left',	defaultValue: '' ,validation: {required:true}},
				{ header:'거래처명',		name:'custNm',		minWidth:140,		align:'left',	defaultValue: ''},
				{ header:'*부서명',			name:'depaNm',		minWidth:140,		align:'center',	defaultValue: '' ,validation: {required:true}},
				{ header:'차량명',			name:'carNm',		minWidth:140,		align:'center',	defaultValue: ''},
				{ header:'공급가액',		name:'supAmt',		minWidth:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'부가세액',		name:'vatAmt',		minWidth:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'합계금액',		name:'totAmt',		minWidth:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},validation: {required:true}},
				{ header:'사용목적',		name:'costPur',		minWidth:150,	align:'left',	 defaultValue: '',editor:{type:'text'}},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',editor:{type:'text'}},
				{ header:'입력자',		name:'inpNm',		minWidth:60,		align:'center',	defaultValue: '',hidden:true},
				{ header:'수정자',		name:'updNm',		minWidth:60,		align:'center',	defaultValue: '',hidden:true},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	editor:{type:'text'},hidden:true },
				{ header:'거래처코드',		name:'custCd',		width:100,		align:'center',	editor:{type:'text'},hidden:true },
				{ header:'계정과목코드',		name:'accountCd',		width:100,		align:'center',	editor:{type:'text'},hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center' ,editor:{type:'text'},	hidden:true },
				{ header:'부서코드',	name:'depaCd',		width:100,		align:'center' ,editor:{type:'text'},	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'카드/계좌',	name:'credCd',		width:150,		align:'left',	hidden:true },
				{ header:'계정과목코드',	name:'accountCd',	width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'찰량번호',		name:'carCd',		width:100,		align:'center',	hidden:true },
				{ header:'지출유형',		name:'expeDivi',	minWidth:80,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM030")}},	formatter: 'listItemText',	hidden:true },
			]);
			
			
			
			// tui.Grid.applyTheme('striped', {
			// });
		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		 document.edmsGridItemForm.addEventListener("keydown", evt => {
			if ((evt.code) === "Enter") {
				if(!(evt.target.name==="note1"))
				evt.preventDefault();
			}
		});
		edmsExpenseGridItem.on('editingFinish', async ev => {
			var columnName = ev.columnName;
			var rowKey = ev.rowKey;

			var vatDivi = edmsExpenseGridItem.getValue(rowKey, 'vatDivi');
			var taxDivi = edmsExpenseGridItem.getValue(rowKey, 'taxDivi');
			var supAmt = edmsExpenseGridItem.getValue(rowKey, 'supAmt');
			var vatAmt = edmsExpenseGridItem.getValue(rowKey, 'vatAmt');
			var totAmt = edmsExpenseGridItem.getValue(rowKey, 'totAmt');

			switch (columnName) {
				case 'supAmt' :
					if (vatDivi === "01") {// 과세, 면세 구분
						// 별도, 포함
						/* 매입가 */
						vatAmt = supAmt/10; // TAX
						totAmt = supAmt/1.1; // 공급가액

					} else {// 면세, 영세
						/* 매입가 */
						vatAmt = 0; // TAX
						totAmt = supAmt; // 공급가액
					}
					break;
				case 'totAmt' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 매입가 */
						supAmt = totAmt/11*10; // 공급가액
						vatAmt = totAmt/11; // TAX
					} else {// 면세, 영세
						/* 매입가 */
						supAmt = totAmt; // 공급가액
						vatAmt = 0; // TAX
					}
					break;
			}

			/* 매입가 */
			supAmt = Math.ceil(supAmt);  // 올림
			vatAmt = Math.floor(vatAmt); // 내림
			totAmt = supAmt + vatAmt; // 합계
			edmsExpenseGridItem.setValue(rowKey, "supAmt", supAmt);
			edmsExpenseGridItem.setValue(rowKey, "vatAmt", vatAmt);
			edmsExpenseGridItem.setValue(rowKey, "totAmt", supAmt + vatAmt);


			/* 매입가+견적가+할인가 합계 적용 */
			await applyTotAmt();
		});
		edmsExpenseGridItem.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='custNm') await popupHandler('cust','open');
					else if(colNm==='depaNm') await popupHandler('depa_cost','open');
					else if(colNm==='accountNm') await popupHandler('account','open');
					else if(colNm==='projNm') await popupHandler('proj','open');
					else if(colNm==='carNm') await popupHandler('car_book','open'); 
				}
				

			});
		edmsExpenseGridItem.on('keydown', ev => {
			let colNm = ev.columnName;
			let target = ev.keyboardEvent.key;
			if(target === 'Enter')
			{
				if(colNm==='custNm') popupHandler('cust','open');
				else if(colNm==='depaNm') popupHandler('depa_cost','open');
				else if(colNm==='accountNm') popupHandler('account','open');
				else if(colNm==='projNm') popupHandler('proj','open');
				else if(colNm==='carNm') popupHandler('car_book','open'); 
			}
		});
		if(parent) {//부모 iframe 과통신
			//수신 이벤트 발생 
			window.addEventListener("message", async function(message) {
				if(message.data.messageDivi=='save')
				{
					const parentData=message.data;
					await edsEdms.insertSubmit(edmsExpenseGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='tempSave')
				{
					const parentData=message.data;
					await edsEdms.insertSubmit(edmsExpenseGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='insert')
				{
					for (const [key, value] of Object.entries(message.data)) {
						if(document.getElementById(key))document.getElementById(key).value = value;
					}
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='select')
				{
					for (const [key, value] of Object.entries(message.data)) {
						if(document.getElementById(key))document.getElementById(key).value = value;
					}
					if(!message.data.submitCd) return console.log('없어');
					/* form data 조회 */
					await edsEdms.selectSubmit(document.edmsGridItemForm);
					/* 품목 조회 */
					await doAction("edmsExpenseGridItem", "search");
					await edsEdms.selectSubmitFileList(document.edmsGridItemForm);//파일조회
				}
				return ;
			})}
			// $('#edmsGridItemForm').submit(async function() { //submit이 발생하면
			// 	await insertEst();
			// });
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		var height = window.innerHeight - 40;
		document.getElementById('edmsExpenseGridItem').style.height = window.innerHeight*(0.6) + 'px';
	}

	function btnEvent(divi)
	{
		if(divi==='01'){
			window.parent.location.href ='/EDMS_SUBMIT_LIST_INS_VIEW';
			window.parent.parent.document.querySelector('a[href="/EDMS_SUBMIT_LIST_VIEW"]').click();
		}else if(divi==='02'){
			window.parent.location.href ='/EDMS_SUBMIT_LIST_INS_VIEW';
			window.parent.parent.document.querySelector('a[href="/EDMS_SUBMIT_TEMP_LIST_VIEW"]').click();
		}
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'edmsExpenseGridItem') {
				switch (sAction) {
					case "search":// 조회
						edmsExpenseGridItem.refreshLayout(); // 데이터 초기화
						edmsExpenseGridItem.finishEditing(); // 데이터 마감
						edmsExpenseGridItem.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#edmsGridItemForm")); //조회조건
						edmsExpenseGridItem.resetData(edsUtil.getAjax("/EDMS_EST_REPORT/selectEstItemList", param)); // 데이터 set
						if(edmsExpenseGridItem.getRowCount() > 0 ){
							edmsExpenseGridItem.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규
					
						var row = edmsExpenseGridItem.getFocusedCell();
						var appendedData = {};
						appendedData.status = "C";
						appendedData.corpCd = document.getElementById("corpCd").value;
						appendedData.depaCd = '<c:out value="${LoginInfo.depaCd}"/>';
						appendedData.depaNm = '<c:out value="${LoginInfo.depaNm}"/>';
						appendedData.vatDivi = '01';
						appendedData.taxDivi = '01';
						appendedData.qty =1;
						appendedData.supAmt = 0;
						appendedData.vatAmt = 0;
						appendedData.totAmt = 0;
						appendedData.saleDivi = '01';
						appendedData.saleRate = 0;
						edmsExpenseGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가
						break;
					case "delete"://삭제
					{
						const rows = edmsExpenseGridItem.getCheckedRows();
						let check=false;
						for(const data of rows)
						{
							data.seq='';
						}
						if(rows.length>0)
						{
							await edmsExpenseGridItem.removeCheckedRows(true);
							await applyTotAmt();
						}
						else
						{
							return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '선택된 품목이 없습니다.',
							});
						}

					}
						break;
					case "copy"://삭제
					{
						const rows = edmsExpenseGridItem.getCheckedRows();
						for(const data of rows)
						{
							data._attributes.checked=false;
							data.seq='';
						}
						let check=false;
						if(rows.length>0)
						{
							await edmsExpenseGridItem.appendRows(rows)
							await applyTotAmt();
						}
						else
						{
							return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '선택된 품목이 없습니다.',
							});
						}

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
			var row = edmsExpenseGridItem.getFocusedCell();
			var names = name.split('_');
			edmsExpenseGridItem.finishEditing();
			switch (names[0]) {
				case 'cust':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						edmsExpenseGridItem.focus(row.rowKey,'custNm',true);
						if(callback.custCd === undefined) return;
						edmsExpenseGridItem.setValue(row.rowKey,'custCd',callback.custCd);
						edmsExpenseGridItem.setValue(row.rowKey,'custNm',callback.custNm);
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.depaNm= edmsExpenseGridItem.getValue(row.rowKey, 'depaNm')??'';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						edmsExpenseGridItem.focus(row.rowKey,'depaNm',true);
						if(callback.depaCd === undefined) return;
						edmsExpenseGridItem.setValue(row.rowKey,'depaCd',callback.depaCd);
						edmsExpenseGridItem.setValue(row.rowKey,'depaNm',callback.depaNm);
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
						edmsExpenseGridItem.focus(row.rowKey,'manNm',true);
						if(callback.empCd === undefined) return;
						edmsExpenseGridItem.setValue(row.rowKey,'manCd',callback.empCd);
						edmsExpenseGridItem.setValue(row.rowKey,'manNm',callback.empNm);
					}
					break;
					case 'proj':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('PROJPOPUP',param);
					}else{
						edmsExpenseGridItem.focus(row.rowKey,'projNm',true);
						if(callback.rows === undefined) return;
						edmsExpenseGridItem.setValue(row.rowKey,'projCd',callback.rows[0].projCd);
						edmsExpenseGridItem.setValue(row.rowKey,'projNm',callback.rows[0].projNm);
						edmsExpenseGridItem.setValue(row.rowKey,'busiCd',callback.rows[0].busiCd);
						document.getElementById("keyCd").value=callback.rows[0].estCd;
						//edmsExpenseGridItem.focus(row.rowKey,'projNm',true);
						
						
					}
					break;
				case 'account':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.name= name;
					await edsIframe.openPopup('ACCOUNTPOPUP',param)
				}else{
					edmsExpenseGridItem.focus(row.rowKey,'accountNm',true);
					if(callback.accountCd === undefined) return;
					edmsExpenseGridItem.setValue(row.rowKey,'accountCd',callback.accountCd);
					edmsExpenseGridItem.setValue(row.rowKey,'accountNm',callback.accountNm);
				}
				break;
				case 'car': // 사용가능차량팝업
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.carNm= '';
					param.name= name;
					await edsIframe.openPopup('CARPOPUP',param);
				}else{
					edmsExpenseGridItem.focus(row.rowKey,'carNm',true);
					if(callback.carCd === undefined) return;
					edmsExpenseGridItem.setValue(row.rowKey,'carCd',callback.carCd);
					edmsExpenseGridItem.setValue(row.rowKey,'carNm',callback.carNm);
					
					
				}
				break;
			}
		}

		/* dropzone 이벤트 끝*/
	function dropZoneEvent()
	{
      	var dropzonePreviewNode = document.querySelector('#dropzone-preview-list');
      	dropzonePreviewNode.id = '';
      	var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
      	dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);

    	dropzone = new Dropzone(".dropzone", {
      		url: "/EDMS_SUBMIT_LIST/fileUpload", // 파일을 업로드할 서버 주소 url. 
      		method: "post", // 기본 post로 request 감. put으로도 할수있음
			autoProcessQueue:false,
      		previewTemplate: previewTemplate, // 만일 기본 테마를 사용하지않고 커스텀 업로드 테마를 사용하고 싶다면
      		previewsContainer: '#dropzone-preview',
			acceptedFiles: ".xlsx,.xls,application/pdf,image/*,.hwp",   //파일 종류

			maxFilesize: 100,
			init: function() {
		    	// 파일이 업로드되면 실행
				this.on('addedfile', function (file) {
					var ext = file.name.split('.').pop();
					if (ext == "pdf") {
						this.emit("thumbnail", file, "/img/fileImage/pdfimg.jpg");
					} else if (ext.indexOf("doc") != -1) {
						this.emit("thumbnail", file, "/img/fileImage/wordimg.jpg");
					} else if (ext.indexOf("xls") != -1) {
						this.emit("thumbnail", file, "/img/fileImage/exclimg.jpg");
					}else if (ext.indexOf("hwp") != -1) {
						this.emit("thumbnail", file, "/img/fileImage/hwpimg.jpg");
					}
				});
				
				// 업로드 에러 처리
				this.on('error', function (file, errorMessage) {
					this.removeFile(file);
					alert(errorMessage);
				});

				this.on('removedfile', function (file) {
					//저장이 되었을 때만 작동
				});
				this.on('downloadedFile', async function (file) {
					if(document.getElementById('submitCd').value){
						if (file)
						{
							let fileInfo={};
							fileInfo.saveRoot=file.saveRoot;
							fileInfo.name=file.name;
							$.ajax({
							type: 'POST',
							url: '/EDMS_SUBMIT_LIST/EdmsfileDownload',
							data: JSON.stringify(fileInfo),
							contentType: 'application/json',
							xhrFields: {
								responseType: 'blob' // Set the response type to 'blob'
							},
							success: function(data) {
								if (window.navigator && window.navigator.msSaveOrOpenBlob) {
									window.navigator.msSaveOrOpenBlob(data, fileInfo.name);
								} else {
									const url = window.URL.createObjectURL(data);
									const link = document.createElement('a');
									link.href = url;
									link.setAttribute('download', fileInfo.name);
									document.body.appendChild(link);
									link.click();
									window.URL.revokeObjectURL(url);
								}
							},
							error: function(xhr, status, error) {
								console.error(error);
							}
						});
						}
					};//저장이 되었을 때만 작동
				});		
      	  }, 
      	}
	  	);
	}
	/* dropzone 이벤트 끝*/

	async function TEMPFUNCTIONGDATA()
	{
		let params={};
		params.submitCd=document.getElementById("submitCd").value;
		let reqData = edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectSubmitTempList", params); // 데이터 set
		if(reqData.length>0)
		{
			let param={};
			param.data=reqData[0];
			param.form=document.getElementById('edmsGridItemForm');
			await edsUtil.eds_dataToForm(param);
		}
		/* form data 조회 */
		const result = await edsEdms.selectSubmit(document.edmsGridItemForm);
		if(!result) return 	Swal.fire({icon: 'error',title: '실패',text:"조회가능한 데이터가 없습니다."});; 
		/* 품목 조회 */
		await doAction("edmsExpenseGridItem", "search");
		//await doAction("edmsExpenseGridItem", "search");
		await edsEdms.selectSubmitFileList(document.edmsGridItemForm);//파일조회

			/* 품목el생성 이벤트 시작*/
		
	}

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

	async function applyTotAmt(){

		let docSupAmt = document.getElementById('supAmt');
		let docvatAmt = document.getElementById('vatAmt');
		let docTotAmt = document.getElementById('totAmt');
		var supAmtAll = 0;
		var vatAmtAll = 0;
		var totAmtAll = 0;
		var data = edmsExpenseGridItem.getFilteredData()
		var dataLen = data.length;
		for (let i = 0; i < dataLen; i++) {
			supAmtAll += Number(data[i].supAmt);
			vatAmtAll += Number(data[i].vatAmt);
			totAmtAll += Number(data[i].totAmt);
		}
		edmsExpenseGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
		edmsExpenseGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
		edmsExpenseGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));
		docSupAmt.value=edsUtil.addComma(supAmtAll);
		docvatAmt.value=edsUtil.addComma(vatAmtAll);
		docTotAmt.value=edsUtil.addComma(totAmtAll);

	}


	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
</body>
</html>