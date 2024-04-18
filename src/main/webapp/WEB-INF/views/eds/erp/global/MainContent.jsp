<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/AdminLTE_main/plugins/select2/css/select2.min.css">
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<!-- overlayScrollbars -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
	<!-- iCheck for checkboxes and radio inputs -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/icheck-bootstrap/icheck-bootstrap.css">
	<!-- AdminLte -->
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<!-- Daterange picker -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/daterangepicker/daterangepicker.css">
	<!-- summernote -->
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/summernote/summernote-bs4.min.css">

	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button)
	</script>
	<!-- Bootstrap 4 -->
	<script src="/css/AdminLTE_main/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="/css/AdminLTE_main/plugins/chart.js/Chart.min.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="/css/AdminLTE_main/plugins/jquery-knob/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="/css/AdminLTE_main/plugins/moment/moment.min.js"></script>
	<script src="/css/AdminLTE_main/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script src="/css/AdminLTE_main/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->
	<script src="/css/AdminLTE_main/plugins/summernote/summernote-bs4.min.js"></script>
	<!-- overlayScrollbars -->
	<script src="/css/AdminLTE_main/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="/css/AdminLTE_main/dist/js/adminlte.js"></script>

	<style>
		.card:hover
		{
			box-shadow: 0 0 5px rgba(60,140,187, 0.5), 0 1px 3px rgba(0,0,0,.2);
		}
		.info-box.hoverBox:hover
		{
			box-shadow: 0 0 5px rgba(60,140,187, 0.5), 0 1px 3px rgba(0,0,0,.2);
		}
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
	<%@ include file="/WEB-INF/views/eds/erp/erpNotice/erpNoticePopView.jsp" %>
</head>

