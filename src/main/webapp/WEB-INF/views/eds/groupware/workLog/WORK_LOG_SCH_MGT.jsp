<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-workLog.jspf"%><%-- 공통 파일 --%>
	<script src="/chartjs/dist/chart.umd.js"></script>
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2/css/select2.min.css">
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
	<link rel="stylesheet" href="/css/AdminLTE_main/plugins/dropzone/min/dropzone.min.css" type="text/css" />


	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

	<style>
		body
		{
			overflow-anchor: none;
			-ms-overflow-style: none;
			touch-action: auto;
			-ms-touch-action: auto;
			background-color: #f8f9fa;
		}
		::-webkit-scrollbar {
			display: none;
		}
		/* 막대 그래프를 감싸는 div의 스타일 */
		.chart-container {
			width: 100%;
			max-width: 100%;
			position: relative;
			margin: auto;
		}
		/* 원형 그래프를 감싸는 div의 스타일 */
		.chart-container-pie {
			width: 100%;
			max-width: 100%;
			position: relative;
		}
		.chartCard {
			width: 100%;
			display: flex;
			align-items: center;
			justify-content: center;
		}
		.chartBox {
			width: 350px;
			/*padding: 20px;*/
			border-radius: 20px;
			background: white;
		}
		.myChart
		{
			width:250px
		}
		.chart-graph {
			width: auto;
			max-width: 100%;
			position: relative;
			margin: auto;
			height:400px;
		}
		.myGraph{
			width: 100%;
			height: 100%;
		}

		.alarmCard
		{
			border: 0 solid rgba(0,0,0,.125);
			background-clip: border-box;
			background-color: #eae9ec;
			border-radius: 0.5rem;
			margin: 0.5rem 0;
			width: unset;
			/* box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2); */
			box-shadow: 0 0 1px rgb(0 0 0 / 50%), 0 1px 3px rgb(0 0 0 / 30%);
		}
		.dropdown-item-title
		{
			margin: 0.25rem 0;
		}
		.dataDisplay {

			font-size: 16px;
			list-style-type: none;
			padding: 10px 5px;
		}
		.dataItem {
			display: flex;
			align-items: center;
			margin-bottom: 10px; /* 아이템 간격을 자연스럽게 조절 */
			border-bottom: 1px solid #ccc; /* 회색 선 추가 */
			padding-bottom: 5px; /* 선과 아이템 사이 간격 조절 */
		}
		.dataColor {
			width: 20px;
			height: 20px;
			margin-right: 10px;
			border-radius: 50%;
		}
		.dataLabel {
			font-weight: bold;
		}
		.tableBodys
		{
			text-align: center;
		}

	</style>
</head>

<body>
	<div>
		<nav class="navbar navbar-expand-sm navbar-whiht navbar-light bg-whiht fixed-top" id="navt">
			<a class="navbar-brand" href="#"><span>성과 대시보드:IMS</span></a>
			<select name="sh_year" id="sh_year" onchange="makeWeekSelectOptions();">
				<option value='2024'>2024년</option>
				<option value='2025'>2025년</option>
				<option value='2026'>2026년</option>
				<option value='2027'>2027년</option>

			</select>

			<select name="sh_month" id="sh_month" onchange="makeWeekSelectOptions(); init();">
				<option value='00'>전체</option>
				<option value='01'>01월</option>
				<option value='02'>02월</option>
				<option value='03'>03월</option>
				<option value='04'>04월</option>
				<option value='05'>05월</option>
				<option value='06'>06월</option>
				<option value='07'>07월</option>
				<option value='08'>08월</option>
				<option value='09'>09월</option>
				<option value='10'>10월</option>
				<option value='11'>11월</option>
				<option value='12'>12월</option>
			</select>

			<select name="sh_week" id="sh_week" onchange="init();">
			</select>

			<select name="depaCd" id="depaCd" onchange="init();">
				<option value>전체</option>
				<option value='1012'>사회재난팀</option>
				<option value='1008'>자연재난1팀</option>
				<option value='1009'>자연재난2팀</option>
			</select>

			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#tebs" aria-controls="#tebs" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="tebs">
				<ul class="navbar-nav mr-auto">
					<!-- <li class="nav-item active">
    	              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
    	            </li>-->
				</ul>
				<form class="form-inline">
					<div class="input-group">
						<div class="float-right ml-auto">
							<div class="container">
<%--								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSearch" id="btnSearch"  onclick="btnEvent('approve')"><i class="fa fa-solid fa-share"></i> 승인</button>--%>
<%--								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSearch" id="btnDecline" onclick="btnEvent('decline')"><i class="fa fa-solid fa-share"></i> 반려</button>--%>
<%--								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnSearch" id="btnCheck"   onclick="btnEvent('over')"   ><i class="fa fa-solid fa-share"></i> 검토</button>--%>
<%--								<button type="button" class="btn btn-sm btn-primary mr-1" name="btnClose" id="btnClose"    onclick="btnEvent('close')"><i class="fa fa-close"></i> 닫기</button>--%>

<%--								<div class="input-group-append">--%>
<%--									<input type="search" class="form-control" id="planNmSearch" placeholder="이름,팀명 검색..">--%>
<%--									<button type="button" class="btn btn-default" onclick="doAction('planGridList', 'search')"><i class="fa fa-search"></i></button>--%>
<%--								</div>--%>
							</div>

						</div>
					</div>
				</form>
			</div>
		</nav>
		<section class="content" style="margin-top:4.25rem" >
			<div class="container-fluid" >
				<div class="row" >
					<div class="col-lg-12">
						<div class="row">
							<div class="col-sm-2 col-6">
								<div class="card description-block">
									<span class="description-percentage text-success" id="mon-per"><i class="fas fa-caret-up"></i> </span>
									<h5 class="description-header" id="mon-count" style="font-size: 1.6rem;"></h5>
									<span class="description-text" id="mon-name">월점검현황</span>
								</div>
							</div>
							<div class="col-sm-2 col-6">
								<div class="card description-block">
									<span class="description-percentage text-warning" id="qua-per"><i class="fas fa-caret-left"></i></span>
									<h5 class="description-header" id="qua-count" style="font-size: 1.6rem;"></h5>
									<span class="description-text" id="qua-name">분기점검현황</span>
								</div>
							</div>
							<div class="col-sm-2 col-6">
								<div class="card description-block">
									<span class="description-percentage text-success" id="user-per"><i class="fas fa-caret-up"></i></span>
									<h5 class="description-header" id="user-count"></h5>
									<span class="description-text" id="user-name">최고월점검기여</span>
								</div>
							</div>
							<div class="col-sm-2 col-6">
								<div class="card description-block">
									<span class="description-percentage text-danger" id="quaUser-per" ><i class="fas fa-caret-up"></i></span>
									<h5 class="description-header" id="quaUser-count"></h5>
									<span class="description-text" id="quaUser-name">최고분기점검기여</span>
								</div>
							</div>
							<div class="col-sm-2 col-6">
								<div class="card description-block">
									<span class="description-percentage text-danger" id="err-per"><i class="fas fa-caret-up"></i></span>
									<h5 class="description-header" style="font-size: 1.6rem;" id="err-count"></h5>
									<span class="description-text" id="err-name">미결장애건</span>
								</div>
							</div>
							<div class="col-sm-2 col-6">
								<div class="card description-block">
									<span class="description-percentage text-danger" id="comerr-per"><i class="fas fa-caret-up"></i> </span>
									<h5 class="description-header" style="font-size: 1.6rem;" id="comerr-count"></h5>
									<span class="description-text" id="comerr-name">장애해결건수</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xl-8">
						<div class="card" style="min-height:300px">
							<div class="card-header border-0 pb-0">
								<h3 class="card-title text-bold">팀별 점검률</h3>
							</div>
							<div class="card-body p-0 d-flex">
								<div class="row w-100 m-auto">
									<div class="col-xl-12">
										<div class="chart-container" id="chart-container_all">
											<canvas  class="myChart" id="myChart_all" width="200" height="200" ></canvas>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-4">
						<div class="row" id="dataDisplay_all">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xl-4 flex-row">
						<div class="card" style="min-height:370px">
							<div class="card-header border-0 pb-0">
								<h3 class="card-title text-bold">개인점검률</h3>
							</div>
							<div class="card-body p-0">
								<div class="row">
									<div class="col-md-8">
										<div class="chartCard">
											<div class="chartBox" id="chart-container_mon">
												<canvas id="myChart_mon" ></canvas>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="overflow-auto" style="height: 300px">
											<ul class='dataDisplay' id="dataDisplay_mon"></ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 flex-row">
