<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<!-- Select2 -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2/css/select2.min.css">
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
	<!-- adminlte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<style>
		@font-face {
			font-family: 'Pretendard-Regular';
			src: url('/bootstrap-4.6.2/dist2/font/Pretendard-Bold.woff') format('woff');
			font-weight: 700;
			font-style: normal;
		}
		* {
			font-family: 'Pretendard-Regular';
			font-size: 0.9rem !important;
		}
		/***************************
		* grid custom css Start
		***************************/
		.tui-grid-cell-header,
		.tui-grid-cell-content,
		.table-font-size td,
		.table-font-size b{
			font-size: 0.9rem !important;
		}
		.tui-grid-cell-summary{
			background-color: #fbfb97;
		}
		.table-font-size th{
			font-size: 0.9rem !important;
			text-align:center !important;
			vertical-align: middle !important;
		}
		.tui-grid-cell-summary{
			padding: 0 5px !important;
		}
		.table-cell th,
		.table-cell td{
			padding: 4px 5px !important;
			min-width: 100px;
			text-align: right;
			border: 1px solid #262626;
		}
		.table-cell th{
			width: calc(100%/30);
		}
		.table-cell td{
			width: calc(100%/30);
			font-weight: bold;
		}
		.table-cell input{
			width: 100%;
			height: 100%;
			font-weight: bold;
			text-align: right;
		}
		.table{
			width: 100vw;
			min-width: 1000px;
			background-color: #fff;
		}

		div[class="tui-grid-lside-area"] .tui-grid-row-odd > td{
			background-color: #fff !important;
		}

		/***************************
		* grid custom css End
		***************************/

		/***************************
		* html custom css Start
		***************************/
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

		/***************************
		* html custom css End
		***************************/
	</style>
</head>

<body>
<div style="position:relative">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12" style="height: calc(2rem); width: 100%; padding: unset; background-color: #ebe9e4">
				<div style="width: 100vw;">
					<i class="fa-solid fa-gears" style="float: left;font-size:1.2rem !important;"></i>
					<i style="float: left;font-size:1.2rem !important;"> 목표설정</i>
					<i style="float: left;font-size:1.2rem !important; margin-left: 10px;"> (단위 : 백 만원)</i>
					<i style="float: left;font-size:1.2rem !important; margin-left: 10px;"> 날짜 :</i>
					<div style="z-index: 1030;float: left;position: relative;">
						<input type="text" class="form-control text-center" style="background-color:white; margin-left: 10px;width: 85px;height: calc(2rem);"id="ordPlanSetDt" aria-label="Date-Time" title="계획날짜"  placeholder="계획날짜" readonly="readonly" required>
						<div id="ordPlanSetDtDIV" style="margin-left: 10px;"></div>
					</div>
					<button type="button" class="btn btn-sm btn-primary mr-1 float-right" name="btnSetSave" id="btnSetSave" onclick="doAction('orderPlanSet','save')"><i class="fa fa-solid fa-share"></i> 목표저장</button>
					<button type="button" class="btn btn-sm btn-primary mr-1 float-right d-none" name="btnSetSearch" id="btnSetSearch" onclick="doAction('orderPlanSet','search')"><i class="fa fa-solid fa-share"></i> 조회</button>
				</div>
			</div>
			<div class="col-lg-12" id="planTable" style="width: 100%; padding: unset; background-color: #dcdad1">
				<table class="table table-bordered m-0 table-font-size table-cell" style="background-color: #fdfd98;border:1px solid #000" id="content-header">
					<tbody>
						<tr>
							<td style="text-align: left" id="ordPlanItemNm01"></td></td><td id="ordPlanItem01"></td>
							<td style="text-align: left" id="ordPlanItemNm06"></td></td><td id="ordPlanItem06"></td>
							<th scope="col" rowspan="6" style="color:red"><b name="topSetYear"></b>년<br>등급별 수주현황</th>
							<td id="gr02"></td><td>A</td>
							<th scope="col" rowspan="6" style="color:red"><b name="topSetYear"></b>년<br>수주목표 설정</th>
							<td id="ord02"></td><td><input id="ordInp02" type="text" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"/></td>
							<th scope="col" rowspan="6" style="color:red"><b name="topSetYear"></b>년<br>매출목표 설정</th>
							<td id="sal02"></td><td><input id="salInp02" type="text" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"/></td>
						</tr>
						<tr>
							<td style="text-align: left" id="ordPlanItemNm02"></td></td><td id="ordPlanItem02"></td>
							<td style="text-align: left" id="ordPlanItemNm07"></td></td><td id="ordPlanItem07"></td>
							<td id="gr03"></td><td>B</td>
							<td id="ord03"></td><td><input id="ordInp03" type="text" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"/></td>
							<td id="sal03"></td><td><input id="salInp03" type="text" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"/></td>
						</tr>
						<tr>
							<td style="text-align: left" id="ordPlanItemNm03"></td><td id="ordPlanItem03"></td>
							<td style="text-align: left" id="ordPlanItemNm08"></td><td id="ordPlanItem08"></td>
							<td id="gr04"></td><td>C</td>
							<td id="ord04"></td><td><input id="ordInp04" type="text" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"/></td>
							<td id="sal04"></td><td><input id="salInp04" type="text" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"/></td>
						</tr>
						<tr>
							<td style="text-align: left" id="ordPlanItemNm04"></td><td id="ordPlanItem04"></td>
							<td style="text-align: left" id="ordPlanItemNm09"></td><td id="ordPlanItem09"></td>
							<td id="gr01" style="color:red"></td><td style="color:red">OK</td>
							<td id="ord01" style="color:red"></td><td style="color:red">OK</td>
							<td id="sal01" style="color:red"></td><td style="color:red">OK</td>
						</tr>
						<tr>
							<td style="text-align: left" id="ordPlanItemNm05"></td><td id="ordPlanItem05"></td>
							<td style="text-align: left" id="ordPlanItemNm10"></td><td id="ordPlanItem10"></td>
							<td id="gr05" style="background-color:#cafd65"></td><td style="background-color:#cafd65">총계</td>
							<td id="ord05" style="background-color:#cafd65"></td><td style="background-color:#cafd65">총계</td>
							<td id="sal05" style="background-color:#cafd65"></td><td style="background-color:#cafd65">총계</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-lg-12" style="height: calc(2rem);width: 100%; padding: unset; background-color: #ebe9e4">
				<i class="fa-solid fa-gears" style="float: left;font-size:1.2rem !important;"></i>
				<i style="float: left;font-size:1.2rem !important;"> 매출계획</i>
				<i style="float: left;font-size:1.2rem !important; margin-left: 10px;"> (단위 : 백 만원)</i>
				<button type="button" class="btn btn-sm btn-primary mr-1 float-right" name="btnAddRow" id="btnAddRow" onclick="doAction('orderPlanGrid','addCol')"><i class="fa fa-solid fa-share"></i> 추가</button>
				<button type="button" class="btn btn-sm btn-primary mr-1 float-right" name="btnSearch" id="btnSearch" onclick="doAction('orderPlanGrid','search')"><i class="fa fa-solid fa-share"></i> 조회</button>
				<button type="button" class="invisible" 			 name="btnInputPopEv"		id="btnInputPopEv"			data-toggle="modal" data-target="#modalOrderPlan"></button>
			</div>
		</div>
		<div class="row" id="contentObjective">
			<div id="orderPlanGridDIV">
				<div class="col-sm-12" id="orderPlanGrid"></div>
			</div>
		</div>
	</div>