<!-- <body class="h-auto"style="min-height: calc(100% - 4.25rem);"> -->
<body class="h-auto">
<div style="position:relative">
	<section class="content" id="printid" style="">
		<div class="container-fluid">
			<div class="row pt-3">
				<div class="col-6 col-sm-3">
					<div class="small-box bg-lightblue">
						<div class="inner">
							<h3 id="longUnSubmit">0건</h3>

							<p>7일이상 지연된 결재</p>
						</div>
						<div class="icon">
							<i class="fa-solid fa-exclamation-triangle"></i>
						</div>
						<a onclick="sendHome('130')" href="#" class="small-box-footer">
							바로가기 <i class="fas fa-arrow-circle-right"></i>
						</a>
					</div>
				</div>

				<div class="col-6 col-sm-3">
					<div class="small-box bg-lightblue">
						<div class="inner">
							<h3 id="unSubmit">0건</h3>

							<p>확인하지 않은 결재요청</p>
						</div>
						<div class="icon">
							<i class="fa-solid fa-file-circle-exclamation"></i>
						</div>
						<a onclick="sendHome('130')" href="#" class="small-box-footer">
							바로가기 <i class="fas fa-arrow-circle-right"></i>
						</a>
					</div>
				</div>
				<div class="col-6 col-sm-3">
					<div class="small-box bg-lightblue">
						<div class="inner">
							<h3 id="unCc">0건</h3>
							<p>확인하지 않은 수신참조</p>
						</div>
						<div class="icon">
							<i class="fa-solid fa-file-circle-exclamation"></i>
						</div>
						<a onclick="sendHome('132')" href="#" class="small-box-footer">
							바로가기 <i class="fas fa-arrow-circle-right"></i>
						</a>
					</div>
				</div>
				<div class="col-6 col-sm-3">
					<div class="small-box bg-lightblue">
						<div class="inner">
							<h3 id="completeSubmit">0건</h3>

							<p>결재내역보기</p>
						</div>
						<div class="icon">
							<i class="fa-solid fa-file-circle-check"></i>
						</div>
						<a onclick="sendHome('134')" href="#" class="small-box-footer">
							바로가기 <i class="fas fa-arrow-circle-right"></i>
						</a>
					</div>
				</div>
			</div>
			<!-- /.row -->
			<!-- Main row -->
			<div class="row">
				<section class="col-lg-12" >
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">
								<i class="fas fa-chart-pie mr-1"></i>월별 매출
							</h3>
							<div class="card-tools">
								<button type="button" class="btn btn-tool" data-card-widget="collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<div class="d-flex">
								<p class="d-flex flex-column">
									<span>총 계약금액</span>
									<span class="text-bold text-lg" id ="allPlan">0</span>
								</p>
								<p class="d-flex flex-column pl-3">
									<span>총 매출금액</span>
									<span class="text-bold text-lg" id ="allSales">0</span>
								</p>
								<p class="ml-auto d-flex flex-column text-right">
										<span id="increasSales">
											
										</span>
									<span class="text-muted">작년동월대비</span>
								</p>
							</div>
							<div class="chart"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
								<canvas id="barChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%; display: block; width: 639px;" width="639" height="250" class="chartjs-render-monitor"></canvas>
							</div>
						</div>
					</div>

				</section>
				<section class="col-lg-6" id="globalListSection">
					<div class="card">
						<div class="card-header">
							<h1 class="card-title">
								<ul class="nav nav-pills ml-auto">
									<li class="nav-item">
										<a class="nav-link active" href="#globalList6" data-toggle="tab">
											<i class="ion ion-clipboard mr-1"></i>미수채권
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#globalList1" data-toggle="tab">
											<i class="ion ion-clipboard mr-1"></i>최근 세금계산서 발행
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#globalList2" data-toggle="tab">
											<i class="ion ion-clipboard mr-1"></i>최근 프로젝트 계약
										</a>
									</li>
								</ul>
							</h1>
							<div class="card-tools">
								<button type="button" class="btn btn-tool" data-card-widget="collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<div class="tab-content p-0">
								<div class="tab-pane active" style="height: 100%;" id="globalList6">
									<div id="globalList6DIV" style="width:100%; height:100%;"></div>
								</div>
								<div class="tab-pane" style="height: 100%;" id="globalList1">
									<div id="globalList1DIV" style="width:100%; height:100%;"></div>
								</div>
								<div class="tab-pane" style="height: 100%;" id="globalList2">
									<div id="globalList2DIV" style="width:100%; height:100%;"></div>
								</div>
							</div>
						</div>
					</div>
				</section>
				<section class="col-lg-6" id="globalListSection2">
					<div class="card">
						<div class="card-header">
							<h1 class="card-title">
								<ul class="nav nav-pills ml-auto">
									<li class="nav-item">
										<a class="nav-link active" href="#globalList3" data-toggle="tab">
											<i class="ion ion-clipboard mr-1"></i>납기 초과 대비 세금계산서 미발행
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#globalList4" data-toggle="tab">
											<i class="ion ion-clipboard mr-1"></i>납기 임박 프로젝트
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" href="#globalList5" data-toggle="tab">
											<i class="ion ion-clipboard mr-1"></i>외상 매입금
										</a>
									</li>
								</ul>
							</h1>
							<div class="card-tools">
								<button type="button" class="btn btn-tool" data-card-widget="collapse">
									<i class="fas fa-minus"></i>
								</button>
							</div>
						</div>
						<div class="card-body">
							<div class="tab-content p-0">
								<div class="tab-pane active" style="height: 100%;" id="globalList3">
									<div id="globalList3DIV" style="width:100%; height:100%;"></div>
								</div>
								<div class="tab-pane" style="height: 100%;" id="globalList4">
									<div id="globalList4DIV" style="width:100%; height:100%;"></div>
								</div>
								<div class="tab-pane" style="height: 100%;" id="globalList5">
									<div id="globalList5DIV" style="width:100%; height:100%;"></div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</section>