<%--						<div class="card" style="min-height:370px">--%>
<%--							<div class="card-header border-0 pb-0">--%>
<%--								<h3 class="card-title text-bold">개인분기점검률</h3>--%>
<%--							</div>--%>
<%--							<div class="card-body p-0">--%>
<%--								<div class="row">--%>
<%--									<div class="col-md-8">--%>
<%--										<div class="chartCard">--%>
<%--											<div class="chartBox" id="chart-container_qua">--%>
<%--												<canvas id="myChart_qua" ></canvas>--%>
<%--											</div>--%>
<%--										</div>--%>
<%--									</div>--%>
<%--									<div class="col-md-4">--%>
<%--										<div class="overflow-auto" style="height: 300px">--%>
<%--											<ul class='dataDisplay' id="dataDisplay_qua"></ul>--%>
<%--										</div>--%>
<%--									</div>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
							<div class="card" style="min-height:370px">
								<div class="card-header border-0 pb-0">
									<h3 class="card-title text-bold">미점검지자체</h3>
								</div>
								<div class="card-body p-0">
									<div class="row">
										<div class="col-md-8">
											<div class="chartCard">
												<div class="chartBox" id="chart-container_qua">
													<canvas id="myChart_qua" ></canvas>
												</div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="overflow-auto" style="height: 300px">
												<ul class='dataDisplay' id="dataDisplay_qua"></ul>
											</div>
										</div>
									</div>
								</div>
							</div>
					</div>
					<div class="col-xl-4">
						<div class="card">
							<div class="card-header border-0 pb-0">
								<h3 class="card-title">미점검내역</h3>
							<div class="card-body table-responsive pt-0 scroll overflow-auto shadow-none" style="height:340px">
								<table class="table table-hover table-head-fixed table-valign-middle" style="">
									<thead class="tableTitle">
									<tr>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 100px;width: 20%;">부서</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 40px;width: 20%;">사이트</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 40px; width: 20%;">지자체</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 40px; width: 20%;">구분</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 120px; width: 20%;">일자</th>
									</tr>
									</thead>
									<tbody  class="tableBodys" id="tableBodyIns">
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				</div>
				<div class="row">
					<div class="col-xl-5 flex-row">
						<div class="card" style="min-height:370px">
							<div class="card-header border-0 pb-0">
								<h3 class="card-title text-bold">장애현황</h3>
							</div>
							<div class="card-body p-0">
								<div class="row">
									<div class="col-md-8">
										<div class="chartCard">
											<div class="chartBox" id="chart-container_err">
												<canvas id="myChart_err" ></canvas>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="overflow-auto" style="height: 300px">
											<ul class='dataDisplay' id="dataDisplay_err"></ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-7">
						<div class="card">
							<div class="card-header border-0 pb-0">
								<h3 class="card-title text-bold">미결장애내역</h3>
							</div>
							<div class="card-body table-responsive pt-0 scroll overflow-auto shadow-none" style="height:340px">
								<table class="table table-hover table-head-fixed table-valign-middle" id="tableBodytd" style="">
									<thead class="tableTitle">
									<tr>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 100px;width: 20%;">부서</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 40px;width: 20%;">사이트</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 40px; width: 20%;">지자체</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 40px; width: 20%;">구분</th>
										<th class="shadow-none" style="text-align:center;vertical-align:middle;min-width: 120px; width: 20%;">일자</th>
									</tr>
									</thead>
									<tbody  class="tableBodys" id="tableBody">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