</div>
<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
	<div class="carousel-indicators">
		<div data-target="#carouselExampleCaptions" data-slide-to="0" class="active">가나다</div>
		<div data-target="#carouselExampleCaptions" data-slide-to="1">라마바</div>
		<div data-target="#carouselExampleCaptions" data-slide-to="2">사아자</div>
	</div>
	<div class="carousel-inner">
		<div class="carousel-item active" style="height: 100vh;background-color: red;">
			<img src="..." class="d-block w-100" alt="...">
			<div class="carousel-caption d-none d-md-block">
				<h5>First slide label</h5>
				<p>Some representative placeholder content for the first slide.</p>
			</div>
		</div>
		<div class="carousel-item" style="height: 100vh;background-color: red;">
			<img src="..." class="d-block w-100" alt="...">
			<div class="carousel-caption d-none d-md-block">
				<h5>Second slide label</h5>
				<p>Some representative placeholder content for the second slide.</p>
			</div>
		</div>
		<div class="carousel-item" style="height: 100vh;background-color: red;">
			<img src="..." class="d-block w-100" alt="...">
			<div class="carousel-caption d-none d-md-block">
				<h5>Third slide label</h5>
				<p>Some representative placeholder content for the third slide.</p>
			</div>
		</div>
	</div>
	<button class="carousel-control-prev" type="button" data-target="#carouselExampleCaptions" data-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</button>
	<button class="carousel-control-next" type="button" data-target="#carouselExampleCaptions" data-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</button>
</div>
<div class="modal fade" id="modalOrderPlan" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header font-color p-0" name="tabs" id="tabs" style="color: #4d4a41">
				<div class="col-md-6 p-2">
					<h4 class="modal-title" style="color:#000;font-weight: bold;font-size:1.5rem !important;">상세정보</h4>
				</div>
				<div class="col-md-6 p-2 text-right">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true" style="font-size:1.5rem !important;">×</span>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="col-md-12" style="height: 100%;" id="log">
					<form name="orderPlanGridForm" id="orderPlanGridForm" onsubmit="return false;" method="post">
						<input type="hidden" name="status" 			id="status" 	title="회사코드">
						<input type="hidden" name="corpCd" 			id="corpCd" 	title="회사코드">
						<input type="hidden" name="ordPlanCd" 		id="ordPlanCd" 	title="수주계획코드">
						<div class="row">
							<div class="col-4 col-md-4 p-2">
								<label for="ordPlanBusiDivi"><b>대분류</b></label>
								<select class="form-control selectpicker" id="ordPlanBusiDivi" name="ordPlanBusiDivi" required></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="ordPlanDivi"><i class="fa-solid fa-star text-danger"></i><b>중분류</b></label>
								<select class="form-control selectpicker" id="ordPlanDivi" name="ordPlanDivi" required></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="ordPlanItem"><i class="fa-solid fa-star text-danger"></i><b>소분류</b></label>
								<select class="form-control selectpicker" id="ordPlanItem" name="ordPlanItem" required></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="ordPlanCustCd"><b>거래처</b></label>
								<input type="text" class="form-control text-center" id="ordPlanCustCd" name="ordPlanCustCd" placeholder="거래처" required>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="ordPlanAmt"><b>금액</b></label>
								<input type="text" class="form-control text-right" id="ordPlanAmt" name="ordPlanAmt" placeholder="금액.." required>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="ordPlanGr"><b>등급</b></label>
								<select class="form-control selectpicker" id="ordPlanGr" name="ordPlanGr" required></select>
							</div>
							<div class="col-md-4 p-2" style="z-index: 1052;">
								<label for="ordPlanDt"><b>계획날짜</b></label>
								<input type="text" class="form-control text-center" id="ordPlanDt" aria-label="Date-Time" title="계획날짜"  placeholder="계획날짜" required>
								<div id="ordPlanDtDIV" style="margin-top: -1px;"></div>
							</div>
							<div class="col-12 col-md-12 p-2">
								<label for="ordPlanEmpCd"><b>담당자</b></label>
								<select class="form-control selectpicker" id="ordPlanEmpCd" name="ordPlanEmpCd" required></select>
							</div>
							<div class="col-6 col-md-6 p-2">
								<label for="ordPlanBusiCd"><b>사업장</b></label>
								<select class="form-control selectpicker" id="ordPlanBusiCd" name="ordPlanBusiCd" required disabled></select>
							</div>
							<div class="col-6 col-md-6 p-2">
								<label for="ordPlanDepaCd"><b>부서</b></label>
								<select class="form-control selectpicker" id="ordPlanDepaCd" name="ordPlanDepaCd" required disabled></select>
							</div>
							<div class="col-md-12 p-2">
								<label for="ordPlanNote"><b>메모</b></label>
								<textarea type="text" rows="5" class="form-control" style="resize: unset" id="ordPlanNote" name="ordPlanNote" placeholder="메모" value=""></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px;">
						<div class="col text-center">
							<form class="form-inline" role="form" name="errorLogModalButtonForm" id="errorLogModalButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary d-none" name="btnReset"	id="btnReset"	style="background-color: #544e4c" onclick="doAction('orderPlanGrid','reset')"><i class="fa fa-trash"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnSave"		id="btnSave"	style="background-color: #544e4c" onclick="doAction('orderPlanGrid','save')"><i class="fa fa-save"></i> 저장</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete"	id="btnDelete"	style="background-color: #544e4c" onclick="doAction('orderPlanGrid','delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose"	id="btnClose"	style="background-color: #544e4c" onclick="doAction('orderPlanGrid','close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