</div>
</body>
<script>
	var globalList1, globalList2, globalList3, globalList4, globalList5, globalList6;

	document.addEventListener('DOMContentLoaded', async function(){

		await initGrid();

		await doAction('globalList3','search');
		await doAction('globalList6','search');

		document.getElementById('globalListSection').addEventListener('click', async function(ev){
			var data = ev.target.href??'';
			if(data.includes('#globalList')){
				var divi = data.split('#');
				setTimeout(()=>{
					doAction(divi[1],'search');
				},100);
			}
		});
		document.getElementById('globalListSection2').addEventListener('click', async function(ev){
			var data = ev.target.href??'';
			if(data.includes('#globalList')){
				var divi = data.split('#');
				setTimeout(()=>{
					doAction(divi[1],'search');
				},100);
			}
		});

	});

	/* 초기설정 */
	async function initGrid() {
		/*********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		globalList1 = new tui.Grid({
			el: document.getElementById('globalList1DIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
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
				height: 28,
				position: 'bottom', // or 'top'
				align:'left',
				columnContent: {
					amt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		globalList1.setColumns([
			{ header:'발행일자',		name:'dt',			width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'내역',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'금액',			name:'amt',			width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
		]);
		globalList2 = new tui.Grid({
			el: document.getElementById('globalList2DIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
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
				height: 28,
				position: 'bottom', // or 'top'
				align:'left',
				columnContent: {
					amt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		globalList2.setColumns([
			{ header:'계약일자',		name:'dt',			width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'프로젝트명',	name:'projNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'금액',			name:'amt',			width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
		]);
		globalList3 = new tui.Grid({
			el: document.getElementById('globalList3DIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
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
				height: 28,
				position: 'bottom', // or 'top'
				align:'left',
				columnContent: {
					amt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		globalList3.setColumns([
			{ header:'납기일자',		name:'dt',			width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'프로젝트명',	name:'projNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'미발행액',		name:'amt',			width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
		]);
		globalList4 = new tui.Grid({
			el: document.getElementById('globalList4DIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
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
				height: 28,
				position: 'bottom', // or 'top'
				align:'left',
				columnContent: {
					amt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		globalList4.setColumns([
			{ header:'납기일자',		name:'dt',			width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'프로젝트명',	name:'projNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'미발행액',		name:'amt',			width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
		]);
		globalList5 = new tui.Grid({
			el: document.getElementById('globalList5DIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
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
				height: 28,
				position: 'bottom', // or 'top'
				align:'left',
				columnContent: {
					amt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		globalList5.setColumns([
			{ header:'발생일자',		name:'dt',			width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'계정과목',		name:'accountNm',	width:150,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'금액',			name:'amt',			width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
		]);
		globalList6 = new tui.Grid({
			el: document.getElementById('globalList6DIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum'],
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
				height: 28,
				position: 'bottom', // or 'top'
				align:'left',
				columnContent: {
					amt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
				}
			}
		});

		globalList6.setColumns([
			{ header:'거래일자',		name:'dt',			width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'거래처',		name:'custNm',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'내역',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'미수금액',		name:'amt',			width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
		]);
	}

	/**********************************************************************
	 * Grid Info 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * Grid set 영역 START
	 ***********************************************************************/

	/* 그리드생성 */
	document.getElementById('globalList1').style.height = (innerHeight)*(1-0.7) + 'px';
	document.getElementById('globalList2').style.height = (innerHeight)*(1-0.7) + 'px';
	document.getElementById('globalList3').style.height = (innerHeight)*(1-0.7) + 'px';
	document.getElementById('globalList4').style.height = (innerHeight)*(1-0.7) + 'px';
	document.getElementById('globalList5').style.height = (innerHeight)*(1-0.7) + 'px';
	document.getElementById('globalList6').style.height = (innerHeight)*(1-0.7) + 'px';

	/**********************************************************************
	 * Grid set 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'globalList1') {
			switch (sAction) {
				case "search":// 조회

					globalList1.refreshLayout(); // 데이터 초기화
					globalList1.finishEditing(); // 데이터 마감
					globalList1.clear(); // 데이터 초기화

					var param = {};

					param.stDt= moment().subtract(7,'d').format('YYYYMMDD');
					param.edDt= moment().format('YYYYMMDD');

					globalList1.resetData(edsUtil.getAjax("/eds/erp/global/recentTaxInvoiceIssuanceStatus", param)); // 데이터 set

					break;
			}
		}
		if (sheetNm == 'globalList2') {
			switch (sAction) {
				case "search":// 조회

					globalList2.refreshLayout(); // 데이터 초기화
					globalList2.finishEditing(); // 데이터 마감
					globalList2.clear(); // 데이터 초기화

					var param = {};

					param.stDt= moment().subtract(7,'d').format('YYYYMMDD');
					param.edDt= moment().format('YYYYMMDD');

					globalList2.resetData(edsUtil.getAjax("/eds/erp/global/recentProjectContractStatus", param)); // 데이터 set

					break;
			}
		}
		if (sheetNm == 'globalList3') {
			switch (sAction) {
				case "search":// 조회

					globalList3.refreshLayout(); // 데이터 초기화
					globalList3.finishEditing(); // 데이터 마감
					globalList3.clear(); // 데이터 초기화

					var param = {};


					globalList3.resetData(edsUtil.getAjax("/eds/erp/global/overdueDeliveryAndNonIssuanceOfTaxInvoice", param)); // 데이터 set

					break;
			}
		}
		if (sheetNm == 'globalList4') {
			switch (sAction) {
				case "search":// 조회

					globalList4.refreshLayout(); // 데이터 초기화
					globalList4.finishEditing(); // 데이터 마감
					globalList4.clear(); // 데이터 초기화

					var param = {};

					param.stDt= moment().subtract(7,'d').format('YYYYMMDD');
					param.edDt= moment().format('YYYYMMDD');

					globalList4.resetData(edsUtil.getAjax("/eds/erp/global/deliveryTermProjectStatus", param)); // 데이터 set

					break;
			}
		}
		if (sheetNm == 'globalList5') {
			switch (sAction) {
				case "search":// 조회

					globalList5.refreshLayout(); // 데이터 초기화
					globalList5.finishEditing(); // 데이터 마감
					globalList5.clear(); // 데이터 초기화

					var param = {};

					param.stDt= moment().subtract(7,'d').format('YYYYMMDD');
					param.edDt= moment().format('YYYYMMDD');

					// globalList5.resetData(edsUtil.getAjax("/eds/erp/global/collectionProjectStatus", param)); // 데이터 set

					break;
			}
		}
		if (sheetNm == 'globalList6') {
			switch (sAction) {
				case "search":// 조회

					globalList6.refreshLayout(); // 데이터 초기화
					globalList6.finishEditing(); // 데이터 마감
					globalList6.clear(); // 데이터 초기화

					var param = {};


					globalList6.resetData(edsUtil.getAjax("/eds/erp/global/longTermAttemptedBondStatus", param)); // 데이터 set

					break;
			}
		}
	}
</script>

<script>
	let select
	$(document).ready(function () {
		init();
	});
	/* 초기설정 */
	async function init() {

		/* 이벤트 셋팅 */
		selectHome();

		/* 그리드생성 */
		editChar()
		//selectMonthSales();

	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/




	/**********************************************************************
	 * 화면 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 START
	 ***********************************************************************/
	/** table 팝업창
	 * */
	async function popupHandler(name,divi,params,callback){
		var names = name.split('_');
		switch (names[0]) {
			case 'busi':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${loginInfo.corpCd}"/>';

					param.name= name;
					await edsIframe.openPopup('BUSIPOPUP',param)
				}else{
					document.getElementById('busiCd').value=callback.busiCd;
					document.getElementById('busiNm').value=callback.busiNm;
					const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					data.messageDivi='insert';
					document.getElementById("iframSubmit").contentWindow.postMessage(data);
				}
				break;
			case 'approver':{
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${loginInfo.corpCd}"/>';
					param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
					param.name= name;
					await edsIframe.openPopup('SUBMITUSERPOPUP',param)
				}else{
					addUser(callback,'approver');
				}
			}
				break;
			case 'ccUser':{
				if(divi==='open'){
					var param={}

					param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
					param.name= name;
					await edsIframe.openPopup('SUBMITUSERPOPUP',param)
				}else{
					addUser(callback,'ccUser');
				}
			}
				break;
			case 'edmsDoc':{
				if(divi==='open'){
					params.name= name;
					await edsIframe.openPopupEdms('EDMSDOCPOPUP',params)
				}else{

				}
			}
				break;
			case 'edmsTemp':{
				if(divi==='open'){
					params.name= name;
					await edsIframe.openPopupEdms('EDMSTEMPPOPUP',params)
				}else{

				}
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

	function selectMonthSales(dataParams ,nowdate)
	{
		let data=dataParams;
		let mon=[];
		let conTotAmt = [];
		let salTotAmt = [];
		let costTotAmt = [];
		let colTotAmt = [];
		let thisYear =new Date(nowdate);
		
		let pastYear=new Date(nowdate);
		pastYear.setFullYear(thisYear.getFullYear()-1);
		let yearTot=0;
		let pastTot=0;
		for(const row of data)
		{
			if(row.mon == null) continue;
			let monss=row.mon;
			let year=monss.substr(0,4);
			let monthnum=monss.substr(4,2);

			if(year==thisYear.getFullYear() && Number(monthnum) <= (thisYear.getMonth()+1))
			{
				yearTot+=Number(row.conTotAmt);
			}
			if(year==(pastYear.getFullYear()) && Number(monthnum) <= (pastYear.getMonth()+1))
			{
				pastTot+=Number(row.conTotAmt);
			}
			let month=monss.substr(4,2);
			// mon.push(row.mon);
			// conTotAmt.push(row.conTotAmt);
			// salTotAmt.push(row.salTotAmt);
			// costTotAmt.push(row.costTotAmt);
			// colTotAmt.push(row.colTotAmt);
		}
		let totvalue=((yearTot-pastTot)/pastTot *100).toFixed(2);
		let sales=document.getElementById('increasSales');
		totvalue>=0?sales.classList.add('text-success'):sales.classList.add('text-red');
		sales.innerHTML=totvalue>=0?'<i class="fas fa-arrow-up" ></i> '+totvalue+'%':'<i class="fas fa-arrow-down"></i> '+totvalue+'%';
		
	}

	async function editChar()
	{

		let param = {};
		param.corpCd='<c:out value="${LoginInfo.corpCd}"/>'
		let data=await edsUtil.getAjax("/eds/erp/global/selectMainSearch", param);
		let condata={"01":"","02":"","03":"","04":"","05":"","06":"","07":"","08":"","09":"","10":"","11":"","12":""};
		let saldata={"01":"","02":"","03":"","04":"","05":"","06":"","07":"","08":"","09":"","10":"","11":"","12":""};
		let costata={"01":"","02":"","03":"","04":"","05":"","06":"","07":"","08":"","09":"","10":"","11":"","12":""};
		let coldata={"01":"","02":"","03":"","04":"","05":"","06":"","07":"","08":"","09":"","10":"","11":"","12":""};
		let allPlan=0;
		let allSales=0;
		let dateYm=edsUtil.getToday('%Y-%m');
		let nowdate=dateYm.substr(0,4)
		selectMonthSales(data,dateYm)
		for(const row of data)
		{
			if(row.mon == null) continue;
			let monss=row.mon;
			let year=monss.substr(0,4);
			let month=monss.substr(4,2);
			const map = new Map();

			if(year==nowdate)
			{
				allPlan+=Number(row.conTotAmt);
				allSales+=Number(row.salTotAmt);
				condata[month]=row.conTotAmt.slice(0, -3);
				saldata[month]=row.salTotAmt.slice(0, -3);
				costata[month]=row.costTotAmt.slice(0, -3);
				coldata[month]=row.colTotAmt.slice(0, -3);
			}
		}
		document.getElementById('allPlan').innerHTML=allPlan.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원";
		document.getElementById('allSales').innerHTML=allSales.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원";
		var areaChartData = {
			labels  : ['1월', '2월', '3월', '4월','5월', '6월','7월', '8월','9월', '10월','11월', '12월'],
			datasets: [
				{
					label               : '신규계약금액',
					backgroundColor     : '#007bff',
					borderColor         : 'rgba(60,141,188,0.8)',
					pointRadius          : false,
					pointColor          : '#3b8bba',
					pointStrokeColor    : 'rgba(60,141,188,1)',
					pointHighlightFill  : '#fff',
					pointHighlightStroke: 'rgba(60,141,188,1)',
					data                : [condata["01"],condata["02"],condata["03"],condata["04"],condata["05"],condata["06"],condata["07"],condata["08"],condata["09"],condata["10"],condata["11"],condata["12"]]
				},
				{
					label               : '매입원가',
					backgroundColor     : '#ffc572',
					borderColor         : 'rgba(60,141,188,0.8)',
					pointRadius          : false,
					pointColor          : '#3b8bba',
					pointStrokeColor    : 'rgba(60,141,188,1)',
					pointHighlightFill  : '#fff',
					pointHighlightStroke: 'rgba(60,141,188,1)',
					data                : [costata["01"],costata["02"],costata["03"],costata["04"],costata["05"],costata["06"],costata["07"],costata["08"],costata["09"],costata["10"],costata["11"],costata["12"]]
				},
				{
					label               : '매출액',
					backgroundColor     : 'rgba(60,141,188,0.9)',
					borderColor         : 'rgba(60,141,188,0.8)',
					pointRadius          : false,
					pointColor          : '#3b8bba',
					pointStrokeColor    : 'rgba(60,141,188,1)',
					pointHighlightFill  : '#fff',
					pointHighlightStroke: 'rgba(60,141,188,1)',
					data                : [saldata["01"],saldata["02"],saldata["03"],saldata["04"],saldata["05"],saldata["06"],saldata["07"],saldata["08"],saldata["09"],saldata["10"],saldata["11"],saldata["12"]]
				},
				{
					label               : '수금액',
					backgroundColor     : 'rgba(210, 214, 222, 1)',
					borderColor         : 'rgba(210, 214, 222, 1)',
					pointRadius         : false,
					pointColor          : 'rgba(210, 214, 222, 1)',
					pointStrokeColor    : '#c1c7d1',
					pointHighlightFill  : '#fff',
					pointHighlightStroke: 'rgba(220,220,220,1)',
					data                : [coldata["01"],coldata["02"],coldata["03"],coldata["04"],coldata["05"],coldata["06"],coldata["07"],coldata["08"],coldata["09"],coldata["10"],coldata["11"],coldata["12"]]
				},
			]
		}


		//-------------
		//- BAR CHART -
		//-------------
		var barChartCanvas = $('#barChart').get(0).getContext('2d')
		var barChartData = $.extend(true, {}, areaChartData)
		var temp0 = areaChartData.datasets[0]
		var temp1 = areaChartData.datasets[1]
		var temp2 = areaChartData.datasets[2]
		var temp3 = areaChartData.datasets[3]

		barChartData.datasets[0] = temp0
		barChartData.datasets[1] = temp1
		barChartData.datasets[2] = temp2
		barChartData.datasets[3] = temp3

		var barChartOptions = {
			scales: {
				yAxes: [{// y축 콤마
					ticks: {
						beginAtZero: true,
						callback: function(value, index) {
							return value.toLocaleString("ko-KR")+ "천원";
						}
					}
				}]
			},
			responsive              : true,
			maintainAspectRatio     : false,
			datasetFill             : false,


			title: { // 이 축의 단위 또는 이름도 title 속성을 이용하여 표시할 수 있습니다.
				display: true,
				align: 'end',
				color: '#808080',
				font: {
					size: 12,
					weight: 300,
				},
				text: '단위: 천원'
			},
			tooltips: {
				callbacks: {
					label: function(tooltipItem, data) { //그래프 콤마
						return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "천원";
					}
				},

			},


		}

		new Chart(barChartCanvas, {
			type: 'bar',
			data: barChartData,
			options: barChartOptions
		})
	}
	async function selectHome()
	{
		var param ={}; //조회조건
		let data=edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectHomeList", param);
		for (const [key, value] of Object.entries(data[0])) {
			if(document.getElementById(key))document.getElementById(key).innerHTML = value+'건';
		}
	}
	function sendHome(id)
	{
		const data= {};
		data.messageDivi='home';//
		data.id=id;
		window.parent.postMessage(data);
	}


	// if(parent) {//부모 iframe 과통신
	// 	//수신 이벤트 발생
	// 	window.addEventListener("message", async function(message) {
	// 		console.log('message')
	// 	})}


	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
<script type="text/javascript" src='/js/com/eds.edms.js'></script>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>