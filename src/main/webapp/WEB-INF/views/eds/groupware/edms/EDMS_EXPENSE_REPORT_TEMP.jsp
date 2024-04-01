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
		body {

		width: 100%;

		height: auto;

		margin: 0;

		padding: 0;

		}

		* {

		box-sizing: border-box;

		-moz-box-sizing: border-box;

		}
		.paper {

		width: 210mm;

		min-height: 297mm;

		padding: 10mm;

		margin: 10mm auto;

		border-radius: 5px;


		box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);

		border: 2px #fff solid;

		}
		.eeeeeee {

		padding: 0;

		border: 1px #888 solid;

		height: auto;
		

		}


		@page {

		size: A4;

		margin: 0;

		}

		@media print {
		
		html, body {
		
			width: 210mm;
		
			height: 297mm;
		
			background: #fff;
		
		}

		.paper {
		
			margin: 0;
		
			border: initial;
		
			border-radius: initial;
		
			width: initial;
		
			min-height: initial;
		
			box-shadow: initial;
		
			background: initial;
		
			page-break-after: always;
		
		}

}
	</style>
</head>

<body>
<div style="position:relative" id="printid">
	<nav class="navbar navbar-expand-sm navbar-whiht navbar-light bg-whiht fixed-top" id="navt">
		<a class="navbar-brand" href="#"><h3>지출품의등록</h3></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#tebs" aria-controls="#tebs" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="tebs">
			<ul class="navbar-nav mr-auto">
			<!-- <li class="nav-item active">
			  <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item">
			  <a class="nav-link" href="#">Features</a>
			</li>
			<li class="nav-item">
			  <a class="nav-link" href="#">Pricing</a>
			</li>
			<li class="nav-item">
			  <a class="nav-link" href="#">About</a>
			</li> -->
		 	 </ul>
		  <form class="form-inline">
			<div class="input-group">
				<div class="float-right ml-auto">
					<div class="container">
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSave" id="btnSave" onclick="btnEvent('save')"><i class="fa fa-solid fa-share"></i> 기안상신</button>
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnTempSave" id="btnTempSave" onclick="btnEvent('tempSave')"><i class="fa fa-solid fa-share"></i> 임시저장</button>
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnCancel" id="btnCancel" onclick="btnEvent('cancel')"><i class="fa fa-solid fa-share"></i> 삭제</button>
						<button type="button" class="btn btn-sm btn-primary mr-1" name="btnClose" id="btnClose" onclick="btnEvent('close')"><i class="fa fa-close"></i> 닫기</button>
					</div>
				</div>
			</div>	
		  </form>
		</div>
	  </nav>

	<section class="content" id="printtest" style="margin-top: calc(4.25rem); ">
		<div class="container-fluid" >
			<div class="row" >
				<div class="col-md-12">
					<div class="card">
						<!-- form start -->
						<form class="form-horizontal" id="submitInfo">

							  <!-- /.card-body -->
						</form>
					</div>
				</div>
				<div class="col-md-12">
					<form name="edmsGridItemForm" id="edmsGridItemForm" method="post" onsubmit="return false;">
						<input type="hidden" name="corpCd" id="corpCd" value="">
						<input type="hidden" name="busiCd" id="busiCd" value="">
						<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="custCd" id="custCd" value="">
						<input type="hidden" id="currApproverCd" >
						<input type="hidden" id="docDivi" >
						<input type="hidden" name="keyCd" id="keyCd" value="">
						<input type="hidden" id="inpId" >
						<input type="hidden" id="submitDivi" >
						
						<div class="card">
							<!-- form start -->
							<div class="card-body">
								<div class="form-group row">
									<label for="busiNm" class="col-sm-2 col-form-label">계열사</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="busiNm" readonly>
									</div>
								</div>
								<div class="form-group row">
								  <label for="submitNm" class="col-sm-2 col-form-label">문서명</label>
								  <div class="col-sm-10">
									<input type="text" class="form-control" id="submitNm" >
								  </div>
								</div>
								<div class="form-group row">
									<label for="submitDt" class="col-sm-2 col-form-label">작성일자</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="submitDt" readonly>
									</div>
								</div>
								<div class="form-group row">
									<label for="inpNm" class="col-sm-2 col-form-label" >기안자</label>
									<div class="col-sm-10">
									  <input type="text" class="form-control" id="inpNm"readonly >
									</div>
								</div>
								<div class="form-group row">
									<label for="appUsers" class="col-sm-2 col-form-label">결재자   <i class="fa-solid fa-user-plus fa-beat" onclick="popupHandler('appUsers','open'); return false;"></i></label>
		
									<div class="col-sm-10">
									  <div class="select2-info">
										<select class="select2" multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-purple" style="width: 100%;" id="appUsers"disabled>
										</select>
									  </div>
									</div>
								</div>
								<div class="form-group row">
									<label for="ccUsers" class="col-sm-2 col-form-label">참조자   <i class="fa-solid fa-user-plus fa-beat" onclick="popupHandler('ccUsers','open'); return false;"></i></label>
									<div class="col-sm-10">
										<div class="select2-info" >
										  <select class="select2" multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-purple" style="width: 100%;" id="ccUsers" disabled>
										  </select>
										</div>
									  </div>
								</div>
							</div>
						</div>

					<div class="card card-lightblue card-outline">
						<div class="card-header">
						<label class="card-title" style="">지출품의 정보</label>
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
													<input type="text" class="form-control" placeholder="입력 ..." name="totAmt" id="totAmt" readonly>
												</div>
												<!-- /.form-group -->
												</div>
												<div class="col-sm-4">
													<!-- text input -->
													<div class="form-group">
													<label>공급가액</label>
													<input type="text" class="form-control" placeholder="입력 ..." name="supAmt" id="supAmt" readonly>
													</div>
													<!-- /.form-group -->
												</div>
												<div class="col-sm-4">
													<!-- text input -->
													<div class="form-group">
													<label>부가세액</label>
													<input type="text" class="form-control" placeholder="입력 ..." name="vatAmt" id="vatAmt" readonly>
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
									<div id="edmsExpenseGridItemDIV"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.row -->

					<button class="btn btn-sm btn-primary" name="submitbtn" id="submitbtn" type="submit" hidden ></button>
					</form>
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
									<div class="border rounded-3" id="dropzone-preview-list"  style="width: 120px; min-width: 120px;margin: 5px;text-align: center; border-radius: 12px;">
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
					<div class="card card-widget">
						<div class="card-header">
							<label class="card-title">결재의견 <small><em>결재의견을 입력하세요.</em></small></label>
						</div>
						<!-- /.card-header -->
						<!-- /.card-body -->
						<div class="card-footer card-comments" id="messageBox">

						</div>
						<!-- /.card-footer -->
						<div class="card-footer">
							<img class="img-fluid img-circle img-sm" src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:${LoginInfo.empCd}" alt="Alt Text" id="messageFace">
							<!-- .img-push is used to add margin to elements next to floating images -->
							<div class="img-push">
							   <textarea class="form-control form-control-sm" placeholder="엔터... 입력 , 쉬프트 + 엔터 줄바꿈..." onkeyup="if(window.event.keyCode==13){  if (!window.event.shiftKey){window.event.preventDefault();edsEdms.initMessage(this)}}" ></textarea>
							</div>
						</div>
						<!-- /.card-footer -->
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
		TEMPFUNCTIONGDATA();
	});

	/* 초기설정 */
	async function init() {

		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#edmsGridItemForm"), "basma");
		select =$('.select2').select2();

		edsUtil.FormValidationEvent($('#edmsGridItemForm'));
		/* 조회옵션 셋팅 param setting*/

		/* searchform 셋팅 */
		
		/* 조회옵션 셋팅 */
		await edsIframe.setParams();

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
				{ header:'*프로젝트명',		name:'projNm',		minWidth:300,		align:'center',	defaultValue: '' ,validation: {required:true}},
				{ header:'*계정과목명',		name:'accountNm',	minWidth:140,		align:'left',	defaultValue: '' ,validation: {required:true}},
				{ header:'거래처명',		name:'custNm',		minWidth:140,		align:'left',	defaultValue: '' },
				{ header:'*부서명',			name:'depaNm',		minWidth:140,		align:'center',	defaultValue: '' ,validation: {required:true}},
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
					vatAmt = supAmt/10; // TAX
					totAmt = supAmt/1.1; // 공급가액
					break;

				case 'totAmt' :
					supAmt = totAmt/11*10; // 공급가액
					vatAmt = totAmt/11; // TAX
					break;

			}

			/**
			 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
			 * */

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
		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		var height = window.innerHeight - 40;
		document.getElementById('edmsExpenseGridItem').style.height = window.innerHeight*(0.6) + 'px';
		
	
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
						edmsExpenseGridItem.resetData(edsUtil.getAjax("/EDMS_EXPENSE_REPORT/selectExpenseItemList", param)); // 데이터 set
						if(edmsExpenseGridItem.getRowCount() > 0 ){
							edmsExpenseGridItem.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규
						var row = edmsExpenseGridItem.getFocusedCell();
						var appendedData = {};
						appendedData.status = "C";
						appendedData.corpCd = document.getElementById("corpCd").value;
						appendedData.busiCd = document.getElementById("busiCd").value;
						appendedData.depaCd = '<c:out value="${LoginInfo.depaCd}"/>';
						appendedData.depaNm = '<c:out value="${LoginInfo.depaNm}"/>';
						appendedData.vatDivi = '01';
						appendedData.taxDivi = '01';
						appendedData.cost = 0;
						appendedData.qty =1;
						appendedData.supAmt = 0;
						appendedData.vatAmt = 0;
						appendedData.totAmt = 0;
						appendedData.saleDivi = '01';
						appendedData.saleRate = 0;
						edmsExpenseGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가
						const rawData = edmsExpenseGridItem.getFormattedValue(0,'payDivi'); 
						console.log(rawData);
						break;
					case "delete"://삭제
						{
							const rows = edmsExpenseGridItem.getCheckedRows();
							let check=false;
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
							await edmsExpenseGridItem.appendRows(rows);
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
	/** 버튼이벤트
	 * */
async function btnEvent(name){
		switch (name) {
			case 'cancel':
			{
				let param=ut.serializeObject(document.querySelector("#edmsGridItemForm"));
				if(!(await edsEdms.deleteSubmitList([param]))) return;;
				param.name = document.getElementById('name').value;

				await edsIframe.closePopup(param);
			}
			break;
			case 'save':
			{
				let data={};
				data.submitApprover=$("#appUsers").val();
				data.submitCcUser=$("#ccUsers").val();
				data.busiCd=document.getElementById("busiCd").value;
				data.docDivi=document.getElementById("docDivi").value;
				data.submitDt=document.getElementById("submitDt").value;
				data.submitCd=document.getElementById("submitCd").value;
				data.submitDivi='01'//저장
				const parentData=data;
				await edsEdms.insertSubmit(edmsExpenseGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
			}
			break;		
			case 'tempSave':
			{
				let data={};
				data.submitApprover=$("#appUsers").val();
				data.submitCcUser=$("#ccUsers").val();
				data.busiCd=document.getElementById("busiCd").value;
				data.docDivi=document.getElementById("docDivi").value;
				data.submitDt=document.getElementById("submitDt").value;
				data.submitCd=document.getElementById("submitCd").value;
				data.submitDivi='02'//임시저장
				const parentData=data;
				await edsEdms.insertSubmit(edmsExpenseGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
				
			}
			break;		
			case 'close':	
			{
				let param = {};
				param.name = document.getElementById('name').value;

				await edsIframe.closePopup(param);
			}
			break;
			case 'move':
			{
				window.parent.location.href ='/EDMS_SUBMIT_TEMP_LIST_VIEW';
				window.parent.parent.document.querySelector('a[href="/EDMS_SUBMIT_LIST_VIEW"]').click();
			}
				break;
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
					case 'appUsers':{
						if(divi==='open'){
							var param={}
								param.corpCd= document.getElementById('corpCd').value;
								param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
								param.name= name;
							await edsIframe.openPopup('SUBMITUSERPOPUP',param)
						}else{
							await addUser(callback,'appUsers');
						}
					}
					break;		
				case 'ccUsers':{
					if(divi==='open'){
						var param={}
							param.corpCd= document.getElementById('corpCd').value;
							param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
							param.name= name;
						await edsIframe.openPopup('SUBMITUSERPOPUP',param)
					}else{
						await addUser(callback,'ccUsers');
					}
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
					if(document.getElementById('submitCd').value){dropzeneRemoveFile.push(file)};//저장이 되었을 때만 작동
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
		await edsEdms.selectSubmitFileList(document.edmsGridItemForm);//파일조회
		await edsEdms.selectMessageData();//메시지조회
		document.getElementById('submitDt').value= edsUtil.getToday("%Y-%m-%d");
		document.getElementById('submitDivi').disable=true;
		if(document.getElementById('submitDivi').value=='04') document.getElementById('btnCancel').hidden= true;
		/*유저리스트인서트*/
		if(reqData[0].appUsers)
		{
			let appUsersCd=reqData[0].appUsers.toString().split(',')
			let appUsersName=reqData[0].appUsersName.toString().split(',')
			let appList=[];
			for(var i=0; i<appUsersCd.length;i++)
			{
				var temp={};
				temp.empCd=appUsersCd[i];
				temp.empNm=appUsersName[i];
				appList.push(temp);
			}
			await addUser(appList,'appUsers');
		}
		if(reqData[0].ccUsers)
		{
			let ccUsersCd=reqData[0].ccUsers.toString().split(',')
			let ccUsersName=reqData[0].ccUsersName.toString().split(',')
			let ccList=[];
			for(var i=0; i<ccUsersCd.length;i++)
			{
				var temp={};
				temp.empCd=ccUsersCd[i];
				temp.empNm=ccUsersName[i];
				ccList.push(temp);
			}
			await addUser(ccList,'ccUsers');
		}
	}

	function printsss()
		{
			var g_oBeforeBody = document.getElementById('printid');
			var g_oBeforeavt = document.getElementById('tebs');
			var g_oBeforeavtnavt = document.getElementById('navt');
			var g_test = document.getElementById('printtest');

			window.onbeforeprint = async function (ev) {
					g_oBeforeavt.remove();
					g_oBeforeavtnavt.classList.remove('fixed-top')
					g_test.classList.add('eeeeeee')
					g_oBeforeBody.classList.add('paper')
					document.body = g_oBeforeBody;
					edmsExpenseGridItem.refreshLayout();
				};

				// window.onafterprint 로 다시 화면원복을 해주는게 맞으나,
				// 문제가 있기에 reload로 처리
			/*
				var initBody = document.body.innerHTML;
				window.onafterprint = function(){
					document.body.innerHTML = initBody;
				}
			*/

			window.print();
		}
		async function addUser(param,target)
		{
			let userData=param;
			let select=[];
			$("#"+target+ " option").remove();
			$("#"+target ).val(null).trigger('change');
			for(const data of userData)
			{
				select.push(data.empCd)
				var newOption = new Option(data.empNm, data.empCd, false, false);
				$("#"+target).append(newOption).trigger('change');
			}
			$("#"+target).val(select).trigger('change');
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