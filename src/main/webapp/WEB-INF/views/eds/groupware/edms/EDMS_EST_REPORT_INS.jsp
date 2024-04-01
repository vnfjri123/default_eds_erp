<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<%@ page import="java.util.*"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper"%>
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
	
</head>

<body>
<div style="position:relative">
	<section class="content-header">
		<div class="container-fluid">
	        <div class="row mb-2">
	          <div class="col-sm-12">
	            <h3>프로젝트 견적품의</h3>
	          </div>
	          <!-- <div class="col-sm-6">
	            <ol class="breadcrumb float-sm-right">
	              <li class="breadcrumb-item"><a href="#">Home</a></li>
	              <li class="breadcrumb-item active">Advanced Form</li>
	            </ol>
	          </div> -->
	        </div>
	      </div>
	</section>
	<section class="content" >
		<div class="container-fluid">
			<div class="row" >
				<div class="col-md-12">
					<form name="edmsGridItemForm" id="edmsGridItemForm" method="post" onsubmit="return false;">
						<input type="hidden" name="corpCd" id="corpCd" value="">
						<input type="hidden" name="busiCd" id="busiCd" value="">
						<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">
						<input type="hidden" name="custCd" id="custCd" value="">
						<input type="hidden" id="docDivi">
						<input type="hidden" id="estDt">
						<!-- Form 영역 -->
						<div class="card card-lightblue card-outline">
							<div class="card-header">
							<label class="card-title" style="">프로젝트 정보</label>
							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<div class="row">
									<div class="col-sm-12">
										<!-- text input -->
										<div class="form-group" style="text-align: center;">
										<label>아래와 같이 프로젝트 견적을 품의하오니, 재가하여 주시기 바랍니다. </label>
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
											<input type="text" class="form-control" placeholder="입력 ..." name="submitNm" id="submitNm" required value="프로젝트 견적품의 - ">
										</div>
										<!-- /.form-group -->
									</div>
								</div>
								<div class="row">
								<div class="col-sm-6">
									<!-- text input -->
									<div class="form-group">
										<i class="fa-solid fa-circle-check"></i><label for="projNm">프로젝트명</label>
										<input type="text" class="form-control" placeholder="입력 ..." name="projNm" id="projNm" required style="background-color: yellow">
									</div>
									<!-- /.form-group -->
								</div>
								<div class="col-sm-6">
									<!-- text input -->
									<div class="form-group">
										<i class="fa-solid fa-circle-check"></i><label for="projPur">프로젝트목적</label>
									<input type="text" class="form-control" placeholder="입력 ..." name="projPur" id="projPur" required>
									</div>
									<!-- /.form-group -->
								</div>
								</div>
								<div class="row">
									<div class="col-sm-2">
									<div class="form-group">
										<label for="stDt">예상 시작일자</label>
										<input type="date" name="stDt" id="stDt" class="form-control" style="width: 100%; border-radius: 3px;" title="입사일자" data-inputmask="'mask': '9999-99-99'" data-mask required>
									</div>
									<!-- /.form-group -->
									</div>
									<div class="col-sm-2">
									<div class="form-group">
										<label for="edDt">예상 마감일자</label>
										<input type="date" name="edDt" id="edDt" class="form-control" style="width: 100%; border-radius: 3px;" title="입사일자" data-inputmask="'mask': '9999-99-99'" data-mask required>
									</div>
									<!-- /.form-group -->
									</div>
									<div class="col-sm-2">
										<div class="form-group">
											<i class="fa-solid fa-circle-check"></i><label>프로젝트분류	</label>
											<select class="form-control select2" style="width: 100%;"name="projDivi" id="projDivi" required >

											</select>
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>업무담당</label>
											<select class="form-control select2" style="width: 100%;"name="empCd" id="empCd" >

											</select>
											<!-- <div class="select2-blue">
											<select class="select2"  multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-blue" style="width: 100%;" name="empCd" id="empCd">
											</select>
											</div> -->
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>담당부서</label>
											<select class="form-control select2" style="width: 100%;" name="depaCd" id="depaCd" >

											</select>
											<!-- <div class="select2-blue">
											<select class="select2"multiple="multiple" data-placeholder="Select a State" data-dropdown-css-class="select2-blue" style="width: 100%;" name="depaCd" id="depaCd">
											</select>
											</div> -->
										</div>
										<!-- /.form-group -->
									</div>

								</div>
								<div class="row">
									<div class="col-sm-3">
										<div class="form-group">
											<label>거래처</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="custNm" id="custNm" onclick="popupHandler('cust','open')" readonly>
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>품목</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="item" id="item" >
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>분류</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="clas" id="clas" >
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-3">
										<div class="form-group">
											<label>결제조건</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="payTm" id="payTm" >
										</div>
										<!-- /.form-group -->
									</div>
								</div>
								<!-- ./form -->
							</div>
							<!-- /.card-body -->
						</div>
						<!-- /.cnt-in -->
						<div class="card card-warning card-outline d-none">
							<div class="card-header">
								<label class="card-title">매입단가</label>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-sm-4">
									<!-- text input -->
									<div class="form-group">
										<label>합계금액</label>
										<input type="text" class="form-control" placeholder="입력 ..." name="totAmt" id="totAmt" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');">
									</div>
									<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
										<label>공급가액</label>
										<input type="text" class="form-control" placeholder="입력 ..." name="supAmt" id="supAmt" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
										<label>부가세액</label>
										<input type="text" class="form-control" placeholder="입력 ..." name="vatAmt" id="vatAmt" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');">
										</div>
										<!-- /.form-group -->
									</div>
								</div>
							</div>
						</div>
						<!-- /.cnt-in -->
						<div class="card card-warning card-outline">
							<div class="card-header">
								<label class="card-title">견적금액</label>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-sm-4">
										<!-- text input -->
										<div class="form-group">
										<label>합계금액(견적)</label>
										<input type="text" class="form-control" placeholder="입력 ..." name="totAmt2" id="totAmt2"onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');" readonly style="background-color: yellow">
										</div>
										<!-- /.form-group -->
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label>영업이익(예상)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="profit" id="profit" oninput="edsUtil.formatNumberHtmlInputForInteger(this)" style="background-color: yellow" required>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label>영업이익율(예상)</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="margin" id="margin" readonly value="0" style="background-color: yellow">
										</div>
									</div>
									<div class="col-sm-4 d-none">
										<!-- text input -->
										<div class="form-group">
											<label>공급가액</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="supAmt2" id="supAmt2"onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');">
										</div>
										<!-- /.form-group -->
										</div>
									<div class="col-sm-4 d-none">
										<!-- text input -->
										<div class="form-group">
											<label>부가세액</label>
											<input type="text" class="form-control" placeholder="입력 ..." name="vatAmt2" id="vatAmt2" onKeyup="this.value=this.value.replace(/[^,0-9]/g,'');">
										</div>
										<!-- /.form-group -->
									</div>
								</div>
	<%--							<div class="row">--%>
	<%--								<div class="col-sm-6">--%>
	<%--									<div class="form-group">--%>
	<%--										<label>영업이익</label>--%>
	<%--										<input type="text" class="form-control" placeholder="입력 ..." name="profit" id="profit">--%>
	<%--									</div>--%>
	<%--								</div>--%>
	<%--								<div class="col-sm-6">--%>
	<%--									<div class="form-group">--%>
	<%--										<label>영업이익율</label>--%>
	<%--										<input type="text" class="form-control" placeholder="입력 ..." name="margin" id="margin">--%>
	<%--									</div>--%>
	<%--								</div>--%>
	<%--							</div>--%>
							</div>
						</div>
						<div class="card card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title">계약품목</label>
								<div class="float-right">
									<div class="container">
										<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnCopy1"	onclick="doAction('edmsEstGridItem', 'copy')"><i class="fa fa-plus"></i> 품목 복사</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnInput1"	id="btnInput1"	onclick="doAction('edmsEstGridItem', 'input')"><i class="fa fa-plus"></i> 품목 추가</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"	id="btnDelete1"	onclick="doAction('edmsEstGridItem', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-sm-12"style="height: calc(60vh)" id="edmsEstGridItem">
										<!-- 그리드 영역 -->
										<!-- 시트가 될 DIV 객체 -->
										<div id="edmsEstGridItemDIV" style="width:100%; height:100%;"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="card card card-lightblue card-outline">
							<div class="card-header">
								<label class="card-title">적요</label>
							</div>
							<div class="card-body">
								<div class="row">
									<textarea class="form-control" rows="8" placeholder="입력 ..." name ="note1" id="note1"></textarea>
								</div>
							</div>
						</div>
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
	var edmsEstGridItem;
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

		document.getElementById('profit').addEventListener('keyup', async ev => {
			var key = ev.keyCode;
			if((key>47 && key<57)||key===8||key===13){
				await applyTotAmt();
			}
		});
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
		 edmsEstGridItem = new tui.Grid({
				el: document.getElementById('edmsEstGridItemDIV'),
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
					complexColumns: [
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
						supAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			edmsEstGridItem.setColumns([
				{ header:'*품목명',		name:'itemNm',		width:150,	align:'left',	defaultValue: '',validation: {required:true}},
				{ header:'규격',			name:'standard',	width:150,	align:'center',	defaultValue: '',	editor:{type:'text'}, validation:{required: true}	},
				{ header:'단위',			name:'unit',		width:50,	align:'center',	defaultValue: '',	editor:{type:'text'}, validation:{required: true}	},
				{ header:'수량',			name:'qty',			width:60,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'견적단가',		name:'cost2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}/*, hidden:true*/},
				{ header:'견적공급가액',	name:'supAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}/*, hidden:true*/},
				{ header:'견적부가세액',	name:'vatAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}/*, hidden:true*/},
				{ header:'견적합계금액',	name:'totAmt2',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'비고',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor:{type:'text'}},


				// hidden(숨김)
				{ header:'과세',			name:'vatDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM006")}},	formatter: 'listItemText', hidden:true},
				{ header:'TAX',			name:'taxDivi',		width:40,	align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM007")}},	formatter: 'listItemText', hidden:true},
				{ header:'단가',			name:'cost',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}, hidden:true},
				{ header:'공급가액',		name:'supAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}, hidden:true},
				{ header:'부가세액',		name:'vatAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}, hidden:true},
				{ header:'합계금액',		name:'totAmt',		width:100,	align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}, hidden:true},
			]);
			// tui.Grid.applyTheme('striped', {
			// });
		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		// document.getElementById('btnTempSave').onclick = async function () {
		// 	await insertEst();
		// };
		// document.getElementById('btnSave').onclick = async function () {
		// 	await insertEst();
		// };
		edmsEstGridItem.disableColumn('standard');
		document.edmsGridItemForm.addEventListener("keydown", evt => {
			if ((evt.code) === "Enter") {
				if(!(evt.target.name==="note1"))
				evt.preventDefault();
			}
		});
		edmsEstGridItem.on('editingFinish', async ev => {
			var columnName = ev.columnName;
			var rowKey = ev.rowKey;

			var vatDivi = edmsEstGridItem.getValue(rowKey, 'vatDivi');
			var taxDivi = edmsEstGridItem.getValue(rowKey, 'taxDivi');

			var qty = edmsEstGridItem.getValue(rowKey, 'qty');
			var cost = edmsEstGridItem.getValue(rowKey, 'cost');
			var supAmt = edmsEstGridItem.getValue(rowKey, 'supAmt');
			var vatAmt = edmsEstGridItem.getValue(rowKey, 'vatAmt');
			var totAmt = edmsEstGridItem.getValue(rowKey, 'totAmt');
			var supAmtAll = 0;
			var vatAmtAll = 0;
			var totAmtAll = 0;

			var cost2 = edmsEstGridItem.getValue(rowKey, 'cost2');
			var supAmt2 = edmsEstGridItem.getValue(rowKey, 'supAmt2');
			var vatAmt2 = edmsEstGridItem.getValue(rowKey, 'vatAmt2');
			var totAmt2 = edmsEstGridItem.getValue(rowKey, 'totAmt2');
			var supAmtAll2 = 0;
			var vatAmtAll2 = 0;
			var totAmtAll2 = 0;

			switch (columnName) {
				case 'qty' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 매입가 */
						supAmt = totAmt / 1.1; // 공급가액
						vatAmt = supAmt * 0.1; // TAX
						cost = supAmt /qty; // 단가
						/* 견적가 */
						supAmt2 = totAmt2 / 1.1; // 공급가액
						vatAmt2 = supAmt2 * 0.1; // TAX
						cost2 = supAmt2 /qty; // 단가
					} else {// 면세, 영세
						/* 매입가 */
						supAmt = totAmt; // 공급가액
						vatAmt = 0; // TAX
						cost = supAmt /qty; // 단가
						/* 견적가 */
						supAmt2 = totAmt2; // 공급가액
						vatAmt2 = 0; // TAX
						cost2 = supAmt2 /qty; // 단가
					}
					break;
				case 'cost' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분
							/* 매입단가 */
							supAmt = qty * cost; // 공급가액
							vatAmt = supAmt * 0.1; // TAX
						} else {//포함
							/* 매입단가 */
							supAmt = qty * cost / 1.1; // 공급가액
							vatAmt = qty * cost - supAmt; // TAX
						}
					} else {// 면세, 영세
						/* 매입단가 */
						supAmt = qty * cost; // 공급가액
						vatAmt = 0; // TAX
					}
					break;
				case 'cost2' :
					if (vatDivi === "01") {// 과세, 면세 구분
						if (taxDivi === "01") {// 별도, 포함 구분
							/* 견적가 */
							supAmt2 = qty * cost2; // 공급가액
							vatAmt2 = supAmt2 * 0.1; // TAX
						} else {//포함
							/* 견적가 */
							supAmt2 = qty * cost2 / 1.1; // 공급가액
							vatAmt2 = qty * cost2 - supAmt2; // TAX
						}
					} else {// 면세, 영세
						/* 견적가 */
						supAmt2 = qty * cost2; // 공급가액
						vatAmt2 = 0; // TAX
					}
					break;
				case 'supAmt' :
					if (vatDivi === "01") {// 과세, 면세 구분
						// 별도, 포함
						/* 매입단가 */
						cost = supAmt/qty; // 단가
						vatAmt = supAmt/10; // TAX
						totAmt = supAmt/1.1; // 공급가액

					} else {// 면세, 영세
						/* 매입단가 */
						cost = supAmt/qty; // 단가
						vatAmt = 0; // TAX
						totAmt = supAmt; // 공급가액
					}
					break;
				case 'supAmt2' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 견적가 */
						cost2 = supAmt2/qty; // 단가
						vatAmt2 = supAmt2/10; // TAX
						totAmt2 = supAmt2/1.1; // 공급가액
					} else {// 면세, 영세
						/* 견적가 */
						cost2 = supAmt2/qty; // 단가
						vatAmt2 = 0; // TAX
						totAmt2 = supAmt2; // 공급가액
					}
					break;
				case 'totAmt' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 매입단가 */
						supAmt = totAmt/11*10; // 공급가액
						vatAmt = totAmt/11; // TAX
						cost = supAmt/qty; // 단가
					} else {// 면세, 영세
						/* 매입단가 */
						supAmt = totAmt; // 공급가액
						vatAmt = 0; // TAX
						cost = supAmt/qty; // 단가
					}
					break;
				case 'totAmt2' :
					if (vatDivi === "01") {// 과세, 면세 구분
						/* 견적가 */
						supAmt2 = totAmt2/11*10; // 공급가액
						vatAmt2 = totAmt2/11; // TAX
						cost2 = supAmt2/qty; // 단가
					} else {// 면세, 영세
						/* 견적가 */
						supAmt2 = totAmt2; // 공급가액
						vatAmt2 = 0; // TAX
						cost2 = supAmt2/qty; // 단가
					}
					break;
			}

			/**
			 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
			 * */

			/* 매입단가 */
			cost = Math.ceil(cost); // 올림
			supAmt = Math.round(supAmt);  // 반올림
			vatAmt = Math.round(vatAmt); // 반올림
			totAmt = supAmt + vatAmt; // 합계
			edmsEstGridItem.setValue(rowKey, "cost", cost);
			edmsEstGridItem.setValue(rowKey, "supAmt", supAmt);
			edmsEstGridItem.setValue(rowKey, "vatAmt", vatAmt);
			edmsEstGridItem.setValue(rowKey, "totAmt", supAmt + vatAmt);

			/* 견적가 */
			cost2 = Math.ceil(cost2); // 올림
			supAmt2 = Math.round(supAmt2);  // 반올림
			vatAmt2 = Math.round(vatAmt2); // 반올림
			totAmt2 = supAmt2 + vatAmt2; // 합계
			edmsEstGridItem.setValue(rowKey, "cost2", cost2);
			edmsEstGridItem.setValue(rowKey, "supAmt2", supAmt2);
			edmsEstGridItem.setValue(rowKey, "vatAmt2", vatAmt2);
			edmsEstGridItem.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

			/* 매입단가+견적가 합계 적용 */
			await applyTotAmt();
		});
		edmsEstGridItem.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm ==='itemNm')
					{
						// await popupHandler('item','open')
					}else if(colNm==='standard') {
						await edsUtil.sheetData2Maldal(edmsEstGridItem);
					};
				}
			});
		edmsEstGridItem.on('keydown', async ev => {
			let colNm = ev.columnName;
			let target = ev.keyboardEvent.key;
			if(target === 'Enter')
			{
				if(colNm ==='itemNm') 
				{
					await popupHandler('item','open')
				};
			}
		});
		if(parent) {//부모 iframe 과통신
			//수신 이벤트 발생 
			window.addEventListener("message", async function(message) {
				if(message.data.messageDivi=='save')
				{
					const parentData=message.data;
					document.getElementById("estDt").value=parentData.submitDt;
					await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='tempSave')
				{
					const parentData=message.data;
					document.getElementById("estDt").value=parentData.submitDt;
					await edsEdms.insertSubmit(edmsEstGridItem,document.edmsGridItemForm,parentData,dropzeneRemoveFile);
					//dropzeneRemoveFile=null;
				}
				else if(message.data.messageDivi=='insert')
				{
					for (const [key, value] of Object.entries(message.data)) {
						if(document.getElementById(key))document.getElementById(key).value = value;
					}
					select.trigger('change');
					//dropzeneRemoveFile=null;
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
		document.getElementById('edmsEstGridItem').style.height = window.innerHeight*(0.6) + 'px';
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'edmsEstGridItem') {
				switch (sAction) {
					case "search":// 조회
						edmsEstGridItem.refreshLayout(); // 데이터 초기화
						edmsEstGridItem.finishEditing(); // 데이터 마감
						edmsEstGridItem.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#edmsGridItemForm")); //조회조건
						edmsEstGridItem.resetData(edsUtil.getAjax("/EDMS_EST_REPORT/selectEstItemList", param)); // 데이터 set
						if(edmsEstGridItem.getRowCount() > 0 ){
							edmsEstGridItem.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규
						/*var row = edmsEstGridItem.getFocusedCell();
						var appendedData = {};
						appendedData.status = "C";
						appendedData.corpCd = document.getElementById("corpCd").value;
						appendedData.busiCd = document.getElementById("busiCd").value;
						appendedData.vatDivi = '01';
						appendedData.taxDivi = '01';
						appendedData.cost = 0;
						appendedData.qty =1;
						appendedData.supAmt = 0;
						appendedData.vatAmt = 0;
						appendedData.totAmt = 0;
						appendedData.cost2 = 0;
						appendedData.supAmt2 = 0;
						appendedData.vatAmt2 = 0;
						appendedData.totAmt2 = 0;
						appendedData.cost3 = 0;
						appendedData.supAmt3 = 0;
						appendedData.vatAmt3 = 0;
						appendedData.totAmt3 = 0;
						appendedData.saleDivi = '01';
						appendedData.saleRate = 0;
						edmsEstGridItem.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가*/
						await popupHandler('item','open');
						break;
					case "copy":// 복사
						{
							const rows = edmsEstGridItem.getCheckedRows();
							for(const data of rows)
							{
								data._attributes.checked=false;
								data.seq='';
							}
							let check=false;
							if(rows.length>0)
							{
								await edmsEstGridItem.appendRows(rows);
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
					case "save"://저장
						await edsUtil.doCUD("/EDMS_EST_REPORT/cudEstItemList", "edmsEstGridItem", edmsEstGridItem);
						break;
					case "delete"://삭제
						const rows = edmsEstGridItem.getCheckedRows();
						let check=false;
						if(rows.length>0)
						{
							await edmsEstGridItem.removeCheckedRows(true);
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
						break;
				}
			}
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
	 * 화면 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 START
	 ***********************************************************************/
	 async function popupHandler(name,divi,callback){
			var row = edmsEstGridItem.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'adress':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('EMAILADRESSPOPUP',param);
					}else{
						/**
						 * name = adress_documentId => documentId setting
						 * */
						var returnName = name.split('_');
						var input = document.getElementById(returnName[1]);

						/**
						 * inputArr + callbackArr and remove duplicates
						 * */
						var inputArr = [...new Set(input.value.split(',').concat(callback.adress))]

						/**
						 * 보내는 사람일 경우 첫번째 선택한 사람 적용
						 * */
						if(returnName[1] === 'setFrom'){
							input.value = (inputArr[1]==undefined?input.value:inputArr[1]);
						}else{
							/**
							 * 보내는 사람일 외 경우 빈값 처리 후 적용
							 * */
							for (let i = 0; i < inputArr.length; i++) {
								if(inputArr[i] === ''){
									inputArr.splice(i, 1);
									i--;
								}
							}
							input.value = inputArr;
						}
					}
					break;
				case 'cust':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						if(callback.custCd === undefined) return;
						document.getElementById('custCd').value=callback.custCd;
						document.getElementById('custNm').value=callback.custNm;
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.depaNm= edmsEstGridItem.getValue(row.rowKey, 'depaNm')??'';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						if(callback.depaCd === undefined) return;
						edmsEstGridItem.setValue(row.rowKey,'depaCd',callback.depaCd);
						edmsEstGridItem.setValue(row.rowKey,'depaNm',callback.depaNm);
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
						if(callback.empCd === undefined) return;
						edmsEstGridItem.setValue(row.rowKey,'manCd',callback.empCd);
						edmsEstGridItem.setValue(row.rowKey,'manNm',callback.empNm);
					}
					break;
				case 'item':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ITEMPOPUP',param)
					}else{
						// edmsEstGridItem.focus(row.rowKey,'itemNm',true);
						var rst = callback.param;
						if(rst === undefined) return;
						var rstLen = rst.length;
						// var subRow = edmsEstGridItem.getFocusedCell();
						if(rstLen > 0){
							for(var i=0; i<rstLen; i++){
								var data = edsUtil.cloneObj(edmsEstGridItem.getData());
								var itemRow = edsUtil.getMaxObject(data,'rowKey');
								if(itemRow == undefined) itemRow = 0;
								else if(itemRow.hasOwnProperty('rowKey'))itemRow = edsUtil.getMaxObject(data,'rowKey').rowKey;
								rst[i].rowKey = itemRow+1;
								rst[i].corpCd = document.getElementById("corpCd").value;
								rst[i].busiCd = document.getElementById("busiCd").value;
								rst[i].vatDivi = '01';
								rst[i].taxDivi = '01';
								rst[i].qty = 1;
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
								edmsEstGridItem.appendRow(rst[i])
							}
							edmsEstGridItem.focus(rst[0].rowKey,'itemNm',true);
							// edmsEstGridItem.removeRow(subRow.rowKey);// 추가된 row 삭제
						}
					}
					break;
				case 'itemPopup':
					if(divi==='open'){
						document.getElementById('btnItemPopup').click();
						setTimeout(async ev =>{
							await doAction('edmsEstGridItem','search')
						},200)
					}else{

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


	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

	async function applyTotAmt(){

		var supAmtAll = 0;
		var vatAmtAll = 0;
		var totAmtAll = 0;
		var supAmtAll2 = 0;
		var vatAmtAll2 = 0;
		var totAmtAll2 = 0;

		var data = edmsEstGridItem.getFilteredData()
		var dataLen = data.length;
		for (let i = 0; i < dataLen; i++) {
			supAmtAll += Number(data[i].supAmt);
			vatAmtAll += Number(data[i].vatAmt);
			totAmtAll += Number(data[i].totAmt);
			supAmtAll2 += Number(data[i].supAmt2);
			vatAmtAll2 += Number(data[i].vatAmt2);
			totAmtAll2 += Number(data[i].totAmt2);
		}
		edmsEstGridItem.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
		edmsEstGridItem.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
		edmsEstGridItem.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));

		edmsEstGridItem.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmtAll2));
		edmsEstGridItem.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmtAll2));
		edmsEstGridItem.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmtAll2));

		document.getElementById('supAmt').value=edsUtil.addComma(supAmtAll);
		document.getElementById('vatAmt').value=edsUtil.addComma(vatAmtAll);
		document.getElementById('totAmt').value=edsUtil.addComma(totAmtAll);

		document.getElementById('supAmt2').value=edsUtil.addComma(supAmtAll2);
		document.getElementById('vatAmt2').value=edsUtil.addComma(vatAmtAll2);
		document.getElementById('totAmt2').value=edsUtil.addComma(totAmtAll2);

		var profit = document.getElementById('profit');
		var margin = document.getElementById('margin');
		if(!isNaN(Number(edsUtil.removeComma(profit.value)))){
			var value= Math.round(Number(edsUtil.removeComma(profit.value))/totAmtAll2*10000)/100;

			if(totAmtAll2 === 0){
				margin.value = 0+"%"
			}else {
				margin.value = value+"%"
			}
		}
	}

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
</body>
</html>