</html>
<script>
	Chart.register(ChartDataLabels);
	let range_1;
	let doingPlanGridListFocusIndex = 0;
	let combinedChart;
	let myChart_mon;
	let myChart_all;
	let myChart_qua;

	let myChart_err;
	const colorErr=[
	'#669999',
	'#CC6666',
	'#99CC66',
	'#666699',
	'#996699',
	'#CCCC66',
	'#669966',
	'#996666',
	'#6699CC',
	'#996633'];
	const colorQua=['#4169E1', '#483D8B', '#696969', '#8B4513', '#2F4F4F', '#778899', '#A52A2A', '#2F4F4F', '#2F4F4F', '#4682B4', '#483D8B', '#556B2F', '#800080', '#696969', '#000080', '#FF4500', '#000080', '#8B4513', '#708090', '#FFFF00'];
	const colorLabel=[
		"rgba(76, 175, 80, 0.8)",   // Emerald Green
		"rgba(25, 118, 210, 0.8)",  // Royal Blue
		"rgba(255, 193, 7, 0.8)",   // Golden Yellow
		"rgba(156, 39, 176, 0.8)",  // Amethyst Purple
		"rgba(244, 67, 54, 0.8)",   // Ruby Red
		"rgba(96, 125, 139, 0.8)",  // Slate Gray
		"rgba(233, 30, 99, 0.8)",   // Fuchsia Pink
		"rgba(63, 81, 181, 0.8)",   // Indigo Blue
		"rgba(255, 235, 59, 0.8)",  // Lemon Yellow
		"rgba(117, 117, 117, 0.8)", // Steel Gray
		"rgba(0, 188, 212, 0.8)",   // Aqua Blue
		"rgba(255, 152, 0, 0.8)",   // Bright Orange
		"rgba(121, 85, 72, 0.8)",   // Mocha Brown
		"rgba(142, 36, 170, 0.8)",  // Rich Purple
		"rgba(255, 82, 82, 0.8)",   // Coral Red
		"rgba(139, 195, 74, 0.8)",  // Lime Green
		"rgba(255, 64, 129, 0.8)",  // Magenta Pink
		"rgba(3, 169, 244, 0.8)",   // Light Blue
		"rgba(255, 179, 0, 0.8)",   // Amber Yellow
		"rgba(139, 195, 74, 0.8)"   // Lime Green
	];
	const colorLabel1=[
		"rgba(25, 118, 210, 0.8)",  // Royal Blue
	];
	const colorLabel2=[
		"#007bff",  // Slate Gray
	];
	const colorLabel3=[
		"#ced4da"  // Amethyst Purple
	];
	const colorLabel4=[
		"rgba(96, 125, 139, 0.8)#ced4da"
	];

	$(document).ready(async function () {

		/*************************************
		 * main range_1 set START
		 * **********************************/
		/* ION SLIDER */
		range_1 = $('#range_1');
		range_1.ionRangeSlider({
			min: 0,
			max: 100,
			from: 0,
			step: 1,            // default 1 (set step)
			grid: false,         // default false (enable grid)
			grid_num: 10,        // default 4 (set number of grid cells)
			grid_snap: false,    // default false (snap grid to step)
			from_fixed: true,  // fix position of FROM handle
			to_fixed: true     // fix position of TO handle
		});
		/*************************************
		 * main range_1 set END
		 * **********************************/

		/*************************************
		 * grid fn set START
		 * **********************************/
		const currentDate = new Date();
		const currentMonth = ("0" + (currentDate.getMonth() + 1)).slice(-2); // 현재 월을 가져옵니다.
		document.getElementById('sh_month').value = currentMonth; // 현재 월에 해당하는 옵션을 선택합니다.
		makeWeekSelectOptions()

		await init();
		const table = document.getElementById('tableBody');

		table.addEventListener('click', function(event) {
			const targetTr = event.target.closest('tr'); // 클릭한 tr 요소를 찾습니다.
			if (targetTr) {
				setTimeout(()=>{
					let nextTr = targetTr.nextElementSibling; // 다음 tr 요소를 가져옵니다.
					if (nextTr) {
						targetTr.scrollIntoView({ behavior: 'smooth', block: 'start'});
					}
				}, 600);

			}
		});
		const tableIns = document.getElementById('tableBodyIns');

		tableIns.addEventListener('click', function(event) {
			const targetTr = event.target.closest('tr'); // 클릭한 tr 요소를 찾습니다.
			if (targetTr) {
				setTimeout(()=>{
					let nextTr = targetTr.nextElementSibling; // 다음 tr 요소를 가져옵니다.
					if (nextTr) {
						targetTr.scrollIntoView({ behavior: 'smooth', block: 'start'});
					}
				}, 600);

			}
		});


		/*************************************
		 * grid fn set END
		 * **********************************/

		/*************************************
		 * bootstrap select2 set START
		 * **********************************/

		/*생성자 생성*/
		$('.selectpicker').select2({
			language: 'ko'
		});

		/* selectpicker change ev set */
		$('.selectpicker').on("select2:select", function (e) {
			var targetId = e.target.id;
			var targetValue = e.target.value;
			var multilpeBoolean = e.target.multiple;
			// 복수 select 일때
			if(multilpeBoolean){
				var option = $(e.params.data.element); // option el 객체 가져오기
				option.detach(); // 자동 append된거 삭제
				$(this).append(option); // 가져온 option el 다시 순서에 맞게 넣기
				$(this).trigger("change"); // 적용시기키
			}
			// 단일 select 일때
			else{
				switch (targetId) {
					case 'insertPlanModalParePlanCd' : // 신규입력 모달창에서 상위 목표 선택시 목표경로 처리
						var data = edsUtil.getAjaxJson('/WORK_LOG/getPlanCdRoot',{planCd:targetValue})
						if(data.planCdRoot === '' || data.planCdRoot === null ){ // 최상위 일때
							document.getElementById('insertPlanModalPlanCdRoot').value = data.planCd;
						}else{ // 최상위 아닐때
							document.getElementById('insertPlanModalPlanCdRoot').value = data.planCdRoot + ',' + data.planCd;
						}
						break;
					case 'insertPlanModalEmpCd' :
						$('#insertPlanModalDepaCd').val(e.target.selectedOptions[0].attributes.depaCd.value).trigger('change');
						$('#insertPlanModalBusiCd').val(e.target.selectedOptions[0].attributes.busiCd.value).trigger('change');
						break;
					case 'detailPlanModalEmpCd' :
						$('#detailPlanModalDepaCd').val(e.target.selectedOptions[0].attributes.depaCd.value).trigger('change');
						$('#detailPlanModalBusiCd').val(e.target.selectedOptions[0].attributes.busiCd.value).trigger('change');
						break;
					case 'insertKeyResultModalEmpCd' :
						$('#insertKeyResultModalDepaCd').val(e.target.selectedOptions[0].attributes.depaCd.value).trigger('change');
						$('#insertKeyResultModalBusiCd').val(e.target.selectedOptions[0].attributes.busiCd.value).trigger('change');
						break;
				}
			}
		});

		/*************************************
		 * bootstrap select2 set END
		 * **********************************/


	});

	/* 초기설정 */
	async function init() {
		//yearGraph();
		await setMonthGraph();
		await setErrGraph();
		//await selectInspection();

	}
	// 사용 예시: sendMessageToKakaoWork 함수 호출하여 메시지 전송
	//sendMessageToKakaoWork('안녕하세요, 카카오워크 봇으로부터의 메시지입니다!');
	function yearGraph() {
		// 데이터 준비
		var combinedCtx = document.getElementById('combinedChart').getContext('2d');
		const months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
		const data = [65, 59, 80, 81, 56, 55, 40, 78, 90, 81, 56, 75];
		// 이전에 그려진 차트 제거
		if (combinedChart) {
			combinedChart.data= {
				labels: months,
				datasets: [{
					label: '막대 그래프',
					data: [6125, 59, 802, 813, 526, 55, 40, 78, 90, 81, 56, 75],
					type: 'line',
					borderColor: 'rgb(75, 192, 192)',
					fill: true,
					yAxisID: 'y-axis-1'
				}, {
					label: '막대 그래프',
					data: data,
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					yAxisID: 'y-axis-1'
				}]
			};
		}
		else
		{
			// 선 그래프와 막대 그래프 생성
			combinedChart = new Chart(combinedCtx, {
				type: 'bar',
				data: {
					labels: months,
					datasets: [{
						label: '막대 그래프',
						data: data,
						type: 'line',
						borderColor: 'rgb(75, 192, 192)',
						fill: true,
						yAxisID: 'y-axis-1'
					}, {
						label: '막대 그래프',
						data: data,
						backgroundColor: 'rgba(255, 99, 132, 0.2)',
						yAxisID: 'y-axis-1'
					}]
				},

				options: {

				}
			});


		}
		combinedChart.update();


	}
	/* 초기날짜설정 */
	function makeWeekSelectOptions() {
		var year = $("#sh_year").val();
		var month = $("#sh_month").val();

		var today = new Date();

		var sdate = new Date(year, month-1, 01);
		var lastDay = (new Date(sdate.getFullYear(), sdate.getMonth()+1, 0)).getDate();
		var endDate = new Date(sdate.getFullYear(), sdate.getMonth(), lastDay);

		var week = sdate.getDay();

		sdate.setDate(sdate.getDate() - week + 1);
		var edate = new Date(sdate.getFullYear(), sdate.getMonth(), sdate.getDate());

		var obj = document.getElementById("sh_week");
		obj.options.length = 0;
		var seled = "";
		var i=0;
		while(endDate.getTime() >= edate.getTime()) {
			if(i==0){obj.options[obj.options.length] = new Option("전체",'')}//전체
			i++;
			var sYear = sdate.getFullYear();
			var sMonth = (sdate.getMonth()+1);
			var sDay = sdate.getDate();

			sMonth = (sMonth < 10) ? "0"+sMonth : sMonth;
			sDay = (sDay < 10) ? "0"+sDay : sDay;

			var stxt = sYear + "-" + sMonth + "-" + sDay;

			edate.setDate(sdate.getDate() + 6);

			var eYear = edate.getFullYear();
			var eMonth = (edate.getMonth()+1);
			var eDay = edate.getDate();

			eMonth = (eMonth < 10) ? "0"+eMonth : eMonth;
			eDay = (eDay < 10) ? "0"+eDay : eDay;

			var etxt = eYear + "-" + eMonth + "-" + eDay;

			if(today.getTime() >= sdate.getTime() && today.getTime() <= edate.getTime()) {
				seled = stxt+"|"+etxt;
			}

			obj.options[obj.options.length] = new Option(stxt+"~"+etxt+"  "+i+"주차", stxt+"|"+etxt);

			sdate = new Date(edate.getFullYear(), edate.getMonth(), edate.getDate() + 1);
			edate = new Date(sdate.getFullYear(), sdate.getMonth(), sdate.getDate());
		}

		if(seled) obj.value = seled;
	}
	/* 초기날짜설정 끝*/
	async function setMonthGraph()
	{
		let param = {};
		param.corpCd = ${LoginInfo.corpCd};
		param.depaCd = document.getElementById('depaCd').value
		param.busiCd = "${LoginInfo.busiCd}";
		let data = await selectInspection(param);
		let paramDate=document.getElementById('sh_week').value;
		let stDt='';
		let edDt='';
		if(paramDate)
		{
			let date =paramDate.split('|')
			stDt= date[0];
			edDt= date[1];
		}
		// siteNm 별로 전체 데이터 개수와 'y'인 데이터 개수를 계산
		var countsMonTotal = {};
		var countsQuaTotal = {};
		var countsMon = {};
		var countsQua = {};
        var lastCountsMon = {};
        var lastCountsQua = {};
		var userTotal={};
		var userCountsMon = {};
		var userCountsQua = {};
		var userLastCountsMon = {};
		var userLastCountsQua = {};
		var userCountTotal = {};
		let depaCdList=[];
		let inpIdList=[];
		let notInpCountTotal = {};
		data.forEach(function(item) {
			depaCdList.includes(item.depaCd) ? null :depaCdList.push(item.depaCd);//부서 코드더하기
			if(item.month>12)
			{countsQuaTotal[item.depaNm] = (countsQuaTotal[item.depaNm] || 0) + 1;}
			else
			{countsMonTotal[item.depaNm] = (countsMonTotal[item.depaNm] || 0) + 1;}

			if (item.inspectDivi === 'Y') {
				userTotal[item.inpId] = (userTotal[item.inpId] || 0) + 1;
				inpIdList.includes(item.inpId) ? null :inpIdList.push(item.inpId);//부서 코드더하기
				if(paramDate)
				{
					if(isDateInRange(item.inspectDt,stDt,edDt))
					{
						if(item.month>12)
						{countsQua[item.depaNm] = (countsQua[item.depaNm] || 0) + 1;
							userCountsQua[item.inpId] = (userCountsQua[item.inpId] || 0) + 1;}
						else
						{countsMon[item.depaNm] = (countsMon[item.depaNm] || 0) + 1;
							userCountsMon[item.inpId] = (userCountsMon[item.inpId] || 0) + 1;
						}
						userCountTotal[item.inpId] = (userCountTotal[item.inpId] || 0) + 1
					}
                    if(lastDateInRange(item.inspectDt,stDt,edDt))
                    {
                        if(item.month>12)
                        {lastCountsQua[item.depaNm] = (lastCountsQua[item.depaNm] || 0) + 1;
							userLastCountsQua[item.inpId] = (userLastCountsQua[item.inpId] || 0) + 1;}
                        else
                        {lastCountsMon[item.depaNm] = (lastCountsMon[item.depaNm] || 0) + 1;
							userLastCountsMon[item.inpId] = (userLastCountsMon[item.inpId] || 0) + 1;}
                    }


				}
				else
				{
					if(item.month>12)
					{lastCountsQua[item.depaNm] = (lastCountsQua[item.depaNm] || 0) + 1;
						userCountsQua[item.inpId] = (userCountsQua[item.inpId] || 0) + 1;}
					else
					{lastCountsMon[item.depaNm] = (lastCountsMon[item.depaNm] || 0) + 1;
						userCountsMon[item.inpId] = (userCountsMon[item.inpId] || 0) + 1;}
					userCountTotal[item.inpId] = (userCountTotal[item.inpId] || 0) + 1
				}

			}
			else
			{
				notInpCountTotal[item.ad] = (notInpCountTotal[item.ad] || 0) + 1;
			}
		});
		resetInspectGraph(countsMonTotal,countsQuaTotal,countsMon,countsQua,lastCountsMon,lastCountsQua,depaCdList)
		resetUserInsGraph(userCountTotal,userLastCountsMon,userTotal)
		//resetUserQuaGraph(userCountsQua,userLastCountsQua,userTotal)
		resetFailGraph(notInpCountTotal)
		setInspectTag(countsMonTotal,countsQuaTotal,countsMon,countsQua,lastCountsMon,lastCountsQua)

		setInspectUserTag();

	}
	async function resetInspectGraph(countsMonTotal,countsQuaTotal,countsMon,countsQua,lastCountsMon,lastCountsQua,depaCdList)
	{
		// 점검 건수를 저장할 객체
		var labels = [];
		var dataValues = [];//팀별 월점검 카운트
		var dataLastWeekVal=[];//팀별 전주월점검 카운트
		var dataQuaValues = [];//팀별 월점검 카운트
		var dataQuaLastWeekVal=[];//팀별 전주월점검 카운트
		Object.keys(countsMonTotal).forEach(function(key) {
			labels.push(key); // siteNm을 라벨로 추가
			var monTotal = countsMonTotal[key] || 0;
			var monCount = countsMon[key] || 0;
			var monRatio = monTotal === 0 ? 0 : ((monCount / monTotal) * 100).toFixed(2);
			var quaTotal = countsQuaTotal[key] || 0;
			var quaCount = countsQua[key] || 0;
			var quaRatio = quaTotal === 0 ? 0 : ((quaCount / quaTotal) * 100).toFixed(2);
			var lastMonCount = lastCountsMon[key] || 0;
			var lastMonRatio = monTotal === 0 ? 0 : ((lastMonCount / monTotal) * 100).toFixed(2);
			var lastQuaCount = lastCountsQua[key] || 0;
			var lastQuaRatio = quaTotal === 0 ? 0 : ((lastQuaCount / quaTotal) * 100).toFixed(2);
			dataValues.push(monRatio); // 금주 월점검 %
			dataQuaValues.push(quaRatio); // 금주 분기점검 %
			dataLastWeekVal.push(lastMonRatio);
			dataQuaLastWeekVal.push(lastQuaRatio)
		});
		var ctx = document.getElementById('myChart_all').getContext('2d');
		// 이전에 그려진 차트 제거
		if (myChart_all)
		{
			myChart_all.data={
				labels: labels,
				datasets: [{
					label:'누적 월간점검률',
					barThickness: 'flex',
					maxBarThickness: 30,
					data: dataLastWeekVal,
					stack: 'Stack 0',
					borderWidth: 1,
					backgroundColor:colorLabel1,
					depaCd:depaCdList
				},{
					label:'금주 월간점검률',
					barThickness: 'flex',
					maxBarThickness: 30,
					data: dataValues,
					stack: 'Stack 0',
					borderWidth: 1,
					backgroundColor:colorLabel2,
					depaCd:depaCdList
				},{
					label:'누적 분기점검률',
					barThickness: 'flex',
					maxBarThickness: 30,
					data: dataQuaLastWeekVal,
					stack: 'Stack 1',
					borderWidth: 1,
					backgroundColor:colorLabel3,
					depaCd:depaCdList
				},{
					label:'금주 분기점검률',
					barThickness: 'flex',
					maxBarThickness: 30,
					data: dataQuaValues,
					stack: 'Stack 1',
					borderWidth: 1,
					backgroundColor:colorLabel4,
					depaCd:depaCdList
				}]
			};
		}
		else{
			myChart_all = new Chart(ctx, {
				type: 'bar',
				data: {
					labels: labels,
					datasets: [{
						label: '누적 월간점검률',
						barThickness: 'flex',
						maxBarThickness: 50,
						data: dataLastWeekVal,
						stack: 'Stack 0',
						borderWidth: 1,
						backgroundColor:colorLabel1,
						depaCd:depaCdList
					},{
						label:'금주 월간점검률',
						barThickness: 'flex',
						maxBarThickness: 30,
						data: dataValues,
						stack: 'Stack 0',
						borderWidth: 1,
						backgroundColor:colorLabel2,
						depaCd:depaCdList

					},{
						label:'누적 분기점검률',
						barThickness: 'flex',
						maxBarThickness: 30,
						data: dataQuaLastWeekVal,
						stack: 'Stack 1',
						borderWidth: 1,
						backgroundColor:colorLabel3,
						depaCd:depaCdList
					},{
						label:'금주 분기점검률',
						barThickness: 'flex',
						maxBarThickness: 30,
						data: dataQuaValues,
						stack: 'Stack 1',
						borderWidth: 1,
						backgroundColor:colorLabel4,
						depaCd:depaCdList
					}]
				},
				options: {
					responsive: true,
					maintainAspectRatio:false,
					indexAxis: 'y',
					scales: {
						y: {
							stacked: true,
							beginAtZero: true,
							ticks: {
								stepSize: 1 // Adjust as needed
							}
						},
						x: {
							stacked: true,
							title: {
								display: true,
								text: '점검율'
							},
							min: 0, // 최소값
							max: 100 // 최대값

						}
					},
					plugins: {
						tooltip: {
							callbacks: {
								label: function (tooltipItem) {
									var depaNm = tooltipItem.label;
									var name=tooltipItem.dataset.label;
									var percentage = tooltipItem.formattedValue;
									if(tooltipItem.datasetIndex=='2' )
									{
										name=getGroup()+"분기 누적 점검율";
									}
									if(tooltipItem.datasetIndex=='3')
									{
										name=getGroup()+"분기 금주 점검율";
									}
									return name + ':' + percentage + '%'; // 마우스 호버 시 'siteNm 비율' 형식으로 표시
								}
							}
						},
						datalabels: {
							display: function(context) {
								//return Number(context.dataset.data[context.dataIndex]) !== 0 && context.dataset.data[context.dataIndex] !== null && context.dataset.data[context.dataIndex] !== undefined;
								return false
							},
							labels: {
								title: {
									color: 'white'
								}
							}
						},
						legend: {
							position: 'right', // 레전드를 오른쪽에 표시
							display: false, // 레전드 표시

						},
					},
					animation: {
						onComplete: function(animation) {
							var chartInstance = animation.chart;
							var ctx = chartInstance.ctx;
							ctx.textAlign = 'center';
							ctx.textBaseline = 'middle';
							ctx.font = "24px Arial";
							var dataIsAllZero = chartInstance.config.data.datasets[0].data.every(value => value === 0);
							if (dataIsAllZero) {
								var centerX = (chartInstance.chartArea.left + chartInstance.chartArea.right) / 2;
								var centerY = (chartInstance.chartArea.top + chartInstance.chartArea.bottom) / 2;
								ctx.fillText('No data', centerX, centerY);
							}
						}
					},
					onClick: async function(event, elements) {
						if (elements.length > 0) {
							var clickedElementIndex = elements[0].index;
							var clickedDatasetIndex = elements[0].datasetIndex;
							let paramClick = {};
							var label = myChart_all.data.labels[clickedElementIndex];
							var value = myChart_all.data.datasets[clickedDatasetIndex].depaCd[clickedElementIndex];
							paramClick.corpCd = ${LoginInfo.corpCd};
							paramClick.depaCd = value;
							paramClick.busiCd = "${LoginInfo.busiCd}";
							var data= await selectInspection(paramClick);
							let paramDate=document.getElementById('sh_week').value;
							let stDt='';
							let edDt='';
							if(paramDate)
							{
								let date =paramDate.split('|')
								stDt= date[0];
								edDt= date[1];
							}
							// siteNm 별로 전체 데이터 개수와 'y'인 데이터 개수를 계산
							var countsMonTotal = {};
							var countsQuaTotal = {};
							var countsMon = {};
							var countsQua = {};
							var lastCountsMon = {};
							var lastCountsQua = {};
							var userTotal={};
							var userCountsMon = {};
							var userCountsQua = {};
							var userLastCountsMon = {};
							var userLastCountsQua = {};
							let depaCdList=[];
							let inpIdList=[];
							data.forEach(function(item) {
								depaCdList.includes(item.depaCd) ? null :depaCdList.push(item.depaCd);//부서 코드더하기


								if(item.month>12)
								{countsQuaTotal[item.depaNm] = (countsQuaTotal[item.depaNm] || 0) + 1;}
								else
								{countsMonTotal[item.depaNm] = (countsMonTotal[item.depaNm] || 0) + 1;}

								if (item.inspectDivi === 'Y') {
									userTotal[item.inpId] = (userTotal[item.inpId] || 0) + 1;
									inpIdList.includes(item.inpId) ? null :inpIdList.push(item.inpId);//부서 코드더하기
									if(paramDate)
									{
										if(isDateInRange(item.inspectDt,stDt,edDt))
										{
											if(item.month>12)
											{countsQua[item.depaNm] = (countsQua[item.depaNm] || 0) + 1;
												userCountsQua[item.inpId] = (userCountsQua[item.inpId] || 0) + 1;}
											else
											{countsMon[item.depaNm] = (countsMon[item.depaNm] || 0) + 1;
												userCountsMon[item.inpId] = (userCountsMon[item.inpId] || 0) + 1;}
										}
										if(lastDateInRange(item.inspectDt,stDt,edDt))
										{
											if(item.month>12)
											{lastCountsQua[item.depaNm] = (lastCountsQua[item.depaNm] || 0) + 1;
												userLastCountsQua[item.inpId] = (userLastCountsQua[item.inpId] || 0) + 1;}
											else
											{lastCountsMon[item.depaNm] = (lastCountsMon[item.depaNm] || 0) + 1;
												userLastCountsMon[item.inpId] = (userLastCountsMon[item.inpId] || 0) + 1;}
										}


									}
									else
									{
										if(item.month>12)
										{countsQua[item.depaNm] = (countsQua[item.depaNm] || 0) + 1;
											userCountsQua[item.inpId] = (userCountsQua[item.inpId] || 0) + 1;}
										else
										{countsMon[item.depaNm] = (countsMon[item.depaNm] || 0) + 1;
											userCountsMon[item.inpId] = (userCountsMon[item.inpId] || 0) + 1;}
									}

								}
							});
							resetUserInsGraph(userCountsMon,userCountsQua,userLastCountsMon,userLastCountsQua,userTotal)
							//alert(label + ": " + value + "개소");
						}
					}
				}
			});
		}
		//데이터 표시 엘리먼트 업데이트
		var dataDisplay = document.getElementById('dataDisplay_all');
		dataDisplay.innerHTML='';
		var dataValues = myChart_all.data.datasets[0].data;
		var dataSum = dataValues.reduce(function(a, b) { return a + b; }, 0);
		labels.forEach(function(label, index) {
			var colDiv = document.createElement('div');
			colDiv.classList.add('col-lg-12');
			var listItem = document.createElement('div');
			var listItemQua = document.createElement('div');
			var text = document.createElement('div');
			var colorBox = document.createElement('div');
			//colorBox.classList.add('dataColor');
			//colorBox.classList.add('TEST');
			//colorBox.style.backgroundColor = myChart_all.data.datasets[1].backgroundColor[index];
			var countVal=(countsMon[label] || 0) +(lastCountsMon[label] || 0);
			var totalVal=(countsMonTotal[label] || 0);
			var labelText = document.createElement('span');
			labelText.classList.add('dataLabel');
			labelText.innerHTML = "월 점검 : "+countVal+" / " + totalVal + "개소 (" +  ((!isNaN(countVal / totalVal) ?(countVal / totalVal):0) * 100).toFixed(2) + "%)" ;
			var parcentIcon=Number(myChart_all.data.datasets[1].data[index]) > 0 ?`<span class="description-percentage text-success"> `+(myChart_all.data.datasets[1].data[index])+`<i class="fas fa-caret-up"></i>`:`<span class="description-percentage text-warning"> `+(myChart_all.data.datasets[1].data[index])+`<i class="fas fa-caret-left"></i>`
			labelText.innerHTML +=parcentIcon+`%</span> (<span class="text-bold">`+(countsMon[label] || 0)+"개소)</span>";
			var countQuaVal=(countsQua[label] || 0) + +(lastCountsQua[label] || 0);
			var totalQuaVal=(countsQuaTotal[label] || 0);
			var labelQuaText = document.createElement('span');
			labelQuaText.classList.add('dataLabel');
			labelQuaText.innerHTML = "분기 점검 : "+countQuaVal+" / " + totalQuaVal + "개소 (" +  ((!isNaN(countQuaVal / totalQuaVal)?(countQuaVal / totalQuaVal):0) * 100).toFixed(2) + "%)";
			var parcentIcon2=Number(myChart_all.data.datasets[3].data[index]) > 0 ?`<span class="description-percentage text-success"> `+(myChart_all.data.datasets[3].data[index])+`<i class="fas fa-caret-up"></i>`:`<span class="description-percentage text-warning"> `+(myChart_all.data.datasets[3].data[index])+`<i class="fas fa-caret-left"></i>`
			labelQuaText.innerHTML +=parcentIcon2+`%</span> (`+(countsQua[label] || 0)+"개소)";
			//text.appendChild(colorBox);
			text.innerHTML += label;
			text.classList.add("text-bold");
			text.classList.add("text-lg");
			listItem.appendChild(labelText);
			listItemQua.appendChild(labelQuaText);
			var cardiv = document.createElement('div');
			cardiv.classList.add('card');
			cardiv.classList.add('bg-gradient');
			cardiv.style.height='calc(105px - 1rem)';

			var carBody = document.createElement('div');
			carBody.classList.add('card-body');
			carBody.style.padding='1rem'
			carBody.appendChild(text);
			carBody.appendChild(listItem);
			carBody.appendChild(listItemQua);
			cardiv.appendChild(carBody)
			colDiv.appendChild(cardiv)

			dataDisplay.appendChild(colDiv);
		});
		myChart_all.update();
	}
	async function resetUserInsGraph(userCountsMon,userLastCountsMon,userTotal)
	{
		console.log(userCountsMon)
		// 점검 건수를 저장할 객체
		var labels = [];
		var dataValues = [];//팀별 월점검 카운트
		var dataLastWeekVal=[];//팀별 전주월점검 카운트
		Object.keys(userTotal).forEach(function(key) {
			labels.push(key); // siteNm을 라벨로 추가
			var monCount = userCountsMon[key] || 0;
			var lastMonCount = userLastCountsMon[key] || 0;
			dataValues.push(monCount); // 금주 월점검 %
			dataLastWeekVal.push(lastMonCount);
		});
		// pieLabelsLine plugin
		const pieLabelsLine = {
			id: "pieLabelsLine",
			afterDraw(chart) {
				const {
					ctx,
					chartArea: { width, height },
				} = chart;

				const cx = chart._metasets[0].data[0].x;
				const cy = chart._metasets[0].data[0].y;
				const sum = chart.data.datasets[0].data.reduce((a, b) => a + b, 0);

				chart.data.datasets.forEach((dataset, i) => {
					chart.getDatasetMeta(i).data.forEach((datapoint, index) => {
						var tet=chart.data.datasets[0].data[index];
						if(tet>0){
							//const { x, y } = datapoint.tooltipPosition();
						const { x: a, y: b } = datapoint.tooltipPosition();

						const x = 2 * a - cx;
						const y = 2 * b - cy;
						// draw line
						const halfwidth = (width) / 2;
						const halfheight = (height) / 2;
						const xLine = x >= (halfwidth+15) ? x + 10 : x - 10;
						const yLine = y >= (halfheight+15) ? y + 10 : y - 10;

						const extraLine = x >= halfwidth+15 ? 0 : -0;

						ctx.beginPath();
						ctx.moveTo(x, y);
						ctx.arc(x, y, 2, 0, 2 * Math.PI, true);
						ctx.fill();
						ctx.moveTo(x, y);
						ctx.lineTo(xLine, yLine);
						ctx.lineTo(xLine + extraLine, yLine);
						ctx.strokeStyle = dataset.backgroundColor[index];
						//ctx.strokeStyle = "black";
						ctx.stroke();


						// text
						const textWidth = ctx.measureText(chart.data.labels[index]).width;
						ctx.font = "12px Arial";
						// control the position
						const textXPosition = x >= halfwidth+15 ? "left" : "right";
						const plusFivePx = x >= halfwidth+15 ? 5 : -5;
						ctx.textAlign = textXPosition;
						ctx.textBaseline = "middle";
						// ctx.fillStyle = dataset.backgroundColor[index];
						ctx.fillStyle = "black";

						ctx.fillText(
								chart.data.labels[index]+((chart.data.datasets[0].data[index] * 100) / sum).toFixed(2) +
								"%",
								xLine + extraLine + plusFivePx,
								yLine
						);}
					});
				});
			},
		};
		var ctx = document.getElementById('myChart_mon').getContext('2d');
		if(myChart_mon)
		{
			myChart_mon.data={
				labels: labels,
				datasets: [{
					label: 'test',
					data: dataValues,
					borderWidth: 1,
					backgroundColor:colorLabel,
				}]
			}
		}
		else
		{
			myChart_mon = new Chart(ctx, {
				type: 'pie',
				data: {
					labels: labels,
					datasets: [{
						label: '# of Votes',
						data: dataValues,
						borderWidth: 1,
						backgroundColor:colorLabel,
					}]
				},
				options: {
					maintainAspectRatio: false,
					layout: {
						padding: 60,
					},
					scales: {
						y: {
							display: false,
							beginAtZero: true,
							ticks: {
								display: false,
							},
							grid: {
								display: false,
							},
						},
						x: {
							display: false,
							ticks: {
								display: false,
							},
							grid: {
								display: false,
							},
						},
					},
					plugins: {
						legend: {
							display: false,
						},
						datalabels: {
							color: '#000',
							display: false,
							align: 'center',
							formatter: (value, ctx) => {
								let sum = 0;
								let dataArr = ctx.chart.data.datasets[0].data;
								dataArr.map(data => {
									sum += data;
								});
								if (value > 0) {
									let percentage = ctx.chart.data.labels[ctx.dataIndex] + "\n" + value + "개소\n" + (value * 100 / sum).toFixed(2) + "%";
									return percentage;
								} else {
									return null
								}
							}
						},
					},
					animation: {
						onComplete: function(animation) {
							var chartInstance = animation.chart;
							var ctx = chartInstance.ctx;
							ctx.textAlign = 'center';
							ctx.textBaseline = 'middle';
							ctx.font = "24px Arial";
							var dataIsAllZero = chartInstance.config.data.datasets[0].data.every(value => value === 0);
							if (dataIsAllZero) {
								var centerX = (chartInstance.chartArea.left + chartInstance.chartArea.right) / 2;
								var centerY = (chartInstance.chartArea.top + chartInstance.chartArea.bottom) / 2;
								ctx.fillText('No data', centerX, centerY);
							}
						}
					},

				},
				plugins: [pieLabelsLine],


			});
		}


		// 데이터 표시 엘리먼트 업데이트
		var dataDisplay = document.getElementById('dataDisplay_mon');
		dataDisplay.innerHTML='';
		var dataLabels = myChart_mon.data.labels;
		var dataValues = myChart_mon.data.datasets[0].data;
		var dataSum = dataValues.reduce(function(a, b) { return a + b; }, 0);
		dataLabels.forEach(function(label, index) {
			var listItem = document.createElement('li');
			listItem.classList.add('dataItem');

			var colorBox = document.createElement('div');
			colorBox.classList.add('dataColor');
			colorBox.style.backgroundColor = myChart_mon.data.datasets[0].backgroundColor[index];

			var labelText = document.createElement('span');
			labelText.classList.add('dataLabel');
			labelText.textContent = dataLabels[index] + ":" + dataValues[index] + "개소 (" + ((!isNaN(dataValues[index] / dataSum) ?(dataValues[index] / dataSum) :0)* 100).toFixed(2) + "%)";
			listItem.appendChild(colorBox);
			listItem.appendChild(labelText);

			dataDisplay.appendChild(listItem);
		});
		myChart_mon.update();
	}
	async function resetUserQuaGraph(userCountsQua,userLastCountsQua,userTotal)
	{
		// 점검 건수를 저장할 객체
		var labels = [];
		var dataQuaValues = [];//팀별 분기점검 카운트
		var dataQuaLastWeekVal=[];//팀별 전주분기점검 카운트
		Object.keys(userTotal).forEach(function(key) {
			labels.push(key); // siteNm을 라벨로 추가
			var quaCount = userCountsQua[key] || 0;
			var lastQuaCount = userLastCountsQua[key] || 0;
			dataQuaValues.push(quaCount); // 금주 분기점검 %
			dataQuaLastWeekVal.push(lastQuaCount)
		});
		// pieLabelsLine plugin
		const pieLabelsLine = {
			id: "pieLabelsLine",
			afterDraw(chart) {
				const {
					ctx,
					chartArea: { width, height },
				} = chart;

				const cx = chart._metasets[0].data[0].x;
				const cy = chart._metasets[0].data[0].y;
				const sum = chart.data.datasets[0].data.reduce((a, b) => a + b, 0);

				chart.data.datasets.forEach((dataset, i) => {
					chart.getDatasetMeta(i).data.forEach((datapoint, index) => {
						var tet=chart.data.datasets[0].data[index];
						if(tet>0){
							//const { x, y } = datapoint.tooltipPosition();
							const { x: a, y: b } = datapoint.tooltipPosition();

							const x = 2 * a - cx;
							const y = 2 * b - cy;
							// draw line
							const halfwidth = (width) / 2;
							const halfheight = (height) / 2;
							const xLine = x >= (halfwidth+15) ? x + 10 : x - 10;
							const yLine = y >= (halfheight+15) ? y + 10 : y - 10;

							const extraLine = x >= halfwidth+15 ? 5 : -5;

							ctx.beginPath();
							ctx.moveTo(x, y);
							ctx.arc(x, y, 2, 0, 2 * Math.PI, true);
							ctx.fill();
							ctx.moveTo(x, y);
							ctx.lineTo(xLine, yLine);
							ctx.lineTo(xLine + extraLine, yLine);
							ctx.strokeStyle = dataset.backgroundColor[index];
							//ctx.strokeStyle = "black";
							ctx.stroke();


							// text
							const textWidth = ctx.measureText(chart.data.labels[index]).width;
							ctx.font = "12px Arial";
							// control the position
							const textXPosition = x >= halfwidth+15 ? "left" : "right";
							const plusFivePx = x >= halfwidth+15 ? 5 : -5;
							ctx.textAlign = textXPosition;
							ctx.textBaseline = "middle";
							// ctx.fillStyle = dataset.backgroundColor[index];
							ctx.fillStyle = "black";

							ctx.fillText(
									chart.data.labels[index]+((chart.data.datasets[0].data[index] * 100) / sum).toFixed(2) +
									"%",
									xLine + extraLine + plusFivePx,
									yLine
							);}
					});
				});
			},
		};
		var ctx = document.getElementById('myChart_qua').getContext('2d');
		if(myChart_qua)
		{
			myChart_qua.data={
				labels: labels,
				datasets: [{
					label: 'test',
					data: dataQuaValues,
					borderWidth: 1,
					backgroundColor:colorQua,
				}]
			}
		}
		else
		{
			myChart_qua = new Chart(ctx, {
				type: 'pie',
				data: {
					labels: labels,
					datasets: [{
						label: '# of Votes',
						data: dataQuaValues,
						borderWidth: 1,
						backgroundColor:colorQua,
					}]
				},
				options: {
					maintainAspectRatio: false,
					layout: {
						padding: 60,
					},
					scales: {
						y: {
							display: false,
							beginAtZero: true,
							ticks: {
								display: false,
							},
							grid: {
								display: false,
							},
						},
						x: {
							display: false,
							ticks: {
								display: false,
							},
							grid: {
								display: false,
							},
						},
					},
					plugins: {
						legend: {
							display: false,
						},
						datalabels: {
							color: '#000',
							display: false,
							align: 'center',
							offset: 10,
							formatter: (value, ctx) => {
								let sum = 0;
								let dataArr = ctx.chart.data.datasets[0].data;
								dataArr.map(data => {
									sum += data;
								});
								if (value > 0) {
									let percentage = ctx.chart.data.labels[ctx.dataIndex] + "\n" + value + "개소\n" + (value * 100 / sum).toFixed(2) + "%";
									return percentage;
								} else {
									return null
								}
							}
						},
					},
					animation: {
						onComplete: function(animation) {
							var chartInstance = animation.chart;
							var ctx = chartInstance.ctx;
							ctx.textAlign = 'center';
							ctx.textBaseline = 'middle';
							ctx.font = "24px Arial";
							var dataIsAllZero = chartInstance.config.data.datasets[0].data.every(value => value === 0);
							if (dataIsAllZero) {
								var centerX = (chartInstance.chartArea.left + chartInstance.chartArea.right) / 2;
								var centerY = (chartInstance.chartArea.top + chartInstance.chartArea.bottom) / 2;
								ctx.fillText('No data', centerX, centerY);
							}
						}
					}

				},
				plugins: [pieLabelsLine],


			});
		}


		// 데이터 표시 엘리먼트 업데이트
		var dataDisplay = document.getElementById('dataDisplay_qua');
		dataDisplay.innerHTML='';
		var dataLabels = myChart_qua.data.labels;
		var dataValues = myChart_qua.data.datasets[0].data;
		var dataSum = dataValues.reduce(function(a, b) { return a + b; }, 0);
		dataLabels.forEach(function(label, index) {
			var listItem = document.createElement('li');
			listItem.classList.add('dataItem');

			var colorBox = document.createElement('div');
			colorBox.classList.add('dataColor');
			colorBox.style.backgroundColor = myChart_qua.data.datasets[0].backgroundColor[index];

			var labelText = document.createElement('span');
			labelText.classList.add('dataLabel');
			labelText.textContent = dataLabels[index] + ":" + dataValues[index] + "개소 (" + ((!isNaN(dataValues[index] / dataSum) ?(dataValues[index] / dataSum) :0)* 100).toFixed(2) + "%)";
			listItem.appendChild(colorBox);
			listItem.appendChild(labelText);

			dataDisplay.appendChild(listItem);
		});
		myChart_qua.update();
	}
	async function resetFailGraph(notInpCountTotal)
	{
		// 점검 건수를 저장할 객체
		let adNm=getCommCode('SYS010');
		var labels = [];
		var adkeys = [];
		var dataNotInpValues = [];//사이트별카운트
		Object.keys(notInpCountTotal).forEach(function(key) {
			labels.push(adNm[key]); // siteNm을 라벨로 추가
			adkeys.push(key);
			var notInpCount = notInpCountTotal[key] || 0;
			dataNotInpValues.push(notInpCount); // 금주 분기점검 %
		});

		const pieLabelsLine = {
			id: "pieLabelsLine",
			afterDraw(chart) {
				const {
					ctx,
					chartArea: { left, top, right, bottom, width, height },
				} = chart;

				// Calculate the center of the chart considering padding
				const cx = (left + right) / 2;
				const cy = (top + bottom) / 2;

				chart.data.datasets.forEach((dataset, i) => {
					chart.getDatasetMeta(i).data.forEach((datapoint, index) => {
						var tet=chart.data.datasets[0].data[index];
						if(tet > 0) {
							//const { x, y } = datapoint.tooltipPosition();
							const { x: a, y: b } = datapoint.tooltipPosition();

							const x = 2 * a - cx;
							const y = 2 * b - cy;

							// draw line
							ctx.beginPath();
							ctx.moveTo(x, y);
							ctx.arc(x, y, 2, 0, 2 * Math.PI, true);
							ctx.fill();
							ctx.moveTo(x, y);

							// Calculate the endpoint coordinates outside the chart
							const angle = Math.atan2(y - cy, x - cx);
							const xLine = x + 25 * Math.cos(angle);
							const yLine = y + 25 * Math.sin(angle);

							ctx.lineTo(xLine, yLine); // 직선의 끝점을 데이터 포인트에서 바깥쪽으로 25픽셀 이동한 지점으로 설정
							ctx.strokeStyle = dataset.backgroundColor[index];
							//ctx.strokeStyle = "black";
							ctx.stroke();

							// text
							const textWidth = ctx.measureText(chart.data.labels[index]).width;
							ctx.font = "12px Arial";
							// control the position
							const textXPosition = xLine >= cx ? xLine + 5 : xLine - 5 - textWidth; // 선의 끝점을 기준으로 텍스트 위치 조정
							const textYPosition = yLine >= cy ? yLine + 5 : yLine - 5;
							ctx.textAlign = "left"; // 텍스트를 항상 왼쪽에 위치시킴
							ctx.textBaseline = "middle";
							// ctx.fillStyle = dataset.backgroundColor[index];
							ctx.fillStyle = "black";

							ctx.fillText(
									chart.data.labels[index],
									textXPosition,
									textYPosition
							);
						}
					});
				});
			},
		};
		var ctx = document.getElementById('myChart_qua').getContext('2d');
		if(myChart_qua)
		{
			myChart_qua.data={
				labels: labels,
				datasets: [{
					label: '미점검 개소:',
					data: dataNotInpValues,
					borderWidth: 1,
					backgroundColor:colorQua,
					adkeys:adkeys,
				}]
			}
		}
		else
		{
			myChart_qua = new Chart(ctx, {
				type: 'pie',
				data: {
					labels: labels,
					datasets: [{
						label: '미점검 개소:',
						data: dataNotInpValues,
						borderWidth: 1,
						backgroundColor:colorQua,
						adkeys:adkeys
					}]
				},
				options: {
					maintainAspectRatio: false,
					layout: {
						padding: 60,
					},
					scales: {
						y: {
							display: false,
							beginAtZero: true,
							ticks: {
								display: false,
							},
							grid: {
								display: false,
							},
						},
						x: {
							display: false,
							ticks: {
								display: false,
							},
							grid: {
								display: false,
							},
						},
					},
					plugins: {
						legend: {
							display: false,
						},
						datalabels: {
							color: '#000',
							display: false,
							align: 'center',
							offset: 10,
							formatter: (value, ctx) => {
								let sum = 0;
								let dataArr = ctx.chart.data.datasets[0].data;
								dataArr.map(data => {
									sum += data;
								});
								if (value > 0) {
									let percentage = ctx.chart.data.labels[ctx.dataIndex] + "\n" + value + "개소\n" + (value * 100 / sum).toFixed(2) + "%";
									return percentage;
								} else {
									return null
								}
							}
						},
					},
					animation: {
						onComplete: function(animation) {
							var chartInstance = animation.chart;
							var ctx = chartInstance.ctx;
							ctx.textAlign = 'center';
							ctx.textBaseline = 'middle';
							ctx.font = "24px Arial";
							var dataIsAllZero = chartInstance.config.data.datasets[0].data.every(value => value === 0);
							if (dataIsAllZero) {
								var centerX = (chartInstance.chartArea.left + chartInstance.chartArea.right) / 2;
								var centerY = (chartInstance.chartArea.top + chartInstance.chartArea.bottom) / 2;
								ctx.fillText('No data', centerX, centerY);
							}
						}
					},
					onClick: async function(event, elements) {
						if (elements.length > 0) {
							var clickedElementIndex = elements[0].index;
							var clickedDatasetIndex = elements[0].datasetIndex;
							let paramClick = {};
							var label = myChart_qua.data.labels[clickedElementIndex];
							var value = document.getElementById('depaCd').value;
							paramClick.corpCd = ${LoginInfo.corpCd};
							paramClick.depaCd = value;
							paramClick.busiCd = "${LoginInfo.busiCd}";
							paramClick.ad =myChart_qua.data.datasets[0].adkeys[clickedElementIndex];
							var data= await selectInspection(paramClick);
							//alert(label + ": " + value + "개소");
						}
					}

				},
				plugins: [pieLabelsLine],


			});
		}


		// 데이터 표시 엘리먼트 업데이트
		var dataDisplay = document.getElementById('dataDisplay_qua');
		dataDisplay.innerHTML='';
		var dataLabels = myChart_qua.data.labels;
		var dataValues = myChart_qua.data.datasets[0].data;
		var dataSum = dataValues.reduce(function(a, b) { return a + b; }, 0);
		dataLabels.forEach(function(label, index) {
			var listItem = document.createElement('li');
			listItem.classList.add('dataItem');

			var colorBox = document.createElement('div');
			colorBox.classList.add('dataColor');
			colorBox.style.backgroundColor = myChart_qua.data.datasets[0].backgroundColor[index];

			var labelText = document.createElement('span');
			labelText.classList.add('dataLabel');
			labelText.textContent = dataLabels[index] + ":" + dataValues[index] + "개소";
			listItem.appendChild(colorBox);
			listItem.appendChild(labelText);

			dataDisplay.appendChild(listItem);
		});
		myChart_qua.update();
	}
	async function setErrGraph()
	{

		let paramDate=document.getElementById('sh_week').value;
		let stDt='';
		let edDt='';
		if(paramDate)
		{
			let date =paramDate.split('|')
			stDt= date[0];
			edDt= date[1];
		}
		else
		{
			var month=document.getElementById('sh_month').value;
			var year=document.getElementById('sh_year').value;;
			stDt=year+'-'+month+'-01';
			edDt=year+'-'+month+'-31';
		}
		let param = {};
		// var param = {};
		param.corpCd = ${LoginInfo.corpCd};
		param.depaCd = document.getElementById('depaCd').value;
		param.busiCd = "${LoginInfo.busiCd}";

		let errCountTag=document.getElementById('err-count')
		let comErrCountTag=document.getElementById('comerr-count')
		let data = await selectErr(param);
		// 장애 건수를 저장할 객체
		var disabilitiesCount = {};
		var comCount = {};
		var lastComCount={};
		let depaCdList=[];
		console.log(stDt)
		// 데이터 처리: 각 지역별로 장애 건수 카운트
		let ad= getCommCode("SYS010");//부서
		data.forEach(function(item) {
			depaCdList.includes(item.depaCd) ? null :depaCdList.push(item.depaCd);//부서 코드더하기
			if (item.progressDivi === '01')
			{
				disabilitiesCount[item.depaNm] = (disabilitiesCount[item.depaNm] || 0) + 1
			}
			else
			{
				if(paramDate)
				{

					if(isDateInRange(item.completionDt,stDt,edDt))
					{
						comCount[item.depaNm] = (comCount[item.depaNm] || 0) + 1;
					}
					if(lastDateInRange(item.completionDt,stDt,edDt))
					{
						lastComCount[item.depaNm] = (lastComCount[item.depaNm] || 0) + 1;
					}


				}
				else if(stDt!=='')
				{
					console.log(stDt)
					if(isDateInRange(item.completionDt,stDt,edDt))
					{
						comCount[item.depaNm] = (comCount[item.depaNm] || 0) + 1;
					}
				}
				else
				{
					comCount[item.depaNm] = (comCount[item.depaNm] || 0) + 1;
				}

			}

		});
		// 그래프 데이터 준비
		var labels = Object.keys(disabilitiesCount); // 부서명명
		var dataValues = Object.values(disabilitiesCount); // 장애 건수
		var comValues = Object.values(comCount); // 장애 건수
		let sum1 = dataValues.reduce((acc, cur) => {
			return acc + cur;
		}, 0);
		let sumCom = comValues.reduce((acc, cur) => {
			return acc + cur;
		}, 0);
		errCountTag.innerHTML=sum1;
		comErrCountTag.innerHTML=sumCom;
		const pieLabelsLine = {
			id: "pieLabelsLine",
			afterDraw(chart) {
				const {
					ctx,
					chartArea: { width, height },
				} = chart;

				const cx = chart._metasets[0].data[0].x;
				const cy = chart._metasets[0].data[0].y;

				const sum = chart.data.datasets[0].data.reduce((a, b) => a + b, 0);

				chart.data.datasets.forEach((dataset, i) => {
					chart.getDatasetMeta(i).data.forEach((datapoint, index) => {
						var tet=chart.data.datasets[0].data[index];
						if(tet>0){
							const { x: a, y: b } = datapoint.tooltipPosition();

							const x = 2 * a - cx;
							const y = 2 * b - cy;

							// draw line
							const halfwidth = width / 2;
							const halfheight = height / 2;
							const xLine = x >= halfwidth ? x + 5 : x - 5;
							const yLine = y >= halfheight ? y + 20 : y - 20;

							const extraLine = x >= halfwidth ? 10 : -10;

							ctx.beginPath();
							ctx.moveTo(x, y);
							ctx.arc(x, y, 2, 0, 2 * Math.PI, true);
							ctx.fill();
							ctx.moveTo(x, y);
							ctx.lineTo(xLine, yLine);
							ctx.lineTo(xLine + extraLine, yLine);
							// ctx.strokeStyle = dataset.backgroundColor[index];
							ctx.strokeStyle = "black";
							ctx.stroke();


							// text
							const textWidth = ctx.measureText(chart.data.labels[index]).width;
							ctx.font = "12px Arial";
							// control the position
							const textXPosition = x >= halfwidth ? "left" : "right";
							const plusFivePx = x >= halfwidth ? 5 : -5;
							ctx.textAlign = textXPosition;
							ctx.textBaseline = "middle";
							// ctx.fillStyle = dataset.backgroundColor[index];
							ctx.fillStyle = "black";

							ctx.fillText(
									((chart.data.datasets[0].data[index] * 100) / sum).toFixed(2) +
									"%",
									xLine + extraLine + plusFivePx,
									yLine
							);}
					});
				});
			},
		};
		var backColor=randomColor(labels.length);
		var ctx = document.getElementById('myChart_err').getContext('2d');
		// 이전에 그려진 차트 제거
		if (myChart_err) {
			myChart_err.data={
				labels: labels,
				datasets:[{
					label: '',
					data: dataValues,
					depaCd:depaCdList,
					backgroundColor: colorErr,
					// borderColor: [
					// 	'rgba(255, 99, 132, 1)',
					// 	'rgba(54, 162, 235, 1)',
					// 	'rgba(255, 206, 86, 1)',
					//
					// ],
					borderWidth: 1
				}]
			}
		}
		else
		{

		myChart_err = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: labels,
				datasets: [{
					label: '# of Votes',
					data: dataValues,
					depaCd:depaCdList,
					backgroundColor: colorErr,
					// borderColor: [
					// 	'rgba(255, 99, 132, 1)',
					// 	'rgba(54, 162, 235, 1)',
					// 	'rgba(255, 206, 86, 1)',
					//
					// ],
					borderWidth: 1,
					datalabels: {
						formatter: (value, ctx) => {
							let sum = 0;
							let dataArr = ctx.chart.data.datasets[0].data;
							dataArr.map(data => {
								sum += data;
							});
							let percentage =ctx.chart.data.labels[ctx.dataIndex]+"\n"+value+"개소\n"+(value * 100 / sum).toFixed(2) + "%";
							return percentage;
						}
					}
				}]
			},
			options: {
				maintainAspectRatio: false,
				layout: {
					padding: 40,
				},
				scales: {
					y: {
						display: false,
						beginAtZero: true,
						ticks: {
							display: false,
						},
						grid: {
							display: false,
						},
					},
					x: {
						display: false,
						ticks: {
							display: false,
						},
						grid: {
							display: false,
						},
					},
				},
				plugins: {
					legend: {
						display: false,
					},
					datalabels: {
						color: '#fff',
						display: 'auto',
						formatter: (value, ctx) => {
							let sum = 0;
							let dataArr = ctx.chart.data.datasets[0].data;
							dataArr.map(data => {
								sum += data;
							});
							let percentage =ctx.chart.data.labels[ctx.dataIndex]+"\n"+value+"개소\n"+(value * 100 / sum).toFixed(2) + "%";
							return percentage;
						}
					}
				},
				animation: {
					onComplete: function(animation) {
						var chartInstance = animation.chart;
						var ctx = chartInstance.ctx;
						ctx.textAlign = 'center';
						ctx.textBaseline = 'middle';
						ctx.font = "24px Arial";
						var dataIsAllZero = chartInstance.config.data.datasets[0].data.every(value => value === 0);
						if (dataIsAllZero) {
							var centerX = (chartInstance.chartArea.left + chartInstance.chartArea.right) / 2;
							var centerY = (chartInstance.chartArea.top + chartInstance.chartArea.bottom) / 2;
							ctx.fillText('No data', centerX, centerY);
						}
					}
				},
				onClick: function(event, elements) {
					if (elements.length > 0) {
						console.log(myChart_err.data.datasets)
						var clickedDatasetIndex = elements[0].datasetIndex;
						var clickedElementIndex = elements[0].index;
						var label = myChart_err.data.labels[clickedElementIndex];
						var value = myChart_err.data.datasets[clickedDatasetIndex].data[clickedElementIndex];
						let paramClick = {};
						// var param = {};
						paramClick.corpCd = ${LoginInfo.corpCd};
						paramClick.depaCd = myChart_err.data.datasets[clickedDatasetIndex].depaCd[clickedElementIndex];
						paramClick.busiCd = "${LoginInfo.busiCd}";
						paramClick.progressDivi= '01';
						selectErr(paramClick);

						//alert(label + ": " + value + "개소");
					}
				}
			},
			plugins: [pieLabelsLine],
		});

		}

		myChart_err.update();


	}
	/* 장애목록 el생성 이벤트 시작*/
	async function selectErr(params)
	{
		console.log(params)
		let param = params;
		let data = await edsUtil.getAjax("/errorView/selectError", param);
		let clasify= getCommCode("SYS012");
		let ad= getCommCode("SYS010");
		// Create table data rowsItemAlign
		const table = document.getElementById('tableBody');
		table.innerHTML='';
		for (const obj of data) {
			if(obj.progressDivi==='01') {
				const dataRow = document.createElement('tr');
				dataRow.setAttribute('aria-expanded', 'false')
				dataRow.setAttribute('data-widget', 'expandable-table')
				const depaNm = document.createElement('td');
				depaNm.textContent = obj['depaNm'];
				dataRow.appendChild(depaNm);
				const siteNm = document.createElement('td');
				siteNm.textContent = obj['siteNm'];
				dataRow.appendChild(siteNm);
				const adDivi = document.createElement('td');
				adDivi.setAttribute("class", "numberAlign");
				adDivi.textContent = ad[obj['ad']];
				dataRow.appendChild(adDivi);
				const clasifyDivi = document.createElement('td');
				clasifyDivi.setAttribute("class", "itemAlign");
				clasifyDivi.textContent = clasify[obj['clasifyDivi']];
				dataRow.appendChild(clasifyDivi);
				const receiptDt = document.createElement('td');
				receiptDt.setAttribute("class", "numberAlign");
				receiptDt.textContent = obj['receiptDt'];
				dataRow.appendChild(receiptDt);
				table.appendChild(dataRow);
				const expandBody = document.createElement('tr');
				expandBody.className = 'expandable-body d-none'
				const colspanEx = document.createElement('td');
				colspanEx.colSpan = 5;
				const about = document.createElement('div');
				const header = document.createElement('div')
				header.className = 'card-header text-bold text-xl';
				header.innerHTML = "<i class='fa-solid fa-circle-exclamation text-xl' style='color: #ff7676'></i> " + obj['title'];

				about.appendChild(header);
				const cardbody = document.createElement('div')
				cardbody.className = 'card-body';
				cardbody.innerHTML = obj['content'];
				about.appendChild(cardbody);
				about.style.display = 'none'
				about.className = 'card mt-1 text-left card-secondary'
				colspanEx.appendChild(about);
				expandBody.appendChild(colspanEx);
				table.appendChild(expandBody);
			}

		}
		return data;

	}
	/* 장애목록 el생성 이벤트 끝*/
	/* 점검 el생성 이벤트 시작*/
	async function selectInspection(params)
	{
		let param = params;
		// var param = {};

		let paramYear=document.getElementById('sh_year').value;
		param.month=document.getElementById('sh_month').value;
		param.year=paramYear;


		let data = await edsUtil.getAjax("/inspection/selectInspectionList", param);
		let clasify= getCommCode("SYS012");
		let ad= getCommCode("SYS010");
		// Create table data rowsItemAlign
		const table = document.getElementById('tableBodyIns');
		table.innerHTML="";
		for (const obj of data) {
			if(obj.inspectDivi==='N')
			{
				const dataRow = document.createElement('tr');
				dataRow.setAttribute('aria-expanded','false')
				dataRow.setAttribute('data-widget','expandable-table')
				const depaNm = document.createElement('td');
				depaNm.textContent = obj['depaNm'];
				dataRow.appendChild(depaNm);
				const siteNm = document.createElement('td');
				siteNm.textContent = obj['siteNm'];
				dataRow.appendChild(siteNm);
				const adDivi = document.createElement('td');
				adDivi.setAttribute("class","numberAlign");
				adDivi.textContent = ad[obj['ad']];
				dataRow.appendChild(adDivi);
				const clasifyDivi = document.createElement('td');
				clasifyDivi.setAttribute("class","itemAlign");
				clasifyDivi.textContent = clasify[obj['clasifyDivi']];
				dataRow.appendChild(clasifyDivi);
				const receiptDt = document.createElement('td');
				receiptDt.setAttribute("class","numberAlign");
				receiptDt.textContent = obj['inspectDt'];
				dataRow.appendChild(receiptDt);
				table.appendChild(dataRow);
				const expandBody = document.createElement('tr');
				expandBody.className='expandable-body d-none'
				const colspanEx = document.createElement('td');
				colspanEx.colSpan=5;
				const about = document.createElement('div');
				const header = document.createElement('div')
				header.className='card-header text-bold text-xl';
				header.innerHTML="<i class='fa-solid fa-circle-exclamation text-xl' style='color: #ff7676'></i> 점검내용";

				about.appendChild(header);
				const cardbody = document.createElement('div')
				cardbody.className='card-body';
				cardbody.innerHTML=obj['content'];
				about.appendChild(cardbody);
				about.style.display='none'
				about.className='card mt-1 text-left card-secondary'
				colspanEx.appendChild(about);
				expandBody.appendChild(colspanEx);
				table.appendChild(expandBody);
			}


		}
		return data;

	}
	/* 점검 el생성 이벤트 끝*/
	//점검 태그 값 세팅
	async function setInspectTag(countsMonTotal,countsQuaTotal,countsMon,countsQua,lastCountsMon,lastCountsQua)
	{
		let monVal=0;
		let monTotal=0;
		let monCount=document.getElementById('mon-count')
		let monPer=document.getElementById('mon-per')
		Object.keys(countsMonTotal).forEach(function(key){
			monVal+=Number(countsMon[key]) || 0;
			monVal+=Number(lastCountsMon[key] )|| 0;
			monTotal+=Number(countsMonTotal[key]) || 0;
		});
		monCount.innerHTML=Number(monVal) || 0;
		let monPerVal=((!isNaN(monVal / monTotal) ?(monVal / monTotal):0) * 100).toFixed(0);
		monPerVal>0? (monPer.classList = 'text-success', monPer.innerHTML =`<i class="fas fa-caret-up"></i> `) : (monPer.classList = 'text-warning', monPer.innerHTML =`<i class="fas fa-caret-left"></i> `);
		monPer.innerHTML += monPerVal+'%';
		let quaVal=0;
		let quaTotal=0;
		let quaCount=document.getElementById('qua-count')
		let quaPer=document.getElementById('qua-per')
		Object.keys(countsQuaTotal).forEach(function(key){
			quaVal+=Number(countsQua[key]) || 0;
			quaVal+=Number(lastCountsQua[key] )|| 0;
			quaTotal+=Number(countsQuaTotal[key]) || 0;
		});
		quaCount.innerHTML=Number(quaVal) || 0;
		let quaPerVal=((!isNaN(quaVal / quaTotal) ?(quaVal / quaTotal):0) * 100).toFixed(0);
		quaPerVal>0? (quaPer.classList = 'text-success', quaPer.innerHTML =`<i class="fas fa-caret-up"></i> `) : (quaPer.classList = 'text-warning', quaPer.innerHTML =`<i class="fas fa-caret-left"></i> `);
		quaPer.innerHTML += quaPerVal+'%';



	}
	//점검 태그 user 값 세팅
	async function setInspectUserTag()
	{
		let param = {};
		// var param = {};
		param.corpCd = ${LoginInfo.corpCd};
		param.depaCd = document.getElementById('depaCd').value;
		param.busiCd = "${LoginInfo.busiCd}";
		let paramYear=document.getElementById('sh_year').value;
		param.month=document.getElementById('sh_month').value;
		param.year=paramYear;
		let data = await edsUtil.getAjax("/inspection/selectInspectionUserList", param);
		var userTotal={};
		var userCountsMon = {};
		var userCountsQua = {};
		var userDepaMon = {};
		var userDepaQua = {};
		var userTotal={};
		var totalMon = 0;
		var totalQua = 0;
		var userDepa={};
		var userSrc={};


		data.forEach(function(item) {
			if (item.inspectDivi === 'Y') {
				userTotal[item.inpId] = (userTotal[item.inpId] || 0) + Number(item.insCount);

				if(item.month>12)
				{userCountsQua[item.inpId] = (userCountsQua[item.inpId] || 0) + Number(item.insCount);}
				else
				{userCountsMon[item.inpId] = (userCountsMon[item.inpId] || 0) + Number(item.insCount);}

			}
			userSrc[item.inpId]=`/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+item.corpCd+`:`+item.empCd;
			userDepa[item.inpId]=item.depaCd
			if(item.month>12)
			{totalQua+=Number(item.insCount);
				userDepaQua[item.depaCd] = (userDepaQua[item.depaCd] || 0) + Number(item.insCount);}
			else
			{totalMon+=Number(item.insCount);
				userDepaMon[item.depaCd] = (userDepaMon[item.depaCd] || 0) + Number(item.insCount);}

		});
		let maxMon={};
		let maxQua={};
		Object.keys(userCountsMon).forEach(function(key) {
			maxMon[key]=((!isNaN(userCountsMon[key] / userDepaMon[userDepa[key]]) ?(userCountsMon[key] / userDepaMon[userDepa[key]]):0) * 100).toFixed(2);
		});
		Object.keys(userCountsQua).forEach(function(key) {
			maxQua[key]=((!isNaN(userCountsQua[key] / userDepaQua[userDepa[key]]) ?(userCountsQua[key] / userDepaQua[userDepa[key]]):0) * 100).toFixed(2);
		});
		// 객체의 속성값과 해당 키값을 배열로 변환하고 최대값 및 해당 키값 찾기
		var monResult = Object.entries(maxMon).reduce(function(max, current) {
			return Number(current[1]) > Number(max[1]) ? current : max;
		}, ['...', 0]);
		var quaResult = Object.entries(maxQua).reduce(function(max, current) {
			return Number(current[1]) > Number(max[1]) ? current : max;
		}, ['...', 0]);

		// let userVal=0;
		// let userTotals=0;
		let userCount=document.getElementById('user-count')
		let userPer=document.getElementById('user-per')
		monResult[1]>0? (userPer.classList = 'text-success', userPer.innerHTML =`<i class="fas fa-caret-up"></i> `) : (userPer.classList = 'text-warning', userPer.innerHTML =`<i class="fas fa-caret-left"></i> `);
		userPer.innerHTML += monResult[1]+'% 기여';
		userCount.innerHTML = `<img src=`+userSrc[monResult[0]]+` style="width: 2rem;height: 2rem;margin-right: 10px;box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;border-radius: 50%;border-style: none;" onerror=this.src="/login/img/ELOGO.png">`+monResult[0];
		let quaUserCount=document.getElementById('quaUser-count')
		let quaUserPer=document.getElementById('quaUser-per')
		quaResult[1]>0? (quaUserPer.classList = 'text-success', quaUserPer.innerHTML =`<i class="fas fa-caret-up"></i> `) : (quaUserPer.classList = 'text-warning', quaUserPer.innerHTML =`<i class="fas fa-caret-left"></i> `);
		quaUserPer.innerHTML += quaResult[1]+'% 기여';
		quaUserCount.innerHTML = `<img src=`+userSrc[quaResult[0]]+` style="width: 2rem;height: 2rem;margin-right: 10px;box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;border-radius: 50%;border-style: none;" onerror=this.src="/login/img/ELOGO.png">`+quaResult[0];


	}

	// 랜덤 색상을 생성하는 함수
	function randomColor(leng) {
		var color=[];
		for(var i =0 ;i<leng;i++)
		{
			color.push('#' + Math.random().toString(16).substr(-6))
		}
		return color;
	}

	// 주어진 날짜가 특정 범위 내에 있는지 확인하는 함수
	function isDateInRange(dateToCheck, startDate, endDate) {
		// 문자열로부터 날짜 객체 생성
		var date = new Date(dateToCheck);
		var start = new Date(startDate);
		var end = new Date(endDate);

		// 날짜가 유효한지 확인
		if (isNaN(date.getTime()) || isNaN(start.getTime()) || isNaN(end.getTime())) {
			return false; // 유효하지 않은 날짜
		}

		// 날짜가 범위 내에 있는지 확인
		return date >= start && date <= end;
		//return date <= end;
	}
    // 주어진 날짜가 범위 전주데이터
    function lastDateInRange(dateToCheck, startDate, endDate) {
        // 문자열로부터 날짜 객체 생성
        var date = new Date(dateToCheck);
        var start = new Date(startDate);
        var end = new Date(endDate);

        // 날짜가 유효한지 확인
        if (isNaN(date.getTime()) || isNaN(start.getTime()) || isNaN(end.getTime())) {
            return false; // 유효하지 않은 날짜
        }

        // 날짜가 범위 내에 있는지 확인
        return date < start;
        //return date <= end;
    }
	function getGroup() {
		// 값(value)에 따라 그룹을 결정합니다.
		const value = Number(document.getElementById('sh_month').value);
		if (value >= 1 && value <= 3) {
			return 1;
		} else if (value >= 4 && value <= 6) {
			return 2;
		} else if (value >= 7 && value <= 9) {
			return 3;
		} else if (value >= 10 && value <= 12) {
			return 4;
		} else {
			return -1; // 예외 처리: 범위를 벗어나는 경우
		}
	}


	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>