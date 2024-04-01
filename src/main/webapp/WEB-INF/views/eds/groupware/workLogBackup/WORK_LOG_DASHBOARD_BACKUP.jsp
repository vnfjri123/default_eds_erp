<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-workLog.jspf"%><%-- 공통 파일 --%>
	<style>
		/************************
		* bootstrap css START
		*************************/
		.row{
			max-width: 100vw;
		}
		.btn-primary{
			border-color: #111f93 !important;
			background-color: #111f93 !important;
			color: #fff !important;
			font-size: 0.9rem;
		}
		.btn-default{
			background-color: #fff !important;
			color: #000;
			font-size: 0.9rem;
		}
		/************************
		* bootstrap css END
		*************************/

		/************************
		* progress css END
		*************************/
		.progress-container {
			width: 100%;
			height: 12px; /* height: 0px; 으로 하면 안 보임 */
			background-color: #a2a1a1;
			/*background-color: #dfe2e7;*/
			z-index: 9997;
			border-radius: 10px;
		}
		.progress-bar {
			width: 0%;
			max-width: 100%;
			height: 12px;
			background: linear-gradient(to right, rgba(250,180,70,1) 0%, rgba(250,30,30,1) 50%, rgba(130,60,180,1) 100%);
			/*background: #57adfb;*/
			border-radius: 10px 10px;
			/* border-radius: 10px; */
		}

		.percent {
			/* display: none; 을 추가 하면 안 보임 */
			position: absolute;
			top:-3px;
			right: 15px;
			display: block;
			font-size: 0.9rem;
			color: #fff;
			/*color: #333333;*/
			text-align: center;
		}
		.percent::after {
			/* display: none; 을 추가 하면 안 보임 */
			position: absolute;
			bottom: 2px;
			right: -15px;
			font-size: 12px;
			font-weight: 500;
			opacity: 0.5;
		}
		/************************
		* progress css END
		*************************/

		/************************
		* select2 css END
		*************************/
		.select2-container.select2-container--default.select2-container--open{
			z-index: 1052;
		}
		.select2-selection__rendered{
			padding-left: 0px !important;
			font-family: 'Pretendard-Regular' !important;
			font-size: 1rem !important;
		}
		.select2-selection--single{
			height: calc(2.25rem + 2px) !important;
			border: 1px solid #ced4da !important;
		}
		.select2-selection--multiple{
			height: auto !important;
			border: 1px solid #ced4da !important;
		}
		.select2-selection--multiple .select2-selection__choice{
			background-color: #003865 !important;
			border: #003865 !important;
		}
		.select2-selection__choice__remove{
			color: #fff !important;
		}
		/************************
		* select2 css END
		*************************/
		/************************
		* common css START
		*************************/

		/* 스크롤바 숨기기 */
		*::-webkit-scrollbar {
			display: none; /* Chrome, Safari, Opera*/
		}

		/* 스크롤 되게하기 */
		.y-scrollable {
			height: calc(100vh - 100.8px);
			overflow-y: scroll;
		}

		/* 초기 스타일 */
		.color-transition {
			display: inline-block;
			color: #333;

			/* "to left" / "to right" - affects initial color */
			background: linear-gradient(to left, white 50%, #111f93 50%) right;
			background-size: 200%;
			transition: .5s ease-out;
		}

		/* 클릭 후 전환 스타일 */
		.color-transition.clicked {
			color: #fff !important;
			background-position: left;
		}

		.baseBlockKr {
			margin: 0px 0px 0px 0px;
			padding: 0 0 15px 0px;
			border-radius: 5px;
			overflow: hidden;
			background-color: #fff;
			-moz-transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
			-o-transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
			transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
		}

		.baseBlockKr:hover {
			background-color: #111f93;
			color: #333;
			-webkit-transform: translate(0, -8px);
			-moz-transform: translate(0, -8px);
			-ms-transform: translate(0, -8px);
			-o-transform: translate(0, -8px);
			transform: translate(0, -8px);
			box-shadow: 0 40px 40px rgba(0, 0, 0, 0.2);
		}

		/* 드래그 막기 */
		body {
			user-select: none; /* 드래그 막기 */
		}
		/************************
		* commen css END
		*************************/
		/************************
		* card css START
		*************************/

		.fade-in-slide-down {
			opacity: 0; /* 시작 시 요소를 투명하게 설정 */
			transform: translateY(-20px); /* 요소를 위로 20px만큼 이동 */
			animation: slideIn 1s ease-out forwards; /* 애니메이션 적용 */
		}

		@keyframes slideIn {
			from {
				opacity: 0; /* 애니메이션 시작 시 요소를 투명하게 설정 */
				transform: translateY(-20px); /* 애니메이션 시작 시 요소를 위로 20px만큼 이동 */
			}
			to {
				opacity: 1; /* 애니메이션 종료 시 요소를 불투명하게 설정 */
				transform: translateY(0); /* 애니메이션 종료 시 요소를 원래 위치로 이동 */
			}
		}

		.fade-out-slide-down {
			animation: fadeOutSlideDown 1s ease-out forwards;
		}

		@keyframes fadeOutSlideDown {
			to {
				opacity: 0;
				transform: translateY(20px);
			}
		}

		.baseBlock {
			margin: 0px 0px 35px 0px;
			padding: 0 0 15px 0px;
			border-radius: 5px;
			overflow: hidden;
			background-color: #fff;
			-moz-transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
			-o-transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
			transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
		}

		.baseBlock:hover {
			background-color: #111f93;
			color: #fff !important;
			-webkit-transform: translate(0, -8px);
			-moz-transform: translate(0, -8px);
			-ms-transform: translate(0, -8px);
			-o-transform: translate(0, -8px);
			transform: translate(0, -8px);
			box-shadow: 0 40px 40px rgba(0, 0, 0, 0.2);
		}
		/************************
		* card css END
		*************************/
	</style>
</head>

<body>
	<section id="header">
		<div class="col-12 col-md-12">
			<div class="row">
				<div class="col-12 col-md-6">
					<b style="font-size: 2rem">성과 대쉬보드</b>
				</div>
				<div class="col-12 col-md-6">
					<div class="input-group d-flex justify-content-end">
						<input type="search" class="form-control" id='headerPlanNmSearch' placeholder="검색">
						<div class="input-group-append">
							<button type="button" class="btn btn-default" id="headerPlanNmSearchButton" name="headerPlanNmSearchButton"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section id="content">
		<div class="col-12 col-md-12">
			<div class="card" id="planRootsContent">
				<div class="card-body p-0 pl-2 text-left align-middle" style="height: 2rem;padding-top: 0.3rem !important;" id="planRoots">
				</div>
			</div>
		</div>
		<div class="col-12 col-md-12">
			<div class="row" id="mainObjectiveContent">
			</div>
		</div>
		<div class="col-12 col-md-12">
			<div class="row" id="subObjectiveContent">
			</div>
		</div>
	</section>
	<section class="d-none" id="detail">
		<div class="row">
			<div class="col-12 col-md-12 ml-2 d-none" id="detailButton">
				<div class="row">
					<div class="col-12 col-md-3 pr-3">
						<select class="form-control selectpicker" id="detailPlanModalPeriod">
							<option value="">없음</option>
							<option value="01">주간</option>
							<option value="02">월간</option>
							<option value="03">연간</option>
						</select>
					</div>
					<div class="col-12 col-md-3" style="z-index: 2030;position: relative;">
						<input class="form-control bg-white d-none" type="text" id="datepicker">
					</div>
					<div class="col-12 col-md-3">
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="detailPlanModalPeriodExit" name="detailPlanModalPeriodExit">나가기</button>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-3 y-scrollable d-none" style="border-right: 1px solid #efefef;" id="detailKeyObjectList">
			</div>
			<div class="col-12 col-md-9 pr-0 y-scrollable d-none"  id="detailKeyObjectInfo">
				<div class="col-12 col-md-12">
					<div class="row">
						<div class="col-md-12 p-2" style="padding-right: 4px !important;">
							<div class="card" id="detailKeyResultLineChart" style="height: 400px">
								<div class="card-body p-0 pl-2 text-left align-middle" style="padding-top: 0.3rem !important;">
									<canvas id="detailProgressChart"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-12">
					<div class="row">
						<div class="col-md-12 p-2">
							<!-- 시트가 될 DIV 객체 -->
							<div id="planKeyResultGridListDIV" style="width:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
<script>
	var planKeyResultGridList;
	var datepicker;
	var rootPlanCd;
	var detailKeyObjectListPlanCdsRoot = [];
	var detailKeyObjectListPlanCds = [];
	var detailProgressChartInstance;
	$(document).ready(async function () {

		/*************************************
		 * grid fn set START
		 * **********************************/
		await init();
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
					case 'detailPlanModalPeriod' :
						new Promise(async (resolve, reject)=>{
							// 1. 기간 대비 캘린더 변경
							detailCalenderToggle(targetValue);
							resolve();
						}).then((value)=>{
							// 2. 주간, 월간, 연간 대비 kr 데이터 가져오기
							switch (targetValue) {
								case "": // 없음
									// 1. detailKeyObjectList 초기화
									var detailKeyObjectList = document.getElementById('detailKeyObjectList');
									detailKeyObjectList.replaceChildren();

									// 2. 차트 초기화
									detailProgressChartInstance.destroy();

									// 3. 그리드 초기화
									planKeyResultGridList.refreshLayout(); // 데이터 초기화
									planKeyResultGridList.clear(); // 데이터 초기화
									break;
								case "01": // 주간
									displayDetailKeyResultList(rootPlanCd);
									break;
								case "02": // 월간
									displayDetailKeyResultList(rootPlanCd)
									break;
								case "03": // 연간
									displayDetailKeyResultList(rootPlanCd)
									break;
							}
						}).then((value)=>{
							// 3.
						})

						break;
				}
			}
		});

		/*************************************
		 * bootstrap select2 set END
		 * **********************************/

		/******************************************
		 * 'header' set Start
		 * ***************************************/

		document.getElementById('header').addEventListener('keyup', async ev => {
			if(ev.key === 'Enter'){
				var target = ev.target;
				switch (target.id) {
					case 'headerPlanNmSearch': await displaySubObjective(rootPlanCd); break; // 검색기능
				}
			}
		});

		document.getElementById('header').addEventListener('click', async ev => {
			var target = ev.target;
			switch (target.id) {
				case 'headerPlanNmSearchButton': await displaySubObjective(rootPlanCd); break; // 검색기능
			}
		});

		/******************************************
		 * 'header' set END
		 * ***************************************/

		/******************************************
		 * 'content' set Start
		 * ***************************************/

		function promiseThenDelay(value, ms) {
			return new Promise(resolve => {
				setTimeout(() => resolve(value), ms);
			});
		}

		document.getElementById('content').addEventListener('click', async ev => {
			var target = ev.target;
			switch (true) {
				case target.id.includes('subObjectiveContentMoveDetailDashBoard') :
				case target.id.includes('subObjectiveContentMoveSubDashBoard') : // 현황 클릭
				case target.id.includes('subObjectiveContentPlanNm') : // 현황 클릭
					if(target.id.includes('subObjectiveContentMoveDetailDashBoard') || target.id.includes('subObjectiveContentPlanNm')){
						new Promise(async (resolve, reject)=>{
							// 1. 루트 목표 코드 설정
							rootPlanCd = target.id.split('-')[1];
							resolve();
						}).then((value)=>{
							// 2. 목표 경로, 메인, 서브 목표 숨기기 애니메이션 클래스 추가
							var content = document.getElementById('content');
							content.classList.add('fade-out-slide-down');
							return promiseThenDelay(value,1000); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 2. 목표 경로, 메인, 서브 목표 숨기기 애니메이션 클래스 추가
							var content = document.getElementById('content');
							content.classList.add('d-none');
						}).then((value)=>{
							// 3. 현황 상세 보이기 애니메이션 클래스 추가
							var detail = document.getElementById('detail');
							detail.classList.remove('d-none');
						}).then((value)=>{
							// 4. 현황 버튼 리스트 데이터 세팅
							var detailButton = document.getElementById('detailButton');
							detailButton.classList.remove('d-none');
							detailButton.classList.add('fade-in-slide-down');
							return promiseThenDelay(value,500); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 5.  detailPlanModalPeriod 초기값
							// $('#detailPlanModalPeriod').val('01').trigger('change')
						}).then((value)=>{
							// 5. 현황 지표 리스트 데이터 세팅
							var param = {};
							param.planCd = rootPlanCd;
						}).then((value)=>{
							// 6. 현황 지표 상세 데이터 세팅
						}).then((value)=>{
							// 7. 현황 지표 리스트, 상세 보이기 애니메이션 클래스 추가
							var detailKeyObjectList = document.getElementById('detailKeyObjectList');
							var detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
							detailKeyObjectList.classList.remove('d-none');
							detailKeyObjectInfo.classList.remove('d-none');
							detailKeyObjectList.classList.add('fade-in-slide-down');
							detailKeyObjectInfo.classList.add('fade-in-slide-down');
							return promiseThenDelay(value,500); // 1초 대기 후 다음 값으로 2를 전달
						})
					}else if(target.id.includes('subObjectiveContentMoveSubDashBoard')){ // 하위 클릭
						new Promise(async (resolve, reject)=>{
							// 1. 루트 목표 코드 설정
							rootPlanCd = target.id.split('-')[1];
							resolve();
						}).then((value)=>{
							// 2. 목표 경로 추가
							var element = document.getElementById('planRoots');
							var length = element.innerText.length;
							var planNm = document.getElementById('subObjectiveContentPlanNm-'+rootPlanCd).innerText;
							if(length === 0) element.innerText = planNm;
							else element.innerText += ' > ' + planNm
						}).then((value)=>{
							// 3. 애니메이션 클래스 추가
							var mainObjectiveContent = document.getElementById('mainObjectiveContent');
							var subObjectiveContent = document.getElementById('subObjectiveContent');
							mainObjectiveContent.classList.add('fade-out-slide-down');
							subObjectiveContent.classList.add('fade-out-slide-down');

							return promiseThenDelay(value,1000); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 3. 애니메이션 클래스 삭제
							var mainObjectiveContent = document.getElementById('mainObjectiveContent');
							var subObjectiveContent = document.getElementById('subObjectiveContent');
							mainObjectiveContent.classList.remove('fade-out-slide-down');
							subObjectiveContent.classList.remove('fade-out-slide-down');
						}).then((value)=>{
							// 4. 메인 데이터 적용
							let subObjectiveContent = document.getElementById('subObjectiveContent');
							subObjectiveContent.replaceChildren();
							displayMainObjective(rootPlanCd);
							return promiseThenDelay(value,500); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 5. 서브 데이터 적용
							displaySubObjective(rootPlanCd)
						})
					}
					break;
				case target.id.includes('mainObjectiveContentMoveDetailDashBoard') :
				case target.id.includes('mainObjectiveContentBackSubDashBoard') : // 현황 클릭
				case target.id.includes('mainObjectiveContentPlanNm') : // 현황 클릭
					if(target.id.includes('mainObjectiveContentMoveDetailDashBoard') || target.id.includes('mainObjectiveContentPlanNm')){
						new Promise(async (resolve, reject)=>{
							// 1. 루트 목표 코드 설정
							rootPlanCd = target.id.split('-')[1];
							resolve();
						}).then((value)=>{
							// 2. 목표 경로, 메인, 서브 목표 숨기기 애니메이션 클래스 추가
							var content = document.getElementById('content');
							content.classList.add('fade-out-slide-down');
							return promiseThenDelay(value,1000); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 2. 목표 경로, 메인, 서브 목표 숨기기 애니메이션 클래스 추가
							var content = document.getElementById('content');
							content.classList.add('d-none');
						}).then((value)=>{
							// 3. 현황 상세 보이기 애니메이션 클래스 추가
							var detail = document.getElementById('detail');
							detail.classList.remove('d-none');
						}).then((value)=>{
							// 4. 현황 버튼 리스트 데이터 세팅
							var detailButton = document.getElementById('detailButton');
							detailButton.classList.remove('d-none');
							detailButton.classList.add('fade-in-slide-down');
							return promiseThenDelay(value,500); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 5.  detailPlanModalPeriod 초기값
							// $('#detailPlanModalPeriod').val('01').trigger('change')
						}).then((value)=>{
							// 5. 현황 지표 리스트 데이터 세팅
							var param = {};
							param.planCd = rootPlanCd;
						}).then((value)=>{
							// 6. 현황 지표 상세 데이터 세팅
						}).then((value)=>{
							// 7. 현황 지표 리스트, 상세 보이기 애니메이션 클래스 추가
							var detailKeyObjectList = document.getElementById('detailKeyObjectList');
							var detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
							detailKeyObjectList.classList.remove('d-none');
							detailKeyObjectInfo.classList.remove('d-none');
							detailKeyObjectList.classList.add('fade-in-slide-down');
							detailKeyObjectInfo.classList.add('fade-in-slide-down');
							return promiseThenDelay(value,500); // 1초 대기 후 다음 값으로 2를 전달
						})
					}else if(target.id.includes('mainObjectiveContentBackSubDashBoard')){ // 이전 클릭
						new Promise(async (resolve, reject)=>{
							// 1. 루트 목표 코드 설정
							rootPlanCd = target.id.split('-')[1];

							var param = {
								corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
								planNmSearch: document.getElementById('headerPlanNmSearch').value,
								objectiveDivi: 'main',
								parePlanCd: rootPlanCd
							};

							var data = edsUtil.getAjax("/WORK_LOG/selectWorkLogRootObjectList", param);

							rootPlanCd = data.length === 0?'':data[0].parePlanCd;
							resolve();
						}).then((value)=>{
							// 2. 목표 경로 삭제
							var planRoots = document.getElementById('planRoots');
							var planNm = document.getElementById('mainObjectiveContentPlanNm-'+target.id.split('-')[1]).innerText;
							if(!planRoots.innerText.includes('>')){ // 목표가 하나 일 경우
								planRoots.innerText = planRoots.innerText.replaceAll(planNm,'')
							}else{ // 목표가 여러개 일 경우
								planRoots.innerText = planRoots.innerText.replaceAll(' > '+planNm,'')
							}
						}).then((value)=>{
							// 3. 애니메이션 클래스 추가
							var mainObjectiveContent = document.getElementById('mainObjectiveContent');
							var subObjectiveContent = document.getElementById('subObjectiveContent');
							mainObjectiveContent.classList.add('fade-out-slide-down');
							subObjectiveContent.classList.add('fade-out-slide-down');
							return promiseThenDelay(value,1000); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 3. 애니메이션 클래스 삭제
							var mainObjectiveContent = document.getElementById('mainObjectiveContent');
							var subObjectiveContent = document.getElementById('subObjectiveContent');
							mainObjectiveContent.classList.remove('fade-out-slide-down');
							subObjectiveContent.classList.remove('fade-out-slide-down');
						}).then((value)=>{
							// 4. 메인 데이터 적용
							let subObjectiveContent = document.getElementById('subObjectiveContent');
							subObjectiveContent.replaceChildren();
							if(rootPlanCd !== ''){
								displayMainObjective(rootPlanCd);
							}else{
								let mainObjectiveContent = document.getElementById('mainObjectiveContent');
								mainObjectiveContent.replaceChildren();
							}
							return promiseThenDelay(value,500); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value)=>{
							// 5. 서브 데이터 적용
							displaySubObjective(rootPlanCd)
						})
					}
					break;
			}
		});
		/******************************************
		 * 'content' set END
		 * ***************************************/

		/******************************************
		 * 'detail' set START
		 * ***************************************/
		document.getElementById('detail').addEventListener('click', ev => {
			var targetId = ev.target.id
			var planCd;
			switch (true) {
				case targetId.includes('detailKeyObjectList'):
					if(targetId.includes('-')){
						new Promise((resolve, reject)=>{
							// 코드 설정
							planCd = targetId.split('-')[1];
							resolve();
						}).then((value)=>{
							// detailKeyObjectListPlanCds 설정
							if (detailKeyObjectListPlanCds.includes(planCd)) {
								var index = detailKeyObjectListPlanCds.indexOf(planCd);
								if (index !== -1) {
									detailKeyObjectListPlanCds.splice(index, 1);
								}
							} else {
								detailKeyObjectListPlanCds.push(planCd)
							}
						}).then((value)=>{
							// CSS 설정
							document.getElementById('detailKeyObjectListTransition-'+planCd).classList.toggle("clicked");
						}).then((value)=>{
							// 1. 계획 대비 실적 데이터
							if(detailKeyObjectListPlanCds.length > 0){
								detailProgressChart(detailKeyObjectListPlanCds);
							}else{
								detailProgressChart(detailKeyObjectListPlanCdsRoot);
							}
						}).then((value)=>{
							// 1. 계획 데이터
							if(detailKeyObjectListPlanCds.length > 0){
								detailProgressChartPlanList(detailKeyObjectListPlanCds);
							}else{
								detailProgressChartPlanList(detailKeyObjectListPlanCdsRoot);
							}
						})
					}
					break;
				case targetId.includes('detailPlanModalPeriodExit'):
					new Promise(async (resolve, reject)=>{
						// 1. detailKeyObjectList 초기화
						var detailKeyObjectList = document.getElementById('detailKeyObjectList');
						detailKeyObjectList.replaceChildren();

						// 2. 차트 초기화
						if (typeof detailProgressChartInstance !== 'undefined') {
							detailProgressChartInstance.destroy();
						}
						// 3. 그리드 초기화
						planKeyResultGridList.refreshLayout(); // 데이터 초기화
						planKeyResultGridList.clear(); // 데이터 초기화
						resolve();
					}).then((value)=>{
						// 4. 현황 지표 리스트, 상세 보이기 애니메이션 클래스 추가
						var detailKeyObjectList = document.getElementById('detailKeyObjectList');
						var detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
						var detailButton = document.getElementById('detailKeyObjectInfo');
						detailKeyObjectList.classList.remove('fade-in-slide-down');
						detailKeyObjectInfo.classList.remove('fade-in-slide-down');
						detailButton.classList.remove('fade-in-slide-down');
					}).then((value)=>{
						// 4. 현황 지표 리스트, 상세 보이기 애니메이션 클래스 추가
						var detailKeyObjectList = document.getElementById('detailKeyObjectList');
						var detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
						var detailButton = document.getElementById('detailKeyObjectInfo');
						detailKeyObjectList.classList.add('fade-out-slide-down');
						detailKeyObjectInfo.classList.add('fade-out-slide-down');
						detailButton.classList.add('fade-out-slide-down');
						return promiseThenDelay(value,1000); // 1초 대기 후 다음 값으로 2를 전달
					}).then((value)=>{
						// 4. 현황 지표 리스트, 상세 보이기 애니메이션 클래스 추가
						var detailKeyObjectList = document.getElementById('detailKeyObjectList');
						var detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
						var detailButton = document.getElementById('detailKeyObjectInfo');
						detailKeyObjectList.classList.remove('d-none');
						detailKeyObjectInfo.classList.remove('d-none');
						detailButton.classList.remove('d-none');
					}).then((value)=>{
						// 4. 상세 숨기기 애니메이션 클래스 추가
						var detail = document.getElementById('detail');
						detail.classList.add('d-none');
					}).then((value)=>{
						// 2. 목표 경로, 메인, 서브 목표 숨기기 애니메이션 클래스 추가
						var content = document.getElementById('content');
						content.classList.remove('d-none');
						content.classList.remove('fade-out-slide-down');
					}).then((value)=>{
						// 3. 현황 상세 보이기 애니메이션 클래스 추가
						var content = document.getElementById('content');
						content.classList.add('fade-in-slide-down');
					})
					break;
			}
		})
		/******************************************
		 * 'detail' set END
		 * ***************************************/

		/******************************************
		 * '초기 목표' set START
		 * ***************************************/

		await displaySubObjective(rootPlanCd);

		/******************************************
		 * '초기 목표' set END
		 * ***************************************/
	});

	/* 초기설정 */
	async function init() {

		/**********************************************************************
		 * Grid Class 영역 START
		 ***********************************************************************/
		class CustomSliderRenderer {
			constructor(props) {

				const rowKey = props.rowKey;
				const value = props.value;
				var divi = props.grid.el.id.includes('planGridListDIV')?'planGridListDIV'
						: props.grid.el.id.includes('keyResultGridListDIV')?'keyResultGridListDIV'
								: props.grid.el.id.includes('planningKeyResultGridListDIV')?'planningKeyResultGridListDIV':'';
				var progressBar = 'progress-bar_' + divi + '_' + rowKey
				var percent = 'percent_' + divi + '_' + rowKey

				const elDivContainer = document.createElement('Div');
				elDivContainer.setAttribute('class', 'progress-container');

				const elDivProgressBar = document.createElement('Div');
				elDivProgressBar.setAttribute('class', 'progress-bar');
				elDivProgressBar.setAttribute('id', progressBar);

				const elSpanPercent = document.createElement('span');
				elSpanPercent.setAttribute('class', 'percent');
				elSpanPercent.setAttribute('id', percent);

				elDivProgressBar.appendChild(elSpanPercent);
				elDivContainer.appendChild(elDivProgressBar);

				this.el = elDivContainer;

				$(document).ready(function (e) {
					$("#"+progressBar).css("width", value + "%");
					$("#"+percent).text(value + "%");
					divi.includes('planGridListDIV')?$("#"+percent).css("right", "125px")
							: divi.includes('planningKeyResultGridListDIV')?$("#"+percent).css("right", "5px"):'';
				});
			}

			getElement() {
				return this.el;
			}
		}
		/**********************************************************************
		 * Grid Class 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid Info 영역 START
		 ***********************************************************************/

		// planning key result
		planKeyResultGridList = new tui.Grid({
			el: document.getElementById('planKeyResultGridListDIV'),
			// data: treeData,
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'auto',
			treeColumnOptions: {
				name: 'planNm',
				useCascadingCheckbox: false,
				useIcon: false,
			},
			rowHeight:'auto',
			minRowHeight:50,
			rowHeaders: [/*'rowNum',*/ /*'checkbox'*/],
			header: {
				height: 100,
				minRowHeight: 100,
				complexColumns: [
					{
						header: '기획',
						name: 'amt',
						childNames: ['cost','supAmt','vatAmt','totAmt']
					},
					{
						header: '견적가',
						name: 'amt2',
						childNames: ['cost2','supAmt2','vatAmt2','totAmt2']
					},
					{
						header: '계약금액',
						name: 'amt3',
						childNames: ['cost3','supAmt3','vatAmt3','totAmt3']
					},
				],
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		planKeyResultGridList.setColumns([
			{ header:'기획명',			name:'planNm',		minWidth:150,	align:'left',	whiteSpace:'pre-line'},
			{ header:'기획목표',			name:'edAmt',		width:60,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value);
				},
				whiteSpace:'pre-line'
			},
			{ header:'단위',				name:'unit',		width:50,	align:'center'},
			{ header:'계획일자',			name:'planDt',		width:85,	align:'center'},
			{ header:'계획내용',			name:'planNote',	minWidth:150,	align:'left',	whiteSpace:'pre-line'},
			{ header:'계획수치',			name:'planAmt',		width:60,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value);
				},
				whiteSpace:'pre-line'
			},
			{ header:'체크인일자',			name:'checkInDt',	width:85,	align:'center'},
			{ header:'체크인내용',			name:'checkInNote',	minWidth:150,	align:'left',	whiteSpace:'pre-line'},
			{ header:'체크인수치',			name:'checkInAmt',	width:60,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value);
				},
				whiteSpace:'pre-line'
			},
			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
			{ header:'기획코드',		name:'planCd',		width:150,		align:'center',	hidden:true },
			{ header:'단위',			name:'unit',		width:150,		align:'center',	hidden:true },
		]);

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/
	}
	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
	async function doAction(sheetNm, sAction, el) {
		if (sheetNm == 'planKeyResultGridList') {
			switch (sAction) {
				case "search":// o 조회

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

	/**********************************************************************
	 * 화면 팝업 이벤트 영역 END
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 함수 영역 START
	 ***********************************************************************/

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

	async function displayMainObjective(planCd) {
		var data;
		var length = 0;
		var param = {
			corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
			planCd: planCd,
			objectiveDivi: 'main'
		};

		new Promise(async (resolve, reject)=>{
			// 1. 데이터 소스 조회
			data = edsUtil.getAjax("/WORK_LOG/selectWorkLogRootObjectList", param);
			resolve();
		}).then((value)=>{
			// 2. 데이터 길이 세팅
			length = data.length;

			// 3. mainObjectiveContent 초기화
			let mainObjectiveContent = document.getElementById('mainObjectiveContent');
			mainObjectiveContent.replaceChildren();

			// 4. mainObjectiveContent 세팅
			for (let i = 0; i < length; i++) {// 틀
				var div01 = document.createElement('div');
				div01.setAttribute('class','col-12 col-md-12 fade-in-slide-down');
				div01.setAttribute('id','mainObjectiveContent-'+data[i].planCd);
				var div02 = document.createElement('div');
				div02.setAttribute('class','card');
				div02.style.backgroundColor = '#eee';
				div02.style.color = '#333';
				var div03 = document.createElement('div');
				div03.setAttribute('class','card-body');
				/*****************
				 * 목표명 세팅 START
				 * ***************/
				var div04 = document.createElement('div');
				div04.setAttribute('class','row');
				var div05 = document.createElement('div');
				div05.setAttribute('class','col-12 col-md-12 pt-0 pb-4 pl-2 pr-2');
				div05.setAttribute('style','font-size: 1.5rem');
				div05.setAttribute('id','mainObjectiveContentPlanNm-'+data[i].planCd);
				div05.innerText = data[i].planNm
				div04.appendChild(div05);
				div03.appendChild(div04);
				/*****************
				 * 목표명 세팅 END
				 * ***************/

				/***********************
				 * 사람얼굴 세팅 START
				 * *********************/
				var div08 = document.createElement('div');
				div08.setAttribute('class','row');
				var div09 = document.createElement('div');
				div09.setAttribute('class','col-12 col-md-12 pt-0 pb-4 pl-2 pr-2');
				div09.setAttribute('id','mainObjectiveContentPartCdsFace-'+data[i].planCd);
				/***********************
				 * 사람얼굴 세팅 END
				 * *********************/

				/***********************
				 * 리더|구성원 세팅 START
				 * *********************/

				/* 상세보기 시, 구성원 연동*/
				var partsData = edsUtil.getAjaxJson('/WORK_LOG/getPartCds',{planCd:data[i].planCd}).data
				var dataLength = partsData.length;

				var partNms = ''
				for (let j = 0; j < dataLength; j++) {
					if(j===0) partNms += data[i].empNm
					else if(j === dataLength-1) partNms += ' 외 ' + (dataLength-1) + '명'
					var partImg = document.createElement('img')
					partImg.setAttribute('src',partsData[j].partImg);
					partImg.setAttribute('title',partsData[j].depaCd);
					partImg.setAttribute('style',
							'width: 2rem;' +
							'height: 2rem;' +
							'margin-right: 10px;' +
							'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
							'border-radius: 50%;' +
							'border-style: none;' +
							'');
					div09.appendChild(partImg);
				}
				div08.appendChild(div09);


				var div06 = document.createElement('div');
				div06.setAttribute('class','row');
				var div07 = document.createElement('div');
				div07.setAttribute('class','col-12 col-md-12 pt-0 pb-4 pl-2 pr-2');
				div07.setAttribute('id','mainObjectiveContentPartCds-'+data[i].planCd);
				div07.innerText = '리더 ' + partNms
				div06.appendChild(div07);
				div03.appendChild(div06); // 리더 구성원 글자 세팅
				div03.appendChild(div08); // 구성원 얼굴 세팅
				/***********************
				 * 리더|구성원 세팅 END
				 * *********************/

				/***********************
				 * 진행상태 세팅 START
				 * *********************/
				var div10 = document.createElement('div');
				div10.setAttribute('class','row');

				// progress bar
				var div11 = document.createElement('div');
				div11.setAttribute('class','col-12 col-md-6 pt-0 pb-3 pl-2 pr-2');
				var div16 = document.createElement('div');
				div16.setAttribute('class','row w-md-100 mt-1');
				var div17 = document.createElement('div');
				div17.setAttribute('class','col-md-12');
				var div18 = document.createElement('div');
				div18.setAttribute('class','progress-container');
				var div19 = document.createElement('div');
				div19.setAttribute('class','progress-bar');
				div19.setAttribute('id','mainObjectiveContentProgressBar-'+data[i].planCd);
				var span01 = document.createElement('span');
				span01.setAttribute('class','percent');
				span01.setAttribute('id','mainObjectiveContentPercent-'+data[i].planCd);
				div18.appendChild(div19);
				div18.appendChild(span01);
				div17.appendChild(div18);
				div16.appendChild(div17);
				div11.appendChild(div16);
				div10.appendChild(div11);


				// status num
				let totStatus = {
					divi01: 0,
					divi02: 0,
					divi03: 0,
					divi04: 0,
				};

				if(data[i].statusDivi === null || data[i].statusDivi === undefined) data[i].statusDivi = ''
				let statusArr = data[i].statusDivi.split(",")
				for (let j = 0; j < statusArr.length; j++) {
					switch (statusArr[j]) {
						case '01': totStatus.divi01 += 1; break;
						case '02': totStatus.divi02 += 1; break;
						case '03': totStatus.divi03 += 1; break;
						case '04': totStatus.divi04 += 1; break;
					}
				}

				var div20 = document.createElement('div');
				div20.setAttribute('class','col-12 col-md-6 text-center');
				var div21 = document.createElement('div');
				div21.setAttribute('class','row pb-3');

				var div22 = document.createElement('div'); // 대기
				div22.setAttribute('class','col-3 col-md-3 text-center');
				div22.setAttribute('style','border-right: 2px solid #a2a1a1');
				var div23 = document.createElement('div');
				div23.setAttribute('class','col-md-12');
				div23.innerText = '대기';
				var div24 = document.createElement('div');
				div24.setAttribute('class','col-md-12');
				div24.setAttribute('id','mainObjectiveContentStatusDivi01-'+data[i].planCd);
				div24.innerText = totStatus.divi01;
				div22.appendChild(div23);
				div22.appendChild(div24);
				div21.appendChild(div22);


				var div25 = document.createElement('div'); // 진행중
				div25.setAttribute('class','col-3 col-md-3 text-center');
				div25.setAttribute('style','border-right: 2px solid #a2a1a1');
				var div26 = document.createElement('div');
				div26.setAttribute('class','col-md-12');
				div26.innerText = '진행중';
				var div27 = document.createElement('div');
				div27.setAttribute('class','col-md-12');
				div27.setAttribute('style','color:#68bae7');
				div27.setAttribute('id','mainObjectiveContentStatusDivi02-'+data[i].planCd);
				div27.innerText = totStatus.divi02;
				div25.appendChild(div26);
				div25.appendChild(div27);
				div21.appendChild(div25);


				var div28 = document.createElement('div'); // 문제
				div28.setAttribute('class','col-3 col-md-3 text-center');
				div28.setAttribute('style','border-right: 2px solid #a2a1a1');
				var div29 = document.createElement('div');
				div29.setAttribute('class','col-md-12');
				div29.innerText = '문제';
				var div30 = document.createElement('div');
				div30.setAttribute('class','col-md-12');
				div30.setAttribute('style','color:#da362e');
				div30.setAttribute('id','mainObjectiveContentStatusDivi03-'+data[i].planCd);
				div30.innerText = totStatus.divi03;
				div28.appendChild(div29);
				div28.appendChild(div30);
				div21.appendChild(div28);


				var div31 = document.createElement('div'); // 완료
				div31.setAttribute('class','col-3 col-md-3 text-center');
				var div32 = document.createElement('div');
				div32.setAttribute('class','col-md-12');
				div32.innerText = '완료';
				var div33 = document.createElement('div');
				div33.setAttribute('class','col-md-12');
				div33.setAttribute('style','color:#51ab42');
				div33.setAttribute('id','mainObjectiveContentStatusDivi04-'+data[i].planCd);
				div33.innerText = totStatus.divi04;
				div31.appendChild(div32);
				div31.appendChild(div33);
				div21.appendChild(div31);
				div20.appendChild(div21);
				div10.appendChild(div20);
				div03.appendChild(div10);
				/***********************
				 * 진행상태 세팅 END
				 * *********************/

				/***********************
				 * 버튼 세팅 START
				 * *********************/
				var div34 = document.createElement('div');
				div34.setAttribute('class','row justify-content-center');

				// 현황
				var div35 = document.createElement('div');
				div35.setAttribute('class','col-3');
				var div36 = document.createElement('div');
				div36.setAttribute('role','button');
				div36.setAttribute('class','text-center');
				div36.setAttribute('id','mainObjectiveContentMoveDetailDashBoard-'+data[i].planCd);
				div36.innerText = '현황';
				div35.appendChild(div36);
				div34.appendChild(div35);

				// 하위
				var div37 = document.createElement('div');
				div37.setAttribute('class','col-3');
				var div38 = document.createElement('div');
				div38.setAttribute('role','button');
				div38.setAttribute('class','text-center');
				div38.setAttribute('id','mainObjectiveContentBackSubDashBoard-'+data[i].planCd);
				div38.innerText = '이전';
				div37.appendChild(div38);
				div34.appendChild(div37);

				div03.appendChild(div34);
				div02.appendChild(div03);
				div01.appendChild(div02);
				/***********************
				 * 버튼 세팅 END
				 * *********************/

				mainObjectiveContent.appendChild(div01);


				$(document).ready(function (e) {
					document.getElementById('mainObjectiveContentProgressBar-'+data[i].planCd).style.width = data[i].rate + '%';
					document.getElementById('mainObjectiveContentPercent-'+data[i].planCd).innerText = data[i].rate + '%';
				});
			}
		})
	}

	async function displaySubObjective(planCd){
		var data;
		var length = 0;
		var param = {
			corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
			planNmSearch: document.getElementById('headerPlanNmSearch').value,
			objectiveDivi: 'sub'
		};
		if(planCd !== undefined && planCd !== null && planCd !== '' ) param.parePlanCd = planCd;
		else param.parePlanCd = '';
		if(document.getElementById('planRoots').innerText.length === 0) param.rootDivi = 'root'; // 목표 루트가 아무거도 없을때는 최상위 목표만 물러오도록 처리
		else param.rootDivi = ''

		new Promise(async (resolve, reject)=>{
			// 1. 데이터 소스 조회
			data = edsUtil.getAjax("/WORK_LOG/selectWorkLogRootObjectList", param);
			resolve();
		}).then((value)=>{
			// 2. 데이터 길이 세팅
			length = data.length;

			// 3. subObjectiveContent 초기화
			let subObjectiveContent = document.getElementById('subObjectiveContent');
			subObjectiveContent.replaceChildren();

			// 4. subObjectiveContent 세팅
			for (let i = 0; i < length; i++) {// 틀
				var div01 = document.createElement('div');
				div01.setAttribute('class','col-6 col-md-3 fade-in-slide-down');
				div01.setAttribute('id','subObjectiveContent-'+data[i].planCd);
				var div02 = document.createElement('div');
				div02.setAttribute('class','card baseBlock');
				var div03 = document.createElement('div');
				div03.setAttribute('class','card-body');
				/*****************
				 * 목표명 세팅 START
				 * ***************/
				var div04 = document.createElement('div');
				div04.setAttribute('class','row');
				var div05 = document.createElement('div');
				div05.setAttribute('class','col-12 col-md-12 pt-0 pb-4 pl-2 pr-2 text-center');
				div05.setAttribute('style','font-size: 1.5rem');
				div05.setAttribute('id','subObjectiveContentPlanNm-'+data[i].planCd);
				div05.innerText = data[i].planNm
				div04.appendChild(div05);
				div03.appendChild(div04);
				/*****************
				 * 목표명 세팅 END
				 * ***************/

				/***********************
				 * 사람얼굴 세팅 START
				 * *********************/
				var div08 = document.createElement('div');
				div08.setAttribute('class','row');
				var div09 = document.createElement('div');
				div09.setAttribute('class','col-12 col-md-12 pt-0 pb-4 pl-2 pr-2 text-center');
				div09.setAttribute('id','subObjectiveContentPartCdsFace-'+data[i].planCd);
				/***********************
				 * 사람얼굴 세팅 END
				 * *********************/

				/***********************
				 * 리더|구성원 세팅 START
				 * *********************/

				/* 상세보기 시, 구성원 연동*/
				var partsData = edsUtil.getAjaxJson('/WORK_LOG/getPartCds',{planCd:data[i].planCd}).data
				var dataLength = partsData.length;

				var partNms = ''
				for (let j = 0; j < dataLength; j++) {
					if(j===0) partNms += data[i].empNm
					else if(j === dataLength-1) partNms += ' 외 ' + (dataLength-1) + '명'
					var partImg = document.createElement('img')
					partImg.setAttribute('src',partsData[j].partImg);
					partImg.setAttribute('title',partsData[j].depaCd);
					partImg.setAttribute('style',
							'width: 2rem;' +
							'height: 2rem;' +
							'margin-right: 10px;' +
							'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
							'border-radius: 50%;' +
							'border-style: none;' +
							'');
					div09.appendChild(partImg);
				}
				div08.appendChild(div09);


				var div06 = document.createElement('div');
				div06.setAttribute('class','row');
				var div07 = document.createElement('div');
				div07.setAttribute('class','col-12 col-md-12 pt-0 pb-4 pl-2 pr-2 text-center');
				div07.setAttribute('id','subObjectiveContentPartCds-'+data[i].planCd);
				div07.innerText = '리더 ' + partNms
				div06.appendChild(div07);
				div03.appendChild(div06); // 리더 구성원 글자 세팅
				div03.appendChild(div08); // 구성원 얼굴 세팅
				/***********************
				 * 리더|구성원 세팅 END
				 * *********************/

				/***********************
				 * 진행상태 세팅 START
				 * *********************/
				var div10 = document.createElement('div');
				div10.setAttribute('class','row');


				// progress bar
				var div11 = document.createElement('div');
				div11.setAttribute('class','col-12 col-md-12 pt-0 pb-3 pl-2 pr-2');
				var div16 = document.createElement('div');
				div16.setAttribute('class','row w-md-100 mt-1');
				var div17 = document.createElement('div');
				div17.setAttribute('class','col-md-12');
				var div18 = document.createElement('div');
				div18.setAttribute('class','progress-container');
				var div19 = document.createElement('div');
				div19.setAttribute('class','progress-bar');
				div19.setAttribute('id','subObjectiveContentProgressBar-'+data[i].planCd);
				var span01 = document.createElement('span');
				span01.setAttribute('class','percent');
				span01.setAttribute('id','subObjectiveContentPercent-'+data[i].planCd);
				div18.appendChild(div19);
				div18.appendChild(span01);
				div17.appendChild(div18);
				div16.appendChild(div17);
				div11.appendChild(div16);
				div10.appendChild(div11);


				// status num
				let totStatus = {
					divi01: 0,
					divi02: 0,
					divi03: 0,
					divi04: 0,
				};

				if(data[i].statusDivi === null || data[i].statusDivi === undefined) data[i].statusDivi = ''
				let statusArr = data[i].statusDivi.split(",")
				for (let j = 0; j < statusArr.length; j++) {
					switch (statusArr[j]) {
						case '01': totStatus.divi01 += 1; break;
						case '02': totStatus.divi02 += 1; break;
						case '03': totStatus.divi03 += 1; break;
						case '04': totStatus.divi04 += 1; break;
					}
				}

				var div20 = document.createElement('div');
				div20.setAttribute('class','col-12 col-md-12 text-center pt-0 pb-3 pl-2 pr-2');
				var div21 = document.createElement('div');
				div21.setAttribute('class','row');

				var div22 = document.createElement('div'); // 대기
				div22.setAttribute('class','col-6 col-md-6 text-center');
				div22.setAttribute('style','border-right: 2px solid #f6f5f8');
				var div23 = document.createElement('div');
				div23.setAttribute('class','col-md-12');
				div23.innerText = '대기';
				var div24 = document.createElement('div');
				div24.setAttribute('class','col-md-12');
				div24.setAttribute('id','subObjectiveContentStatusDivi01-'+data[i].planCd);
				div24.innerText = totStatus.divi01;
				div22.appendChild(div23);
				div22.appendChild(div24);
				div21.appendChild(div22);


				var div25 = document.createElement('div'); // 진행중
				div25.setAttribute('class','col-6 col-md-6 text-center');
				var div26 = document.createElement('div');
				div26.setAttribute('class','col-md-12');
				div26.innerText = '진행중';
				var div27 = document.createElement('div');
				div27.setAttribute('class','col-md-12');
				div27.setAttribute('style','color:#68bae7');
				div27.setAttribute('id','subObjectiveContentStatusDivi02-'+data[i].planCd);
				div27.innerText = totStatus.divi02;
				div25.appendChild(div26);
				div25.appendChild(div27);
				div21.appendChild(div25);


				var div28 = document.createElement('div'); // 문제
				div28.setAttribute('class','col-6 col-md-6 text-center');
				div28.setAttribute('style','border-right: 2px solid #f6f5f8');
				var div29 = document.createElement('div');
				div29.setAttribute('class','col-md-12');
				div29.innerText = '문제';
				var div30 = document.createElement('div');
				div30.setAttribute('class','col-md-12');
				div30.setAttribute('style','color:#da362e');
				div30.setAttribute('id','subObjectiveContentStatusDivi03-'+data[i].planCd);
				div30.innerText = totStatus.divi03;
				div28.appendChild(div29);
				div28.appendChild(div30);
				div21.appendChild(div28);


				var div31 = document.createElement('div'); // 완료
				div31.setAttribute('class','col-6 col-md-6 text-center');
				var div32 = document.createElement('div');
				div32.setAttribute('class','col-md-12');
				div32.innerText = '완료';
				var div33 = document.createElement('div');
				div33.setAttribute('class','col-md-12');
				div33.setAttribute('style','color:#51ab42');
				div33.setAttribute('id','subObjectiveContentStatusDivi04-'+data[i].planCd);
				div33.innerText = totStatus.divi04;
				div31.appendChild(div32);
				div31.appendChild(div33);
				div21.appendChild(div31);
				div20.appendChild(div21);
				div10.appendChild(div20);
				div03.appendChild(div10);
				/***********************
				 * 진행상태 세팅 END
				 * *********************/

				/***********************
				 * 버튼 세팅 START
				 * *********************/
				var div34 = document.createElement('div');
				div34.setAttribute('class','row justify-content-center');

				// 현황
				var div35 = document.createElement('div');
				div35.setAttribute('class','col-3');
				var div36 = document.createElement('div');
				div36.setAttribute('role','button');
				div36.setAttribute('class','text-center');
				div36.setAttribute('id','subObjectiveContentMoveDetailDashBoard-'+data[i].planCd);
				div36.innerText = '현황';
				div35.appendChild(div36);
				div34.appendChild(div35);

				// 하위
				var div37 = document.createElement('div');
				div37.setAttribute('class','col-3');
				var div38 = document.createElement('div');
				div38.setAttribute('role','button');
				div38.setAttribute('class','text-center');
				div38.setAttribute('id','subObjectiveContentMoveSubDashBoard-'+data[i].planCd);
				div38.innerText = '하위';
				div37.appendChild(div38);
				div34.appendChild(div37);

				div03.appendChild(div34);
				div02.appendChild(div03);
				div01.appendChild(div02);
				/***********************
				 * 버튼 세팅 END
				 * *********************/

				subObjectiveContent.appendChild(div01);


				$(document).ready(function (e) {
					document.getElementById('subObjectiveContentProgressBar-'+data[i].planCd).style.width = data[i].rate + '%';
					document.getElementById('subObjectiveContentPercent-'+data[i].planCd).innerText = data[i].rate + '%';
				});
			}
		})
	}

	async function displayDetailKeyResultList(planCd){
		var planCds = [];
		var data;
		var periodDivi;
		var periodValue;
		var length = 0;
		var param = {};

		new Promise(async (resolve, reject)=>{
			// 0. 조회값 설정
			periodDivi = $('.selectpicker').select2('data')[0].id;
			periodValue = $('#datepicker').val();

			param.planCd = planCd
			param.periodDivi = periodDivi
			switch (periodDivi) {
				case '':
					break;
				case '01':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					periodValue = periodValue.split('~')
					param.stDt = periodValue[0];
					param.edDt = periodValue[1];
					break;
				case '02':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					param.stDt = periodValue;
					break;
				case '03':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					periodValue = periodValue.split('~')
					param.stDt = periodValue[0].substring(0, 4);
					break;
			}
			resolve();
		}).then((value)=> {
			// 1. 데이터 소스 조회
			data = edsUtil.getAjax("/WORK_LOG/getLowKeyResultsForSch", param);
		}).then((value)=>{
			// 2. 데이터 길이 세팅
			length = data.length;

			// 3. detailKeyObjectList 초기화
			var detailKeyObjectList = document.getElementById('detailKeyObjectList');
			detailKeyObjectList.replaceChildren();

			// 4. detailKeyObjectList 세팅
			for (let i = 0; i < length; i++) {
				planCds.push(data[i].planCd)
				var div01 = document.createElement('div');
				div01.setAttribute('class','col-md-12 p-2 fade-in-slide-down');

				var div02 = document.createElement('div');
				div02.setAttribute('class','card w-100 color-transition p-0');
				div02.setAttribute('id','detailKeyObjectListTransition-'+data[i].planCd);

				var div03 = document.createElement('div');
				div03.setAttribute('class','card-body');
				div03.setAttribute('id','detailKeyObjectListCardBody-'+data[i].planCd);

				var div04 = document.createElement('div');
				div04.setAttribute('class','row');

				/*****************
				 * 목표명 세팅 START
				 * ***************/
				var div05 = document.createElement('div');
				div05.setAttribute('class','col-12 h4 mb-0 pb-2');
				div05.setAttribute('id','detailKeyObjectListPlanNm-'+data[i].planCd);
				div05.textContent = data[i].planNm;
				/*****************
				 * 목표명 세팅 END
				 * ***************/

				/***********************
				 * 사람얼굴 세팅 START
				 * *********************/
				var div07 = document.createElement('div');
				div07.setAttribute('class','col-12 pb-2');
				div07.setAttribute('id','detailKeyObjectListPartCdsFace-'+data[i].planCd);
				/***********************
				 * 사람얼굴 세팅 END
				 * *********************/

				/***********************
				 * 리더|구성원 세팅 START
				 * *********************/

				/* 상세보기 시, 구성원 연동*/
				var partsData = edsUtil.getAjaxJson('/WORK_LOG/getPartCds',{planCd:data[i].planCd}).data
				var dataLength = partsData.length;

				var partNms = ''
				for (let j = 0; j < dataLength; j++) {
					if(j===0) partNms += data[i].empNm
					else if(j === dataLength-1) partNms += ' 외 ' + (dataLength-1) + '명'
					var partImg = document.createElement('img')
					partImg.setAttribute('src',partsData[j].partImg);
					partImg.setAttribute('title',partsData[j].depaCd);
					partImg.setAttribute('id','detailKeyObjectListImgs'+j+'-'+data[i].planCd);
					partImg.setAttribute('style',
							'width: 2rem;' +
							'height: 2rem;' +
							'margin-right: 10px;' +
							'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
							'border-radius: 50%;' +
							'border-style: none;' +
							'');
					div07.appendChild(partImg);
				}

				var div06 = document.createElement('div');
				div06.setAttribute('class','col-12 pb-2');
				div06.setAttribute('id','detailKeyObjectListPartCds-'+data[i].planCd);
				div06.innerText = '리더 ' + partNms
				/***********************
				 * 리더|구성원 세팅 END
				 * *********************/

				/***********************
				 * card 세팅 START
				 * *********************/
				div04.appendChild(div05);
				div04.appendChild(div06);
				div04.appendChild(div07);
				div03.appendChild(div04);
				div02.appendChild(div03);
				div01.appendChild(div02);
				/***********************
				 * card 세팅 END
				 * *********************/

				/***********************
				 * card 삽입 START
				 * *********************/
				detailKeyObjectList.appendChild(div01);
				/***********************
				 * card 삽입 END
				 * *********************/
			}
		}).then((value) => {
			detailKeyObjectListPlanCdsRoot = planCds;
			detailProgressChart(planCds);
		}).then((value) => {
			detailProgressChartPlanList(planCds);
		})
	}

	async function detailProgressChart(planCds){
		// 0. 조회값 설정
		var data;
		var param = {
			planCds : planCds,
		};

		var periodDivi;
		var periodValue;

		new Promise((resolve, reject)=>{
			periodDivi = $('.selectpicker').select2('data')[0].id;
			periodValue = $('#datepicker').val();
			param.periodDivi = periodDivi
			resolve();
		}).then(value => {
			switch (periodDivi) {
				case '':
					break;
				case '01':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					periodValue = periodValue.split('~')
					param.edDt = periodValue[1];
					break;
				case '02':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					param.edDt = periodValue;
					break;
				case '03':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					periodValue = periodValue.split('~')
					param.edDt = periodValue[0].substring(0, 4);
					break;
			}
		}).then(value => {
			data = edsUtil.getAjax("/WORK_LOG/getWorkLogSchDetailProgressChart", param);
			var length = data.length;
			var labels = [];
			var planPer = [];
			var checkInPer = [];
			// if(length > 0){
				for (let i = 0; i < length; i++) {
					labels.push(data[i].planDt)
					planPer.push(data[i].planPer)
					checkInPer.push(data[i].checkInPer)
				}
				var data = {
					labels: labels,
					datasets: [{
						label: '계획',
						backgroundColor: 'rgb(217,217,217)',
						borderColor: 'rgb(217,217,217)',
						data: planPer,
						fill: false,
					},{
						label: '체크인',
						backgroundColor: 'rgb(17,31,147)',
						borderColor: 'rgb(17,31,147)',
						data: checkInPer,
						fill: false,
					},]
				};

				// Chart 유무
				if (typeof detailProgressChartInstance !== 'undefined') {
					detailProgressChartInstance.destroy();
				}
				// Chart 생성
				var detailProgressChartx = document.getElementById('detailProgressChart').getContext('2d');
				detailProgressChartInstance = new Chart(detailProgressChartx, {
					type: 'bar',
					data: data,
					options: {
						responsive: true,
						plugins: {
							title: {
								display: true,
								text: '계획 대비 실적 현황'
							}
						},
					},
				});
			// }
		})
	}

	async function detailProgressChartPlanList(planCds){
		// 0. 조회값 설정
		var data;
		var param = {
			planCds : planCds,
		};

		var periodDivi;
		var periodValue;

		new Promise((resolve, reject)=>{
			periodDivi = $('.selectpicker').select2('data')[0].id;
			periodValue = $('#datepicker').val();
			param.periodDivi = periodDivi
			resolve();
		}).then(value => {
			switch (periodDivi) {
				case '':
					break;
				case '01':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					periodValue = periodValue.split('~')
					param.edDt = periodValue[1];
					break;
				case '02':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					param.edDt = periodValue;
					break;
				case '03':
					periodValue = periodValue.replaceAll(' ','');
					periodValue = periodValue.replaceAll('-','');
					periodValue = periodValue.split('~')
					param.edDt = periodValue[0].substring(0, 4);
					break;
			}
		}).then(value => {
			new Promise((resolve, reject) => {
				data = edsUtil.getAjax("/WORK_LOG/getWorkLogSchDetailProgressChartPlanList", param);
				resolve();
			}).then(value1 => {
				planKeyResultGridList.refreshLayout(); // 데이터 초기화
				planKeyResultGridList.clear(); // 데이터 초기화
			}).then(value1 => {
				planKeyResultGridList.resetData(data);
			})
		})
	}

	async function detailCalenderToggle(divi){
		switch (divi) {
			case '':
				/* 데이트픽커 초기 속성 설정 */
				flatpickr("#datepicker").clear();
				flatpickr("#datepicker").destroy();
				document.getElementById('datepicker').classList.add('d-none');
				break;
			case '01':
				document.getElementById('datepicker').classList.remove('d-none');
				/* 데이트픽커 초기 속성 설정 */
				// 현재 날짜를 가져옵니다.
				const today = new Date();

				// 이전 주의 시작 날짜를 계산합니다.
				const startOfLastWeek = new Date(today);
				startOfLastWeek.setDate(startOfLastWeek.getDate() - startOfLastWeek.getDay() - 6);

				// 이전 주의 마지막 날짜를 계산합니다.
				const endOfLastWeek = new Date(today);
				endOfLastWeek.setDate(endOfLastWeek.getDate() - endOfLastWeek.getDay());

				/* 데이트픽커 초기 속성 설정 */
				datepicker = flatpickr("#datepicker", {
					locale: 'ko',
					mode: 'range',
					// 선택된 기간을 기본값으로 설정합니다.
					defaultDate: [startOfLastWeek, endOfLastWeek],
					onChange: function(selectedDates, dateStr, instance) {
						// 선택된 날짜가 있을 경우에만 처리
						if (selectedDates.length > 0) {
							// 선택된 날짜의 첫번째 날을 가져옴
							const selectedDate = selectedDates[0];
							// 해당 주의 시작 날짜를 계산 (월요일)
							const startOfWeek = new Date(selectedDate);
							startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay() + 1);
							// 해당 주의 마지막 날짜를 계산 (일요일)
							const endOfWeek = new Date(selectedDate);
							endOfWeek.setDate(endOfWeek.getDate() - endOfWeek.getDay() + 7);
							// 기간으로 선택된 날짜를 설정
							instance.setDate([startOfWeek, endOfWeek]);
							new Promise((resolve, reject)=>{
								displayDetailKeyResultList(rootPlanCd);
							}).then((value) =>{
								if(detailKeyObjectListPlanCds.length > 0){
									console.log(detailKeyObjectListPlanCds)
									detailProgressChart(detailKeyObjectListPlanCds);
								}
							})
						}
					}
				});
				break;
				case '02':
					document.getElementById('datepicker').classList.remove('d-none');
					/* 데이트픽커 초기 속성 설정 */
					datepicker = flatpickr("#datepicker", {
						locale: 'ko',
						defaultDate: new Date(new Date().getFullYear(), new Date().getMonth() - 1, 1),
						onChange: function(selectedDates, dateStr, instance) {
							// 선택된 날짜가 있을 경우에만 처리
							if (selectedDates.length > 0) {
								displayDetailKeyResultList(rootPlanCd)
							}
						},
						plugins: [
							new monthSelectPlugin({
								shorthand: true, //defaults to false
								dateFormat: "Y-m", //defaults to "F Y"
								altFormat: "F Y", //defaults to "F Y"
							})
						],
					});
				break;
				case '03':
					document.getElementById('datepicker').classList.remove('d-none');
					/* 데이트픽커 초기 속성 설정 */
					datepicker = flatpickr("#datepicker", {
						locale: 'ko',
						mode: 'range',
						defaultDate: [
							new Date(new Date().getFullYear(), 0, 1),
							new Date(new Date().getFullYear(), 11, 31)
						],
						onChange: function(selectedDates, dateStr, instance) {
							// 선택된 날짜가 있을 경우에만 처리
							if (selectedDates.length > 0) {
								// 선택된 날짜의 연도와 월을 추출
								const year = instance.selectedDates[0].getFullYear();
								instance.setDate([new Date(year, 0, 1), new Date(year, 11, 31)]);
								displayDetailKeyResultList(rootPlanCd)
							}
						},
						plugins: [
							new monthSelectPlugin({
								shorthand: true, //defaults to false
								dateFormat: "Y-m", //defaults to "F Y"
								altFormat: "F Y", //defaults to "F Y"
							})
						]
					});
				break;
		}
	}
	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>