<script>
	var orderPlanGrid;
	var ordPlanDt, ordPlanSetDt;
	var select;
	var beforeRow, beforeCol;
	$(document).ready(async function () {
		/*************************************
		 * grid init START
		 * **********************************/

		await init();

		/*************************************
		 * grid init END
		 * **********************************/


		/*************************************
		 * contentObjective margin-set START
		 * **********************************/
		/* page initSize set*/
		var contentMainPaddingTop = document.getElementById('content-header').offsetHeight;
		document.getElementById('contentObjective').style.height = 'calc(100vh - '+contentMainPaddingTop+'px - 70px)';
		setTimeout(async ev=>{
			var contentMainWidth = document.getElementById('content-header').offsetWidth;
			document.getElementById('orderPlanGridDIV').style.width = contentMainWidth + 'px';
			document.getElementById('orderPlanGrid').style.width = contentMainWidth + 'px';
			await orderPlanGrid.refreshLayout();
		},100)

		/* page resize set*/
		window.addEventListener("resize", async function() {
			var contentMainPaddingTop = document.getElementById('content-header').offsetHeight;
			var contentMainWidth = document.getElementById('content-header').offsetWidth;
			document.getElementById('contentObjective').style.height = 'calc(100vh - '+contentMainPaddingTop+'px - 70px)';
			document.getElementById('orderPlanGridDIV').style.width = contentMainWidth + 'px';
			document.getElementById('orderPlanGrid').style.width = contentMainWidth + 'px';
			await orderPlanGrid.refreshLayout();
		})
		/*************************************
		 * contentObjective margin-set END
		 * **********************************/


		/*************************************
		 * contentObjective scroll-memorial-set START
		 * **********************************/

		/*************************************
		 * contentObjective scroll-memorial-set END
		 * **********************************/

		document.getElementById('planTable').addEventListener('change', async ev=>{
			var el = ev.target
			switch (el.id) {
				case "ordInp02":
				case "salInp02":
				case "ordInp03":
				case "salInp03":
				case "ordInp04":
				case "salInp04":
					/***********************
					 * 목표설정 값 세팅 Start
					 ***********************/
					var target = el.id.replaceAll('Inp','');
					var org = '';

					if(target.includes('ord')){
						org = parseFloat(edsUtil.removeComma(document.getElementById('gr'+target.substr(3,2)).innerText));
					}else if(target.includes('sal')){
						org = parseFloat(edsUtil.removeComma(document.getElementById('ord'+target.substr(3,2)).innerText));
					}
					var per = parseFloat(el.value);
					var val = (org * (per/100)).toFixed(2);
					val = val.toString().split('.');
					if(val.length === 1){
						val += '.00';
					}else{
						val = val[0] + '.' + val[1].padEnd(2,0);
					}
					document.getElementById(target).innerText = edsUtil.addComma(val);

					/***********************
					 * 목표설정 값 세팅 End
					 ***********************/
					/***********************************
					 * 수주목표 대비 매출목표 연동 Start
					 ***********************************/
					if(target.includes('ord')){
						per = parseFloat(edsUtil.removeComma(document.getElementById('salInp'+target.substr(3,2)).value));
						val = val = (parseFloat(val) * (per/100)).toFixed(2);
						val = val.toString().split('.');
						if(val.length === 1){
							val += '.00';
						}else{
							val = val[0] + '.' + val[1].padEnd(2,0);
						}
						document.getElementById('sal'+target.substr(3,2)).innerText = edsUtil.addComma(val);
					}
					/***********************************
					 * 수주목표 대비 매출목표 연동 End
					 ***********************************/

					/***********************
					 * 수주목표총계 값 세팅 Start
					 ***********************/

					var tot = 0;

					var ord = [
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('ord01').innerText))),
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('ord02').innerText))),
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('ord03').innerText))),
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('ord04').innerText))),
					]
					for (let i = 0, length = ord.length; i < length; i++) tot += ord[i];

					tot = tot.toString().split('.');
					if(tot.length === 1){
						tot += '.00';
					}else{
						tot = tot[0] + '.' + tot[1].padEnd(2,0);
					}

					document.getElementById('ord05').innerText = edsUtil.addComma(parseFloat(tot).toFixed(3));

					/***********************
					 * 수주목표총계 값 세팅 End
					 ***********************/

					/***********************
					 * 매출목표총계 값 세팅 Start
					 ***********************/

					tot = 0;
					var sal = [
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('sal01').innerText))),
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('sal02').innerText))),
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('sal03').innerText))),
						await NaNToZero(parseFloat(edsUtil.removeComma(document.getElementById('sal04').innerText))),
					]

					for (let i = 0, length = sal.length; i < length; i++) tot += sal[i];
					tot = tot.toString().split('.');
					if(tot.length === 1){
						tot += '.00';
					}else{
						tot = tot[0] + '.' + tot[1].padEnd(2,0);
					}
					document.getElementById('sal05').innerText = edsUtil.addComma(parseFloat(tot).toFixed(3));

					/***********************
					 * 매출목표총계 값 세팅 End
					 ***********************/
					break;
				default: break;
			}
		})

		/*************************************
		 * bootstrap select2 set START
		 * **********************************/
		edsUtil.setSelectEl(document.querySelector("#orderPlanGridForm"), "guMae",
				{
					corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
					busiCd: '<c:out value="${LoginInfo.busiCd}"/>',
					depaCd: '<c:out value="${LoginInfo.depaCd}"/>',
					empCd: '<c:out value="${LoginInfo.empCd}"/>',
				});

		/*생성자 생성*/
		$('.selectpicker').select2({
			language: 'ko'
		});

		/*************************************
		 * bootstrap select2 set END
		 * **********************************/

		/*************************************
		 * topSetYear set Start
		 * **********************************/
		await topSetYearData();
		/*************************************
		 * topSetYear set END
		 * **********************************/

		/*************************************
		 * 'bootstrap select2' Tap set Start
		 * **********************************/

		/*탭시 누를 시, 자동 open 기능*/
		// on first focus (bubbles up to document), open the menu
		$(document).on('focus', '.select2-selection.select2-selection--single', function (e) {
			$(this).closest(".select2-container").siblings('select:enabled').select2('open');
		});

		// steal focus during close - only capture once and stop propogation
		$('select.select2').on('select2:closing', function (e) {
			$(e.target).data("select2").$selection.one('focus focusin', function (e) {
				e.stopPropagation();
			});
		});

		/* selectpicker change ev set */
		$('.selectpicker').on("select2:select", function (e) {
			var targetId = e.target.id;
			var targetValue = e.target.value;
			var multilpeBoolean = e.target.multiple;
			// 단일 select 일때
			if (!multilpeBoolean) {
				switch (targetId) {
					case 'ordPlanEmpCd' :
						$('#ordPlanDepaCd').val(e.target.selectedOptions[0].attributes.depaCd.value).trigger('change');
						$('#ordPlanBusiCd').val(e.target.selectedOptions[0].attributes.busiCd.value).trigger('change');
						break;
				}
			}
		});
		/*************************************
		 * 'bootstrap select2' Tap set END
		 * **********************************/
	});

	/* 초기설정 */
	async function init() {

		/* Form 셋팅 */
		// edsUtil.setForm(document.querySelector("#orderPlanGridForm"), "guMae");
		// select =$('.select2').select2();

		/**********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/
		 orderPlanGrid = new tui.Grid({
				el: document.getElementById('orderPlanGridDIV'),
                scrollY:true,
                scrollX:true,
                bodyHeight: 'fitToParent',
				rowHeight:25,
				minRowHeight:25,
                header: {
					height: 50,
					minRowHeight: 50,
					complexColumns: [
						{
							header: '01월',
							name: '01colum',
							childNames: ['ordPlanCustCd01','ordPlanAmt01','ordPlanGr01']
						},
						{
							header: '02월',
							name: '02colum',
							childNames: ['ordPlanCustCd02','ordPlanAmt02','ordPlanGr02']
						},
                        {
							header: '03월',
							name: '03colum',
							childNames: ['ordPlanCustCd03','ordPlanAmt03','ordPlanGr03']
						},
                        {
							header: '04월',
							name: '04colum',
							childNames: ['ordPlanCustCd04','ordPlanAmt04','ordPlanGr04']
						},
                        {
							header: '05월',
							name: '05colum',
							childNames: ['ordPlanCustCd05','ordPlanAmt05','ordPlanGr05']
						},
                        {
							header: '06월',
							name: '06colum',
							childNames: ['ordPlanCustCd06','ordPlanAmt06','ordPlanGr06']
						},
                        {
							header: '07월',
							name: '07colum',
							childNames: ['ordPlanCustCd07','ordPlanAmt07','ordPlanGr07']
						},
                        {
							header: '08월',
							name: '08colum',
							childNames: ['ordPlanCustCd08','ordPlanAmt08','ordPlanGr08']
						},
                        {
							header: '09월',
							name: '09colum',
							childNames: ['ordPlanCustCd09','ordPlanAmt09','ordPlanGr09']
						},
                        {
							header: '10월',
							name: '10colum',
							childNames: ['ordPlanCustCd10','ordPlanAmt10','ordPlanGr10']
						},
                        {
							header: '11월',
							name: '11colum',
							childNames: ['ordPlanCustCd11','ordPlanAmt11','ordPlanGr11']
						},
                        {
							header: '12월',
							name: '12colum',
							childNames: ['ordPlanCustCd12','ordPlanAmt12','ordPlanGr12']
						},
					],
				},
				rowHeaders: [/*'rowNum',*/ /*'checkbox'*/],
				columns:[],
				columnOptions: {
					resizable: true,
					frozenCount: 2,
					frozenBorderWidth: 2, // 컬럼 고정 옵션
				},
				summary: {
					height: 100,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						ordPlanCustCd01: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd02: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd03: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd04: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd05: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd06: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd07: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd08: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd09: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd10: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd11: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanCustCd12: { template: function(valueMap) { return '등급(A)<br>등급(B)<br>등급(C)<br><b style="color:royalblue">계약</b><br><b style="color:red">예상매출</b><br>'}},
						ordPlanGr01: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr02: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr03: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr04: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr05: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr06: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr07: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr08: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr09: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr10: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr11: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
						ordPlanGr12: { template: function(valueMap) { return '<div style="text-align: center">A<br>B<br>C<br>OK<br><br></div>'}},
					}
				},

				contextMenu: () => [
				[
					{
						name: '엑셀내보내기',
						label: '엑셀다운로드',
						action: () => {
							orderPlanGrid.export('xlsx', { useFormattedValue: true,fileName:'지출품목내역'+'_<c:out value="${LoginInfo.empNm}"/>'});
                    	},
					}
				]
				],
			});
		 /*
		 *
		 * */
			orderPlanGrid.setColumns([
				{ header:'구분',					name:'ordPlanDivi',		minWidth:60,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM043")}},	formatter: 'listItemText',rowSpan: true},
				{ header:'항목',					name:'ordPlanItem',		minWidth:60,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM044")}},	formatter: 'listItemText',rowSpan: true},
				{ header:'거래처',				name:'ordPlanCustCd01',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt01',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr01',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd02',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt02',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr02',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd03',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt03',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr03',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd04',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt04',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr04',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd05',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt05',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr05',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd06',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt06',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr06',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd07',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt07',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr07',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd08',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt08',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr08',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd09',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt09',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr09',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd10',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt10',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr10',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd11',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt11',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr11',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
				{ header:'거래처',				name:'ordPlanCustCd12',		minWidth:120,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
                { header:'금액',					name:'ordPlanAmt12',		minWidth:60,		align:'right',	defaultValue: ''	},
				{ header:'등급',					name:'ordPlanGr12',			minWidth:50,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},

					/* hidden*/
				{ header:'회사코드01',			name:'corpCd01',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드01',		name:'ordPlanCd01',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도01',		name:'ordPlanYear01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월01',			name:'ordPlanMonth01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분02',		name:'ordPlanDivi01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목02',		name:'ordPlanItem01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드01',	name:'ordPlanBusiCd01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드01',	name:'ordPlanDepaCd01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드01',	name:'ordPlanEmpCd01',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분01',	name:'ordPlanBusiDivi01',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모01',		name:'ordPlanNote01',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드02',			name:'corpCd02',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드02',		name:'ordPlanCd02',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도02',		name:'ordPlanYear02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월02',			name:'ordPlanMonth02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분02',		name:'ordPlanDivi02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목02',		name:'ordPlanItem02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드02',	name:'ordPlanBusiCd02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드02',	name:'ordPlanDepaCd02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드02',	name:'ordPlanEmpCd02',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분02',	name:'ordPlanBusiDivi02',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모02',		name:'ordPlanNote02',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드03',			name:'corpCd03',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드03',		name:'ordPlanCd03',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도03',		name:'ordPlanYear03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월03',			name:'ordPlanMonth03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분03',		name:'ordPlanDivi03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목03',		name:'ordPlanItem03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드03',	name:'ordPlanBusiCd03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드03',	name:'ordPlanDepaCd03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드03',	name:'ordPlanEmpCd03',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분03',	name:'ordPlanBusiDivi03',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모03',		name:'ordPlanNote03',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드04',			name:'corpCd04',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드04',		name:'ordPlanCd04',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도04',		name:'ordPlanYear04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월04',			name:'ordPlanMonth04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분04',		name:'ordPlanDivi04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목04',		name:'ordPlanItem04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드04',	name:'ordPlanBusiCd04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드04',	name:'ordPlanDepaCd04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드04',	name:'ordPlanEmpCd04',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분04',	name:'ordPlanBusiDivi04',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모04',		name:'ordPlanNote04',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드05',			name:'corpCd05',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드05',		name:'ordPlanCd05',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도05',		name:'ordPlanYear05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월05',			name:'ordPlanMonth05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분05',		name:'ordPlanDivi05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목05',		name:'ordPlanItem05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드05',	name:'ordPlanBusiCd05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드05',	name:'ordPlanDepaCd05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드05',	name:'ordPlanEmpCd05',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분05',	name:'ordPlanBusiDivi05',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모05',		name:'ordPlanNote05',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드06',			name:'corpCd06',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드06',		name:'ordPlanCd06',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도06',		name:'ordPlanYear06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월06',			name:'ordPlanMonth06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분06',		name:'ordPlanDivi06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목06',		name:'ordPlanItem06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드06',	name:'ordPlanBusiCd06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드06',	name:'ordPlanDepaCd06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드06',	name:'ordPlanEmpCd06',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분06',	name:'ordPlanBusiDivi06',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모06',		name:'ordPlanNote06',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드07',			name:'corpCd07',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드07',		name:'ordPlanCd07',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도07',		name:'ordPlanYear07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월07',			name:'ordPlanMonth07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분07',		name:'ordPlanDivi07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목07',		name:'ordPlanItem07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드07',	name:'ordPlanBusiCd07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드07',	name:'ordPlanDepaCd07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드07',	name:'ordPlanEmpCd07',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분07',	name:'ordPlanBusiDivi07',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모07',		name:'ordPlanNote07',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드08',			name:'corpCd08',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드08',		name:'ordPlanCd08',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도08',		name:'ordPlanYear08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월08',			name:'ordPlanMonth08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분08',		name:'ordPlanDivi08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목08',		name:'ordPlanItem08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드08',	name:'ordPlanBusiCd08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드08',	name:'ordPlanDepaCd08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드08',	name:'ordPlanEmpCd08',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분08',	name:'ordPlanBusiDivi08',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모08',		name:'ordPlanNote08',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드09',			name:'corpCd09',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드09',		name:'ordPlanCd09',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도09',		name:'ordPlanYear09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월09',			name:'ordPlanMonth09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분09',		name:'ordPlanDivi09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목09',		name:'ordPlanItem09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드09',	name:'ordPlanBusiCd09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드09',	name:'ordPlanDepaCd09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드09',	name:'ordPlanEmpCd09',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분09',	name:'ordPlanBusiDivi09',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모09',		name:'ordPlanNote09',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드10',			name:'corpCd10',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드10',		name:'ordPlanCd10',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도10',		name:'ordPlanYear10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월10',			name:'ordPlanMonth10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분10',		name:'ordPlanDivi10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목10',		name:'ordPlanItem10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드10',	name:'ordPlanBusiCd10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드10',	name:'ordPlanDepaCd10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드10',	name:'ordPlanEmpCd10',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분10',	name:'ordPlanBusiDivi10',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모10',		name:'ordPlanNote10',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드11',			name:'corpCd11',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드11',		name:'ordPlanCd11',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도11',		name:'ordPlanYear11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월11',			name:'ordPlanMonth11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분11',		name:'ordPlanDivi11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목11',		name:'ordPlanItem11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드11',	name:'ordPlanBusiCd11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드11',	name:'ordPlanDepaCd11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드11',	name:'ordPlanEmpCd11',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분11',	name:'ordPlanBusiDivi11',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모11',		name:'ordPlanNote11',		width:100,		align:'center',	hidden:true },
				{ header:'회사코드12',			name:'corpCd12',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획코드12',		name:'ordPlanCd12',			width:100,		align:'center',	hidden:true },
				{ header:'수주계획년도12',		name:'ordPlanYear12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획월12',			name:'ordPlanMonth12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획구분12',		name:'ordPlanDivi12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획항목12',		name:'ordPlanItem12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업장코드12',	name:'ordPlanBusiCd12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획부서코드12',	name:'ordPlanDepaCd12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획담당자코드12',	name:'ordPlanEmpCd12',		width:100,		align:'center',	hidden:true },
				{ header:'수주계획사업구분12',	name:'ordPlanBusiDivi12',	width:100,		align:'center',	hidden:true },
				{ header:'수주계획메모12',		name:'ordPlanNote12',		width:100,		align:'center',	hidden:true },
			]);

			orderPlanGrid.disableColumn('ordPlanDivi01');
			orderPlanGrid.disableColumn('ordPlanItem01');
			orderPlanGrid.disableColumn('ordPlanGr01');
			orderPlanGrid.disableColumn('ordPlanGr02');
			orderPlanGrid.disableColumn('ordPlanGr03');
			orderPlanGrid.disableColumn('ordPlanGr04');
			orderPlanGrid.disableColumn('ordPlanGr05');
			orderPlanGrid.disableColumn('ordPlanGr06');
			orderPlanGrid.disableColumn('ordPlanGr07');
			orderPlanGrid.disableColumn('ordPlanGr08');
			orderPlanGrid.disableColumn('ordPlanGr09');
			orderPlanGrid.disableColumn('ordPlanGr10');
			orderPlanGrid.disableColumn('ordPlanGr11');
			orderPlanGrid.disableColumn('ordPlanGr12');
		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * DatePicker Info 영역 START
		 ***********************************************************************/

		/* 데이트픽커 초기 속성 설정 */
		ordPlanDt = new DatePicker(['#ordPlanDtDIV'], {
			language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
			showAlways: false, // If true, the datepicker will not close until you call "close()".
			autoClose: true,// If true, Close datepicker when select date
			date: new Date(), // Date instance or Timestamp for initial date
			input: {
				element: ['#ordPlanDt'],
				format: 'yyyy-MM'
			},
			type: 'month', // Type of picker - 'date', 'month', year'
		});

		/* 데이트픽커 초기 속성 설정 */
		ordPlanSetDt = new DatePicker(['#ordPlanSetDtDIV'], {
			language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
			showAlways: false, // If true, the datepicker will not close until you call "close()".
			autoClose: true,// If true, Close datepicker when select date
			date: new Date(), // Date instance or Timestamp for initial date
			input: {
				element: ['#ordPlanSetDt'],
				format: 'yyyy'
			},
			type: 'year', // Type of picker - 'date', 'month', year'
		});

		/**********************************************************************
		 * DatePicker Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/

		orderPlanGrid.on('onGridUpdated', async ev => {
			await calculateMonthlySumsByGr();
		});


		orderPlanGrid.on('afterFilter', async ev => {
			await calculateMonthlySumsByGr();
		});

		orderPlanGrid.on('afterUnfilter', async ev => {
			await calculateMonthlySumsByGr();
		});

		orderPlanGrid.on('click', async ev => {
			const { columnName: colNm, targetType: target, rowKey } = ev;
			if(target === 'cell'){
				beforeRow = rowKey;
				beforeCol = colNm;
				var arr = ['ordPlanDivi', 'ordPlanItem'];
				if(arr.includes(colNm)) return;

				var data = orderPlanGrid.getRow(orderPlanGrid.getFocusedCell().rowKey);
				var mth = colNm.slice(-2);

				document.getElementById('btnInputPopEv').click();

				// 일반 el
				document.querySelector('form[id="orderPlanGridForm"] input[id="corpCd"]').value = data['corpCd'+mth]??'';
				document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanCd"]').value = data['ordPlanCd'+mth]??'';
				document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanCustCd"]').value = data['ordPlanCustCd'+mth]??'';
				document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanAmt"]').value = data['ordPlanAmt'+mth]??'';
				document.querySelector('form[id="orderPlanGridForm"] textarea[id="ordPlanNote"]').value = data['ordPlanNote'+mth]??'';
				// select2 el
				var status = '';
				var ordPlanDivi = '';
				var ordPlanItem = '';
				var ordPlanYear = '';
				var ordPlanBusiCd = '';
				var ordPlanDepaCd = '';
				var ordPlanEmpCd = '';
				var ordPlanBusiDivi = '';
				var ordPlanGr = '';
				if(data['ordPlanCd'+mth]){
					status = 'U'
					ordPlanYear = (data['ordPlanYear'+mth]??'') + '-' + (data['ordPlanMonth'+mth]??'');
					ordPlanDivi = data['ordPlanDivi'+mth]??null;
					ordPlanItem = data['ordPlanItem'+mth]??null;
					ordPlanBusiCd = data['ordPlanBusiCd'+mth]??null;
					ordPlanDepaCd = data['ordPlanDepaCd'+mth]??null;
					ordPlanEmpCd = data['ordPlanEmpCd'+mth]??null;
					ordPlanBusiDivi = data['ordPlanBusiDivi'+mth]??null;
					ordPlanGr = data['ordPlanGr'+mth]??null;
				}else{
					status = 'C';
					ordPlanYear = document.getElementById('ordPlanSetDt').value + '-' + mth;
					ordPlanBusiCd = '${LoginInfo.busiCd}';
					ordPlanDepaCd = '${LoginInfo.depaCd}';
					ordPlanEmpCd = '${LoginInfo.empCd}';
					ordPlanBusiDivi = '01';
					ordPlanGr = '01';
					for (let i = 1; i <= 12; i++) {
						ordPlanDivi = data['ordPlanDivi'+i.toString().padStart(2, '0')];
						ordPlanItem = data['ordPlanItem'+i.toString().padStart(2, '0')];
						if(ordPlanDivi&&ordPlanDivi) break;
					}
				}
				document.querySelector('form[id="orderPlanGridForm"] input[id="status"]').value = status;
				document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanDt"]').value = ordPlanYear;
				$('form[id="orderPlanGridForm"] select[id="ordPlanDivi"]').val(ordPlanDivi).trigger('change');
				$('form[id="orderPlanGridForm"] select[id="ordPlanItem"]').val(ordPlanItem).trigger('change');
				$('form[id="orderPlanGridForm"] select[id="ordPlanBusiDivi"]').val(ordPlanBusiDivi).trigger('change');
				$('form[id="orderPlanGridForm"] select[id="ordPlanGr"]').val(ordPlanGr).trigger('change');
				$('form[id="orderPlanGridForm"] select[id="ordPlanBusiCd"]').val(ordPlanBusiCd).trigger('change');
				$('form[id="orderPlanGridForm"] select[id="ordPlanDepaCd"]').val(ordPlanDepaCd).trigger('change');
				$('form[id="orderPlanGridForm"] select[id="ordPlanEmpCd"]').val(ordPlanEmpCd).trigger('change');

			}else{
				// guMaeGridList.finishEditing();
			}
		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * DatePicker 이벤트 영역 START
		 ***********************************************************************/

		ordPlanSetDt.on('change', async ev => {
			await doAction('orderPlanGrid','search');
			await topSetYearData();
		});

		/**********************************************************************
		 * DatePicker 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		await doAction('orderPlanGrid','search');
	}

	async function afterInit(){
		let grid = $(document.querySelector('div[id=orderPlanGridDIV] div[class=tui-grid-rside-area] div[class=tui-grid-body-area]'));

		// 스크롤 위치 저장
		let gridScrollPosition = {
			x: 0,
			y: 0
		};

		async function gridSaveBeforeScrollLocation() {
			gridScrollPosition.x = grid.scrollLeft();
			gridScrollPosition.y = grid.scrollTop();
		}

		async function gridMoveBeforeScrollLocation() {
			grid.scrollLeft(gridScrollPosition.x);
			grid.scrollTop(gridScrollPosition.y);
		}

		// 내부 함수들에 대한 참조를 포함하는 객체 반환
		return {
			saveScroll: gridSaveBeforeScrollLocation,
			moveScroll: gridMoveBeforeScrollLocation
		};
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
    	/** 버튼이벤트
	 * */
	async function doAction(sheet, name){
		if(sheet === 'orderPlanGrid'){
			switch (name) {
				case 'search':

					let gridFunctions = await afterInit();
					await gridFunctions.saveScroll(); // 스크롤 위치 저장

					await doAction('orderPlanSet','search');
					await orderPlanGrid.refreshLayout(); // 데이터 초기화
					await orderPlanGrid.finishEditing(); // 데이터 마감
					await orderPlanGrid.clear(); // 데이터 초기화
					var param = { //조회조건
						corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
						ordPlanSetDt: document.getElementById('ordPlanSetDt').value};
					let data = await edsUtil.getAjax("/ORDER_PLAN_LIST/selectOrderPlanList", param);
					await orderPlanGrid.resetData(data); // 데이터 set

					setTimeout(async ev => {
						await gridFunctions.moveScroll(); // 이전 스크롤 위치로 이동
					},50)
					break;
				case "save"://저장
					// inputModal Form validation
					var ajaxCondition = await edsUtil.checkValidationForForm('orderPlanGridForm', ['ordPlanDivi', 'ordPlanItem', 'ordPlanDt']);
					if (!ajaxCondition) { // 저장
						await edsUtil.modalCUD('/ORDER_PLAN_LIST/cuOrderPlanList','orderPlanGrid',orderPlanGrid,'orderPlanGridForm')
						await document.getElementById('btnClose').click();
					}
					break;
				case 'addCol':
					await document.getElementById('btnInputPopEv').click();
					setTimeout(async () => {
						document.getElementById('status').value = 'C';
					}, 100);
					setTimeout(async () => {
						await doAction('orderPlanGrid', 'resetAll');
					}, 100);
					break;
				case 'delete': // 삭제
					document.getElementById('status').value = 'D';
					setTimeout(async () => {
						await edsUtil.modalCUD('/ORDER_PLAN_LIST/cuOrderPlanList','orderPlanGrid',orderPlanGrid,'orderPlanGridForm')
						await document.getElementById('btnClose').click();
					}, 100);
				break;
				case "resetAll":// 초기화
					// 일반 el
					document.querySelector('form[id="orderPlanGridForm"] input[id="corpCd"]').value = '';
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanCd"]').value = '';
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanDt"]').value = document.getElementById('ordPlanSetDt').value + moment().format('-MM');
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanCustCd"]').value = '';
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanAmt"]').value = '';
					document.querySelector('form[id="orderPlanGridForm"] textarea[id="ordPlanNote"]').value = '';
					// select2 el
					$('form[id="orderPlanGridForm"] select[id="ordPlanBusiDivi"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanDivi"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanItem"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanGr"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanBusiCd"]').val('${LoginInfo.busiCd}').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanDepaCd"]').val('${LoginInfo.depaCd}').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanEmpCd"]').val('${LoginInfo.empCd}').trigger('change');
					break;
				case "reset":// 초기화
					// 일반 el
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanDt"]').value = document.getElementById('ordPlanSetDt').value + moment().format('-MM');
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanCustCd"]').value = '';
					document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanAmt"]').value = '';
					document.querySelector('form[id="orderPlanGridForm"] textarea[id="ordPlanNote"]').value = '';
					// select2 el
					$('form[id="orderPlanGridForm"] select[id="ordPlanBusiDivi"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanDivi"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanItem"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanGr"]').val('01').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanBusiCd"]').val('${LoginInfo.busiCd}').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanDepaCd"]').val('${LoginInfo.depaCd}').trigger('change');
					$('form[id="orderPlanGridForm"] select[id="ordPlanEmpCd"]').val('${LoginInfo.empCd}').trigger('change');
					break;
			}
		}else if(sheet === 'orderPlanSet'){
			switch (name) {
				case 'search':

					var param = { //조회조건
						corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
						ordPlanSetDt: document.getElementById('ordPlanSetDt').value,
					};

					let data = edsUtil.getAjax("/ORDER_PLAN_LIST/selectOrderPlanSetList", param);
					if(data.length > 0){
						document.querySelector('input[id="ordInp02"]').value = data[0].ordInp02;
						document.querySelector('input[id="ordInp03"]').value = data[0].ordInp03;
						document.querySelector('input[id="ordInp04"]').value = data[0].ordInp04;
						document.querySelector('input[id="salInp02"]').value = data[0].salInp02;
						document.querySelector('input[id="salInp03"]').value = data[0].salInp03;
						document.querySelector('input[id="salInp04"]').value = data[0].salInp04;
					}else{
						document.querySelector('input[id="ordInp02"]').value = 0;
						document.querySelector('input[id="ordInp03"]').value = 0;
						document.querySelector('input[id="ordInp04"]').value = 0;
						document.querySelector('input[id="salInp02"]').value = 0;
						document.querySelector('input[id="salInp03"]').value = 0;
						document.querySelector('input[id="salInp04"]').value = 0;
					}
					break;
				case "save"://저장
					var condition = document.querySelector('form[id="orderPlanGridForm"] input[id="ordPlanCd"]').value;
					var param = {};
					param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
					param.ordPlanSetDt = document.querySelector('input[id="ordPlanSetDt"]').value;
					param.ordInp02 = document.querySelector('input[id="ordInp02"]').value;
					param.ordInp03 = document.querySelector('input[id="ordInp03"]').value;
					param.ordInp04 = document.querySelector('input[id="ordInp04"]').value;
					param.salInp02 = document.querySelector('input[id="salInp02"]').value;
					param.salInp03 = document.querySelector('input[id="salInp03"]').value;
					param.salInp04 = document.querySelector('input[id="salInp04"]').value;
					await edsUtil.postAjax('/ORDER_PLAN_LIST/cuOrderPlanSetList', orderPlanGrid, param);

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
			var row = orderPlanGrid.getFocusedCell();
			var names = name.split('_');
			orderPlanGrid.finishEditing();
			switch (names[0]) {
				case 'busi':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('BUSIPOPUP',param)
					}else{
						if(callback.busiCd === undefined) return;
						document.getElementById('ordPlanBusiCd').value=callback.busiCd;
						document.getElementById('ordPlanBusiNm').value=callback.busiNm;
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
						document.getElementById('ordPlanCustCd').value=callback.custCd;
						document.getElementById('ordPlanCustNm').value=callback.custNm;
					}
					break;
			}
		}

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/
	async function calculateMonthlySumsByGr() {
		let data = orderPlanGrid.getFilteredData();
		const monthlySums = {
			'01': Array(12).fill(0),
			'02': Array(12).fill(0),
			'03': Array(12).fill(0),
			'04': Array(12).fill(0),
			'05': Array(12).fill(0),
		};

		const grTotals = {
			'01': 0,
			'02': 0,
			'03': 0,
			'04': 0,
			'05': 0
		};

		data.forEach(row => {
			for (let month = 1; month <= 12; month++) {
				const grKey = 'ordPlanGr'+month.toString().padStart(2, '0');
				const amtKey = 'ordPlanAmt'+month.toString().padStart(2, '0');
				const amount = parseFloat(row[amtKey]);

				if (!isNaN(amount)) {
					const grValue = row[grKey];
					const roundedAmount = Math.round(amount*100)/100;
					if (grValue in monthlySums) {
						monthlySums[grValue][month - 1] += roundedAmount;
						monthlySums['05'][month - 1] += roundedAmount; // 월별 합계 업데이트
						grTotals[grValue] += roundedAmount; // 등급별 합계 업데이트
					}
					if(grValue === '01'){
						orderPlanGrid.addCellClassName(row.rowKey,'ordPlanCustCd'+month.toString().padStart(2, '0'),'red');
						orderPlanGrid.addCellClassName(row.rowKey,'ordPlanAmt'+month.toString().padStart(2, '0'),'red');
						orderPlanGrid.addCellClassName(row.rowKey,'ordPlanGr'+month.toString().padStart(2, '0'),'red');
					}
				}
			}
		});

		/* grid summary 적용*/
		for (let month = 1; month <= 12; month++) {
			let html = '';
			for (let gr = 2; gr <= 4; gr++) {
				const grKey = gr.toString().padStart(2, '0');
				html += Math.round((monthlySums[grKey][month - 1])*100)/100+'<br>';
			}
			html += '<b style="color:royalblue">'+Math.round((monthlySums['01'][month - 1])*100)/100+'<b/><br>';
			html += '<b style="color:red"    >'+Math.round((monthlySums['05'][month - 1])*100)/100+'<b/><br>';
			orderPlanGrid.setSummaryColumnContent('ordPlanAmt'+month.toString().padStart(2,'0'),edsUtil.addComma(html));
		}

		/* 상단 총계 html 적용*/
		for (let gr = 1; gr <= 5; gr++) {
			const grKey = gr.toString().padStart(2, '0');
			/**************************
			* 등급별 수주현황 세팅 START
			 **************************/

			document.getElementById('gr'+grKey).innerText =edsUtil.addComma(Math.round(grTotals[grKey]*100)/100);

			/**************************
			 * 등급별 수주현황 세팅 END
			 **************************/
			/**************************************************
			 * 수주목표설정, 매출목표설정 값 세팅 세팅 START
			 **************************************************/

			var ordInp = 1;
			var salInp = 1;
			if(1<gr && gr<5){
				ordInp = parseInt(edsUtil.removeComma(document.getElementById('ordInp'+grKey).value))/100;
				salInp = parseInt(edsUtil.removeComma(document.getElementById('salInp'+grKey).value))/100;
				var ord = edsUtil.addComma(Math.round(grTotals[grKey]*100*ordInp)/100);
				var sal = edsUtil.addComma(Math.round(grTotals[grKey]*100*ordInp*salInp)/100);
				document.getElementById('ord'+grKey).innerText = ord;
				document.getElementById('sal'+grKey).innerText = sal;
			}else{
				document.getElementById('ord'+grKey).innerText = edsUtil.addComma(Math.round(grTotals[grKey]*100)/100);
				document.getElementById('sal'+grKey).innerText = edsUtil.addComma(Math.round(grTotals[grKey]*100)/100);
			}

			if(gr === 5){
				let grSum = 0;
				let ordSum = 0;
				let salSum = 0;
				for (let j = 1; j <= 4; j++) {
					const jKey = j.toString().padStart(2, '0');
					grSum += parseFloat(edsUtil.removeComma(document.getElementById('gr'+jKey).innerText));
					ordSum += parseFloat(edsUtil.removeComma(document.getElementById('ord'+jKey).innerText));
					salSum += parseFloat(edsUtil.removeComma(document.getElementById('sal'+jKey).innerText));
				}
				document.getElementById('gr05').innerText = edsUtil.addComma(Math.round(grSum*100)/100);
				document.getElementById('ord05').innerText = edsUtil.addComma(Math.round(ordSum*100)/100);
				document.getElementById('sal05').innerText = edsUtil.addComma(Math.round(salSum*100)/100);
			}
			/**************************************************
			 * 수주목표설정, 매출목표설정 값 세팅 세팅 END
			 **************************************************/
		}
		/**************************************************
		 * 지진해일 ～　공사　tot값 세팅 세팅 START
		 **************************************************/

		const itemTotals = {}; // Object to hold the sums for each ordPlanItem
		const itemOkTotals = {}; // Object to hold the sums for each ordPlanItem

		data.forEach(entry => {
			const item = entry.ordPlanItem; // Get the ordPlanItem value

			// Initialize sum for this item if not already done
			if (!itemTotals[item]) {
				itemTotals[item] = 0;
				itemOkTotals[item] = 0;
			}

			// Iterate through each ordPlanAmtXX and add to the sum
			for (let i = 1; i <= 12; i++) {
				const amtKey = 'ordPlanAmt'+i.toString().padStart(2, '0'); // Constructs the key like ordPlanAmt01, ordPlanAmt02, ...
				const grKey = 'ordPlanGr'+i.toString().padStart(2, '0'); // Constructs the key like ordPlanAmt01, ordPlanAmt02, ...
				const amtValue = parseFloat(entry[amtKey]); // Convert the amount to a number
				const grValue = entry[grKey]; // Convert the amount to a number

				if (!isNaN(amtValue)) { // Check if the value is a number
					itemTotals[item] += amtValue; // Add to the sum for this item
					if(grValue === '01'){
						itemOkTotals[item] += amtValue;
					}
				}
			}
		});

		for (let i = 1; i <= 10; i++) {
			const id = i.toString().padStart(2, '0'); // Constructs the key like ordPlanItem01, ordPlanItem02, ...
			const itemTot = Math.round((itemTotals[id]??0)*100)/100;
			const itemOkTot = Math.round((itemOkTotals[id]??0)*100)/100;
			const itemOkPer = await NaNToZero(((itemOkTot/itemTot)*100));
			const itemNm = ['지진해일','민방위','내진면진','스마트계측','침수차단','예경보','교부세','지진','기타','공사'];
			document.getElementById('ordPlanItem'+id).innerHTML =
					`<b style='color:red'>`+ itemOkTot+ `</b>`+
					`<b>/`+ itemTot+ `</b>`;
			document.getElementById('ordPlanItemNm'+id).innerHTML =
					`<b class='float-left'>`+ itemNm[i-1]+ `</b>`+
					`<b class='float-right' style='color:red'>(`+ Math.round(itemOkPer*100)/100+ `)</b>`;

		}

		/**************************************************
		 * 지진해일 ～　공사　tot값 세팅 세팅 END
		 **************************************************/
	}
	async function NaNToZero(x) {
		if (isNaN(x)) {
			return 0;
		}
		return x;
	}

	// 스크롤 위치 저장
	let scrollPosition = {
		x: 0,
		y: 0
	};

	async function saveBeforeScrollLocation() {
		scrollPosition.x = window.scrollX;
		scrollPosition.y = window.scrollY;
	}

	async function moveBeforeScrollLocation() {
		window.scrollTo(scrollPosition.x, scrollPosition.y);
	}

	async function topSetYearData(){
		var els = document.getElementsByName('topSetYear');
		var elsLength = els.length;
		var yyyy = moment(ordPlanSetDt.getDate()).format('YYYY');
		for (let i = 0; i < elsLength; i++) {
			els[i].innerText = yyyy;
		}
	}

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
</body>
</html>