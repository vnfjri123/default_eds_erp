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
		.card {
			margin-top: 1rem;
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
			background: linear-gradient(to right, rgb(253, 201, 106) 0%, rgba(250,30,30,1) 50%, rgba(130,60,180,1) 100%);
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
		.color-fill {
			display: inline-block;
			color: #fff;
			background: linear-gradient(to left, transparent 50%, #111f93 50%) left;
			background-size: 200%;
			transition: 0.2s ease-out;
		}

		/* 호버하거나, 클래스가 추가될 때 채워지는 효과를 활성화 */
		.color-fill.active {
			background-position: right;
		}

		.color-revert {
			display: inline-block;
			color: #333;
			background: linear-gradient(to left, transparent 50%, #111f93 50%) left;
			background-size: 202%;
			transition: 0.2s ease-out;
			background-position: right; /* 초기 상태를 채워진 상태로 설정 */
		}

		/* 호버하거나, 클래스가 추가될 때 원래 상태로 돌아가는 효과 활성화 */
		.color-revert.active {
			background-position: left;
		}

		/* 드래그 막기 */
		body {
			user-select: none; /* 드래그 막기 */
		}

		/* bootstrap4.6 col에 스크롤 가능하게함 */
		.scrollable-div {
			overflow-y: auto; /* 세로 스크롤 활성화 */
			scroll-behavior: smooth; /* 부드러운 스크롤 효과 적용 */
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
		/************************
		* card css END
		*************************/
		/************************
		* select2 css START
		*************************/
		.select2-selection__rendered {
			line-height: calc(2.25rem + 2px) !important;
			margin-top: -6px !important;
		}
		.select2-container .select2-selection--single {
			height: calc(2.25rem + 2px) !important;
		}
		.select2-selection__arrow {
			height: calc(2.25rem + 2px) !important;
		}
		/************************
		* select2 css END
		*************************/
		/************************
		* loading Make css START
		*************************/
		.loading-container {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background: rgba(0, 0, 0, 0.7);
			align-items: center;
			justify-content: center;
			z-index: 2031;
		}

		.loading-circle {
			position: relative;
			width: 80px;
			height: 80px;
			border-radius: 50%;
			background: radial-gradient(circle, #2980b9 10%, transparent 60%),
			conic-gradient(from 90deg, #3498db, #9b59b6, #3498db);
			animation: rotateCircle 2s linear infinite, pulsate 2s ease-out infinite alternate;
		}

		@keyframes rotateCircle {
			0% {
				transform: rotate(0deg);
			}
			100% {
				transform: rotate(360deg);
			}
		}

		@keyframes pulsate {
			0% {
				box-shadow: 0 0 0 0 rgba(52, 152, 219, 0.7);
			}
			100% {
				box-shadow: 0 0 20px 10px rgba(52, 152, 219, 0);
			}
		}
		/************************
		* loading Make css END
		*************************/
	</style>
</head>

<body id="body_0" name="body">
	<div class="row">
		<div class="col-12" id="search">
			<section id="searchSection" name="searchSection">
				<div class="col-12 col-md-12">
					<div class="row">
						<div class="col-12 col-md-6">
							<b style="font-size: 2rem">성과 대쉬보드</b>
						</div>
						<div class="col-12 col-md-6 pt-1">
							<div class="row">
								<div class="col-12 col-md-3">
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
								<div class="col-12 col-md-6">
									<div class="input-group d-flex justify-content-end">
										<input type="search" class="form-control" id='diagramHeadPlanNmSearch' placeholder="검색">
										<div class="input-group-append">
											<button type="button" class="btn btn-default" id="searchPlanNmButton" name="searchPlanNmButton"><i class="fa fa-search"></i></button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<section id="headerSection" name="headerSection">
				<div class="row">
					<div class="col-4"><span style="font-size: 1.1rem">목표내역</span></div>
					<div class="col-8">
						<div class="row">
							<div class="col-12 col-md-3"><span style="font-size: 1.1rem">하위핵심결과지표</span></div>
							<div class="col-12 col-md-9"><span style="font-size: 1.1rem;cursor: pointer;">활동내역</span></div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<div class="col-4 scrollable-div" id="diagram" style="padding-right: 1rem;border-right: 0.3rem solid #e2e2e2;">
		</div>
		<div class="col-8" id="detail">
			<div class="row" id="detailRow">
				<div class="col-12 col-md-3 scrollable-div" style="border-right: 0.3rem solid #e0e0e0;" id="detailKeyResultList">
				</div>
				<div class="col-12 col-md-9 pr-0 scrollable-div"  id="detailKeyObjectInfo">
				</div>
			</div>
		</div>
	</div>
	<div id="loading" class="loading-container">
		<div class="loading-circle"></div>
	</div>
</body>
</html>
<script>
	/** @type {number} 현재 섹션 순서 */
	let sectionNum = 0;
	/** @type {string} 클릭된 현재 계획코드 */
	var rootPlanCd;
	/** @type {*[]} 목표 클릭 전 전체 kr 코드 */
	var detailKeyResultListPlanCdsAll = [];
	/** @type {*[]} 목표 클릭 전 활동된 전체 kr 코드 */
	var detailKeyResultListDisplayPlanCds = [];
	/** @type {*[]} 목표 클릭 후 해당 kr 코드 */
	var detailKeyResultListPlanCds = [];
	$(document).ready(async function () {

		//#region detail height 세팅
		document.getElementById('diagram').style.height = 'calc(100vh - '+document.getElementById('search').clientHeight+'px)';
		document.getElementById('detailKeyResultList').style.height = 'calc(100vh - '+document.getElementById('search').clientHeight+'px)';
		document.getElementById('detailKeyObjectInfo').style.height = 'calc(100vh - '+document.getElementById('search').clientHeight+'px)';
		//#endregion detail height 세팅

		//#region bootstrap select2 세팅
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
							await detailCalenderToggle(targetValue);
							resolve();
						}).then((value)=>{
							// 2. 주간, 월간, 연간 대비 목표 데이터 가져오기
							new Promise((resolve, reject) => {
								let sections = document.querySelectorAll('div[id="diagram"] section')
								let sectionsLength = sections.length;
								for (let i = 0; i < sectionsLength; i++) {
									sections[i].remove();
								}

								resolve();
							}).then((value)=>{
								// 3. 주간, 월간, 연간 대비 KR 데이터 초기화
								document.getElementById('detailKeyResultList').replaceChildren();
							}).then(value => {
								switch (targetValue) {
									case "": // 없음
										break;
									case "01": // 주간
										new Promise((resolve, reject)=>{
											// 다이어그램세팅
											diagramAddSection('','main');
											resolve();
										}).then((value) =>{
											// 그래프세팅
											displayDetailKeyResultList(rootPlanCd);
										})
										break;
									case "02": // 월간
										new Promise((resolve, reject)=>{
											// 다이어그램세팅
											diagramAddSection('','main');
											resolve();
										}).then((value) =>{
											// 그래프세팅
											displayDetailKeyResultList(rootPlanCd);
										})
										break;
									case "03": // 연간
										new Promise((resolve, reject)=>{
											// 다이어그램세팅
											diagramAddSection('','main');
											resolve();
										}).then((value) =>{
											// 그래프세팅
											displayDetailKeyResultList(rootPlanCd);
										})
										break;
								}
							})
						}).then((value)=>{
							// 3.
						})

						break;
				}
			}
		});
		//#endregion

		//#region body_0 클릭 이벤트
		document.getElementById('body_0').addEventListener('click', async ev => {
			/** @type {HTMLElement} 바디0 클릭 타겟 */
			let targetEl = ev.target;
			/** @type {string} 바디0 클릭 타겟 아이디 */
			let targetElId = ev.target.id;
			// let targetElId = ev.target.id;
			/** @type {string} 섹션 마지막 엘리멘트 */
			let planCd = targetElId.includes('-')?targetElId.split('-')[1]:'';
			rootPlanCd = planCd;
			switch (true) {
				case targetElId.includes('diagram'):
					if(targetElId.includes('diagramAddSection')){
						new Promise((resolve, reject) => {
							/** @type {HTMLElement} 섹션 클릭 타겟 */
							let sectionEls = ev.target.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
							let sectionElsLength = sectionEls.children.length;

							let sectionEl = ev.target.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
							let sectionElId = sectionEl.id;

							let cardEls = document.querySelectorAll('section[id="'+sectionElId+'"] div[name="diagramContent"]');
							let cardElsLength = cardEls.length;

							// 1. 해당섹션 css 초기화
							for (let i = 0; i < cardElsLength; i++) {
								if(cardEls[i].classList.contains('color-fill')){
									cardEls[i].classList.remove('color-fill');
									cardEls[i].classList.add('color-revert');
								}
							}
							// 2. 해당섹션 이하 섹션 초기화
							for (let i = sectionElId.split('-')[1]*1+1; i < sectionElsLength; i++) {
								document.getElementById('section-'+i.toString().padStart(3, '0')).remove();
							}
							// 3. 해당섹션 카드 추가
							/** @type {HTMLElement} 카드 클릭 타겟 */
							let cardEl = ev.target.parentNode.parentNode.parentNode;
							cardEl.classList.remove('color-revert');
							cardEl.classList.add('color-fill');

							// 4. 디테일 kr 초기화
							/** @type {HTMLElement} 카드 클릭 타겟 */
							let detailKeyResultList = document.getElementById('detailKeyResultList');
							detailKeyResultList.replaceChildren();

							// 5. 디테일 활동내역 초기화
							/** @type {HTMLElement} 카드 클릭 타겟 */
							let detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
							detailKeyObjectInfo.replaceChildren();
							detailKeyResultListPlanCds.length = 0;
							resolve();
						}).then((value) =>{
							// 로딩마스크 on
							on();
							return promiseThenDelay(value,250); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value) =>{
							// 다이어그램세팅
							diagramAddSection(planCd,'sub');
						}).then((value) =>{
							// KR 세팅
							displayDetailKeyResultList(rootPlanCd);
						}).then((value) =>{
							return promiseThenDelay(value,50); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value) =>{
							// 활동 세팅
							displayDetailKeyResultsActivitys(detailKeyResultListPlanCdsAll);
						}).then((value) =>{
							return promiseThenDelay(value,200); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value) =>{
							// 로딩마스크 off
							off();
						})
					}
					break;
				case targetElId.includes('detail'):
					if(targetElId.includes('detailKeyResultList')){
						new Promise((resolve, reject) => {
							/** @type {HTMLElement} 섹션 클릭 타겟 */
							let detailKeyResultListCardBody = document.getElementById('detailKeyResultListCardBody-'+planCd);
							if(detailKeyResultListCardBody.classList.contains('color-revert')){
								detailKeyResultListCardBody.classList.remove('color-revert');
								detailKeyResultListCardBody.classList.add('color-fill');
							}else {
								detailKeyResultListCardBody.classList.remove('color-fill');
								detailKeyResultListCardBody.classList.add('color-revert');
							}

							// detailKeyResultListPlanCds 설정
							if (detailKeyResultListPlanCds.includes(planCd)) {
								var index = detailKeyResultListPlanCds.indexOf(planCd);
								if (index !== -1) {
									detailKeyResultListPlanCds.splice(index, 1);
								}
							} else {
								detailKeyResultListPlanCds.push(planCd)
							}

							// 5. 디테일 활동내역 초기화
							/** @type {HTMLElement} 카드 클릭 타겟 */
							let detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
							detailKeyObjectInfo.replaceChildren();
							resolve();
						}).then((value) =>{
							// 로딩마스크 on
							on();
							return promiseThenDelay(value,250); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value) =>{
							// 활동 세팅
							// KR 세팅
							/** @type {*[]} 클릭된 kr에 대한 활동 planCds 세팅 */
							let planCds = [];
							if(detailKeyResultListPlanCds.length === 0){
								planCds = detailKeyResultListPlanCdsAll;
							}else{
								planCds = detailKeyResultListPlanCds;
							}
							displayDetailKeyResultsActivitys(planCds);
						}).then((value) =>{
							return promiseThenDelay(value,200); // 1초 대기 후 다음 값으로 2를 전달
						}).then((value) =>{
							// 로딩마스크 off
							off();
						})
					}
					break;
			}
		})
		//#endregion
	});

	/* 초기설정 */
	async function init() {

	}
	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/**********************************************************************
	 * 화면 이벤트 영역 END
	 ***********************************************************************/

	//#region 섹션 추가 함수
	/**
	 * planCd와 button 값에 대한 section 세팅
	 * @param {string} planCd - 첫번째 변수 계획코드
	 * @param {string} dataDiv - 두번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function diagramAddSection(planCd, dataDiv){
		/** @type {NodeListOf<HTMLElement>} 섹션 엘리멘트들 */
		let sections;
		/** @type {HTMLElement} 섹션 마지막 엘리멘트 */
		let recentSection;
		/** @type {number} 섹션 엘리멘트 수 */
		let sectionsLength;
		/** @type {string} 섹션 엘리멘트 색상 */
		let sectionsColor;
		/** @type {{corpCd: string, planNmSearch: string, dataDiv: string}} 조회 조건 값 */
		let param = {};
		/** @type {*[]} 조회 값 */
		let dbData = [];
		/** @type {number} 조회값 길이 */
		let dbDataLength;
		/** @type {string} 기간 구분 */
		let dateDiv;
		/** @type {string} 기간 데이터 */
		let datepicker;

		new Promise(async (resolve, reject)=>{
			//#region 1. 섹션 조회
			sections = document.querySelectorAll('div[id="diagram"] section');
			//#endregion
			resolve();
		}).then((value)=>{
			//#region 2. 섹션 길이 세팅
			sectionsLength = sections.length;
			//#endregion
		}).then((value)=>{
			//#region 3. 조회 조건 값 세팅
			param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
			param.planNm = document.getElementById('diagramHeadPlanNmSearch').value;
			param.planCd = planCd;
			param.dataDiv = dataDiv;

			dateDiv = $('.selectpicker').val();
			param.dateDiv = dateDiv;
			if(dateDiv === '01'){
				datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
				datepicker = datepicker.split("~");
				param.stDt = edsUtil.removeMinus(datepicker[0]);
				param.edDt = edsUtil.removeMinus(datepicker[1]);
			}else if(dateDiv === '02'){
				datepicker = document.getElementById('datepicker').value;
				param.stDt = edsUtil.removeMinus(datepicker);
			}else if(dateDiv === '03'){
				datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
				datepicker = datepicker.split("~");
				param.stDt = edsUtil.removeMinus(datepicker[0]);
				param.edDt = edsUtil.removeMinus(datepicker[1]);
			}
			// param.dateDiv = dataDiv;
			//#endregion
		}).then((value)=>{
			//#region 4. 조회값 세팅
			if(dataDiv === 'main' || dataDiv === 'sub') dbData = edsUtil.getAjax("/WORK_LOG/selectWorkLogObjectiveList", param);
			if(dataDiv === 'kr') dbData = edsUtil.getAjax("/WORK_LOG/selectWorkLogKeyResultList", param);
			else if(dataDiv === 'active') dbData = edsUtil.getAjax("/WORK_LOG/selectWorkLogActiveList", param);
			//#endregion
		}).then((value)=>{
			//#region 5. 조회값 길이 세팅
			dbDataLength = dbData.length;
			//#endregion
		}).then((value)=>{
			//#region 6. 조회값 0 일 경우 리턴 처리
			if(dbDataLength === 0) return;
			//#endregion

			//#region 7. diagram 또는 섹션 마지막 엘리먼트 가져오기 및 섹션 색상 선택
			if(sectionsLength - 1 < 0) recentSection = document.getElementById('diagram');
			else recentSection = sections[sectionsLength - 1];
			//#endregion

			/** @type {HTMLElement} 섹션 마지막 엘리멘트에 추가될 섹션 */
			let sectionTag = document.createElement('section');
			sectionTag.setAttribute('style','border-top: 0.3rem solid #e2e2e2;');
			sectionTag.setAttribute('id','section-' + sectionsLength.toString().padStart(3, '0'));
			sectionTag.setAttribute('name','section');

			/** @type {HTMLElement} 섹션 마지막 엘리멘트에 추가될 섹션 */
			let divTag = document.createElement('div');
			divTag.classList.add('row');
			sectionTag.appendChild(divTag);

			//#region 8. section 세팅
			// for(let r = 0; r < 100; r++) {// 틀
			for (let i = 0; i < dbDataLength; i++) {// 틀
				/** @type {HTMLElement} div */
				let div01Tag = document.createElement('div');
				div01Tag.setAttribute('class','col-12 col-sm-6 col-md-6 col-lg-4 col-xl-3 fade-in-slide-down');

				/** @type {HTMLElement} div */
				let div02Tag = document.createElement('div');
				div02Tag.setAttribute('class','card');
				div02Tag.setAttribute('style','background: '+ dbData[i].cntColor);

				/** @type {HTMLElement} div */
				let div03Tag = document.createElement('div');
				div03Tag.setAttribute('id','diagramContent-'+dbData[i].planCd);
				div03Tag.setAttribute('name','diagramContent');
				div03Tag.setAttribute('class','card-body color-revert');

				//#region 8-1. 목표명 세팅
				/** @type {HTMLElement} div */
				let div04Tag = document.createElement('div');
				div04Tag.setAttribute('class','row');

				/** @type {HTMLElement} div */
				let div05Tag = document.createElement('div');
				div05Tag.setAttribute('class','col-12 col-md-12 pt-0 pb-1 pl-2 pr-2 text-center');
				div05Tag.setAttribute('style','font-size: 1.1rem');
				div05Tag.setAttribute('id','diagramPlanNm-'+dbData[i].planCd);
				div05Tag.innerText = dbData[i].planNm
				div04Tag.appendChild(div05Tag);
				div03Tag.appendChild(div04Tag);
				//#endregion

				//#region 8-2. 사람얼굴 세팅
				/** @type {HTMLElement} div */
				let div08Tag = document.createElement('div');
				div08Tag.setAttribute('class','row');

				/** @type {HTMLElement} div */
				let div09Tag = document.createElement('div');
				div09Tag.setAttribute('class','col-12 col-md-12 pt-0 pb-1 pl-2 pr-2 text-center');
				div09Tag.setAttribute('id','diagramPartCdsFace-'+dbData[i].planCd);
				//#endregion

				//#region 8-3. 리더|구성원 세팅
				let partsData = edsUtil.getAjaxJson('/WORK_LOG/getPartCds',{planCd:dbData[i].planCd}).data
				let partsDataLength = partsData.length;

				let partNms = ''
				for (let j = 0; j < partsDataLength; j++) {
					if(j===0) partNms += dbData[i].empNm
					else if(j === partsDataLength-1) partNms += ' 외 ' + (partsDataLength-1) + '명'
					if(j < 3) {
						/** @type {HTMLElement} img */
						let partImg = document.createElement('img')
						partImg.setAttribute('src', partsData[j].partImg);
						partImg.setAttribute('title', partsData[j].depaCd);
						partImg.setAttribute('style',
								'width: 1.5rem;' +
								'height: 1.5rem;' +
								'margin-right: 10px;' +
								'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
								'border-radius: 50%;' +
								'border-style: none;' +
								'');
						div09Tag.appendChild(partImg);
					}
				}
				div08Tag.appendChild(div09Tag);

				/** @type {HTMLElement} div */
				let div30Tag = document.createElement('div');
				div30Tag.setAttribute('class','row');

				/** @type {HTMLElement} div */
				let div31Tag = document.createElement('div');
				div31Tag.setAttribute('class','col-12 col-md-12 pt-0 pb-1 pl-2 pr-2 text-center');
				div31Tag.setAttribute('id','diagramPartCds-'+dbData[i].planCd);
				div31Tag.setAttribute('style','font-size: 0.9rem');
				div31Tag.innerText = '리더 ' + partNms
				div30Tag.appendChild(div31Tag);
				div03Tag.appendChild(div30Tag); // 리더 구성원 글자 세팅
				div03Tag.appendChild(div08Tag); // 구성원 얼굴 세팅
				//#endregion

				//#region 8-4. 진행상태 세팅
				/** @type {HTMLElement} div */
				let div10Tag = document.createElement('div');
				div10Tag.setAttribute('class','row');

				// progress bar
				/** @type {HTMLElement} div */
				let div11Tag = document.createElement('div');
				div11Tag.setAttribute('class','col-12 col-md-12 pt-0 pb-3 pl-2 pr-2');

				/** @type {HTMLElement} div */
				let div12Tag = document.createElement('div');
				div12Tag.setAttribute('class','row w-md-100 mt-1');

				/** @type {HTMLElement} div */
				let div13Tag = document.createElement('div');
				div13Tag.setAttribute('class','col-md-12');

				/** @type {HTMLElement} div */
				let div14Tag = document.createElement('div');
				div14Tag.setAttribute('class','progress-container');

				/** @type {HTMLElement} div */
				let div15Tag = document.createElement('div');
				div15Tag.setAttribute('class','progress-bar');
				div15Tag.setAttribute('id','diagramProgressBar-'+dbData[i].planCd);

				/** @type {HTMLElement} span */
				let span01Tag = document.createElement('span');
				span01Tag.setAttribute('class','percent');
				span01Tag.setAttribute('id','diagramPercent-'+dbData[i].planCd);
				div14Tag.appendChild(div15Tag);
				div14Tag.appendChild(span01Tag);
				div13Tag.appendChild(div14Tag);
				div12Tag.appendChild(div13Tag);
				div11Tag.appendChild(div12Tag);
				div10Tag.appendChild(div11Tag);
				div03Tag.appendChild(div10Tag);
				//#endregion

				//#region 8-5. 버튼 세팅
				/** @type {HTMLElement} div */
				let div16Tag = document.createElement('div');
				div16Tag.setAttribute('class','row justify-content-center');

				/** @type {HTMLElement} div */
				let div17Tag = document.createElement('div');
				div17Tag.setAttribute('class','col-12');

				/** @type {HTMLElement} div */
				let div18Tag = document.createElement('div');
				div18Tag.setAttribute('role','button');
				div18Tag.setAttribute('class','text-center');
				div18Tag.setAttribute('id','diagramAddSection-'+dbData[i].planCd);
				div18Tag.setAttribute('style','font-size: 0.9rem');
				div18Tag.innerText = '하위목표';
				div17Tag.appendChild(div18Tag);
				div16Tag.appendChild(div17Tag);
				div03Tag.appendChild(div16Tag);
				div02Tag.appendChild(div03Tag);
				div01Tag.appendChild(div02Tag);
				//#endregion

				divTag.appendChild(div01Tag);

				$(document).ready(function (e) {
					document.getElementById('diagramProgressBar-'+dbData[i].planCd).style.width = dbData[i].rate + '%';
					document.getElementById('diagramPercent-'+dbData[i].planCd).innerText = dbData[i].rate + '%';
				});
			}
			// }
			if(sectionsLength - 1 < 0) recentSection.appendChild(sectionTag);
			else recentSection.after(sectionTag);
			//#endregion
		}).then(value => {
			document.getElementById('diagram').scrollTop = document.getElementById('diagram').scrollHeight;
		})
	}
	//#endregion

	//#region KR 추가 함수
	/**
	 * parePlanCd에 따른 차트 세팅
	 * @param {string} rootPlanCd - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function displayDetailKeyResultList(rootPlanCd){
		/** @type {*[]} 조회 값 */
		let dbData = [];
		/** @type {number} 조회 길이 값 */
		let dbDataLength = 0;
		/** @type {{parePlanCd: string, dateDiv: string, edDt: string}} 조회 조건 값 */
		let param = {};
		/** @type {string} 기간 구분 */
		let dateDiv;
		/** @type {string[]} 기간 데이터 */
		let datepicker;
		/** @type {*[]} 계획코드 값들 */
		let planCds = [];
		/** @type {HTMLElement} kr list 공간 */
		let detailKeyResultList;

		new Promise((resolve, reject)=>{
			//#region 1. 조회 조건 세팅
			dateDiv = $('.selectpicker').val();
			datepicker = document.getElementById('datepicker').value;
			param.planCd = rootPlanCd;
			param.dateDiv = dateDiv;
			//#endregion
			resolve();
		}).then(value => {
			//#region 2. 조회 조건 세팅
			switch (dateDiv) {
				case '':
					break;
				case '01':
					datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
					datepicker = datepicker.split("~");
					param.stDt = edsUtil.removeMinus(datepicker[0]);
					param.edDt = edsUtil.removeMinus(datepicker[1]);
					break;
				case '02':
					datepicker = document.getElementById('datepicker').value;
					param.stDt = edsUtil.removeMinus(datepicker);
					break;
				case '03':
					datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
					datepicker = datepicker.split("~");
					param.stDt = edsUtil.removeMinus(datepicker[0]);
					param.edDt = edsUtil.removeMinus(datepicker[1]);
					break;
			}
			//#endregion
		}).then(value => {
			//#region 3. 조회 값 세팅
			dbData = edsUtil.getAjax("/WORK_LOG/getLowKeyResultsForSch", param);
			dbDataLength = dbData.length;
			//#endregion
		}).then(value => {
			//#region 4. 디테일 kr 초기화
			detailKeyResultList = document.getElementById('detailKeyResultList');
			detailKeyResultList.replaceChildren();
			//#endregion
		}).then(value => {
			//#region 5. KR 리스트 세팅
			for (let i = 0; i < dbDataLength; i++) {
				planCds.push(dbData[i].planCd)

				/** @type {HTMLElement} div */
				let div01Tag = document.createElement('div');
				div01Tag.setAttribute('class','col-md-12 p-2 fade-in-slide-down');

				/** @type {HTMLElement} div */
				let div02Tag = document.createElement('div');
				div02Tag.setAttribute('class','card w-100 p-0');
				div02Tag.setAttribute('style','background: '+ dbData[i].cntColor);
				div02Tag.setAttribute('id','detailKeyResultListTransition-'+dbData[i].planCd);

				/** @type {HTMLElement} div */
				let div03Tag = document.createElement('div');
				div03Tag.setAttribute('class','card-body color-revert');
				div03Tag.setAttribute('id','detailKeyResultListCardBody-'+dbData[i].planCd);

				/** @type {HTMLElement} div */
				let div04Tag = document.createElement('div');
				div04Tag.setAttribute('class','row');

				//#region 5-1. KR명 세팅
				/** @type {HTMLElement} div */
				let div05Tag = document.createElement('div');
				div05Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div05Tag.setAttribute('id','detailKeyResultListPlanNm-'+dbData[i].planCd);
				div05Tag.setAttribute('style','font-size: 1.1rem');
				div05Tag.textContent = dbData[i].planNm;
				//#endregion

				//#region 5-1. 목표명 세팅
				/** @type {HTMLElement} div */
				let div06Tag = document.createElement('div');
				div06Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div06Tag.setAttribute('id','detailKeyResultListSubPlanNm-'+dbData[i].planCd);
				div06Tag.setAttribute('style','font-size: 0.9rem');
				div06Tag.textContent = dbData[i].subPlanNm;
				//#endregion

				//#region 5-3. 리더 세팅
				/** @type {HTMLElement} div */
				let div07Tag = document.createElement('div');
				div07Tag.setAttribute('class','col-12 pb-2');
				div07Tag.setAttribute('id','detailKeyResultListPartCds-'+dbData[i].planCd);
				div07Tag.setAttribute('style','font-size: 0.9rem');
				div07Tag.innerText = '리더 ' + dbData[i].empNm
				//#endregion

				//#region 5-4. card 세팅
				div04Tag.appendChild(div05Tag);
				div04Tag.appendChild(div06Tag);
				div04Tag.appendChild(div07Tag);
				div03Tag.appendChild(div04Tag);
				div02Tag.appendChild(div03Tag);
				div01Tag.appendChild(div02Tag);
				//#endregion

				//#region 5-4. card 삽입 세팅
				detailKeyResultList.appendChild(div01Tag);
				//#endregion
			}
			//#endregion
		}).then((value) => {
			detailKeyResultListPlanCdsAll = planCds;
		})
	}
	//#endregion

	//#region KR 추가 함수
	/**
	 * parePlanCd에 따른 차트 세팅
	 * @param {*[]} planCds - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function displayDetailKeyResultsActivitys(planCds){
		/** @type {*[]} 활동 조회 값 */
		let dbData = [];
		/** @type {number} 활동 조회 길이 값 */
		let dbDataLength = 0;
		/** @type {*[]} 계획대비체크인 그래프 조회 값 */
		let dbDataGraph = [];
		/** @type {number} 계획대비체크인 그래프 조회 길이 값 */
		let dbDataGraphLength = 0;
		/** @type {*[]} 계획대비체크인 내역 조회 값 */
		let dbDataNote = [];
		/** @type {number} 계획대비체크인 내역 조회 길이 값 */
		let dbDataNoteLength = 0;
		/** @type {{parePlanCd: string, dateDiv: string, planCdArr: *[], stDt: string, edDt: string}} 조회 조건 값 */
		let param = {};
		/** @type {string} 기간 구분 */
		let dateDiv;
		/** @type {string[]} 기간 데이터 */
		let datepicker;
		/** @type {HTMLElement} 디테일 활동 데이터 */
		let detailKeyObjectInfo;
		/** @type {{}} planCd 그룹될 객체 */
		let grouped = {};
		/** @type {*[]} planCd 그룹된 객체 */
		let groupedData  = [];
		/** @type {number} planCd 그룹된 객체 길이 값 */
		let groupedDataLength = 0;

		new Promise((resolve, reject)=>{
			//#region 1. 조회 조건 세팅
			dateDiv = $('.selectpicker').val();
			datepicker = document.getElementById('datepicker').value;
			param.dateDiv = dateDiv;
			param.planCdArr = planCds;
			//#endregion
			resolve();
		}).then(value => {
			//#region 2. 조회 조건 세팅
			switch (dateDiv) {
				case '':
					break;
				case '01':
					datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
					datepicker = datepicker.split("~");
					param.stDt = edsUtil.removeMinus(datepicker[0]);
					param.edDt = edsUtil.removeMinus(datepicker[1]);
					break;
				case '02':
					datepicker = document.getElementById('datepicker').value;
					param.stDt = edsUtil.removeMinus(datepicker);
					break;
				case '03':
					datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
					datepicker = datepicker.split("~");
					param.stDt = edsUtil.removeMinus(datepicker[0]);
					param.edDt = edsUtil.removeMinus(datepicker[1]);
					break;
			}
			//#endregion
		}).then(value => {
			//#region 3. 활동 값 세팅
			dbData = edsUtil.getAjax("/WORK_LOG/getLowKeyResultsActivitys", param);
			dbDataLength = dbData.length;
			//#endregion
		}).then(value => {
			//#region 4. 디테일 활동 초기화
			detailKeyObjectInfo = document.getElementById('detailKeyObjectInfo');
			detailKeyObjectInfo.replaceChildren();
			//#endregion
		}).then(value => {
			//#region 5. 디테일 활동 데이터 그룹화

			// 데이터를 순회하면서 planCd 기준으로 그룹화
			dbData.forEach((item) => {
				const planCd = item.planCd;
				if (!grouped[planCd]) {
					grouped[planCd] = [];
				}
				grouped[planCd].push(item);
			});

			// grouped 객체의 값들만을 배열로 변환하여 세팅
			groupedData = Object.values(grouped);
			groupedDataLength = groupedData.length;
			//#endregion
		}).then(value => {
			//#region 5. KR 디테일 리스트 세팅 및 detailKeyResultListDisplayPlanCds 초기화
			detailKeyResultListDisplayPlanCds.length = 0;
			for (let i = 0; i < groupedDataLength; i++) {
				/** @type {HTMLElement} div */
				let div01Tag = document.createElement('div');
				div01Tag.setAttribute('class','col-md-12 p-2 fade-in-slide-down');

				/** @type {HTMLElement} div */
				let div02Tag = document.createElement('div');
				div02Tag.setAttribute('class','card w-100 p-0');
				div02Tag.setAttribute('id','detailKeyObjectInfoTransition-'+groupedData[i][0].planCd);

				/** @type {HTMLElement} div */
				let div03Tag = document.createElement('div');
				div03Tag.setAttribute('class','card-body color-revert');
				div03Tag.setAttribute('id','detailKeyObjectInfoCardBody-'+groupedData[i][0].planCd);

				/** @type {HTMLElement} div */
				let div04Tag = document.createElement('div');
				div04Tag.setAttribute('class','row');

				//#region 5-1. KR명 세팅
				/** @type {HTMLElement} div */
				let div05Tag = document.createElement('div');
				div05Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div05Tag.setAttribute('id','detailKeyObjectInfoPlanNm-'+groupedData[i][0].planCd);
				div05Tag.setAttribute('style','font-size: 2rem; margin-bottom: 1rem !important;');
				div05Tag.textContent = groupedData[i][0].planNm;
				//#endregion

				//#region 5-2. 활동내역 틀 세팅
				/** @type {HTMLElement} div */
				let div06Tag = document.createElement('div');
				div06Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div06Tag.setAttribute('style','font-size: 1.0rem');
				//#endregion

				//#region 5-2-1-1. 계획대비체크인 그래프 섹션 세팅
				/** @type {HTMLElement} section */
				let section01Tag = document.createElement('section');
				section01Tag.setAttribute('style','margin-bottom: 1rem;');
				//#endregion

				//#region 5-2-1-2. 계획대비체크인 그래프 캔버스 세팅
				/** @type {HTMLElement} canvas */
				let canvas01Tag = document.createElement('canvas');
				canvas01Tag.setAttribute('id','detailKeyObjectInfoCheckInChart-'+groupedData[i][0].planCd);
				//#endregion

				//#region 5-2-1-3. 계획대비체크인 제목 세팅
				/** @type {HTMLElement} div */
				let div07Tag = document.createElement('div');
				div07Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div07Tag.setAttribute('style','font-size: 1.5rem');
				div07Tag.textContent = '1. 계획 대비 체크인 현황 그래프';
				//#endregion

				//#region 5-2-2-1. 계획대비체크인 내역 섹션 세팅
				/** @type {HTMLElement} div */
				let section02Tag = document.createElement('section');
				section02Tag.setAttribute('style','margin-bottom: 1rem;');
				//#endregion

				//#region 5-2-2-2. 계획대비체크인 내역 테이블 세팅
				/** @type {HTMLElement} table */
				let table01Tag = document.createElement('table');
				table01Tag.setAttribute('class','table table-hover table-sm');
				//#endregion

				//#region 5-2-2-3. 계획대비체크인 내역 테이블 헤더 세팅
				/** @type {HTMLElement} thead */
				let thead01Tag = document.createElement('thead');
				thead01Tag.setAttribute('id','detailKeyObjectInfoThead-'+groupedData[i][0].planCd);
				//#endregion

				//#region 5-2-2-3. 계획대비체크인 내역 테이블 헤더 세팅
				/** @type {HTMLElement} tbody */
				let tbody01Tag = document.createElement('tbody');
				tbody01Tag.setAttribute('id','detailKeyObjectInfoTbody-'+groupedData[i][0].planCd);
				//#endregion

				//#region 5-2-2-4. 계획대비체크인 내역 테이블 헤더 내용 세팅
				/** @type {HTMLElement} tr */
				let tr01Tag = document.createElement('tr');
				/** @type {HTMLElement} th */
				let th01Tag = document.createElement('th');
				th01Tag.setAttribute('scope','col');
				th01Tag.setAttribute('style','font-size: 1rem;text-align: center;');
				th01Tag.innerText = '일자';
				/** @type {HTMLElement} th */
				let th02Tag = document.createElement('th');
				th02Tag.setAttribute('scope','col');
				th02Tag.setAttribute('style','font-size: 1rem;');
				th02Tag.innerText = '계획내용';
				/** @type {HTMLElement} th */
				let th03Tag = document.createElement('th');
				th03Tag.setAttribute('scope','col');
				th03Tag.setAttribute('style','font-size: 1rem;text-align: center;');
				th03Tag.innerText = '수치';
				/** @type {HTMLElement} th */
				let th04Tag = document.createElement('th');
				th04Tag.setAttribute('scope','col');
				th04Tag.setAttribute('style','font-size: 1rem;text-align: center;');
				th04Tag.innerText = '일자';
				/** @type {HTMLElement} th */
				let th05Tag = document.createElement('th');
				th05Tag.setAttribute('scope','col');
				th05Tag.setAttribute('style','font-size: 1rem;');
				th05Tag.innerText = '체크인내용';
				/** @type {HTMLElement} th */
				let th06Tag = document.createElement('th');
				th06Tag.setAttribute('scope','col');
				th06Tag.setAttribute('style','font-size: 1rem;text-align: center;');
				th06Tag.innerText = '수치';
				/** @type {HTMLElement} th */
				let th07Tag = document.createElement('th');
				th07Tag.setAttribute('scope','col');
				th07Tag.setAttribute('style','font-size: 1rem;text-align: center;');
				th07Tag.innerText = '상태';
				//#endregion

				//#region 5-2-2-5. 계획대비체크인 내역 제목 세팅
				/** @type {HTMLElement} div */
				let div08Tag = document.createElement('div');
				div08Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div08Tag.setAttribute('style','font-size: 1.5rem');
				div08Tag.textContent = '2. 계획 대비 체크인 현황 내역';
				//#endregion

				//#region 5-2-3-1. 활동내역 틀 세팅
				/** @type {HTMLElement} div */
				let section03Tag = document.createElement('section');
				section03Tag.setAttribute('style','margin-bottom: 1rem;');
				//#endregion

				//#region 5-2-3-2. 활동 내역 제목 세팅
				/** @type {HTMLElement} div */
				let div09Tag = document.createElement('div');
				div09Tag.setAttribute('class','col-12 h4 mb-0 pb-2');
				div09Tag.setAttribute('style','font-size: 1.5rem');
				div09Tag.textContent = '3. 활동 내역';
				//#endregion

				section03Tag.appendChild(div09Tag);

				//#region 5-3. 활동내역 세팅
				/** @type {HTMLElement} div */
				let br01Tag = document.createElement('br');
				for (let j = 0,length = groupedData[i].length; j < length; j++) {
					/** @type {HTMLElement} img */
					let empImg = document.createElement('img')
					empImg.setAttribute('src', "/BASE_USER_MGT_LIST/selectUserFaceImageEdms/"+groupedData[i][j].corpCd+":"+groupedData[i][j].inpId);
					empImg.setAttribute('title', groupedData[i][j].inpNm);
					empImg.setAttribute("class", "mr-2");
					empImg.setAttribute('style',
							'width: 1.5rem;' +
							'height: 1.5rem;' +
							'margin-right: 10px;' +
							'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
							'border-radius: 50%;' +
							'border-style: none;' +
							'');
					section03Tag.appendChild(empImg);

					// 새 텍스트 노드 생성 및 추가
					/** @type {HTMLElement} div */
					let span = document.createElement('span');
					span.setAttribute("class", "mr-2");
					span.setAttribute('style','font-size: 1.0rem');
					span.innerText = groupedData[i][j].activityDt;
					section03Tag.appendChild(span);

					// 새 텍스트 노드 생성 및 추가
					/** @type {HTMLElement} div */
					let textNode02 = document.createTextNode(groupedData[i][j].content);
					section03Tag.appendChild(textNode02);

					// 새 <br> 요소 생성 및 추가 (각 항목마다 새로운 <br> 태그를 만듭니다)
					/** @type {HTMLElement} div */
					let brTag = document.createElement('br');
					section03Tag.appendChild(brTag);

					// 추가적인 공백을 위한 <span> 요소 생성 및 추가
					/** @type {HTMLElement} div */
					let spaceSpan = document.createElement('span');
					spaceSpan.innerHTML = ' '; // non-breaking space
					section03Tag.appendChild(spaceSpan);

					// 두 번째 <br> 요소 생성 및 추가하여 항목마다 더 많은 공간을 제공
					/** @type {HTMLElement} div */
					let secondBrTag = document.createElement('br');
					section03Tag.appendChild(secondBrTag);
				}
				//#endregion

				//#region 5-4. card 세팅
				tr01Tag.appendChild(th01Tag);
				tr01Tag.appendChild(th02Tag);
				tr01Tag.appendChild(th03Tag);
				tr01Tag.appendChild(th04Tag);
				tr01Tag.appendChild(th05Tag);
				tr01Tag.appendChild(th06Tag);
				tr01Tag.appendChild(th07Tag);
				thead01Tag.appendChild(tr01Tag);
				table01Tag.appendChild(thead01Tag);
				table01Tag.appendChild(tbody01Tag);
				section02Tag.appendChild(div08Tag);
				section02Tag.appendChild(table01Tag);
				section01Tag.appendChild(div07Tag);
				section01Tag.appendChild(canvas01Tag);
				div04Tag.appendChild(div05Tag);
				div06Tag.appendChild(section01Tag);
				div06Tag.appendChild(section02Tag);
				div06Tag.appendChild(section03Tag);
				div04Tag.appendChild(div06Tag);
				div03Tag.appendChild(div04Tag);
				div02Tag.appendChild(div03Tag);
				div01Tag.appendChild(div02Tag);
				//#endregion

				//#region 5-4. card 삽입 세팅
				detailKeyObjectInfo.appendChild(div01Tag);
				//#endregion

				//#region 5-5. detailKeyResultListDisplayPlanCds 세팅
				detailKeyResultListDisplayPlanCds.push(groupedData[i][0].planCd);
				//#endregion
			}
			//#endregion
		}).then((value) => {
			//#region 그래프 세팅
			for (let i = 0, length = detailKeyResultListDisplayPlanCds.length; i < length; i++) {
				var chartStatus = Chart.getChart('detailKeyObjectInfoCheckInChart-'+detailKeyResultListDisplayPlanCds[i]);
				if (chartStatus !== undefined) {
					chartStatus.destroy();
				}
				var param = { //조회조건
					planCd : detailKeyResultListDisplayPlanCds[i],
				};
				var data = edsUtil.getAjax("/WORK_LOG/getWorkLogCheckInKeyResultChart", param);

				// dt와 amt 값을 분리하여 저장할 배열을 초기화합니다.
				var dtValues = [];
				var planningAmtValues = [];
				var ckeckInamtValues = [];
				var edAmtValues = [];

				// 데이터 배열을 순회하면서 각 객체의 dt와 amt 값을 추출하여 배열에 저장합니다.
				data.forEach(item => {
					dtValues.push(item.dt);
					planningAmtValues.push(item.planningAmt);
					ckeckInamtValues.push(item.ckeckInamt);
					edAmtValues.push(item.edAmt);
				});

				var ctx = document.getElementById('detailKeyObjectInfoCheckInChart-'+detailKeyResultListDisplayPlanCds[i]);
				new Chart(ctx, {
					type: 'line',
					data: {
						labels: dtValues,
						datasets: [
							{
								label: '계획',
								fill: true,
								data: planningAmtValues,
								borderColor: `#fd6283`,
								backgroundColor: `rgba(255, 255, 255, 0)`,
								tension: 0.4,
							},
							{
								label: '달성',
								fill: true,
								data: ckeckInamtValues,
								borderColor: `#36a1e9`,
								backgroundColor: `rgba(153, 206, 243, 0.4)`,
								tension: 0.4,
							},
							{
								label: '목표',
								fill: true,
								data: edAmtValues,
								borderColor: `#333333`,
								backgroundColor: `rgba(255, 255, 255, 0)`,
								tension: 0.4,
							},
						]
					},
					options: {
						responsive: true,
						interaction: {
							intersect: false,
							mode: 'index'
						},
						scales: {
							x: {
								beginAtZero: true
							},
							y: {
								beginAtZero: true
							}
						},
						plugins: {
							tooltip: {
								callbacks: {
									footer: (tooltipItems) => {
										let plan = tooltipItems[0].parsed.y;
										let checkIn = tooltipItems[1].parsed.y;
										let target = tooltipItems[2].parsed.y;
										let planRate = 0;
										let CheckInRate = 0;
										let targetDiv = '';
										let rst = [];

										// 진행예정율
										planRate = Math.round(plan*100/target);

										// 진행율
										CheckInRate = Math.round(checkIn*10000/target)/100;

										if(planRate < CheckInRate){
											targetDiv = '⬆️';
										}else if(planRate === CheckInRate){
											targetDiv = '➡️';
										}else if(planRate > CheckInRate){
											targetDiv = '⬇️';
										}

										// 제목
										rst.push('              간편요약 ' + targetDiv);
										rst.push('예정율: ' + planRate + ' % (' + plan + ' / ' + target + ' )');
										rst.push('진척률: ' + CheckInRate + ' % (' + checkIn + ' / ' + target + ' )');
										// 중간 바 02
										return rst;
									},
								}
							}
						}
					}
				});
			}
			//#endregion
		}).then((value) => {
			//#region 그리드 세팅
			if(detailKeyResultListDisplayPlanCds.length > 0){
				var unit = '';
				var planCd = '';
				for (let i = 0, length = detailKeyResultListDisplayPlanCds.length; i < length; i++) {
					var param = { //조회조건
						planCd : detailKeyResultListDisplayPlanCds[i],
					};
					var checkInComparedToPlanList = edsUtil.getAjax("/WORK_LOG/getWorkLogCheckInComparedToPlanList", param);
					var planSeqBf = '';
					var planSeqAf = '';
					var checkInSubAmt = 0;
					var checkInTotAmt = 0;
					var planTotAmt = 0;
					planCd = detailKeyResultListDisplayPlanCds[i];
					for (let j = 0, length = checkInComparedToPlanList.length; j < length; j++) {
						// 단위 세팅
						unit = checkInComparedToPlanList[j].unit;

						// 앞뒤 같은 계획인지 구분
						planSeqAf = checkInComparedToPlanList[j].planSeq;

						// 앞뒤 계획 대비 소계 밑 합계
						checkInSubAmt += Number(checkInComparedToPlanList[j].checkInAmt);
						checkInTotAmt += Number(checkInComparedToPlanList[j].checkInAmt);
						if(planSeqBf !== planSeqAf) planTotAmt += Number(checkInComparedToPlanList[j].planAmt);

						//#region 5-1-1. 체크인 상태값 대비 i 태그 세팅
						var i01Tag = document.createElement('tr');
						switch (checkInComparedToPlanList[j].statusDivi) {
							case '01':
								i01Tag.setAttribute('class','fa-regular fa-face-meh-blank fa-shake fa-lg');
								i01Tag.setAttribute('style','--fa-animation-duration: 3s; --fa-fade-opacity: 0.1;');
								break;
							case '02':
								i01Tag.setAttribute('class','fa-regular fa-face-smile-beam fa-lg fa-flip');
								i01Tag.setAttribute('style','--fa-animation-duration: 3s;color:#68bae7;');
								break;
							case '03':
								i01Tag.setAttribute('class','fa-regular fa-face-surprise fa-beat fa-lg');
								i01Tag.setAttribute('style','color:#da362e');

								break;
							case '04':
								i01Tag.setAttribute('class','fa-regular fa-face-laugh-beam fa-lg');
								i01Tag.setAttribute('style','color:#51ab42');
								break;
						}
						//#endregion 5-1-1. 체크인 상태값 대비 i 태그 세팅

						//#region 5-1-2. 계획대비체크인 내역 테이블 헤더 내용 세팅
						/** @type {HTMLElement} tr */
						let tr01Tag = document.createElement('tr');
						/** @type {HTMLElement} td */
						let td01Tag = document.createElement('td');
						td01Tag.setAttribute('scope','col');
						td01Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');
						if(planSeqBf !== planSeqAf) td01Tag.innerText = checkInComparedToPlanList[j].planDt;
						/** @type {HTMLElement} td */
						let td02Tag = document.createElement('td');
						td02Tag.setAttribute('scope','col');
						td02Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%');
						if(planSeqBf !== planSeqAf) td02Tag.innerText = checkInComparedToPlanList[j].planNote;
						/** @type {HTMLElement} td */
						let td03Tag = document.createElement('td');
						td03Tag.setAttribute('scope','col');
						td03Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
						if(planSeqBf !== planSeqAf) td03Tag.innerText = checkInComparedToPlanList[j].planAmt + ' ' + unit;
						/** @type {HTMLElement} td */
						let td04Tag = document.createElement('td');
						td04Tag.setAttribute('scope','col');
						td04Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');
						td04Tag.innerText = checkInComparedToPlanList[j].checkInDt;
						/** @type {HTMLElement} td */
						let td05Tag = document.createElement('td');
						td05Tag.setAttribute('scope','col');
						td05Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%');
						td05Tag.innerText = checkInComparedToPlanList[j].checkInNote;
						/** @type {HTMLElement} td */
						let td06Tag = document.createElement('td');
						td06Tag.setAttribute('scope','col');
						td06Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
						td06Tag.innerText = checkInComparedToPlanList[j].checkInAmt + ' ' + unit;
						/** @type {HTMLElement} td */
						let td07Tag = document.createElement('td');
						td07Tag.setAttribute('scope','col');
						td07Tag.setAttribute('style','font-size: 0.8rem;width: 5%;text-align: center;');
						//#endregion

						td07Tag.appendChild(i01Tag);
						tr01Tag.appendChild(td01Tag);
						tr01Tag.appendChild(td02Tag);
						tr01Tag.appendChild(td03Tag);
						tr01Tag.appendChild(td04Tag);
						tr01Tag.appendChild(td05Tag);
						tr01Tag.appendChild(td06Tag);
						tr01Tag.appendChild(td07Tag);
						document.getElementById('detailKeyObjectInfoTbody-'+planCd).appendChild(tr01Tag);

						//#region 5-1-3. 앞뒤 계획 대비 소계 세팅
						if(j+1 < length){
							if(checkInComparedToPlanList[j].planSeq !== checkInComparedToPlanList[j+1].planSeq){
								/** @type {HTMLElement} tr */
								let tr01Tag = document.createElement('tr');
								tr01Tag.setAttribute('style', 'background-color: #efefef;')
								/** @type {HTMLElement} td */
								let td01Tag = document.createElement('td');
								td01Tag.setAttribute('scope','col');
								td01Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');

								/** @type {HTMLElement} td */
								let td02Tag = document.createElement('td');
								td02Tag.setAttribute('scope','col');
								td02Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%;text-align: center;');
								td02Tag.innerText = '소계';
								/** @type {HTMLElement} td */
								let td03Tag = document.createElement('td');
								td03Tag.setAttribute('scope','col');
								td03Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
								/** @type {HTMLElement} td */
								let td04Tag = document.createElement('td');
								td04Tag.setAttribute('scope','col');
								td04Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');
								/** @type {HTMLElement} td */
								let td05Tag = document.createElement('td');
								td05Tag.setAttribute('scope','col');
								td05Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%');
								/** @type {HTMLElement} td */
								let td06Tag = document.createElement('td');
								td06Tag.setAttribute('scope','col');
								td06Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
								td06Tag.innerText = checkInSubAmt + ' ' + unit;
								/** @type {HTMLElement} td */
								let td07Tag = document.createElement('td');
								td07Tag.setAttribute('scope','col');
								td07Tag.setAttribute('style','font-size: 0.8rem;width: 5%;text-align: center;');
								//#endregion

								tr01Tag.appendChild(td01Tag);
								tr01Tag.appendChild(td02Tag);
								tr01Tag.appendChild(td03Tag);
								tr01Tag.appendChild(td04Tag);
								tr01Tag.appendChild(td05Tag);
								tr01Tag.appendChild(td06Tag);
								tr01Tag.appendChild(td07Tag);
								document.getElementById('detailKeyObjectInfoTbody-'+planCd).appendChild(tr01Tag);

								checkInSubAmt = 0;
							}
						}else if(j+1 === length){
							/** @type {HTMLElement} tr */
							let tr01Tag = document.createElement('tr');
							tr01Tag.setAttribute('style', 'background-color: #efefef;')
							/** @type {HTMLElement} td */
							let td01Tag = document.createElement('td');
							td01Tag.setAttribute('scope','col');
							td01Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');

							/** @type {HTMLElement} td */
							let td02Tag = document.createElement('td');
							td02Tag.setAttribute('scope','col');
							td02Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%;text-align: center;');
							td02Tag.innerText = '소계';
							/** @type {HTMLElement} td */
							let td03Tag = document.createElement('td');
							td03Tag.setAttribute('scope','col');
							td03Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
							/** @type {HTMLElement} td */
							let td04Tag = document.createElement('td');
							td04Tag.setAttribute('scope','col');
							td04Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');
							/** @type {HTMLElement} td */
							let td05Tag = document.createElement('td');
							td05Tag.setAttribute('scope','col');
							td05Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%');
							/** @type {HTMLElement} td */
							let td06Tag = document.createElement('td');
							td06Tag.setAttribute('scope','col');
							td06Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
							td06Tag.innerText = checkInSubAmt + ' ' + unit;
							/** @type {HTMLElement} td */
							let td07Tag = document.createElement('td');
							td07Tag.setAttribute('scope','col');
							td07Tag.setAttribute('style','font-size: 0.8rem;width: 5%;text-align: center;');
							//#endregion

							tr01Tag.appendChild(td01Tag);
							tr01Tag.appendChild(td02Tag);
							tr01Tag.appendChild(td03Tag);
							tr01Tag.appendChild(td04Tag);
							tr01Tag.appendChild(td05Tag);
							tr01Tag.appendChild(td06Tag);
							tr01Tag.appendChild(td07Tag);
							document.getElementById('detailKeyObjectInfoTbody-'+planCd).appendChild(tr01Tag);

							checkInSubAmt = 0;
						}
						//#endregion 5-1-3. 앞뒤 계획 대비 소계 세팅

						planSeqBf = planSeqAf;

					}

					//#region 5-1-4. 앞뒤 계획 대비 체크인 합계 세팅
					/** @type {HTMLElement} tr */
					let tr01Tag = document.createElement('tr');
					tr01Tag.setAttribute('style', 'background-color: #dbdbdb;')
					/** @type {HTMLElement} td */
					let td01Tag = document.createElement('td');
					td01Tag.setAttribute('scope','col');
					td01Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');

					/** @type {HTMLElement} td */
					let td02Tag = document.createElement('td');
					td02Tag.setAttribute('scope','col');
					td02Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%;text-align: center;');
					td02Tag.innerText = '합계';
					/** @type {HTMLElement} td */
					let td03Tag = document.createElement('td');
					td03Tag.setAttribute('scope','col');
					td03Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
					td03Tag.innerText = planTotAmt + ' ' + unit;
					/** @type {HTMLElement} td */
					let td04Tag = document.createElement('td');
					td04Tag.setAttribute('scope','col');
					td04Tag.setAttribute('style','font-size: 0.8rem;width: 13%;text-align: center;');
					/** @type {HTMLElement} td */
					let td05Tag = document.createElement('td');
					td05Tag.setAttribute('scope','col');
					td05Tag.setAttribute('style','font-size: 0.8rem;width: 27.5%;text-align: center;');
					/** @type {HTMLElement} td */
					let td06Tag = document.createElement('td');
					td06Tag.setAttribute('scope','col');
					td06Tag.setAttribute('style','font-size: 0.8rem;width: 7%;text-align: right;');
					td06Tag.innerText = checkInTotAmt + ' ' + unit;
					/** @type {HTMLElement} td */
					let td07Tag = document.createElement('td');
					td07Tag.setAttribute('scope','col');
					td07Tag.setAttribute('style','font-size: 0.8rem;width: 5%;text-align: center;');
					//#endregion

					tr01Tag.appendChild(td01Tag);
					tr01Tag.appendChild(td02Tag);
					tr01Tag.appendChild(td03Tag);
					tr01Tag.appendChild(td04Tag);
					tr01Tag.appendChild(td05Tag);
					tr01Tag.appendChild(td06Tag);
					tr01Tag.appendChild(td07Tag);
					document.getElementById('detailKeyObjectInfoTbody-'+planCd).appendChild(tr01Tag);

					checkInTotAmt = 0;
					planTotAmt = 0;
					//#endregion 5-1-1. 앞뒤 계획 대비 소계 세팅
				}
			}
			//#endregion
		})
	}
	//#endregion

	//#region 차트 추가 함수
	/**
	 * parePlanCd에 따른 차트 세팅
	 * @param {string} parePlanCd - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function detailProgressChart(parePlanCd){
		/** @type {*[]} 조회 값 */
		let dbData = [];
		/** @type {number} 조회 길이 값 */
		let dbDataLength = 0;
		/** @type {{parePlanCd: string, dateDiv: string}} 조회 조건 값 */
		let param = {};
		/** @type {string} 기간 구분 */
		let dateDiv;
		/** @type {string} 기간 데이터 */
		let datepicker;
		/** @type {*[]} 차트 라벨 값 */
		var labels = [];
		/** @type {*[]} 차트 계획 값 */
		var planPer = [];
		/** @type {*[]} 조회 체크인 값 */
		var checkInPer = [];
		/** @type {{labels: *[], datasets: *[]}} 조회 조건 값 */
		let chartData = {};
		/** @type {Chart} chartInstance - 조회 조건 값 */
		let detailProgressChartInstance;

		new Promise((resolve, reject)=>{
			//#region 1. 조회 조건 세팅
			dateDiv = $('.selectpicker').val();
			datepicker = document.getElementById('datepicker').value;
			param.dateDiv = dateDiv;
			param.parePlanCd = parePlanCd;
			//#endregion
			resolve();
		}).then(value => {
			//#region 2. 조회 조건 세팅
			switch (dateDiv) {
				case '':
					break;
				case '01':
					datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
					datepicker = datepicker.split("~");
					param.edDt = edsUtil.removeMinus(datepicker[1]);
					break;
				case '02':
					datepicker = document.getElementById('datepicker').value;
					param.edDt = edsUtil.removeMinus(datepicker);
					break;
				case '03':
					datepicker = document.getElementById('datepicker').value.replaceAll(" ","");
					datepicker = datepicker.split("~");
					param.edDt = edsUtil.removeMinus(datepicker[1]).substring(0, 4);
					break;
			}
			//#endregion
		}).then(value => {
			//#region 3. 조회 값 세팅
			dbData = edsUtil.getAjax("/WORK_LOG/getWorkLogSchDetailProgressChart", param);
			dbDataLength = dbData.length;
			for (let i = 0; i < length; i++) {
				labels.push(dbData[i].planDt)
				planPer.push(dbData[i].planPer)
				checkInPer.push(dbData[i].checkInPer)
			}

			//#endregion
		})
		// 		.then(value => {
		// 	//#region 4. 차트 세팅
		// 	chartData = {
		// 		labels: labels,
		// 		datasets: [{
		// 			label: '계획',
		// 			backgroundColor: 'rgb(217,217,217)',
		// 			borderColor: 'rgb(217,217,217)',
		// 			data: planPer,
		// 			fill: false,
		// 		},{
		// 			label: '체크인',
		// 			backgroundColor: 'rgb(17,31,147)',
		// 			borderColor: 'rgb(17,31,147)',
		// 			data: checkInPer,
		// 			fill: false,
		// 		},]
		// 	};
		//
		// 	// Chart 유무
		// 	if (typeof detailProgressChartInstance !== 'undefined') {
		// 		detailProgressChartInstance.destroy();
		// 	}
		// 	// Chart 생성
		// 	let detailProgressChartx = document.getElementById('detailProgressChart').getContext('2d');
		// 	detailProgressChartInstance = new Chart(detailProgressChartx, {
		// 		type: 'bar',
		// 		data: chartData,
		// 		options: {
		// 			responsive: true,
		// 			plugins: {
		// 				title: {
		// 					display: true,
		// 					text: '계획 대비 실적 현황'
		// 				}
		// 			},
		// 		},
		// 	});
		//
		// 	//#endregion
		// })
	}
	//#endregion

	//#region 데이터픽커 동기 컨트롤 함수
	/**
	 * dateDiv에 따른 datepicker 세팅
	 * @param {string} dateDiv - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */async function detailCalenderToggle(dateDiv){
		switch (dateDiv) {
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
								// 섹션 초기화
								let sections = document.querySelectorAll('div[id="diagram"] section')
								let sectionsLength = sections.length;
								for (let i = 0; i < sectionsLength; i++) {
									sections[i].remove();
								}
								resolve();
							}).then((value) =>{
								// 디테일 초기화
								document.getElementById('detailKeyResultList').replaceChildren();
							}).then((value) =>{
								// 다이어그램세팅
								diagramAddSection('','main');
							}).then((value) =>{
								// 그래프세팅
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
							new Promise((resolve, reject)=>{
								// 섹션 초기화
								let sections = document.querySelectorAll('div[id="diagram"] section')
								let sectionsLength = sections.length;
								for (let i = 0; i < sectionsLength; i++) {
									sections[i].remove();
								}
								resolve();
							}).then((value) =>{
								// 디테일 초기화
								document.getElementById('detailKeyResultList').replaceChildren();
							}).then((value) =>{
								// 다이어그램세팅
								diagramAddSection('','main');
							}).then((value) =>{
								// 그래프세팅
							})
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
							new Promise((resolve, reject)=>{
								// 섹션 초기화
								let sections = document.querySelectorAll('div[id="diagram"] section')
								let sectionsLength = sections.length;
								for (let i = 0; i < sectionsLength; i++) {
									sections[i].remove();
								}
								resolve();
							}).then((value) =>{
								// 디테일 초기화
								document.getElementById('detailKeyResultList').replaceChildren();
							}).then((value) =>{
								// 다이어그램세팅
								diagramAddSection('','main');
							}).then((value) =>{
								// 그래프세팅
							})
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
	//#endregion

	//#region
	function promiseThenDelay(value, ms) {
		return new Promise(resolve => {
			setTimeout(() => resolve(value), ms);
		});
	}
	// 로딩 애니메이션을 활성화하는 함수
	function on() {
		document.getElementById("loading").style.display = "flex";
	}

	// 로딩 애니메이션을 비활성화하고 서서히 사라지게 하는 함수
	function off() {
		var loadingElement = document.getElementById("loading");
		loadingElement.style.opacity = '0';
		setTimeout(function() {
			loadingElement.style.display = "none";
			loadingElement.style.opacity = '1';
		}, 500); // 로딩 애니메이션을 숨기기 전에 500ms 동안 페이드 아웃 효과를 줍니다.
	}
	//#endregion
</script>