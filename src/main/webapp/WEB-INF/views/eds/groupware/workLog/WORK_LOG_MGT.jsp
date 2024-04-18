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

		.right .modal-dialog-slideout {
			min-height: 100%;
			margin: 0 0 0 auto;
		}
		.right .modal.fade .modal-dialog.modal-dialog-slideout {
			-webkit-transform: translate(100%,0)scale(1);
			transform: translate(100%,0)scale(1);
		}
		.right .modal.fade.show .modal-dialog.modal-dialog-slideout {
			-webkit-transform: translate(0,0);
			transform: translate(0,0);
			display: flex;
			align-items: stretch;
			-webkit-box-align: stretch;
			height: 100%;
		}
		.right .modal.fade.show .modal-dialog.modal-dialog-slideout .modal-body{
			overflow-y: auto;
			overflow-x: hidden;
		}
		.right .modal-dialog-slideout .modal-content{
			border: 0;
			max-height: 100vh;
		}
		.right .posright{
			height: 100%;
		}
		.modal.left.selectFunction .modal-dialog {
			position:fixed;
			right: 0;
			margin: auto;
			width: 150px;
			height: 100%;
			-webkit-transform: translate3d(0%, 0, 0);
			-ms-transform: translate3d(0%, 0, 0);
			-o-transform: translate3d(0%, 0, 0);
			transform: translate3d(0%, 0, 0);
		}
		.fade2 {
			left:100%; top:0; bottom:0; right:-100%;
			transform: scale(0.9);
			opacity: 0;
			transition: all .1s linear;
			/*transition: all .5s cubic-bezier(0.68, -0.55, 0.27, 1.55);*/
			display: block !important;
			width: 150px !important;
		}
		.fade2.show {
			left: calc(100% - 150px); right:0;
			opacity: 1;
			transform: scale(1);
			width: 150px !important;
		}
		.fade3 {
			transform: scale(0.9);
			opacity: 0;
			transition: all 0.1s linear;
			display: none !important;
		}
		.fade3.show {
			opacity: 1;
			transform: scale(1);
		}
		div[id="selectFunctionModal"] div[class="modal-body"]{ cursor: pointer; }
		/************************
		* bootstrap css END
		*************************/

		/************************
		* tui css START
		*************************/
		/*.tui-grid-header-area,*/
		.tui-grid-scrollbar-right-bottom,
		.tui-grid-scrollbar-right-top,
		.tui-grid-scrollbar-y-inner-border,
		.tui-grid-scrollbar-y-outer-border,
		.tui-grid-scrollbar-left-bottom,
		.tui-grid-border-line-bottom{
			display: none;
		}
		.tui-grid-content-area{
			border-bottom: 0;
		}
		.tui-grid-body-area{
			overflow-x: auto;
			overflow-y: hidden;
		}
		.tui-grid-row-odd,
		.tui-grid-row-even{
			border-bottom: 7.5px solid #fff;!important;
		}
		tr[class='tui-grid-row-odd'] td:first-child,
		tr[class='tui-grid-row-even'] td:first-child,
		tr[class='tui-grid-row-odd tui-grid-row-hover'] td:first-child,
		tr[class='tui-grid-row-even tui-grid-row-hover'] td:first-child,
		tr[class='tui-grid-row-odd tui-grid-cell-current-row'] td:first-child,
		tr[class='tui-grid-row-even tui-grid-cell-current-row'] td:first-child,
		tr[class='tui-grid-row-odd tui-grid-row-hover tui-grid-cell-current-row'] td:first-child,
		tr[class='tui-grid-row-even tui-grid-row-hover tui-grid-cell-current-row'] td:first-child
		{
			border-top-left-radius: 2rem;
			border-bottom-left-radius: 2rem;
		}

		tr[class='tui-grid-row-odd'] td:last-child,
		tr[class='tui-grid-row-even'] td:last-child,
		tr[class='tui-grid-row-odd tui-grid-row-hover'] td:last-child,
		tr[class='tui-grid-row-even tui-grid-row-hover'] td:last-child,
		tr[class='tui-grid-row-odd tui-grid-cell-current-row'] td:last-child,
		tr[class='tui-grid-row-even tui-grid-cell-current-row'] td:last-child,
		tr[class='tui-grid-row-odd tui-grid-row-hover tui-grid-cell-current-row'] td:last-child,
		tr[class='tui-grid-row-even tui-grid-row-hover tui-grid-cell-current-row'] td:last-child
		{
			border-top-right-radius: 2rem;
			border-bottom-right-radius: 2rem;
		}

		td[data-column-name='planNm']{ cursor: pointer !important; }
		td[data-column-name='fn']{ cursor: pointer !important; }
		td[data-column-name='dt']{ cursor: pointer !important; }
		td[data-column-name='amt']{ cursor: pointer !important; }

		td[data-column-name='ordPlanCustCd']{ cursor: pointer !important; }
		td[data-column-name='ordPlanAmt']{ cursor: pointer !important; }
		td[data-column-name='ordPlanGr']{ cursor: pointer !important; }

		div[class='tui-grid-layer-state-content'] p{ color:#fff !important; }

		div[class='tui-grid-layer-selection']{
			background-color: unset;
			border: unset;
		}
		div[id='planningKeyResultGridListDIV'] div[class='tui-grid-header-area'],
		div[id='checkInKeyResultGridListDIV'] div[class='tui-grid-header-area']
		{
			display: none;
		}
		/************************
		* tui css END
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
			right: 55px;
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
		* comment css END
		*************************/
		.comment-list {
			list-style: none;
			padding: 0;
			overflow-y: auto;
		}
		.comment {
			margin-bottom: 10px;
			display: flex;
			align-items: flex-start; /* 항목을 시작점에 맞추어 정렬 */
			border-top: 1px solid #e2e2e2;
			padding-top: 10px;
		}
		.profile-pic {
			width: 40px;
			height: 40px;
			border-radius: 50%;
			margin-right: 10px;
		}
		.comment-content {
			margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
			font-size: 14px;
		}
		.comment-time {
			font-size: 12px;
			color: #666;
		}
		.comment-delete-button {
			margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
			background-color: transparent;
			border: none;
			cursor: pointer;
			font-size: 10px;
			color: #666;
		}
		/************************
		* comment css END
		*************************/

		/************************
		* activity css END
		*************************/
		.activity-list {
			list-style: none;
			padding: 0;
			overflow-y: auto;
		}
		.activity {
			margin-bottom: 10px;
			display: flex;
			align-items: flex-start; /* 항목을 시작점에 맞추어 정렬 */
			border-top: 1px solid #e2e2e2;
			padding-top: 10px;
		}
		.profile-pic {
			width: 40px;
			height: 40px;
			border-radius: 50%;
			margin-right: 10px;
		}
		.activity-content {
			margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
			font-size: 14px;
		}
		.activity-time {
			font-size: 12px;
			color: #666;
		}
		.activity-delete-button {
			margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
			background-color: transparent;
			border: none;
			cursor: pointer;
			font-size: 10px;
			color: #666;
		}
		/************************
		* activity css END
		*************************/
		/************************
		* common css START
		*************************/
		/**::-webkit-scrollbar {*/
    	/*	display: none; !* Chrome, Safari, Opera*!*/
		/*}*/
		/************************
		* commen css END
		*************************/
	</style>
</head>

<body>
<div class="content">
	<nav class="navbar fixed-top bg-white d-block" id="content-header">
		<div class="row" id="searchDivi">
			<div class="col-12 col-md-6">
				<div class="input-group d-flex justify-content-start">
					<div class="input-group-prepend">
						<input type="radio" class="d-none" 	style="border-radius: 1.25rem; color:#000 !important;" id="input01" name="searchDivi" checked>
						<label class="btn btn-primary mr-2"	style="border-radius: 1rem !important;"	id="label01" name="searchDivi" for="input01">내 목표</label>
					</div>
					<div class="input-group-append">
						<input type="radio" class="d-none" 	style="border-radius: 1.25rem; color:#000 !important;" id="input02" name="searchDivi">
						<label class="btn btn-default mr-2"	style="border-radius: 1rem !important;"	id="label02" name="searchDivi" for="input02">팀 목표</label>
					</div>
					<div class="input-group-append">
						<input type="radio" class="d-none" 	style="border-radius: 1.25rem; color:#000 !important;" id="input03" name="searchDivi">
						<label class="btn btn-default mr-2"	style="border-radius: 1rem !important;" id="label03" name="searchDivi" for="input03">전사목표</label>
					</div>
					<div class="input-group-append">
						<video id="synchronizationVideo" name="synchronizationVideo" style="cursor:pointer;height: 2.1rem;" autoplay title="동기화">
							<source src="/img/countdown/License Certificate_472646436-558_1277242_472646436-558_ROYALTY-FREE LICENSE_용하 김_2024-02-21 (KST).mp4">
						</video>
					</div>
					<script>
						let synchronizationVideo = document.getElementById('synchronizationVideo');
						synchronizationVideo.addEventListener('click', async ev => {
							await synchronization();
							await doAction('planGridList', 'search');
							ev.target.currentTime = 0;
						});
						synchronizationVideo.addEventListener('ended', async ev => {
							await synchronization();
							await doAction('planGridList','search');
							ev.target.play();
						})
					</script>
				</div>
			</div>
			<div class="col-12 col-md-6">
				<div class="input-group d-flex justify-content-end">
					<input type="search" class="form-control" id='planNmSearch' placeholder="검색">
					<div class="input-group-append">
						<button type="button" class="btn btn-default" onclick="doAction('planGridList','search')"><i class="fa fa-search"></i></button>
					</div>
					<div class="input-group-append">
						<button type="button" class="btn btn-default"  style="background-color: #000 !important; color:#fff !important;" data-toggle="modal" data-target="#insertPlanModal" id="insertPlanModalOpenButton">신규</button>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-md-6 pt-0 pb-0 pl-2 pr-2">
				<div class="row w-md-100">
					<div class="col-md-12">
						<div class="float-left mr-2"><strong id="totOAmt">1</strong>개의 목표</div>
						<div class="float-left mr-2">|</div>
						<div class="float-left mr-2"><strong id="totKRAmt">1</strong>개의 핵심결과지표</div>
						<div class="float-right mr-1" id="range_1_num"></div>
					</div>
				</div>
				<div class="row w-md-100 mt-1">
					<div class="col-md-12">
						<div class="progress-container">
							<div class="progress-bar" id="progress-bar_main">
								<span class="percent" id="percent_main"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 text-center">
				<div class="row">
					<div class="col-3 col-md-3 text-center" style="border-right: 2px solid #f6f5f8;">
						<div class="col-md-12">대기</div>
						<div class="col-md-12" id="content-header-statusDivi-01">0</div>
					</div>
					<div class="col-3 col-md-3 text-center" style="border-right: 2px solid #f6f5f8;">
						<div class="col-md-12">진행중</div>
						<div class="col-md-12" style="color:#68bae7" id="content-header-statusDivi-02">0</div>
					</div>
					<div class="col-3 col-md-3 text-center" style="border-right: 2px solid #f6f5f8;">
						<div class="col-md-12">문제발생</div>
						<div class="col-md-12" style="color:#da362e" id="content-header-statusDivi-03">0</div>
					</div>
					<div class="col-3 col-md-3 text-center">
						<div class="col-md-12">완료</div>
						<div class="col-md-12" style="color:#51ab42" id="content-header-statusDivi-04">0</div>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<div class="row" style="border-top: 2px solid #f6f5f8;" id="contentObjective">
		<div class="col-md-12 p-2" id="plan">
			<!-- 시트가 될 DIV 객체 -->
			<div id="planGridListDIV" style="width:100vw;"></div>
		</div>
	</div>
</div>
</body>

<!----------------------------------------
---- Fn 사이드 메뉴 Start
 ----------------------------------------->
<button type="button" class="btn btn-primary d-none" data-toggle="modal" data-target="#selectFunctionModal" id="selectFunctionOpenButton" name="selectFunctionOpenButton"></button>
<button type="button" class="btn btn-primary d-none" data-dismiss="modal" data-target="#detailPlanModal" data-toggle="modal" id="selectFunctionCloseButton" name="selectFunctionCloseButton"></button>
<div class="modal left selectFunction fade" id="selectFunctionModal" tabindex="" role="dialog" aria-labelledby="selectFunctionLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content" id="detailedMenuDivi">
			<div class="modal-body" role="button" data-dismiss="modal" data-target="#detailPlanModal" data-toggle="modal" id="detailPlanModalOpenButton" name="detailPlanModalOpenButton">상세보기</div> <%--bubbling Objective--%>
			<div class="modal-body" role="button" data-dismiss="modal" data-target="#detailKeyResultModal" data-toggle="modal" id="detailKeyResultModalOpenButton" name="detailKeyResultModalOpenButton">상세보기</div> <%--bubbling KeyResult--%>
			<div class="modal-body" role="button" data-dismiss="modal" data-target="#insertPlanModal" data-toggle="modal" id="insertSubPlanOpenButton" name="insertSubPlanOpenButton">하위목표생성</div>
			<div class="modal-body" role="button" data-dismiss="modal" data-target="#insertKeyResultModal" data-toggle="modal" id="insertKeyResultModalOpenButton" name="insertKeyResultModalOpenButton">하위핵심결과지표생성</div>
			<div class="modal-body" role="button" data-dismiss="modal" data-target="#selectOrderPlanModal" data-toggle="modal" id="selectOrderPlanModalOpenButton" name="selectOrderPlanModalOpenButton">월간성과기획적용</div>
			<div class="modal-body" role="button" data-dismiss="modal" id="deleteSubPlanButton" name="deleteSubPlanButton">삭제</div>
			<div class="modal-body" role="button" data-dismiss="modal">닫기</div>

			<div class="modal-body d-none" data-dismiss="modal" data-target="#detailPlanModal" data-toggle="modal" id="detailPlanModalCloseButton" name="detailPlanModalCloseButton">상세보기닫기</div>
			<div class="modal-body d-none" data-dismiss="modal" data-target="#detailKeyResultModal" data-toggle="modal" id="detailKeyResultModalCloseButton" name="detailKeyResultModalCloseButton">상세보기닫기</div>
			<div class="modal-body d-none" data-dismiss="modal" data-target="#insertPlanModal" data-toggle="modal" id="insertSubPlanCloseButton" name="insertSubPlanCloseButton">하위목표생성닫기</div>
			<div class="modal-body d-none" data-dismiss="modal" data-target="#insertKeyResultModal" data-toggle="modal" id="insertKeyResultModalCloseButton" name="insertKeyResultModalCloseButton">하위핵심결과지표생성닫기</div>
			<div class="modal-body d-none" data-dismiss="modal" data-target="#selectOrderPlanModal" data-toggle="modal" id="selectOrderPlanModalCloseButton" name="selectOrderPlanModalCloseButton">월간성과기획적용닫기</div>
			<div class="modal-body d-none" role="button" data-dismiss="modal" data-target="#detailKeyResultModal" data-toggle="modal" id="detailKeyResultModalOpenButton2" name="detailKeyResultModalOpenButton2">상세보기</div> <%--bubbling KeyResult--%>
			<div class="modal-body d-none" data-dismiss="modal" data-target="#selectKeyResultModal" data-toggle="modal" id="detailKeyResultModalCloseButton2" name="detailKeyResultModalCloseButton2">하위핵심결과지표생성닫기</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- Fn 사이드 메뉴 End
 ----------------------------------------->
<!----------------------------------------
---- 목표 신규생성 모달 Start
 ----------------------------------------->
<div class="modal fade" style="z-index: 1050" tabindex="-1" aria-labelledby="insertPlanLabel" aria-hidden="true" id="insertPlanModal" name="insertPlanModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header p-0">
				<div class="col-auto col-md-auto p-2">
					<h4 class="modal-title" id="insertPlanLabel">목표 설정</h4>
				</div>
				<div class="col-auto col-md-auto p-2 text-right">
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" id="insertPlanModalPreviousButton" name="insertPlanModalPreviousButton">이전</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="insertPlanModalNextButton" name="insertPlanModalNextButton">다음</button>
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" id="insertPlanModalSubmitButton" name="insertPlanModalSubmitButton">완료</button>
				</div>
			</div>
			<div class="modal-body p-9">
				<form id="insertPlanModalForm" name="insertPlanModalForm">
					<input type="hidden" id="insertPlanModalCorpCd" name="insertPlanModalCorpCd">
					<input type="hidden" id="insertPlanModalPlanCd" name="insertPlanModalPlanCd">
					<input type="hidden" id="insertPlanModalPlanDivi" name="insertPlanModalPlanDivi">
					<input type="hidden" id="insertPlanModalPlanCdRoot" name="insertPlanModalPlanCdRoot">
					<input type="hidden" id="insertPlanModalSaveDivi" name="insertPlanModalSaveDivi">
					<div class="row" id="insertPlanModal-modal-content-01" name="insertPlanModal-modal-content-01">
						<div class="col-md-12 p-2">
							<label for="insertPlanModalPlanNm"><i class="fa-solid fa-star text-danger"></i> <b>이루고자 하는 목표를 입력해주세요.</b></label>
							<input type="text" class="form-control text-left" placeholder="목표 입력" required title="목표" autocomplete="off" id="insertPlanModalPlanNm" name="insertPlanModalPlanNm">
						</div>
						<div class="col-md-12 p-2">
							<label for="insertPlanModalParePlanCd"><i class="fa-solid fa-star text-danger"></i> <b>연결할 상위 목표를 설정해주세요.</b></label>
							<select class="form-control selectpicker" required title="상위 목표" id="insertPlanModalParePlanCd" name="insertPlanModalParePlanCd" ></select>
						</div>
						<div class="col-md-12 p-2 text-right">
							<label><b>다음 "TAB"키</b></label>
						</div>
					</div>
					<div class="row fade3" id="insertPlanModal-modal-content-02" name="modal-content-02">
						<div class="col-md-12 p-2">
							<label for="insertPlanModalEmpCd"><i class="fa-solid fa-star text-danger"></i> <b>담당자는 누구입니까?</b></label>
							<select class="form-control selectpicker" required title="담당자" id="insertPlanModalEmpCd" name="insertPlanModalEmpCd" ></select>
						</div>
						<div class="col-6 col-md-6 p-2">
							<label for="insertPlanModalDepaCd"><b>담당부서</b></label>
							<select class="form-control selectpicker" id="insertPlanModalDepaCd" name="insertPlanModalDepaCd" disabled></select>
						</div>
						<div class="col-6 col-md-6 p-2">
							<label for="insertPlanModalBusiCd"><b>담당사업장</b></label>
							<select class="form-control selectpicker" id="insertPlanModalBusiCd" name="insertPlanModalBusiCd" disabled></select>
						</div>
						<div class="col-md-6 p-2 text-left">
							<label><b>이전 "SHIFT+TAB"키</b></label>
						</div>
						<div class="col-md-6 p-2 text-right">
							<label><b>다음 "TAB"키</b></label>
						</div>
					</div>
					<div class="row fade3" id="insertPlanModal-modal-content-03" name="insertPlanModal-modal-content-03">
						<div class="col-md-12 p-2">
							<label for="insertPlanModalStDt"><i class="fa-solid fa-star text-danger"></i> <b>기간은 어떻게 되나요?</b></label>
							<div class="row">
								<div class="col-6 col-md-6" style="z-index: 1;">
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="시작일 입력" required title="시작일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="insertPlanModalStDt" name="insertPlanModalStDt">
								</div>
								<div class="col-6 col-md-6" style="z-index: 1;">
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="종료일 입력" required title="종료일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="insertPlanModalEdDt" name="insertPlanModalEdDt">
								</div>
							</div>
						</div>
						<div class="col-md-12 p-2">
							<label for="insertPlanModalNote"><b>상세설명란을 입력해주세요.</b></label>
							<textarea type="text" class="form-control" style="resize: none" placeholder="상세설명 입력" rows="3" autocomplete="off" id="insertPlanModalNote" name="insertPlanModalNote"></textarea>
						</div>
						<div class="col-md-6 p-2 text-left">
							<label><b>이전 "SHIFT+TAB"키</b></label>
						</div>
						<div class="col-md-6 p-2 text-right">
							<label><b>확인 "TAB"키</b></label>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 목표 신규생성 모달 End
 ----------------------------------------->
<!----------------------------------------
---- 목표 상세보기 모달 Start
 ----------------------------------------->
<div class="right">
	<div class="modal fade posright" id="detailPlanModal" tabindex="-1" role="dialog" aria-labelledby="detailPlanLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-slideout modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header p-0">
					<div class="col-auto col-md-auto p-2">
						<h4 class="modal-title" id="detailPlanLabel">목표 상세</h4>
					</div>
					<div class="col-auto col-md-auto p-2 text-right">
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="detailPlanModalSubmitButton" name="detailPlanModalSubmitButton">저장</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" id="detailPlanModalDeleteButton" name="detailPlanModalDeleteButton">삭제</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-target="#selectKeyResultModal" data-toggle="modal" id="selectKeyResultOpenButton" name="selectKeyResultOpenButton">지표</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-target="#selectFunctionModal" data-toggle="modal" id="detailPlanModalPreviousButton" name="detailPlanModalPreviousButton">메뉴</button>

						<div class="modal-body d-none" data-dismiss="modal" data-target="#selectFunctionModal" data-toggle="modal" id="selectKeyResultCloseButton" name="selectKeyResultCloseButton">핵심결과지표내역닫기</div>
					</div>
				</div>
				<div class="modal-body p-9">
					<form id="detailPlanModalForm" name="detailPlanModalForm">
						<input type="hidden" id="detailPlanModalStatus" name="detailPlanModalStatus">
						<input type="hidden" id="detailPlanModalCorpCd" name="detailPlanModalCorpCd">
						<input type="hidden" id="detailPlanModalPlanCd" name="detailPlanModalPlanCd">
						<input type="hidden" id="detailPlanModalPlanDivi" name="detailPlanModalPlanDivi">
						<input type="hidden" id="detailPlanModalPlanCdRoot" name="detailPlanModalPlanCdRoot">
						<input type="hidden" id="detailPlanModalSaveDivi" name="detailPlanModalSaveDivi">
						<div class="row">
							<div class="col-md-12 p-2">
								<label for="detailPlanModalPartImgs"><b>참가 구성원</b></label>
								<div class="col-md-12" id="detailPlanModalPartImgs" name="detailPlanModalPartImgs">

								</div>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailPlanModalPlanNm"><i class="fa-solid fa-star text-danger"></i> <b>목표명</b></label>
								<input type="text" class="form-control text-left" required placeholder="목표 입력" title="목표명" autocomplete="off" id="detailPlanModalPlanNm" name="detailPlanModalPlanNm">
							</div>
							<div class="col-md-12 p-2">
								<label for="detailPlanModalParePlanCd"><i class="fa-solid fa-star text-danger"></i> <b>연결된 상위 목표</b></label>
								<select class="form-control selectpicker" required title="상위 목표" id="detailPlanModalParePlanCd" name="detailPlanModalParePlanCd" ></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="detailPlanModalEmpCd"><i class="fa-solid fa-star text-danger"></i> <b>담당자</b></label>
								<select class="form-control selectpicker" required title="담당자" id="detailPlanModalEmpCd" name="detailPlanModalEmpCd" ></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="detailPlanModalDepaCd"><b>담당부서</b></label>
								<select class="form-control selectpicker" id="detailPlanModalDepaCd" name="detailPlanModalDepaCd" disabled></select>

							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="detailPlanModalBusiCd"><b>담당사업장</b></label>
								<select class="form-control selectpicker" id="detailPlanModalBusiCd" name="detailPlanModalBusiCd" disabled></select>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailPlanModalStDt"><i class="fa-solid fa-star text-danger"></i> <b>기간</b></label>
								<div class="row">
									<div class="col-6 col-md-6" style="z-index: 1;">
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="시작일 입력" required title="시작일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="detailPlanModalStDt" name="detailPlanModalStDt">
									</div>
									<div class="col-6 col-md-6" style="z-index: 1;">
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="종료일 입력" required title="종료일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="detailPlanModalEdDt" name="detailPlanModalEdDt">
									</div>
								</div>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailPlanModalNote"><b>상세설명란</b></label>
								<textarea type="text" class="form-control" style="resize: none" placeholder="상세설명 입력" rows="3" autocomplete="off" id="detailPlanModalNote" name="detailPlanModalNote"></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 목표 상세보기 모달 End
 ----------------------------------------->
<!----------------------------------------
---- 하위핵심결과지표 입력 모달 Start
 ----------------------------------------->
<div class="modal left fade" style="z-index: 1052" id="insertKeyResultModal" tabindex="-1" role="dialog" aria-labelledby="insertKeyResultLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header p-0">
				<div class="col-auto col-md-auto p-2">
					<h4 class="modal-title" id="insertKeyResultLabel">핵심결과지표 설정</h4>
				</div>
				<div class="col-auto col-md-auto p-2 text-right">
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" id="insertKeyResultModalPreviousButton" name="insertKeyResultModalPreviousButton">이전</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="insertKeyResultModalNextButton" name="insertKeyResultModalNextButton">다음</button>
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" id="insertKeyResultModalSubmitButton" name="insertKeyResultModalSubmitButton">완료</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-toggle="modal" id="insertKeyResultModalCloseButton" name="insertKeyResultModalCloseButton">나가기</button>
				</div>
			</div>
			<div class="modal-body p-9">
				<form id="insertKeyResultModalForm" name="insertKeyResultModalForm">
					<input type="hidden" id="insertKeyResultModalCorpCd" name="insertKeyResultModalCorpCd">
					<input type="hidden" id="insertKeyResultModalPlanCd" name="insertKeyResultModalPlanCd">
					<input type="hidden" id="insertKeyResultModalPlanDivi" name="insertKeyResultModalPlanDivi">
					<input type="hidden" id="insertKeyResultModalPlanCdRoot" name="insertKeyResultModalPlanCdRoot">
					<input type="hidden" id="insertKeyResultModalSaveDivi" name="insertKeyResultModalSaveDivi">
					<div class="row" id="insertKeyResultModal-modal-content-01" name="insertKeyResultModal-modal-content-01">
						<div class="col-md-12 p-2">
							<label for="insertKeyResultModalPlanNm"><i class="fa-solid fa-star text-danger"></i> <b>이루고자 하는 핵심결과지표를 입력해주세요.</b></label>
							<input type="text" class="form-control text-left" placeholder="핵심결과지표 입력" required title="핵심결과지표" autocomplete="off" id="insertKeyResultModalPlanNm" name="insertKeyResultModalPlanNm">
						</div>
						<div class="col-md-12 p-2">
							<label for="insertKeyResultModalParePlanCd"><i class="fa-solid fa-star text-danger"></i> <b>연결할 상위 목표를 설정해주세요.</b></label>
							<select class="form-control selectpicker" style="z-index:1053" required title="상위 목표" id="insertKeyResultModalParePlanCd" name="insertKeyResultModalParePlanCd" ></select>
						</div>
						<div class="col-md-12 p-2 text-right">
							<label><b>다음 "TAB"키</b></label>
						</div>
					</div>
					<div class="row fade3" id="insertKeyResultModal-modal-content-02" name="insertKeyResultModal-modal-content-02">
						<div class="col-md-12 p-2">
							<label for="insertKeyResultModalEmpCd"><i class="fa-solid fa-star text-danger"></i> <b>담당자는 누구입니까?</b></label>
							<select class="form-control selectpicker" required title="담당자" id="insertKeyResultModalEmpCd" name="insertKeyResultModalEmpCd" ></select>
						</div>
						<div class="col-6 col-md-6 p-2">
							<label for="insertKeyResultModalDepaCd"><b>담당부서</b></label>
							<select class="form-control selectpicker" id="insertKeyResultModalDepaCd" name="insertKeyResultModalDepaCd" disabled></select>
						</div>
						<div class="col-6 col-md-6 p-2">
							<label for="insertKeyResultModalBusiCd"><b>담당사업장</b></label>
							<select class="form-control selectpicker" id="insertKeyResultModalBusiCd" name="insertKeyResultModalBusiCd" disabled></select>
						</div>
						<div class="col-md-6 p-2 text-left">
							<label><b>이전 "SHIFT+TAB"키</b></label>
						</div>
						<div class="col-md-6 p-2 text-right">
							<label><b>다음 "TAB"키</b></label>
						</div>
					</div>
					<div class="row fade3" id="insertKeyResultModal-modal-content-03" name="insertKeyResultModal-modal-content-03">
						<div class="col-md-12 p-2">
							<div class="row">
								<div class="col-2 col-md-2" style="z-index: 1;">
									<label for="insertKeyResultModalUnit"><i class="fa-solid fa-star text-danger"></i> <b>단위</b></label>
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="단위" required title="단위" autocomplete="off" id="insertKeyResultModalUnit" name="insertKeyResultModalUnit">
								</div>
								<div class="col-5 col-md-5" style="z-index: 1;">
									<label for="insertKeyResultModalStAmt"><i class="fa-solid fa-star text-danger"></i> <b>시작값</b></label>
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="시작값 입력" required title="시작값" autocomplete="off" oninput="edsUtil.formatNumberHtmlInputForDouble(this)" id="insertKeyResultModalStAmt" name="insertKeyResultModalStAmt">
								</div>
								<div class="col-5 col-md-5" style="z-index: 1;">
									<label for="insertKeyResultModalEdAmt"><i class="fa-solid fa-star text-danger"></i> <b>목표값</b></label>
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="목표값 입력" required title="목표값" autocomplete="off" oninput="edsUtil.formatNumberHtmlInputForDouble(this)" id="insertKeyResultModalEdAmt" name="insertKeyResultModalEdAmt">
								</div>
							</div>
						</div>
						<div class="col-md-12 p-2">
							<label for="insertKeyResultModalPartCds"><b>공동 작업자</b></label>
							<select class="form-control selectpicker" id="insertKeyResultModalPartCds" name="insertKeyResultModalPartCds" multiple="multiple"></select>
						</div>
						<div class="col-md-6 p-2 text-left">
							<label><b>이전 "SHIFT+TAB"키</b></label>
						</div>
						<div class="col-md-6 p-2 text-right">
							<label><b>확인 "TAB"키</b></label>
						</div>
					</div>
					<div class="row fade3" id="insertKeyResultModal-modal-content-04" name="insertKeyResultModal-modal-content-04">
						<div class="col-md-12 p-2">
							<label for="insertKeyResultModalStDt"><i class="fa-solid fa-star text-danger"></i> <b>기간은 어떻게 되나요?</b></label>
							<div class="row">
								<div class="col-6 col-md-6" style="z-index: 1;">
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="시작일 입력" required title="시작일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="insertKeyResultModalStDt" name="insertKeyResultModalStDt">
								</div>
								<div class="col-6 col-md-6" style="z-index: 1;">
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="종료일 입력" required title="종료일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="insertKeyResultModalEdDt" name="insertKeyResultModalEdDt">
								</div>
							</div>
						</div>
						<div class="col-md-12 p-2">
							<label for="insertKeyResultModalNote"><b>상세설명란을 입력해주세요.</b></label>
							<textarea type="text" class="form-control" style="resize: none" placeholder="상세설명 입력" rows="3" autocomplete="off" id="insertKeyResultModalNote" name="insertKeyResultModalNote"></textarea>
						</div>
						<div class="col-md-6 p-2 text-left">
							<label><b>이전 "SHIFT+TAB"키</b></label>
						</div>
						<div class="col-md-6 p-2 text-right">
							<label><b>확인 "TAB"키</b></label>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 하위핵심결과지표 입력 모달 End
 ----------------------------------------->
<!----------------------------------------
---- 하위핵심결과지표 상세보기 모달 Start
 ----------------------------------------->
<div class="right">
	<div class="modal fade posright" id="detailKeyResultModal" tabindex="-1" role="dialog" aria-labelledby="detailKeyResultLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-slideout modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header p-0">
					<div class="col-md-6 p-2">
						<h4 class="modal-title" id="detailKeyResultLabel">핵심결과지표 상세</h4>
					</div>
					<div class="col-md-6 p-2 text-right">
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="detailKeyResultModalSubmitButton" name="detailKeyResultModalSubmitButton" title="핵심결과지표내역저장">저장</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" id="detailKeyResultModalDeleteButton1" name="detailKeyResultModalDeleteButton1" title="목표에서삭제버튼">삭제</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-toggle="modal" id="detailKeyResultModalDeleteButton2" name="detailKeyResultModalDeleteButton2" title="핵심결과지표내역에서삭제버튼">삭제</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#insertPlanningKeyResultModal" data-toggle="modal" id="detailKeyResultModalPlanAddButton" name="detailKeyResultModalPlanAddButton" title="계획추가버튼">추가</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#applyPlanKeyResultModal" data-toggle="modal" id="detailKeyResultModalPlanApplyOpenButton" name="detailKeyResultModalPlanApplyOpenButton" title="계획열기버튼">계획</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#applyPlanKeyResultModal" data-toggle="modal" id="detailKeyResultModalPlanApplyCloseButton" name="detailKeyResultModalPlanApplyCloseButton" title="계획닫기버튼">계획</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#insertCheckInKeyResultModal" data-toggle="modal" id="detailKeyResultModalCheckInAddButton" name="detailKeyResultModalCheckInAddButton" title="체크인추가버튼">추가</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" id="detailKeyResultModalCheckInDeleteButton" name="detailKeyResultModalCheckInDeleteButton" title="체크인삭제버튼">삭제</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-target="#selectKeyResultModal" data-toggle="modal" id="detailKeyResultModalselectKeyResultOpenButton" name="detailKeyResultModalselectKeyResultOpenButton" title="핵심결과지표내역버튼">지표</button>
						<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-toggle="modal" id="detailKeyResultModalselectKeyResultClosButton" name="detailKeyResultModalselectKeyResultClosButton" title="핵심결과지표내역나가기역버튼">닫기</button>
					</div>
				</div>
				<div class="row text-center vertical-middle p-2">
					<div class="col col-md p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="detailKeyResultModalInfoButton" name="detailKeyResultModalInfoButton">상세</div>
					<div class="col col-md p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="detailKeyResultModalCommentButton" name="detailKeyResultModalCommentButton">코멘트</div>
					<div class="col col-md p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="detailKeyResultModalActivityButton" name="detailKeyResultModalActivityButton">활동</div>
					<div class="col col-md p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="detailKeyResultModalPlanButton" name="detailKeyResultModalPlanButton">계획</div>
					<div class="col col-md p-2" role="button" id="detailKeyResultModalCheckInButton" name="detailKeyResultModalCheckInButton">체크인</div>
				</div>
				<%-- 하위핵심결과지표 상세보기 Start--%>
				<div class="modal-body p-9" id="detailKeyResultModalInfo" name="detailKeyResultModalInfo" style="padding-top:unset">
					<form id="detailKeyResultModalForm" name="detailKeyResultModalForm">
						<input type="hidden" id="detailKeyResultModalStatus" name="detailKeyResultModalStatus">
						<input type="hidden" id="detailKeyResultModalCorpCd" name="detailKeyResultModalCorpCd">
						<input type="hidden" id="detailKeyResultModalPlanCd" name="detailKeyResultModalPlanCd">
						<input type="hidden" id="detailKeyResultModalPlanDivi" name="detailKeyResultModalPlanDivi">
						<input type="hidden" id="detailKeyResultModalPlanCdRoot" name="detailKeyResultModalPlanCdRoot">
						<input type="hidden" id="detailKeyResultModalSaveDivi" name="detailKeyResultModalSaveDivi">
						<div class="row">
							<div class="col-md-12 p-2">
								<label for="detailKeyResultModalPartImgs"><b>공동 작업자</b></label>
								<div class="col-md-12" id="detailKeyResultModalPartImgs" name="detailKeyResultModalPartImgs">

								</div>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailKeyResultModalPlanNm"><i class="fa-solid fa-star text-danger"></i><b>핵심결과지표 명</b></label>
								<input type="text" class="form-control text-left" placeholder="핵심결과지표 명 입력" required title="핵심결과지표 명" autocomplete="off" id="detailKeyResultModalPlanNm" name="detailKeyResultModalPlanNm">
							</div>
							<div class="col-md-12 p-2">
								<label for="detailKeyResultModalParePlanCd"><b>연결된 상위 목표</b></label>
								<select class="form-control selectpicker" style="z-index:1053" id="detailKeyResultModalParePlanCd" name="detailKeyResultModalParePlanCd" ></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="detailKeyResultModalEmpCd"><i class="fa-solid fa-star text-danger"></i><b>담당자</b></label>
								<select class="form-control selectpicker" required title="담당자" id="detailKeyResultModalEmpCd" name="detailKeyResultModalEmpCd" ></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="detailKeyResultModalDepaCd"><b>담당부서</b></label>
								<select class="form-control selectpicker" id="detailKeyResultModalDepaCd" name="detailKeyResultModalDepaCd" disabled></select>
							</div>
							<div class="col-4 col-md-4 p-2">
								<label for="detailKeyResultModalBusiCd"><b>담당사업장</b></label>
								<select class="form-control selectpicker" id="detailKeyResultModalBusiCd" name="detailKeyResultModalBusiCd" disabled></select>
							</div>
							<div class="col-md-12 p-2">
								<div class="row">
									<div class="col-2 col-md-2" style="z-index: 1;">
										<label for="detailKeyResultModalUnit"><i class="fa-solid fa-star text-danger"></i><b>단위</b></label>
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="단위" required title="단위" autocomplete="off" id="detailKeyResultModalUnit" name="detailKeyResultModalUnit">
									</div>
									<div class="col-5 col-md-5" style="z-index: 1;">
										<label for="detailKeyResultModalStAmt"><i class="fa-solid fa-star text-danger"></i><b>시작값</b></label>
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="시작값 입력" required title="시작값" autocomplete="off" id="detailKeyResultModalStAmt" name="detailKeyResultModalStAmt">
									</div>
									<div class="col-5 col-md-5" style="z-index: 1;">
										<label for="detailKeyResultModalEdAmt"><i class="fa-solid fa-star text-danger"></i><b>목표값</b></label>
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="종료값 입력" required title="종료값" autocomplete="off" id="detailKeyResultModalEdAmt" name="detailKeyResultModalEdAmt">
									</div>
								</div>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailKeyResultModalPartCds"><b>공동 작업자</b></label>
								<select class="form-control selectpicker" id="detailKeyResultModalPartCds" name="detailKeyResultModalPartCds" multiple="multiple"></select>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailKeyResultModalStDt"><i class="fa-solid fa-star text-danger"></i><b>기간</b></label>
								<div class="row">
									<div class="col-6 col-md-6" style="z-index: 1;">
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="시작일 입력" required title="시작일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="detailKeyResultModalStDt" name="detailKeyResultModalStDt">
										<div id="detailKeyResultModalStDtDIV" style="margin-top: -1px;"></div>
									</div>
									<div class="col-6 col-md-6" style="z-index: 1;">
										<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="종료일 입력" required title="종료일" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="detailKeyResultModalEdDt" name="detailKeyResultModalEdDt">
										<div id="detailKeyResultModalEdDtDIV" style="margin-top: -1px;"></div>
									</div>
								</div>
							</div>
							<div class="col-md-12 p-2">
								<label for="detailKeyResultModalNote"><b>상세설명란</b></label>
								<textarea type="text" class="form-control" style="resize: none" placeholder="상세설명 입력" rows="3" autocomplete="off" id="detailKeyResultModalNote" name="detailKeyResultModalNote"></textarea>
							</div>
						</div>
					</form>
				</div>
				<%-- 하위핵심결과지표 상세보기 END--%>
				<%-- 하위핵심결과지표 활동 Start--%>
				<div class="modal-body p-9 d-none" id="detailKeyResultModalActivity" name="detailKeyResultModalActivity">
					<div class="row" style="height: calc(100% - 3rem) !important">
						<!-- 메세지 박스-->
						<div class="col-12 col-md-12 h-100" style="overflow: auto;" id="detailKeyResultModalActivityMessageBox" name="detailKeyResultModalActivityMessageBox">
							<ul id="activitys" class="activity-list">
							</ul>
						</div>
					</div>
					<nav class="navbar-default"  id="detailKeyResultModalActivityFooter" name="detailKeyResultModalActivityFooter">
						<form id="detailKeyResultModalActivityForm" name="detailKeyResultModalActivityForm">
							<div class="input-group">
								<div class="input-group-prepend d-flex justify-content-center align-items-center">
									<img class="img-circle img-sm float-left mr-2"
										 style="height: 2rem;width: 2rem;"
										 src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:${LoginInfo.empCd}"
										 alt="사용자 이미지">
								</div>
								<div class="input-group-prepend d-flex justify-content-center align-items-center">
									<input type="text"
										   class="form-control text-center"
										   style="width: 110px;"
										   aria-label="Date-Time"
										   placeholder="활동일 입력"
										   title="활동일"
										   autocomplete="off"
										   onblur="edsUtil.convertToISOFormat(this)"
										   id="activityDt"
										   name="activityDt"
										   required>
								</div>
								<textarea class="form-control" style="resize: unset" rows="1" placeholder="코멘트.." id="detailKeyResultModalActivityContent" name="detailKeyResultModalActivityContent"></textarea>
								<div class="input-group-append d-flex justify-content-center align-items-center">
									<i class="fa-solid fa-circle-up ml-2" style="font-size: 1.5rem" role="button" id="detailKeyResultModalActivityContentSubmit" name="detailKeyResultModalActivityContentSubmit"></i>
								</div>
							</div>
						</form>
					</nav>
				</div>
				<%-- 하위핵심결과지표 활동 END--%>
				<%-- 하위핵심결과지표 코멘트 Start--%>
				<div class="modal-body p-9 d-none" id="detailKeyResultModalComment" name="detailKeyResultModalComment">
					<div class="row" style="height: calc(100% - 3rem) !important">
						<!-- 메세지 박스-->
						<div class="col-12 col-md-12 h-100" style="overflow: auto;" id="detailKeyResultModalCommentMessageBox" name="detailKeyResultModalCommentMessageBox">
							<ul id="comments" class="comment-list">
							</ul>
						</div>
					</div>
					<nav class="navbar-default"  id="detailKeyResultModalCommentFooter" name="detailKeyResultModalCommentFooter">
						<div class="input-group">
							<div class="input-group-prepend d-flex justify-content-center align-items-center">
								<img class="img-circle img-sm float-left mr-2"
									 style="height: 2rem;width: 2rem;"
									 src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:${LoginInfo.empCd}"
									 alt="사용자 이미지">
							</div>
							<textarea class="form-control" style="resize: unset" rows="1" placeholder="코멘트.." id="detailKeyResultModalCommentContent" name="detailKeyResultModalCommentContent"></textarea>
							<div class="input-group-append d-flex justify-content-center align-items-center">
								<i class="fa-solid fa-circle-up ml-2" style="font-size: 1.5rem" role="button" id="detailKeyResultModalCommentContentSubmit" name="detailKeyResultModalCommentContentSubmit"></i>
							</div>
						</div>
					</nav>
				</div>
				<%-- 하위핵심결과지표 코멘트 END--%>
				<%-- 하위핵심결과지표 계획하기 Start--%>
				<div class="modal-body p-9 d-none" id="detailKeyResultModalPlan" name="detailKeyResultModalPlan">
					<div class="row">
						<div class="col-md-12 p-2" style="padding-right: 4px !important;">
							<canvas id="detailKeyResultModalPlanChart"></canvas>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 p-2" id="planningKeyResult" style="padding-right: 4px !important;">
							<!-- 시트가 될 DIV 객체 -->
							<div id="planningKeyResultGridListDIV" style="width:100%;"></div>
						</div>
					</div>
				</div>
				<%-- 하위핵심결과지표 계획하기 END--%>
				<%-- 하위핵심결과지표 체크인 Start--%>
				<div class="modal-body p-9 d-none" id="detailKeyResultModalCheckIn" name="detailKeyResultModalCheckIn">
					<div class="row">
						<div class="col-md-12 p-2" style="padding-right: 4px !important;">
							<canvas id="detailKeyResultModalCheckInChart"></canvas>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 p-2" id="checkInKeyResult" style="padding-right: 4px !important;">
							<!-- 시트가 될 DIV 객체 -->
							<div id="checkInKeyResultGridListDIV" style="width:100%;"></div>
						</div>
					</div>
				</div>
				<%-- 하위핵심결과지표 체크인 END--%>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 하위핵심결과지표 상세보기 모달 End
 ----------------------------------------->
<!----------------------------------------
---- 하위핵심결과지표내역 모달 Start
 ----------------------------------------->
<div class="right">
	<div class="modal fade posright"  id="selectKeyResultModal" tabindex="-1" role="dialog" aria-labelledby="selectKeyResultLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-slideout modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header p-0">
					<div class="col-md-6 p-2">
						<h4 class="modal-title" id="selectKeyResultLabel">핵심결과지표 내역</h4>
					</div>
					<div class="col-md-6 p-2 text-right">
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-target="#insertKeyResultModal" data-toggle="modal" id="selectKeyResultModalinsertKeyResultModalOpenButton">추가</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-target="#detailPlanModal" data-toggle="modal">이전</button>
					</div>
				</div>
				<div class="modal-body p-9" style="padding-right: 0px !important;">
					<form id="selectKeyResultModalForm" name="selectKeyResultModalForm">
						<input type="hidden" id="selectKeyResultModalCorpCd" name="selectKeyResultModalCorpCd">
						<input type="hidden" id="selectKeyResultModalPlanCd" name="selectKeyResultModalPlanCd">
						<div class="row">
							<div class="col-12 col-md-12 p-2" style="z-index: 1055;background-color: #fff;">
								<label for="selectKeyResultModalPartImgs"><b>공동 작업자</b></label>
								<div class="col-md-12" id="selectKeyResultModalPartImgs" name="selectKeyResultModalPartImgs">
								</div>
							</div>
							<div class="col-md-12 p-2" id="keyResul" style="padding-right: 4px !important;">
								<!-- 시트가 될 DIV 객체 -->
								<div id="keyResultGridListDIV" style="width:100%;"></div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 하위핵심결과지표내역 모달 End
 ----------------------------------------->
<!----------------------------------------
---- 하위핵심결과지표 계획하기 모달 Start
 ----------------------------------------->
<div class="modal left fade" style="z-index: 1052" id="insertPlanningKeyResultModal" tabindex="-1" role="dialog" aria-labelledby="planningKeyResultLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header p-0">
				<div class="col-md-6 p-2">
					<h4 class="modal-title" id="planningKeyResultLabel">성과 계획</h4>
				</div>
				<div class="col-md-6 p-2 text-right">
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="insertPlanningKeyResultModalSubmitButton" name="insertPlanningKeyResultModalSubmitButton">완료</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="updatePlanningKeyResultModalSubmitButton" name="updatePlanningKeyResultModalSubmitButton">수정</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" id="deletePlanningKeyResultModalSubmitButton" name="deletePlanningKeyResultModalSubmitButton">삭제</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-toggle="modal" id="insertPlanningKeyResultModalCloseButton" name="insertPlanningKeyResultModalCloseButton">나가기</button>
				</div>
			</div>
			<div class="modal-body p-9">
				<form id="insertPlanningKeyResultModalForm" name="insertPlanningKeyResultModalForm">
					<input type="hidden" id="insertPlanningKeyResultModalCorpCd" name="insertPlanningKeyResultModalCorpCd">
					<input type="hidden" id="insertPlanningKeyResultModalPlanCd" name="insertPlanningKeyResultModalPlanCd">
					<input type="hidden" id="insertPlanningKeyResultModalSeq" name="insertPlanningKeyResultModalSeq">
					<input type="hidden" id="insertPlanningKeyResultModalCheckInDivi" name="insertPlanningKeyResultModalCheckInDivi">
					<input type="hidden" id="insertPlanningKeyResultModalStatus" name="insertPlanningKeyResultModalStatus">
					<input type="hidden" id="insertPlanningKeyResultModalInpId" name="insertPlanningKeyResultModalInpId">
					<div class="row p-2 rounded-lg" style="background-color: #efefef" id="insertPlanningKeyResultModal-modal-content-01" name="insertPlanningKeyResultModal-modal-content-01">
						<div class="col-md-12">
							· 현재 : <b id="insertPlanningKeyResultModalAmt1" name="insertPlanningKeyResultModalAmt1"></b><b id="insertPlanningKeyResultModalUnit1" name="insertPlanningKeyResultModalUnit"></b>
						</div>
						<div class="col-md-12">
							· 목표 : <b id="insertPlanningKeyResultModalAmt2" name="insertPlanningKeyResultModalAmt2"></b><b id="insertPlanningKeyResultModalUnit2" name="insertPlanningKeyResultModalUnit"></b>
						</div>
					</div>
					<div class="row" id="insertPlanningKeyResultModal-modal-content-02" name="insertPlanningKeyResultModal-modal-content-02">
						<div class="col-md-12 p-2">
							<label for="insertPlanningKeyResultModalDt"><i class="fa-solid fa-star text-danger"></i><b>계획 마감 일자를 입력해주세요.</b></label>
							<div class="row">
								<div class="col-6 col-md-6" style="z-index: 1;">
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="계획 일자 입력" required title="계획 일자" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="insertPlanningKeyResultModalDt" name="insertPlanningKeyResultModalDt">
								</div>
							</div>
						</div>
						<div class="col-md-6 p-2">
							<label for="insertPlanningKeyResultModalAmt"><i class="fa-solid fa-star text-danger"></i> <b>계획 수치를 입력해주세요.</b></label>
							<div class="input-group">
								<input type="text" class="form-control text-right rounded-sm" placeholder="수치 입력" required title="수치" autocomplete="off" oninput="edsUtil.formatNumberHtmlInputForDouble(this)" id="insertPlanningKeyResultModalAmt" name="insertPlanningKeyResultModalAmt">
								<div class="input-group-append text-left">
									<span class="input-group-text bg-white" style="color: #939BA2 !important;border: unset;" id="insertPlanningKeyResultModalUnit3" name="insertPlanningKeyResultModalUnit"></span>
								</div>
							</div>
						</div>
						<div class="col-md-12 p-2 d-none">
							<input type="hidden" id="insertPlanningKeyResultModalStatusDivi" name="insertPlanningKeyResultModalStatusDivi">
							<i class="fa-solid fa-star text-danger"></i> <b>상태를 체크하세요.</b>
							<div class="row text-center vertical-middle p-2">
								<div class="col-3 col-md-3 p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="insertPlanningKeyResultModalStatusDiviOption01" name="insertPlanningKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-meh-blank"></i> 대기
								</div>
								<div class="col-3 col-md-3 p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="insertPlanningKeyResultModalStatusDiviOption02" name="insertPlanningKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-smile-beam" style="color:#68bae7"></i> 진행중
								</div>
								<div class="col-3 col-md-3 p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="insertPlanningKeyResultModalStatusDiviOption03" name="insertPlanningKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-surprise" style="color:#da362e"></i> 문제발생
								</div>
								<div class="col-3 col-md-3 p-2" role="button" id="insertPlanningKeyResultModalStatusDiviOption04" name="insertPlanningKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-laugh-beam" style="color:#51ab42"></i> 완료
								</div>
							</div>
							<script>
								document.getElementById('insertPlanningKeyResultModal').addEventListener('click', ev => {
									let targetId = ev.target.tagName === "I"?ev.target.parentNode.id:ev.target.id;
									switch (true) {
										case targetId.includes('insertPlanningKeyResultModalStatusDivi') === true:
											document.getElementById('insertPlanningKeyResultModalStatusDivi').value = targetId.replaceAll('insertPlanningKeyResultModalStatusDiviOption','');
											document.getElementsByName('insertPlanningKeyResultModalStatusDiviOption').forEach(el => {
												if(el.id === targetId) el.style.backgroundColor = '#efefef'
												else el.style.backgroundColor = '#fff'
											});
											break;
									}
								});
							</script>
						</div>
						<div class="col-md-12 p-2">
							<label for="insertPlanningKeyResultModalNote"><b>상세설명란을 입력해주세요.</b></label>
							<textarea type="text" class="form-control" style="resize: none" placeholder="상세설명 입력" rows="3" autocomplete="off" id="insertPlanningKeyResultModalNote" name="insertPlanningKeyResultModalNote"></textarea>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 하위핵심결과 계획하기 모달 End
------------------------------------------>
<!----------------------------------------
---- 하위핵심결과 체크인하기 모달 Start
 ----------------------------------------->
<div class="modal left fade" style="z-index: 1052" id="insertCheckInKeyResultModal" tabindex="-1" role="dialog" aria-labelledby="checkInKeyResultLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header p-0">
				<div class="col-md-6 p-2">
					<h4 class="modal-title" id="checkInKeyResultLabel">성과 체크인</h4>
				</div>
				<div class="col-md-6 p-2 text-right">
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="insertCheckInKeyResultModalSubmitButton" name="insertCheckInKeyResultModalSubmitButton">완료</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="updateCheckInKeyResultModalSubmitButton" name="updateCheckInKeyResultModalSubmitButton">수정</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" id="deleteCheckInKeyResultModalSubmitButton" name="deleteCheckInKeyResultModalSubmitButton">삭제</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-toggle="modal" id="insertCheckInKeyResultModalCloseButton" name="insertCheckInKeyResultModalCloseButton">나가기</button>
				</div>
			</div>
			<div class="modal-body p-9">
				<form id="insertCheckInKeyResultModalForm" name="insertCheckInKeyResultModalForm">
					<input type="hidden" id="insertCheckInKeyResultModalCorpCd" name="insertCheckInKeyResultModalCorpCd">
					<input type="hidden" id="insertCheckInKeyResultModalPlanCd" name="insertCheckInKeyResultModalPlanCd">
					<input type="hidden" id="insertCheckInKeyResultModalSeq" name="insertCheckInKeyResultModalSeq">
					<input type="hidden" id="insertCheckInKeyResultModalCheckInDivi" name="insertCheckInKeyResultModalCheckInDivi">
					<input type="hidden" id="insertCheckInKeyResultModalStatus" name="insertCheckInKeyResultModalStatus">
					<input type="hidden" id="insertCheckInKeyResultModalInpId" name="insertCheckInKeyResultModalInpId">
					<div class="row p-2 rounded-lg" style="background-color: #efefef" id="insertCheckInKeyResultModal-modal-content-01" name="insertCheckInKeyResultModal-modal-content-01">
						<div class="col-md-12">
							· 현재 : <b id="insertCheckInKeyResultModalAmt1" name="insertCheckInKeyResultModalAmt1"></b><b id="insertCheckInKeyResultModalUnit1" name="insertCheckInKeyResultModalUnit"></b>
						</div>
						<div class="col-md-12">
							· 목표 : <b id="insertCheckInKeyResultModalAmt2" name="insertCheckInKeyResultModalAmt2"></b><b id="insertCheckInKeyResultModalUnit2" name="insertCheckInKeyResultModalUnit"></b>
						</div>
					</div>
					<div class="row" id="insertCheckInKeyResultModal-modal-content-02" name="insertCheckInKeyResultModal-modal-content-02">
						<div class="col-md-12 p-2">
							<label for="insertCheckInKeyResultModalDt"><i class="fa-solid fa-star text-danger"></i><b>체크인 일자를 입력해주세요.</b></label>
							<div class="row">
								<div class="col-6 col-md-6" style="z-index: 1;">
									<input type="text" class="form-control text-center" aria-label="Date-Time" placeholder="계획 일자 입력" required title="계획 일자" autocomplete="off" onblur="edsUtil.convertToISOFormat(this)" id="insertCheckInKeyResultModalDt" name="insertCheckInKeyResultModalDt">
								</div>
							</div>
						</div>
						<div class="col-md-6 p-2">
							<label for="insertCheckInKeyResultModalAmt"><i class="fa-solid fa-star text-danger"></i> <b>체크인 수치를 입력해주세요.</b></label>
							<div class="input-group">
								<input type="text" class="form-control text-right rounded-sm" placeholder="수치 입력" required title="수치" autocomplete="off" oninput="edsUtil.formatNumberHtmlInputForDouble(this)" id="insertCheckInKeyResultModalAmt" name="insertCheckInKeyResultModalAmt">
								<div class="input-group-append text-left">
									<span class="input-group-text bg-white" style="color: #939BA2 !important;border: unset;" id="insertCheckInKeyResultModalUnit3" name="insertCheckInKeyResultModalUnit"></span>
								</div>
							</div>
						</div>
						<div class="col-md-12 p-2">
							<input type="hidden" title="상태값" required id="insertCheckInKeyResultModalStatusDivi" name="insertCheckInKeyResultModalStatusDivi">
							<i class="fa-solid fa-star text-danger"></i> <b>상태를 체크하세요.</b>
							<div class="row text-center vertical-middle p-2">
								<div class="col-3 col-md-3 p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="insertCheckInKeyResultModalStatusDiviOption01" name="insertCheckInKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-meh-blank"></i> 대기
								</div>
								<div class="col-3 col-md-3 p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="insertCheckInKeyResultModalStatusDiviOption02" name="insertCheckInKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-smile-beam" style="color:#68bae7"></i> 진행중
								</div>
								<div class="col-3 col-md-3 p-2" role="button" style="border-right: 2px solid #f6f5f8;" id="insertCheckInKeyResultModalStatusDiviOption03" name="insertCheckInKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-surprise" style="color:#da362e"></i> 문제발생
								</div>
								<div class="col-3 col-md-3 p-2" role="button" id="insertCheckInKeyResultModalStatusDiviOption04" name="insertCheckInKeyResultModalStatusDiviOption">
									<i class="fa-regular fa-face-laugh-beam" style="color:#51ab42"></i> 완료
								</div>
							</div>
							<script>
								document.getElementById('insertCheckInKeyResultModal').addEventListener('click', ev => {
									let targetId = ev.target.tagName === "I"?ev.target.parentNode.id:ev.target.id;
									switch (true) {
										case targetId.includes('insertCheckInKeyResultModalStatusDivi') === true:
											document.getElementById('insertCheckInKeyResultModalStatusDivi').value = targetId.replaceAll('insertCheckInKeyResultModalStatusDiviOption','');
											document.getElementsByName('insertCheckInKeyResultModalStatusDiviOption').forEach(el => {
												if(el.id === targetId) el.style.backgroundColor = '#efefef'
												else el.style.backgroundColor = '#fff'
											});
											break;
									}
								});
							</script>
						</div>
						<div class="col-md-12 p-2">
							<label for="insertCheckInKeyResultModalNote"><b>상세설명란을 입력해주세요.</b></label>
							<textarea type="text" class="form-control" style="resize: none" placeholder="상세설명 입력" rows="3" autocomplete="off" id="insertCheckInKeyResultModalNote" name="insertCheckInKeyResultModalNote"></textarea>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 하위핵심결과지표 체크인하기 모달 End
------------------------------------------>
<!----------------------------------------
---- 월간성과기획서 계획하기 Start
 ----------------------------------------->
<div class="right">
	<div class="modal fade posright"  id="selectOrderPlanModal" tabindex="-1" role="dialog" aria-labelledby="selectKeyResultLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-slideout modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header p-0">
					<div class="col-auto col-md-auto p-2">
						<div style="z-index: 1030;float: left;position: relative;">
							<input type="text" class="form-control text-center" style="background-color:white; margin-left: 10px;width: 85px;height: calc(2rem);"id="ordPlanSetDt" aria-label="Date-Time" title="계획날짜"  placeholder="계획날짜" readonly="readonly" required>
							<div id="ordPlanSetDtDIV" style="margin-left: 10px;"></div>
						</div>
					</div>
					<div class="col-auto col-md-auto p-2 text-right">
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="selectOrderPlanModalButton">조회</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="insertOrderPlanModalButton">추가</button>
						<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-target="#selectFunctionModal" data-toggle="modal">이전</button>
					</div>
				</div>
				<div class="modal-body p-9" style="padding-right: 0px !important;">
					<form id="selectOrderPlanModalForm" name="selectOrderPlanModalForm">
						<div class="row">
							<div class="col-md-12 p-2" style="padding-right: 4px !important;">
								<!-- 시트가 될 DIV 객체 -->
								<div id="orderPlanGridListDIV" style="width:100%;"></div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 월간성과기획서 계획하기 End
 ----------------------------------------->
<!----------------------------------------
---- 핵심결과지표 상세 적용하기 Start
 ----------------------------------------->
<div class="modal fade"  id="applyPlanKeyResultModal" tabindex="-1" role="dialog" aria-labelledby="applyPlanKeyResultLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-slideout modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header p-0">
				<div class="col-auto col-md-auto p-2">
				</div>
				<div class="col-auto col-md-auto p-2 text-right">
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="selectPlanKeyResultModalButton">조회</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" id="applyPlanKeyResultModalButton">적용</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal">나가기</button>
				</div>
			</div>
			<div class="modal-body p-9" style="padding-right: 0px !important;">
				<form id="applyPlanKeyResultModalForm" name="applyPlanKeyResultModalForm">
					<div class="row">
						<div class="col-md-12 p-2" style="top: -65px;padding-right: 4px !important;">
							<!-- 시트가 될 DIV 객체 -->
							<div id="planKeyResultGridListDIV" style="width:100%;"></div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!----------------------------------------
---- 핵심결과지표 상세 적용하기 End
 ----------------------------------------->
</html>
<script>
	var planGridList, keyResultGridList, planningKeyResultGridList, checkInKeyResultGridList, planKeyResultGridList, orderPlanGridList;
	var ordPlanSetDt;
	let range_1;
	let doingPlanGridListFocusIndex = 0;
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
		 * synchronization fn set START
		 * **********************************/
		await synchronization(); // 수주계획, 프로젝트 데이터 동기화
		/*************************************
		 * synchronization fn set END
		 * **********************************/

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
					case 'detailKeyResultModalEmpCd' :
						$('#detailKeyResultModalDepaCd').val(e.target.selectedOptions[0].attributes.depaCd.value).trigger('change');
						$('#detailKeyResultModalBusiCd').val(e.target.selectedOptions[0].attributes.busiCd.value).trigger('change');
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

		/*************************************
		 * 'bootstrap select2' Tap set END
		 * **********************************/

		/*************************************
		 * 'insertPlanModal' Tap set Start
		 * **********************************/

		/*탭시 누를 시, 자동 'insertPlanModal' 페이징 기능*/
		document.getElementById('insertPlanModalForm').addEventListener('keydown', async ev => {
			const key = ev.key;
			const shiftKey = ev.shiftKey;
			const targetId = ev.target.id?ev.target.id:ev.target.parentNode.parentNode.previousSibling.id; // nomal tag:select2 tag
			if(key === 'Tab' && shiftKey){
				switch (targetId) {
					case 'insertPlanModalEmpCd':
							await modalContentMove ('insertPlanModalPreviousButton');
						break;
					case 'insertPlanModalStDt':
							await modalContentMove ('insertPlanModalPreviousButton');
						break;
				}
			}else if(key === 'Tab' && !shiftKey){
				switch (targetId) {
					case 'insertPlanModalPlanNm':
						if(document.getElementById('insertPlanModalParePlanCd').disabled === true){
							await modalContentMove ('insertPlanModalNextButton');
						}
						break;
					case 'insertPlanModalParePlanCd': await modalContentMove ('insertPlanModalNextButton'); break;
					case 'insertPlanModalEmpCd': await modalContentMove ('insertPlanModalNextButton'); break;
					case 'insertPlanModalNote':
						var ajaxCondition = await modifyModalInputCheck('insertPlanModalForm');
						if (!ajaxCondition) { // 저장
							await doAction('planGridList','input');
						}
						break;
				}
			}
		})

		/*************************************
		 * 'insertPlanModal' Tap set END
		 * **********************************/

		/*************************************
		 * 'insertKeyResultModal' Tap set Start
		 * **********************************/

		/*탭시 누를 시, 자동 'insertKeyResultModal' 페이징 기능*/
		document.getElementById('insertKeyResultModalForm').addEventListener('keydown', async ev => {
			const key = ev.key;
			const shiftKey = ev.shiftKey;
			const targetId = ev.target.id?ev.target.id:ev.target.parentNode.parentNode.previousSibling.id; // nomal tag:select2 tag
			if(key === 'Tab' && shiftKey){
				switch (targetId) {
					case 'insertKeyResultModalEmpCd':
							await modalContentMove ('insertKeyResultModalPreviousButton');
						break;
					case 'insertKeyResultModalUnit':
							await modalContentMove ('insertKeyResultModalPreviousButton');
						break;
					case 'insertKeyResultModalStDt':
							await modalContentMove ('insertKeyResultModalPreviousButton');
						break;
				}
			}else if(key === 'Tab' && !shiftKey){
				switch (targetId) {
					case 'insertKeyResultModalPlanNm':
						if(document.getElementById('insertKeyResultModalParePlanCd').disabled === true){
							await modalContentMove ('insertKeyResultModalNextButton');
						}
						break;
					case 'insertKeyResultModalParePlanCd': await modalContentMove ('insertKeyResultModalNextButton'); break;
					case 'insertKeyResultModalEmpCd': await modalContentMove ('insertKeyResultModalNextButton'); break;
					case 'insertKeyResultModalNote':
						var ajaxCondition = await modifyModalInputCheck('insertKeyResultModalForm');
						if (!ajaxCondition) { // 저장
							await doAction('planGridList','keyResultInput');
						}
						break;
				}
			}
		})

		/*'select2 multiple' Tab시, 페이징 처리 기능*/
		document.querySelector('span[class="select2-selection select2-selection--multiple"]').addEventListener('keydown', async ev => {
			const key = ev.key;
			const shiftKey = ev.shiftKey;
			const targetId = ev.target.id?ev.target.id:ev.target.parentNode.parentNode.parentNode.parentNode.parentNode.previousSibling.id; // nomal tag:select2 tag
			if(key === 'Tab' && !shiftKey){
				switch (targetId) {
						case 'insertKeyResultModalPartCds': await modalContentMove ('insertKeyResultModalNextButton'); break;
				}
			}
		});

		/*************************************
		 * 'insertKeyResultModal' Tap set END
		 * **********************************/

		/****************************************
		 * tui grid setColorForCheckedRow START
		 * **************************************/
		// await edsUtil.setColorForCheckedRow(planKeyResultGridList);
		/****************************************
		 * tui grid setColorForCheckedRow END
		 * **************************************/

		/****************************************
		 * tui grid setColorForSelectedRow START
		 * **************************************/
		await edsUtil.setColorForSelectedRow(planGridList);
		await edsUtil.setColorForSelectedRow(orderPlanGridList);
		/****************************************
		 * tui grid setColorForSelectedRow END
		 * **************************************/

		/****************************************
		 * tui grid setColorForSelectedCell START
		 * **************************************/
		await edsUtil.setColorForSelectedCell(planGridList,'planNm');
		await edsUtil.setColorForSelectedCell(planGridList,'empNm');
		await edsUtil.setColorForSelectedCell(planGridList,'edDt');
		await edsUtil.setColorForSelectedCell(planGridList,'fn');

		await edsUtil.setColorForSelectedCell(orderPlanGridList,'ordPlanCustCd');
		await edsUtil.setColorForSelectedCell(orderPlanGridList,'ordPlanAmt');
		await edsUtil.setColorForSelectedCell(orderPlanGridList,'ordPlanGr');
		/****************************************
		 * tui grid setColorForSelectedCell END
		 * **************************************/

		/*************************************
		 * contentObjective margin-set START
		 * **********************************/
		/* page initSize set*/
		var contentMainPaddingTop = document.getElementById('content-header').offsetHeight;
		document.getElementById('contentObjective').style.paddingTop = (contentMainPaddingTop-60)+'px';
		document.getElementById('contentObjective').style.paddingBottom = 200+'px';

		/* page resize set*/
		window.addEventListener("resize", function() {
			var contentMainPaddingTop = document.getElementById('content-header').offsetHeight;
			document.getElementById('contentObjective').style.paddingTop = (contentMainPaddingTop-65)+'px';
			document.getElementById('contentObjective').style.paddingBottom = 200+'px';
		})
		/*************************************
		 * contentObjective margin-set END
		 * **********************************/

		/*************************************
		 * planNmSearch click ev set START
		 * **********************************/
		document.getElementById('planNmSearch').addEventListener('keyup', async ev => {
			if(ev.key === 'Enter'){
				await doAction('planGridList','search');
			}
		});
		/*************************************
		 * planNmSearch click ev set END
		 * **********************************/

		/*************************************
		 * searchDivi click ev set START
		 * **********************************/
		document.getElementById('searchDivi').addEventListener('click', async ev => {
			const id = ev.target.id
			switch (id) {
				case 'label01': await searchDiviMove('label01'); break;
				case 'label02': await searchDiviMove('label02'); break;
				case 'label03': await searchDiviMove('label03'); break;
				case 'insertPlanModalOpenButton':
					document.getElementById('insertPlanModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.getElementById('insertPlanModalPlanCd').value = ''
					document.getElementById('insertPlanModalPlanNm').value = ''
					document.getElementById('insertPlanModalPlanDivi').value = '01'
					document.getElementById('insertPlanModalPlanCdRoot').value = ''
					document.getElementById('insertPlanModalStDt').value = moment().format('YYYY-MM-DD');
					document.getElementById('insertPlanModalEdDt').value = moment().format('YYYY-MM-DD');
					$('#insertPlanModalParePlanCd').val('').trigger('change');
					$('#insertPlanModalEmpCd').val('<c:out value="${LoginInfo.empCd}"/>').trigger('change');
					$('#insertPlanModalDepaCd').val('<c:out value="${LoginInfo.depaCd}"/>').trigger('change');
					$('#insertPlanModalBusiCd').val('<c:out value="${LoginInfo.busiCd}"/>').trigger('change');

					/* 신규생성 시, 연결할 상위 목표목록 활성화*/
					document.getElementById('insertPlanModalParePlanCd').disabled = false;
					await modalContentMove ('insertPlanModalOpenButton'); // 맨 앞 페이지로 초기화
					break;
			}
		});
		/*************************************
		 * searchDivi click ev set END
		 * **********************************/

		/*************************************
		 * detailedMenuDivi click ev set START
		 * **********************************/
		document.getElementById('detailedMenuDivi').addEventListener('click', async ev => {
			const id = ev.target.id
			const planGridListCell = planGridList.getFocusedCell()
			switch (id) {
				case 'insertSubPlanOpenButton':
					/* insert 시 planCdRoot 초기설정 */
					if(planGridList.getValue(planGridListCell.rowKey,'planCdRoot') === '' ||
						planGridList.getValue(planGridListCell.rowKey,'planCdRoot') === null){
						document.getElementById('insertPlanModalPlanCdRoot').value = planGridList.getValue(planGridListCell.rowKey,'planCd');
					}else{
						document.getElementById('insertPlanModalPlanCdRoot').value = planGridList.getValue(planGridListCell.rowKey,'planCdRoot') + ',' + planGridList.getValue(planGridListCell.rowKey,'planCd');
					}

					/* insert 시 나머지값 초기설정 */
					document.getElementById('insertPlanModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.getElementById('insertPlanModalPlanCd').value = ''
					document.getElementById('insertPlanModalPlanNm').value = ''
					document.getElementById('insertPlanModalPlanDivi').value = '01'
					document.getElementById('insertPlanModalStDt').value = moment().format('YYYY-MM-DD');
					document.getElementById('insertPlanModalEdDt').value = moment().format('YYYY-MM-DD');
					$('#insertPlanModalParePlanCd').val(planGridList.getValue(planGridListCell.rowKey,'planCd')).trigger('change');
					$('#insertPlanModalEmpCd').val('<c:out value="${LoginInfo.empCd}"/>').trigger('change');
					$('#insertPlanModalDepaCd').val('<c:out value="${LoginInfo.depaCd}"/>').trigger('change');
					$('#insertPlanModalBusiCd').val('<c:out value="${LoginInfo.busiCd}"/>').trigger('change');

					/* 상세목록 시, 연결할 상위 목표목록 비활성화*/
					document.getElementById('insertPlanModalParePlanCd').disabled = true;
					await modalContentMove ('insertPlanModalOpenButton'); // 맨 앞 페이지로 초기화
					break;
				case 'detailPlanModalOpenButton':

					/* 상세보기 시, 연결할 상위 목표목록 비활성화*/
					document.getElementById('detailPlanModalParePlanCd').disabled = true;

					/* 상세보기 시, 그리드 데이터 적용*/
					var row = planGridList.getFocusedCell();
					edsUtil.eds_CopySheet2Form({
						sheet: planGridList,
						form: document.detailPlanModalForm,
						rowKey: row.rowKey,
					})

					/* 상세보기 시, 상태 데이터 적용*/
					await document.getElementById('detailPlanModalStatus').setAttribute('value','U');

					/* 상세보기 시, 참가자 연동*/
					var data = edsUtil.getAjaxJson('/WORK_LOG/getPartCds',{planCd:planGridList.getValue(planGridListCell.rowKey,'planCd')}).data
					var dataLength = data.length;

					var detailPlanModalPartImgs = document.getElementById('detailPlanModalPartImgs');
					detailPlanModalPartImgs.innerHTML = '';
					for (let i = 0; i < dataLength; i++) {
						var partImg = document.createElement('img')
						partImg.setAttribute('src',data[i].partImg);
						partImg.setAttribute('title',data[i].depaCd);
						partImg.setAttribute('style',
								'width: 2rem;' +
								'height: 2rem;' +
								'margin-right: 10px;' +
								'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
								'border-radius: 50%;' +
								'border-style: none;' +
								'');
						detailPlanModalPartImgs.appendChild(partImg);
					}
					break;
				case 'insertKeyResultModalOpenButton':
					/* insert 시 planCdRoot 초기설정 */
					if(planGridList.getValue(planGridListCell.rowKey,'planCdRoot') === '' ||
							planGridList.getValue(planGridListCell.rowKey,'planCdRoot') === null){
						document.getElementById('insertKeyResultModalPlanCdRoot').value = planGridList.getValue(planGridListCell.rowKey,'planCd');
					}else{
						document.getElementById('insertKeyResultModalPlanCdRoot').value = planGridList.getValue(planGridListCell.rowKey,'planCdRoot') + ',' + planGridList.getValue(planGridListCell.rowKey,'planCd');
					}

					/* insert 시 나머지값 초기설정 */
					document.getElementById('insertKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.getElementById('insertKeyResultModalPlanCd').value = ''
					document.getElementById('insertKeyResultModalPlanNm').value = ''
					document.getElementById('insertKeyResultModalUnit').value = ''
					document.getElementById('insertKeyResultModalStAmt').value = ''
					document.getElementById('insertKeyResultModalEdAmt').value = ''
					document.getElementById('insertKeyResultModalNote').value = ''
					document.getElementById('insertKeyResultModalPlanDivi').value = '02'
					document.getElementById('insertKeyResultModalStDt').value = moment().format('YYYY-MM-DD');
					document.getElementById('insertKeyResultModalEdDt').value = moment().format('YYYY-MM-DD');
					$('#insertKeyResultModalParePlanCd').val(planGridList.getValue(planGridListCell.rowKey,'planCd')).trigger('change');
					$('#insertKeyResultModalEmpCd').val('<c:out value="${LoginInfo.empCd}"/>').trigger('change');
					$('#insertKeyResultModalDepaCd').val('<c:out value="${LoginInfo.depaCd}"/>').trigger('change');
					$('#insertKeyResultModalBusiCd').val('<c:out value="${LoginInfo.busiCd}"/>').trigger('change');

					//공동작업자: select2 multiple 처리
					$("#insertKeyResultModalPartCds").val(null).trigger('change');
					$("div[id='insertKeyResultModal'] li[class='select2-selection__choice']").remove();

					/* 상세목록 시, 연결할 상위 목표목록 비활성화*/
					document.getElementById('insertKeyResultModalParePlanCd').disabled = true;
					await modalContentMove ('insertKeyResultModalOpenButton'); // 맨 앞 페이지로 초기화
					break;
				case 'deleteSubPlanButton':
					await doAction('planGridList','delete');
					break;
				case 'detailKeyResultModalOpenButton':

					/* 상세보기 시, 연결할 상위 목표목록 비활성화*/
					document.getElementById('detailKeyResultModalParePlanCd').disabled = true;

					/* 상세보기 시, 그리드 데이터 적용*/
					var row = planGridList.getFocusedCell();
					edsUtil.eds_CopySheet2Form({
						sheet: planGridList,
						form: document.detailKeyResultModalForm,
						rowKey: row.rowKey,
					})

					/* 상세보기 시, 담당자 연동*/
					var data = edsUtil.getAjaxJson('/WORK_LOG/getWorkCds',{planCd:planGridList.getValue(planGridListCell.rowKey,'planCd')}).data
					var dataLength = data.length;

					var detailKeyResultModalPartImgs = document.getElementById('detailKeyResultModalPartImgs');
					detailKeyResultModalPartImgs.innerHTML = '';
					for (let i = 0; i < dataLength; i++) {
						var partImg = document.createElement('img')
						partImg.setAttribute('src',data[i].partImg);
						partImg.setAttribute('title',data[i].depaCd);
						partImg.setAttribute('style',
								'width: 2rem;' +
								'height: 2rem;' +
								'margin-right: 10px;' +
								'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
								'border-radius: 50%;' +
								'border-style: none;' +
								'');
						detailKeyResultModalPartImgs.appendChild(partImg);
					}
					await document.getElementById('detailKeyResultModalInfoButton').click();
					break;
				case 'detailKeyResultModalOpenButton2':
					/* 상세보기 시, 연결할 상위 목표목록 비활성화*/
					document.getElementById('detailKeyResultModalParePlanCd').disabled = true;

					/* 상세보기 시, 그리드 데이터 적용*/
					var row = keyResultGridList.getFocusedCell();
					edsUtil.eds_CopySheet2Form({
						sheet: keyResultGridList,
						form: document.detailKeyResultModalForm,
						rowKey: row.rowKey,
					})

					/* 상세보기 시, 담당자 연동*/
					var data = edsUtil.getAjaxJson('/WORK_LOG/getWorkCds',{planCd:keyResultGridList.getValue(row.rowKey,'planCd')}).data
					var dataLength = data.length;

					var detailKeyResultModalPartImgs = document.getElementById('detailKeyResultModalPartImgs');
					detailKeyResultModalPartImgs.innerHTML = '';
					for (let i = 0; i < dataLength; i++) {
						var partImg = document.createElement('img')
						partImg.setAttribute('src',data[i].partImg);
						partImg.setAttribute('title',data[i].depaCd);
						partImg.setAttribute('style',
								'width: 2rem;' +
								'height: 2rem;' +
								'margin-right: 10px;' +
								'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
								'border-radius: 50%;' +
								'border-style: none;' +
								'');
						detailKeyResultModalPartImgs.appendChild(partImg);
					}
					await document.getElementById('detailKeyResultModalInfoButton').click();
					break;
				case 'selectOrderPlanModalOpenButton':
					await doAction('planGridList','orderPlanSearch');
					break;
			}
		});
		/*************************************
		 * detailedMenuDivi click ev set END
		 * **********************************/

		/*************************************
		 * selectKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('selectKeyResultModal').addEventListener('click', async ev => {
			const id = ev.target.id
			const planGridListCell = planGridList.getFocusedCell()
			switch (id) {
				case 'selectKeyResultModalinsertKeyResultModalOpenButton': /*여기*/
					/* insert 시 planCdRoot 초기설정 */
					if(planGridList.getValue(planGridListCell.rowKey,'planCdRoot') === '' ||
							planGridList.getValue(planGridListCell.rowKey,'planCdRoot') === null){
						document.getElementById('insertKeyResultModalPlanCdRoot').value = planGridList.getValue(planGridListCell.rowKey,'planCd');
					}else{
						document.getElementById('insertKeyResultModalPlanCdRoot').value = planGridList.getValue(planGridListCell.rowKey,'planCdRoot') + ',' + planGridList.getValue(planGridListCell.rowKey,'planCd');
					}

					/* insert 시 나머지값 초기설정 */
					document.getElementById('insertKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.getElementById('insertKeyResultModalPlanCd').value = ''
					document.getElementById('insertKeyResultModalPlanNm').value = ''
					document.getElementById('insertKeyResultModalUnit').value = ''
					document.getElementById('insertKeyResultModalStAmt').value = ''
					document.getElementById('insertKeyResultModalEdAmt').value = ''
					document.getElementById('insertKeyResultModalNote').value = ''
					document.getElementById('insertKeyResultModalPlanDivi').value = '02'
					document.getElementById('insertKeyResultModalStDt').value = moment().format('YYYY-MM-DD');
					document.getElementById('insertKeyResultModalEdDt').value = moment().format('YYYY-MM-DD');
					$('#insertKeyResultModalParePlanCd').val(planGridList.getValue(planGridListCell.rowKey,'planCd')).trigger('change');
					$('#insertKeyResultModalEmpCd').val('<c:out value="${LoginInfo.empCd}"/>').trigger('change');
					$('#insertKeyResultModalDepaCd').val('<c:out value="${LoginInfo.depaCd}"/>').trigger('change');
					$('#insertKeyResultModalBusiCd').val('<c:out value="${LoginInfo.busiCd}"/>').trigger('change');

					//공동작업자: select2 multiple 처리
					$("#insertKeyResultModalPartCds").val(null).trigger('change');
					$("div[id='insertKeyResultModal'] li[class='select2-selection__choice']").remove();

					/* 상세목록 시, 연결할 상위 목표목록 비활성화*/
					document.getElementById('insertKeyResultModalParePlanCd').disabled = true;
					await modalContentMove ('insertKeyResultModalOpenButton'); // 맨 앞 페이지로 초기화
					break;
			}
		});
		/*************************************
		 * selectKeyResultModal click ev set END
		 * **********************************/

		/*************************************
		 * insertPlanModal click ev set START
		 * **********************************/
		document.getElementById('insertPlanModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			switch (targetId) {
				case 'insertPlanModalPreviousButton': await modalContentMove ('insertPlanModalPreviousButton'); break;
				case 'insertPlanModalNextButton': await modalContentMove ('insertPlanModalNextButton'); break;
				case 'insertPlanModalSubmitButton':
					var ajaxCondition = await modifyModalInputCheck('insertPlanModalForm');
					if (!ajaxCondition) { // 저장
						await doAction('planGridList','input');
					}
					break;
			}
		})
		/*************************************
		 * insertPlanModal click ev set END
		 * **********************************/

		/*************************************
		 * applyPlanKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('applyPlanKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			switch (targetId) {
				case 'selectPlanKeyResultModalButton': await doAction('planGridList','planKeyResultGridListSearch'); break;
				case 'applyPlanKeyResultModalButton': await doAction('planGridList','planKeyResultGridListApply'); break;
			}
		})
		/*************************************
		 * insertPlanModal click ev set END
		 * **********************************/

		/*************************************
		 * insertKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('insertKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			switch (targetId) {
				case 'insertKeyResultModalPreviousButton': await modalContentMove ('insertKeyResultModalPreviousButton'); break;
				case 'insertKeyResultModalNextButton': await modalContentMove ('insertKeyResultModalNextButton'); break;
				case 'insertKeyResultModalSubmitButton':
					var ajaxCondition = await modifyModalInputCheck('insertKeyResultModalForm');
					if (!ajaxCondition) { // 저장
						await doAction('planGridList','keyResultInput');
					}
					break;
			}
		})
		/*************************************
		 * insertKeyResultModal click ev set END
		 * **********************************/

		/*************************************
		 * detailPlanModal click ev set START
		 * **********************************/
		document.getElementById('detailPlanModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			const planGridListCell = planGridList.getFocusedCell()
			switch (targetId) {
				case 'selectKeyResultOpenButton':
					/* 상세보기 시, 그리드 데이터 적용*/
					var row = planGridList.getFocusedCell();
					edsUtil.eds_CopySheet2Form({
						sheet: planGridList,
						form: document.selectKeyResultModalForm,
						rowKey: row.rowKey,
					})
					await doAction('planGridList','keyResultSearch');

					/* 하위내역보기 시, 공동 작업자 연동*/
					var data = edsUtil.getAjaxJson('/WORK_LOG/getWorkCds',{planCd:document.getElementById('selectKeyResultModalPlanCd').value}).data
					var dataLength = data.length;

					var selectKeyResultModalPartImgs = document.getElementById('selectKeyResultModalPartImgs');
					selectKeyResultModalPartImgs.innerHTML = '';
					for (let i = 0; i < dataLength; i++) {
						var partImg = document.createElement('img')
						partImg.setAttribute('src',data[i].partImg);
						partImg.setAttribute('title',data[i].depaCd);
						partImg.setAttribute('style',
								'width: 2rem;' +
								'height: 2rem;' +
								'margin-right: 10px;' +
								'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
								'border-radius: 50%;' +
								'border-style: none;' +
								'');
						selectKeyResultModalPartImgs.appendChild(partImg);
					}

					// 하위핵심결과내역 top 지정
					setTimeout(async ev =>{
						document.getElementById('keyResul').style.top = 'calc(1rem - ' + selectKeyResultModalPartImgs.offsetHeight + 'px)';
					},200);
					break;
				case 'detailPlanModalSubmitButton':
					var ajaxCondition = await modifyModalInputCheck('detailPlanModalForm');
					if (!ajaxCondition) { // 저장
						await doAction('planGridList','save');
					}
					break;
				case 'detailPlanModalDeleteButton': await doAction('planGridList','delete2'); break;
			}
		})
		/*************************************
		 * detailPlanModal click ev set END
		 * **********************************/

		/*************************************
		 * detailKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('detailKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			const buttonIds = ['detailKeyResultModalInfoButton', 'detailKeyResultModalActivityButton', 'detailKeyResultModalCommentButton', 'detailKeyResultModalPlanButton', 'detailKeyResultModalCheckInButton'];
			const row = planGridList.getFocusedCell();
			const row2 = keyResultGridList.getFocusedCell();
			var detailKeyResultModalPlanAddButton = document.getElementById('detailKeyResultModalPlanAddButton');
			var detailKeyResultModalCheckInAddButton = document.getElementById('detailKeyResultModalCheckInAddButton');
			var detailKeyResultModalPlanApplyOpenButton = document.getElementById('detailKeyResultModalPlanApplyOpenButton');
			var detailKeyResultModalSubmitButton = document.getElementById('detailKeyResultModalSubmitButton');
			var detailKeyResultModalDeleteButton1 = document.getElementById('detailKeyResultModalDeleteButton1');
			var detailKeyResultModalDeleteButton2 = document.getElementById('detailKeyResultModalDeleteButton2');
			var detailKeyResultModalselectKeyResultOpenButton = document.getElementById('detailKeyResultModalselectKeyResultOpenButton');
			var insertPlanningKeyResultModalSubmitButton = document.getElementById('insertPlanningKeyResultModalSubmitButton');
			var updatePlanningKeyResultModalSubmitButton = document.getElementById('updatePlanningKeyResultModalSubmitButton');
			var deletePlanningKeyResultModalSubmitButton = document.getElementById('deletePlanningKeyResultModalSubmitButton');
			var insertCheckInKeyResultModalSubmitButton = document.getElementById('insertCheckInKeyResultModalSubmitButton');
			var updateCheckInKeyResultModalSubmitButton = document.getElementById('updateCheckInKeyResultModalSubmitButton');
			var deleteCheckInKeyResultModalSubmitButton = document.getElementById('deleteCheckInKeyResultModalSubmitButton');

			if (targetId === 'detailKeyResultModalSubmitButton') {
				var ajaxCondition = await modifyModalInputCheck('detailKeyResultModalForm');
				if (!ajaxCondition) { // 저장
					await doAction('planGridList','keyResultSave');
				}
			}
			else if (targetId === 'detailKeyResultModalCommentContentSubmit') await doAction('planGridList','commentInput', document.getElementById('detailKeyResultModalCommentContent'));
			else if (targetId === 'detailKeyResultModalActivityContentSubmit'){
				var ajaxCondition = await modifyModalInputCheck('detailKeyResultModalActivityForm');
				if (!ajaxCondition) { // 저장
					await doAction('planGridList','activityInput', document.getElementById('detailKeyResultModalActivityContent'));
				}
			}
			else if (targetId === 'detailKeyResultModalDeleteButton1') await doAction('planGridList','keyResultDelete1');
			else if (targetId === 'detailKeyResultModalDeleteButton2') await doAction('planGridList','keyResultDelete2');
			else if (targetId === 'detailKeyResultModalCommentContent') {
				setTimeout(() => {

					// 메세지 세팅 후 가장 아래로 스크롤
					var detailKeyResultModalCommentMessageBox = document.getElementById('detailKeyResultModalCommentMessageBox')
					detailKeyResultModalCommentMessageBox.scrollTop = detailKeyResultModalCommentMessageBox.scrollHeight;
				}, 100);
			}else if (targetId === 'detailKeyResultModalCommentButton') {

				detailKeyResultModalCheckInAddButton.classList.add('d-none');
				detailKeyResultModalPlanApplyOpenButton.classList.add('d-none');
				detailKeyResultModalPlanAddButton.classList.add('d-none');
				detailKeyResultModalSubmitButton.classList.add('d-none');
				detailKeyResultModalDeleteButton1.classList.add('d-none');
				detailKeyResultModalDeleteButton2.classList.add('d-none');
				var planDivi = planGridList.getValue(row.rowKey,'planDivi');
				if(planDivi==='01'){
					detailKeyResultModalselectKeyResultOpenButton.classList.remove('d-none');
				}else{
					detailKeyResultModalselectKeyResultOpenButton.classList.add('d-none');
				}

				await doAction('planGridList','commentSearch');

			}else if (targetId === 'detailKeyResultModalActivityContent') {
				setTimeout(() => {

					// 메세지 세팅 후 가장 아래로 스크롤
					var detailKeyResultModalActivityMessageBox = document.getElementById('detailKeyResultModalActivityMessageBox')
					detailKeyResultModalActivityMessageBox.scrollTop = detailKeyResultModalActivityMessageBox.scrollHeight;
				}, 100);
			}else if (targetId === 'detailKeyResultModalActivityButton') {

				detailKeyResultModalCheckInAddButton.classList.add('d-none');
				detailKeyResultModalPlanApplyOpenButton.classList.add('d-none');
				detailKeyResultModalPlanAddButton.classList.add('d-none');
				detailKeyResultModalSubmitButton.classList.add('d-none');
				detailKeyResultModalDeleteButton1.classList.add('d-none');
				detailKeyResultModalDeleteButton2.classList.add('d-none');
				var planDivi = planGridList.getValue(row.rowKey,'planDivi');
				if(planDivi==='01'){
					detailKeyResultModalselectKeyResultOpenButton.classList.remove('d-none');
				}else{
					detailKeyResultModalselectKeyResultOpenButton.classList.add('d-none');
				}

				await doAction('planGridList','activitySearch');

			}else if (targetId === 'detailKeyResultModalPlanButton') {

				await doAction('planGridList','planningKeyResulChartSearch');
				await doAction('planGridList','planningKeyResulListSearch');

				document.getElementsByName('insertPlanningKeyResultModalUnit').forEach(el=>{
					el.innerHTML = document.getElementById('detailKeyResultModalUnit').value
				})

				detailKeyResultModalCheckInAddButton.classList.add('d-none');
				detailKeyResultModalPlanApplyOpenButton.classList.add('d-none');
				detailKeyResultModalPlanAddButton.classList.remove('d-none');
				detailKeyResultModalSubmitButton.classList.add('d-none');
				detailKeyResultModalDeleteButton1.classList.add('d-none');
				detailKeyResultModalDeleteButton2.classList.add('d-none');
				var planDivi = planGridList.getValue(row.rowKey,'planDivi');
				if(planDivi==='01'){
					detailKeyResultModalselectKeyResultOpenButton.classList.remove('d-none');
				}else{
					detailKeyResultModalselectKeyResultOpenButton.classList.add('d-none');
				}

			}else if (targetId === 'detailKeyResultModalCheckInButton') {

				await doAction('planGridList','checkInKeyResulChartSearch');
				await doAction('planGridList','checkInKeyResulListSearch');

				document.getElementsByName('insertCheckInKeyResultModalUnit').forEach(el=>{
					el.innerHTML = document.getElementById('detailKeyResultModalUnit').value
				})

				detailKeyResultModalCheckInAddButton.classList.add('d-none');
				detailKeyResultModalPlanApplyOpenButton.classList.remove('d-none');
				detailKeyResultModalPlanAddButton.classList.add('d-none');
				detailKeyResultModalSubmitButton.classList.add('d-none');
				detailKeyResultModalDeleteButton1.classList.add('d-none');
				detailKeyResultModalDeleteButton2.classList.add('d-none');
				var planDivi = planGridList.getValue(row.rowKey,'planDivi');
				if(planDivi==='01'){
					detailKeyResultModalselectKeyResultOpenButton.classList.remove('d-none');
				}else{
					detailKeyResultModalselectKeyResultOpenButton.classList.add('d-none');
				}

			}else if (targetId === 'detailKeyResultModalInfoButton') {

				detailKeyResultModalCheckInAddButton.classList.add('d-none');
				detailKeyResultModalPlanApplyOpenButton.classList.add('d-none');
				detailKeyResultModalPlanAddButton.classList.add('d-none');
				detailKeyResultModalSubmitButton.classList.remove('d-none');
				var planDivi = planGridList.getValue(row.rowKey,'planDivi');
				if(planDivi==='01'){
					detailKeyResultModalselectKeyResultOpenButton.classList.remove('d-none');
					detailKeyResultModalDeleteButton1.classList.remove('d-none');
					detailKeyResultModalDeleteButton2.classList.add('d-none');
				}else{
					detailKeyResultModalselectKeyResultOpenButton.classList.add('d-none');
					detailKeyResultModalDeleteButton1.classList.add('d-none');
					detailKeyResultModalDeleteButton2.classList.remove('d-none');
				}

			}else if (targetId === 'detailKeyResultModalPlanAddButton') {
				insertPlanningKeyResultModalSubmitButton.classList.remove('d-none');
				updatePlanningKeyResultModalSubmitButton.classList.add('d-none');
				deletePlanningKeyResultModalSubmitButton.classList.add('d-none');

				var data = planningKeyResultGridList.getFilteredData();
				var insertPlanningKeyResultModalAmt1 = 0;
				data.forEach(row_1 => {
					insertPlanningKeyResultModalAmt1 += Number(row_1.amt);
				})
				/* 성과수치 계획 모달 적용*/
				document.getElementById('insertPlanningKeyResultModalStatus').value = 'C'
				document.getElementById('insertPlanningKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
				document.getElementById('insertPlanningKeyResultModalPlanCd').value = document.getElementById('detailKeyResultModalPlanCd').value;
				document.getElementById('insertPlanningKeyResultModalSeq').value = '';
				document.getElementById('insertPlanningKeyResultModalCheckInDivi').value = '01';
				document.getElementById('insertPlanningKeyResultModalAmt1').textContent = insertPlanningKeyResultModalAmt1;
				document.getElementById('insertPlanningKeyResultModalUnit1').value = '';
				document.getElementById('insertPlanningKeyResultModalAmt2').textContent = document.getElementById('detailKeyResultModalEdAmt').value;
				document.getElementById('insertPlanningKeyResultModalUnit2').value = '';
				document.getElementById('insertPlanningKeyResultModalDt').value = moment().format('YYYY-MM-DD');
				document.getElementById('insertPlanningKeyResultModalAmt').value = '';
				document.getElementById('insertPlanningKeyResultModalStatusDivi').value = '';
				document.getElementById('insertPlanningKeyResultModalNote').value = '';
			}else if (targetId === 'detailKeyResultModalCheckInAddButton') {
				insertCheckInKeyResultModalSubmitButton.classList.remove('d-none');
				updateCheckInKeyResultModalSubmitButton.classList.add('d-none');
				deleteCheckInKeyResultModalSubmitButton.classList.add('d-none');

				var data = checkInKeyResultGridList.getFilteredData();
				var insertCheckInKeyResultModalAmt1 = 0;
				data.forEach(row_1 => {
					insertCheckInKeyResultModalAmt1 += Number(row_1.amt);
				})

				/* 성과수치 계획 모달 적용*/
				document.getElementById('insertCheckInKeyResultModalStatus').value = 'C'
				document.getElementById('insertCheckInKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
				document.getElementById('insertCheckInKeyResultModalPlanCd').value = document.getElementById('detailKeyResultModalPlanCd').value;
				document.getElementById('insertCheckInKeyResultModalSeq').value = '';
				document.getElementById('insertCheckInKeyResultModalCheckInDivi').value = '02';
				document.getElementById('insertCheckInKeyResultModalAmt1').textContent = insertCheckInKeyResultModalAmt1;
				document.getElementById('insertCheckInKeyResultModalUnit1').value = '';
				document.getElementById('insertCheckInKeyResultModalAmt2').textContent = document.getElementById('detailKeyResultModalEdAmt').value;
				document.getElementById('insertCheckInKeyResultModalUnit2').value = '';
				document.getElementById('insertCheckInKeyResultModalDt').value = moment().format('YYYY-MM-DD');
				document.getElementById('insertCheckInKeyResultModalAmt').value = '';
				document.getElementById('insertCheckInKeyResultModalStatusDivi').value = '';
				document.getElementById('insertCheckInKeyResultModalNote').value = '';
			}else if (targetId === 'detailKeyResultModalPlanApplyOpenButton') {

				await doAction('planGridList','planKeyResultGridListSearch');

			}else if (targetId === 'detailKeyResultModalselectKeyResultOpenButton') {

				await doAction('planGridList','keyResultSearch');

				/* 하위내역보기 시, 공동 작업자 연동*/
				var data = edsUtil.getAjaxJson('/WORK_LOG/getWorkCds',{planCd:document.getElementById('selectKeyResultModalPlanCd').value}).data
				var dataLength = data.length;

				var selectKeyResultModalPartImgs = document.getElementById('selectKeyResultModalPartImgs');
				selectKeyResultModalPartImgs.innerHTML = '';
				for (let i = 0; i < dataLength; i++) {
					var partImg = document.createElement('img')
					partImg.setAttribute('src',data[i].partImg);
					partImg.setAttribute('title',data[i].depaCd);
					partImg.setAttribute('style',
							'width: 2rem;' +
							'height: 2rem;' +
							'margin-right: 10px;' +
							'box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23) !important;' +
							'border-radius: 50%;' +
							'border-style: none;' +
							'');
					selectKeyResultModalPartImgs.appendChild(partImg);
				}

				// 하위핵심결과내역 top 지정
				setTimeout(async ev =>{
					document.getElementById('keyResul').style.top = 'calc(1rem - ' + selectKeyResultModalPartImgs.offsetHeight + 'px)';
				},200);
			}
			if (buttonIds.includes(targetId)) await detailKeyResultModalButtonMove(targetId);
		})
		/*************************************
		 * detailKeyResultModal click ev set END
		 * **********************************/

		/*************************************
		 * detailKeyResultModal keyhdown ev set START
		 * **********************************/
		document.getElementById('detailKeyResultModal').addEventListener('keydown', async ev =>{
			const targetId = ev.target.id;
			const keyCode = ev.code;
			const shiftKey = ev.shiftKey;
			if (keyCode === "Enter" && !shiftKey && !ev.isComposing) {
				if (targetId === 'detailKeyResultModalCommentContent') {
					await ev.preventDefault(); // 기본 Enter 동작 (줄바꿈) 방지
					await doAction('planGridList','commentInput', ev.target)
				}else if (targetId === 'detailKeyResultModalActivityContent') {
					await ev.preventDefault(); // 기본 Enter 동작 (줄바꿈) 방지
					var ajaxCondition = await modifyModalInputCheck('detailKeyResultModalActivityForm');
					if (!ajaxCondition) { // 저장
						await doAction('planGridList','activityInput', ev.target)
					}
				}
			}
		})
		/*************************************
		 * detailKeyResultModal keydown ev set END
		 * **********************************/

		/*************************************
		 * insertPlanningKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('insertPlanningKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			if (targetId === 'insertPlanningKeyResultModalSubmitButton') {
				var ajaxCondition = await modifyModalInputCheck('insertPlanningKeyResultModalForm');
				if (!ajaxCondition) { // 저장
					await doAction('planGridList', 'planningKeyResultInput');
					await document.getElementById('insertPlanningKeyResultModalCloseButton').click();
					await doAction('planGridList', 'search');
				}
			}
			else if (targetId === 'updatePlanningKeyResultModalSubmitButton') {
				await doAction('planGridList', 'planningKeyResultUpdate');
				await doAction('planGridList', 'search');
			}
			else if (targetId === 'deletePlanningKeyResultModalSubmitButton') {
				await doAction('planGridList', 'planningKeyResultDelete');
				await doAction('planGridList', 'search');
			}
		})
		/*************************************
		 * insertPlanningKeyResultModal click ev set END
		 * **********************************/

		/*************************************
		 * insertCheckInKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('insertCheckInKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			if (targetId === 'insertCheckInKeyResultModalSubmitButton') {
				var ajaxCondition = await modifyModalInputCheck('insertCheckInKeyResultModalForm');
				if (!ajaxCondition) { // 저장
					await doAction('planGridList', 'checkInKeyResultInput');
					await document.getElementById('insertCheckInKeyResultModalCloseButton').click();
					await doAction('planGridList', 'search');
				}
			}
			else if (targetId === 'updateCheckInKeyResultModalSubmitButton') {
				await doAction('planGridList', 'checkInKeyResultUpdate')
				await doAction('planGridList', 'search');
			}
			else if (targetId === 'deleteCheckInKeyResultModalSubmitButton') {
				await doAction('planGridList', 'checkInKeyResultDelete')
				await doAction('planGridList', 'search');
			};
		})
		/*************************************
		 * insertCheckInKeyResultModal click ev set END
		 * **********************************/

		/*************************************
		 * selectOrderPlanModal click ev set START
		 * **********************************/
		document.getElementById('selectOrderPlanModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			if (targetId === 'selectOrderPlanModalButton') await doAction('planGridList','orderPlanSearch');
			else if (targetId === 'insertOrderPlanModalButton') await doAction('planGridList','orderPlanInput');
		})
		/*************************************
		 * selectOrderPlanModal click ev set END
		 * **********************************/

		/*************************************
		 * modal back scroll ev set START
		 * **********************************/

		// 모달이 열릴 때 뒷단 클라이언트 스크롤 비활성화
		$('#selectKeyResultModal, #detailKeyResultModal, #insertKeyResultModal,' +
		  '#detailPlanModal, #insertPlanModal,' +
		  '#selectFunctionModal, #selectOrderPlanModal').on('show.bs.modal', function(e) {
			// body 스크롤을 비활성화
			$('body').css('overflow', 'hidden');
		});

		// 모달이 열릴 때 뒷단 클라이언트 스크롤 활성화
		$('#selectKeyResultModal, #detailKeyResultModal, #insertKeyResultModal,' +
		  '#detailPlanModal, #insertPlanModal,' +
		  '#selectFunctionModal, #selectOrderPlanModal').on('hide.bs.modal', function(e) {
			// body 스크롤을 다시 활성화
			$('body').css('overflow', 'auto');
		});

		/*************************************
		 * modal back scroll ev set END
		 * **********************************/
	});

	/* 초기설정 */
	async function init() {
		/* Form 셋팅 */
		edsUtil.setSelectEl(document.querySelector("#insertPlanModalForm"), "commute",
				{
					corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
					busiCd: '<c:out value="${LoginInfo.busiCd}"/>',
					depaCd: '<c:out value="${LoginInfo.depaCd}"/>',
					empCd: '<c:out value="${LoginInfo.empCd}"/>',
				});
		edsUtil.setSelectEl(document.querySelector("#detailPlanModalForm"), "commute",
				{
					corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
					busiCd: '<c:out value="${LoginInfo.busiCd}"/>',
					depaCd: '<c:out value="${LoginInfo.depaCd}"/>',
					empCd: '<c:out value="${LoginInfo.empCd}"/>',
				});
		edsUtil.setSelectEl(document.querySelector("#insertKeyResultModalForm"), "commute",
				{
					corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
					busiCd: '<c:out value="${LoginInfo.busiCd}"/>',
					depaCd: '<c:out value="${LoginInfo.depaCd}"/>',
					empCd: '<c:out value="${LoginInfo.empCd}"/>',
				});
		edsUtil.setSelectEl(document.querySelector("#detailKeyResultModalForm"), "commute",
				{
					corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
					busiCd: '<c:out value="${LoginInfo.busiCd}"/>',
					depaCd: '<c:out value="${LoginInfo.depaCd}"/>',
					empCd: '<c:out value="${LoginInfo.empCd}"/>',
				});
		/* 조회옵션 셋팅 */

		/* Button 셋팅 */

		/* 이벤트 셋팅 */
		/*edsUtil.addChangeEvent("planGridListForm", fn_CopyForm2planGridList);*/

		/*********************************************************************
		 * DatePicker Info 영역 START
		 ***********************************************************************/

		/* 데이트픽커 초기 속성 설정 */

		/* 데이트픽커 초기 속성 설정 */
		ordPlanSetDt = new DatePicker(['#ordPlanSetDtDIV'], {
			language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
			showAlways: false, // If true, the datepicker will not close until you call "close()".
			autoClose: true,// If true, Close datepicker when select date
			date: new Date(), // Date instance or Timestamp for initial date
			input: {
				element: ['#ordPlanSetDt'],
				format: 'yyyy-MM'
			},
			type: 'month', // Type of picker - 'date', 'month', year'
		});

		/**********************************************************************
		 * DatePicker Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid Class 영역 START
		 ***********************************************************************/
		class CustomSliderRenderer {
			constructor(props) {

				const rowKey = props.rowKey;
				const value = props.value;
				var divi = props.grid.el.id.includes('planGridListDIV')?'planGridListDIV'
						 : props.grid.el.id.includes('keyResultGridListDIV')?'keyResultGridListDIV'
						 : props.grid.el.id.includes('planningKeyResultGridListDIV')?'planningKeyResultGridListDIV'
						 : props.grid.el.id.includes('checkInKeyResultGridListDIV')?'checkInKeyResultGridListDIV':'';
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
		// objective
		planGridList = new tui.Grid({
			el: document.getElementById('planGridListDIV'),
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
			rowHeaders: [/*'rowNum', 'checkbox'*/],
			header: {
				height: 50,
				minRowHeight: 50
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		planGridList.setColumns([
			{ header:'기획명',		name:'planNm',		minWidth:200,	align:'left', whiteSpace:"pre-line"},
			{ header:'목표구분',		name:'userDivi',	width:100,		align:'left',
				formatter:function (ev) {
					if(ev.row.planDivi === '01'){
						if(ev.row.empCd === '<c:out value="${LoginInfo.empCd}"/>'){
							return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #111f94;padding: 2px 0px;"><i class="fa-solid fa-user"></i> 내 목표</div>';
						}else{
							return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333333;padding: 2px 0px;"> 목표</div>';
						}
					}else if(ev.row.planDivi === '02'){
						if(ev.row.empCd === '<c:out value="${LoginInfo.empCd}"/>'){
							return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"><i class="fa-solid fa-square-poll-vertical"></i> 내 지표</div>';
						}else{
							return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"> 지표</div>';
						}
					}else{

					}
				}},
			{ header:'담당자',		name:'empNm',	width:100,		align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.empCd+'">'+ ev.row.empNm;
				}},
			{ header:'부서',			name:'depaNm',		width:100,		align:'center',
				formatter:function (ev) {
					return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: '+ev.row.depaColorCd+';padding: 2px 0px;">'+ev.row.depaNm+'</div>';
				}},
			{ header:'종료일',		name:'edDt',		width:100,		align:'center'},
			{ header:'진행율',			name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:'진행상태',		name:'statusDivi',		width:70,		align:'center',
				formatter:function (ev) {
					var rtn = '';
					switch (ev.row.statusDivi) {
						case '01':
							// rtn = `<b>대기<b/>`
							rtn = '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"><i class="fa-regular fa-face-meh-blank fa-shake fa-lg" style="--fa-animation-duration: 3s; --fa-fade-opacity: 0.1;"></i>&nbsp;&nbsp;대기</div>'
							break;
						case '02':
							// rtn = `<b style="color:#68bae7">진행중<b/>`
							rtn = '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"><i class="fa-regular fa-face-smile-beam fa-lg fa-flip" style="--fa-animation-duration: 3s;color:#68bae7;"></i>&nbsp;&nbsp;순항</div>'
							break;
						case '03':
							// rtn = `<b style="color:#da362e">문제발생<b/>`
							rtn = '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"><i class="fa-regular fa-face-surprise fa-beat fa-lg" style="--fa-animation-duration: 0.5s;color:#da362e"></i>&nbsp;&nbsp;문제</div>'
							break;
						case '04':
							// rtn = `<b style="color:#51ab42">완료<b/>`
							rtn = '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"><i class="fa-regular fa-face-laugh-beam fa-lg" style="color:#51ab42"></i>&nbsp;&nbsp;완료</div>'
							break;
					}
					return rtn;
				}},
			{ header:'상세기능',		name:'fn',			width:20,		align:'center',
				formatter:function (ev) {
					return '···';
				}
			},
			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
			{ header:'부모기획코드',	name:'parePlanCd',	width:150,		align:'center',	hidden:true },
			{ header:'기획코드',		name:'planCd',		width:150,		align:'center',	hidden:true },
			{ header:'기획구분',		name:'planDivi',	width:150,		align:'center',	hidden:true },
			{ header:'기획코드경로',	name:'planCdRoot',	width:150,		align:'center',	hidden:true },
			{ header:'부모순번',		name:'pareSeq',		width:100,		align:'center',	hidden:true },
			{ header:'담당사업장코드',name:'busiCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당부서코드',	name:'depaCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당자코드',	name:'empCd',		width:150,		align:'center',	hidden:true },
			{ header:'공동 작업자코드',name:'partCds',	width:150,		align:'center',	hidden:true },
			{ header:'저장상태',		name:'saveDivi',	width:100,		align:'center',	hidden:true },
			{ header:'단위',			name:'unit',		width:100,		align:'center',	hidden:true },
			{ header:'시작값',		name:'stAmt',		width:100,		align:'center',	hidden:true },
			{ header:'목표값',		name:'edAmt',		width:100,		align:'center',	hidden:true },
			{ header:'진행율',		name:'edRate',		width:100,		align:'center',	hidden:true },
		]);
		// key result
		keyResultGridList = new tui.Grid({
			el: document.getElementById('keyResultGridListDIV'),
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
			rowHeaders: [/*'rowNum', 'checkbox'*/],
			header: {
				height: 50,
				minRowHeight: 50
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		keyResultGridList.setColumns([
			{ header:' ',			name:'planNm',		minWidth:100,	align:'left', whiteSpace:"pre-line"},
			{ header:' ',			name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:' ',			name:'statusDivi',	width:50,		align:'center',
				formatter:function (ev) {
					var rtn = '';
					switch (ev.row.statusDivi) {
						case '01':
							// rtn = `<b>대기<b/>`
							rtn = `<i class="fa-regular fa-face-meh-blank fa-shake fa-lg" style="--fa-animation-duration: 3s; --fa-fade-opacity: 0.1;"></i> `
							break;
						case '02':
							// rtn = `<b style="color:#68bae7">진행중<b/>`
							rtn = `<i class="fa-regular fa-face-smile-beam fa-lg fa-flip" style="--fa-animation-duration: 3s;color:#68bae7;"></i> `
							break;
						case '03':
							// rtn = `<b style="color:#da362e">문제발생<b/>`
							rtn = `<i class="fa-regular fa-face-surprise fa-beat fa-lg" style="color:#da362e"></i>`
							break;
						case '04':
							// rtn = `<b style="color:#51ab42">완료<b/>`
							rtn = `<i class="fa-regular fa-face-laugh-beam fa-lg" style="color:#51ab42"></i>`
							break;
					}
					return rtn;
				}},
			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
			{ header:'부모기획코드',	name:'parePlanCd',	width:150,		align:'center',	hidden:true },
			{ header:'기획코드',		name:'planCd',		width:150,		align:'center',	hidden:true },
			{ header:'기획구분',		name:'planDivi',	width:150,		align:'center',	hidden:true },
			{ header:'기획코드경로',	name:'planCdRoot',	width:150,		align:'center',	hidden:true },
			{ header:'부모순번',		name:'pareSeq',		width:100,		align:'center',	hidden:true },
			{ header:'담당사업장코드',name:'busiCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당부서코드',	name:'depaCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당자코드',	name:'empCd',		width:150,		align:'center',	hidden:true },
			{ header:'공동 작업자코드',name:'partCds',		width:150,		align:'center',	hidden:true },
			{ header:'저장상태',		name:'saveDivi',	width:100,		align:'center',	hidden:true },
			{ header:'단위',			name:'unit',		width:100,		align:'center',	hidden:true },
			{ header:'시작값',		name:'stAmt',		width:100,		align:'center',	hidden:true },
			{ header:'목표값',		name:'edAmt',		width:100,		align:'center',	hidden:true },
			{ header:'진행율',		name:'edRate',		width:100,		align:'center',	hidden:true },
			{ header:'목표구분',		name:'userDivi',	width:100,		align:'left',
				formatter:function (ev) {
					if(ev.row.empCd === '<c:out value="${LoginInfo.empCd}"/>' && ev.row.planDivi === '01'){
						return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #111f94;padding: 2px 0px;"><i class="fa-solid fa-user"></i> 내 목표</div>';
					}else if(ev.row.empCd === '<c:out value="${LoginInfo.empCd}"/>' && ev.row.planDivi === '02'){
						return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: #333;padding: 2px 0px;"><i class="fa-solid fa-square-poll-vertical"></i> 담당 KR</div>';
					}else{

					}
				},
				hidden:true},
			{ header:'담당자',		name:'empNm',	width:100,		align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.empCd+'">'+ ev.row.empNm;
				},
				hidden:true},
			{ header:'부서',			name:'depaNm',		width:100,		align:'center',
				formatter:function (ev) {
					return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: '+ev.row.depaColorCd+';padding: 2px 0px;">'+ev.row.depaNm+'</div>';
				},
				hidden:true},
			{ header:'종료일',		name:'edDt',		width:100,		align:'center',
				hidden:true},
			{ header:'',			name:'fn',			width:20,		align:'center',
				formatter:function (ev) {
					return '···';
				},
				hidden:true
			},
			{ header:' ',			name:'edRateBar',	width:100,		align:'center',	hidden:true },
			{ header:' ',			name:'edDivi',		width:50,		align:'center',	hidden:true },
		]);
		// planning key result
		planningKeyResultGridList = new tui.Grid({
			el: document.getElementById('planningKeyResultGridListDIV'),
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
			rowHeaders: [/*'rowNum', 'checkbox'*/],
			header: {
				height: 50,
				minRowHeight: 50
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		planningKeyResultGridList.setColumns([
			{ header:' ',			name:'dt',			width:85,	align:'center'},
			{ header:' ',			name:'note',		minWidth:150,		align:'left',	whiteSpace:'pre-line'},
			{ header:' ',			name:'amt',			width:50,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + document.getElementById('detailKeyResultModalUnit').value;
				},
				whiteSpace:'pre-line'
			},
			{ header:' ',			name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:' ',			name:'statusDivi',	width:50,		align:'center',
				formatter:function (ev) {
					var rtn = '';
					switch (ev.row.statusDivi) {
						case '01':
							// rtn = `<b>대기<b/>`
							rtn = `<i class="fa-regular fa-face-meh-blank fa-shake fa-lg" style="--fa-animation-duration: 3s; --fa-fade-opacity: 0.1;"></i> `
							break;
						case '02':
							// rtn = `<b style="color:#68bae7">진행중<b/>`
							rtn = `<i class="fa-regular fa-face-smile-beam fa-lg fa-flip" style="--fa-animation-duration: 3s;color:#68bae7;"></i> `
							break;
						case '03':
							// rtn = `<b style="color:#da362e">문제발생<b/>`
							rtn = `<i class="fa-regular fa-face-surprise fa-beat fa-lg" style="color:#da362e"></i>`
							break;
						case '04':
							// rtn = `<b style="color:#51ab42">완료<b/>`
							rtn = `<i class="fa-regular fa-face-laugh-beam fa-lg" style="color:#51ab42"></i>`
							break;
					}
					return rtn;
				},
				hidden:true},
			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
			{ header:'회사명',		name:'corpNm',		width:150,		align:'center',	hidden:true },
			{ header:'기획코드',		name:'planCd',		width:150,		align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:150,		align:'center',	hidden:true },
			{ header:'저장상태',		name:'saveDivi',	width:100,		align:'center',	hidden:true },
			{ header:'체크인구분',	name:'checkInDivi',	width:150,		align:'center',	hidden:true },
			{ header:'담당사업장코드',name:'busiCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당사업장명',	name:'busiNm',		width:150,		align:'center',	hidden:true },
			{ header:'담당부서코드',	name:'depaCd',		width:150,		align:'center',	hidden:true },
			{ header:'입력자자코드',	name:'inpId',		width:150,		align:'center',	hidden:true },
			{ header:'수정자코드',	name:'updId',		width:150,		align:'center',	hidden:true },
			{ header:'입력자',		name:'inpNm',	width:100,			align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.inpId+'">'+ ev.row.inpNm;
				},
				hidden:true},
			{ header:'수정자',		name:'inpNm',	width:100,		align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.updId+'">'+ ev.row.updNm;
				},
				hidden:true},
			{ header:'부서',			name:'depaNm',		width:100,		align:'center',
				formatter:function (ev) {
					return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: '+ev.row.depaColorCd+';padding: 2px 0px;">'+ev.row.depaNm+'</div>';
				},
				hidden:true},
		]);
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
				height: 50,
				minRowHeight: 50
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		planKeyResultGridList.setColumns([
			{ header:' ',			name:'dt',			width:85,	align:'center'},
			{ header:' ',			name:'note',		minWidth:150,		align:'left',	whiteSpace:'pre-line'},
			{ header:' ',			name:'amt',			width:50,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + document.getElementById('detailKeyResultModalUnit').value;
				},
				whiteSpace:'pre-line'
			},
			{ header:' ',			name:'applyTotAmt',	width:50,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + document.getElementById('detailKeyResultModalUnit').value;
				},
				whiteSpace:'pre-line'
			},
			{ header:' ',			name:'applyAmt',	width:50,	align:'right',	whiteSpace:'pre-line', editor:{type: 'text'}},
			{ header:' ',			name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:' ',			name:'statusDivi',	width:50,		align:'center',
				formatter:function (ev) {
					var rtn = '';
					switch (ev.row.statusDivi) {
						case '01':
							// rtn = `<b>대기<b/>`
							rtn = `<i class="fa-regular fa-face-meh-blank fa-shake fa-lg" style="--fa-animation-duration: 3s; --fa-fade-opacity: 0.1;"></i> `
							break;
						case '02':
							// rtn = `<b style="color:#68bae7">진행중<b/>`
							rtn = `<i class="fa-regular fa-face-smile-beam fa-lg fa-flip" style="--fa-animation-duration: 3s;color:#68bae7;"></i> `
							break;
						case '03':
							// rtn = `<b style="color:#da362e">문제발생<b/>`
							rtn = `<i class="fa-regular fa-face-surprise fa-beat fa-lg" style="color:#da362e"></i>`
							break;
						case '04':
							// rtn = `<b style="color:#51ab42">완료<b/>`
							rtn = `<i class="fa-regular fa-face-laugh-beam fa-lg" style="color:#51ab42"></i>`
							break;
					}
					return rtn;
				},
				hidden:true},
			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
			{ header:'회사명',		name:'corpNm',		width:150,		align:'center',	hidden:true },
			{ header:'기획코드',		name:'planCd',		width:150,		align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:150,		align:'center',	hidden:true },
			{ header:'저장상태',		name:'saveDivi',	width:100,		align:'center',	hidden:true },
			{ header:'체크인구분',	name:'checkInDivi',	width:150,		align:'center',	hidden:true },
			{ header:'담당사업장코드',name:'busiCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당사업장명',	name:'busiNm',		width:150,		align:'center',	hidden:true },
			{ header:'담당부서코드',	name:'depaCd',		width:150,		align:'center',	hidden:true },
			{ header:'입력자자코드',	name:'inpId',		width:150,		align:'center',	hidden:true },
			{ header:'수정자코드',	name:'updId',		width:150,		align:'center',	hidden:true },
			{ header:'입력자',		name:'inpNm',	width:100,			align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.inpId+'">'+ ev.row.inpNm;
				},
				hidden:true},
			{ header:'수정자',		name:'inpNm',	width:100,		align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.updId+'">'+ ev.row.updNm;
				},
				hidden:true},
			{ header:'부서',			name:'depaNm',		width:100,		align:'center',
				formatter:function (ev) {
					return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: '+ev.row.depaColorCd+';padding: 2px 0px;">'+ev.row.depaNm+'</div>';
				},
				hidden:true},
		]);
		// check in key result
		checkInKeyResultGridList = new tui.Grid({
			el: document.getElementById('checkInKeyResultGridListDIV'),
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
			rowHeaders: [/*'rowNum', 'checkbox'*/],
			header: {
				height: 50,
				minRowHeight: 50
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		checkInKeyResultGridList.setColumns([
			{ header:' ',			name:'dt',			width:85,	align:'center'},
			{ header:' ',			name:'note',		minWidth:150,	align:'left',	whiteSpace:'pre-line'},
			{ header:' ',			name:'amt',			width:50,		align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + document.getElementById('detailKeyResultModalUnit').value;
				},
				whiteSpace:'pre-line'
			},
			{ header:' ',			name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:' ',			name:'statusDivi',	width:50,		align:'center',
				formatter:function (ev) {
					var rtn = '';
					switch (ev.row.statusDivi) {
						case '01':
							// rtn = `<b>대기<b/>`
							rtn = `<i class="fa-regular fa-face-meh-blank fa-shake fa-lg" style="--fa-animation-duration: 3s; --fa-fade-opacity: 0.1;"></i> `
							break;
						case '02':
							// rtn = `<b style="color:#68bae7">진행중<b/>`
							rtn = `<i class="fa-regular fa-face-smile-beam fa-lg fa-flip" style="--fa-animation-duration: 3s;color:#68bae7;"></i> `
							break;
						case '03':
							// rtn = `<b style="color:#da362e">문제발생<b/>`
							rtn = `<i class="fa-regular fa-face-surprise fa-beat fa-lg" style="color:#da362e"></i>`
							break;
						case '04':
							// rtn = `<b style="color:#51ab42">완료<b/>`
							rtn = `<i class="fa-regular fa-face-laugh-beam fa-lg" style="color:#51ab42"></i>`
							break;
					}
					return rtn;
				}},
			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
			{ header:'회사명',		name:'corpNm',		width:150,		align:'center',	hidden:true },
			{ header:'기획코드',		name:'planCd',		width:150,		align:'center',	hidden:true },
			{ header:'순번',			name:'seq',			width:150,		align:'center',	hidden:true },
			{ header:'저장상태',		name:'saveDivi',	width:100,		align:'center',	hidden:true },
			{ header:'체크인구분',	name:'checkInDivi',	width:150,		align:'center',	hidden:true },
			{ header:'담당사업장코드',name:'busiCd',		width:150,		align:'center',	hidden:true },
			{ header:'담당사업장명',	name:'busiNm',		width:150,		align:'center',	hidden:true },
			{ header:'담당부서코드',	name:'depaCd',		width:150,		align:'center',	hidden:true },
			{ header:'입력자자코드',	name:'inpId',		width:150,		align:'center',	hidden:true },
			{ header:'수정자코드',	name:'updId',		width:150,		align:'center',	hidden:true },
			{ header:'입력자',		name:'inpNm',	width:100,			align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.inpId+'">'+ ev.row.inpNm;
				},
				hidden:true},
			{ header:'수정자',		name:'inpNm',	width:100,		align:'center',
				formatter:function (ev) {
					return '<img class="img-circle elevation-2"'+
							'id="userFace"'+
							'style="height: 2rem;width: 2rem;margin-right: 10px;"'+
							'src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/'+ev.row.corpCd+':'+ev.row.updId+'">'+ ev.row.updNm;
				},
				hidden:true},
			{ header:'부서',			name:'depaNm',		width:100,		align:'center',
				formatter:function (ev) {
					return '<div style="text-align: center;vertical-align: middle;background-color: #fff;border-radius: 1rem;color: '+ev.row.depaColorCd+';padding: 2px 0px;">'+ev.row.depaNm+'</div>';
				},
				hidden:true},
		]);
		// order plan list
		orderPlanGridList = new tui.Grid({
			el: document.getElementById('orderPlanGridListDIV'),
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
			rowHeaders: [/*'rowNum',*/ 'checkbox'],
			header: {
				height: 50,
				minRowHeight: 50
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		orderPlanGridList.setColumns([
			{ header:' ',				name:'ordPlanCustCd',	minWidth:120,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:' ',				name:'ordPlanAmt',		width:60,	align:'right',	defaultValue: ''	},
			{ header:' ',				name:'ordPlanGr',		width:50,	align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM045")}},	formatter: 'listItemText'},
			// hidden(숨김)
			{ header:'회사코드',			name:'corpCd',			width:100,		align:'center',	hidden:true },
			{ header:'수주계획코드',		name:'ordPlanCd',		width:100,		align:'center',	hidden:true },
			{ header:'수주계획년도',		name:'ordPlanYear',		width:100,		align:'center',	hidden:true },
			{ header:'수주계획월',		name:'ordPlanMonth',	width:100,		align:'center',	hidden:true },
			{ header:'수주계획구분',		name:'ordPlanDivi',		width:100,		align:'center',	hidden:true },
			{ header:'수주계획항목',		name:'ordPlanItem',		width:100,		align:'center',	hidden:true },
			{ header:'수주계획사업장코드',	name:'ordPlanBusiCd',	width:100,		align:'center',	hidden:true },
			{ header:'수주계획부서코드',	name:'ordPlanDepaCd',	width:100,		align:'center',	hidden:true },
			{ header:'수주계획담당자코드',	name:'ordPlanEmpCd',	width:100,		align:'center',	hidden:true },
			{ header:'수주계획사업구분',	name:'ordPlanBusiDivi',	width:100,		align:'center',	hidden:true },
			{ header:'수주계획메모',		name:'ordPlanNote',		width:100,		align:'center',	hidden:true },
		]);

		orderPlanGridList.disableColumn('ordPlanGr');
		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/

		planGridList.on('click', async ev => {
			if(ev.targetType === 'cell'){ // 상세보기 별도 구분
				var rowKey = ev.rowKey;
				var planDivi = planGridList.getValue(rowKey,'planDivi')

				var detailPlanModalOpenButton = document.getElementById('detailPlanModalOpenButton');
				var insertSubPlanOpenButton = document.getElementById('insertSubPlanOpenButton');
				var insertKeyResultModalOpenButton = document.getElementById('insertKeyResultModalOpenButton');
				var selectOrderPlanModalOpenButton = document.getElementById('selectOrderPlanModalOpenButton');
				var detailKeyResultModalOpenButton = document.getElementById('detailKeyResultModalOpenButton');
				var detailKeyResultModalselectKeyResultOpenButton = document.getElementById('detailKeyResultModalselectKeyResultOpenButton');
				var detailKeyResultModalDeleteButton1 = document.getElementById('detailKeyResultModalDeleteButton1');
				var detailKeyResultModalDeleteButton2 = document.getElementById('detailKeyResultModalDeleteButton2');

				if (planDivi === '01') {
					if(ev.columnName === 'fn') document.getElementById('selectFunctionOpenButton').click();
					else document.getElementById('detailPlanModalOpenButton').click();

					detailKeyResultModalOpenButton.classList.add('d-none');
					detailPlanModalOpenButton.classList.remove('d-none');
					insertSubPlanOpenButton.classList.remove('d-none');
					insertKeyResultModalOpenButton.classList.remove('d-none');
					selectOrderPlanModalOpenButton.classList.remove('d-none');
					detailKeyResultModalselectKeyResultOpenButton.classList.remove('d-none');

					document.getElementById('detailPlanModalStatus').value = 'U'
				}
				if (planDivi === '02') {
					if(ev.columnName === 'fn') document.getElementById('selectFunctionOpenButton').click();
					else {
						document.getElementById('detailKeyResultModalOpenButton').click();
						document.getElementById('detailKeyResultModalInfoButton').click();
					}
					detailPlanModalOpenButton.classList.add('d-none');
					insertSubPlanOpenButton.classList.add('d-none');
					insertKeyResultModalOpenButton.classList.add('d-none');
					selectOrderPlanModalOpenButton.classList.add('d-none');
					detailKeyResultModalOpenButton.classList.remove('d-none')
					detailKeyResultModalselectKeyResultOpenButton.classList.add('d-none');
					detailKeyResultModalDeleteButton1.classList.remove('d-none');
					detailKeyResultModalDeleteButton2.classList.add('d-none');

					/* 성과수치 계획 모달 적용*/
					document.getElementById('insertPlanningKeyResultModalStatus').value = 'C'
					document.getElementById('insertPlanningKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
					document.getElementById('insertPlanningKeyResultModalPlanCd').value = planGridList.getValue(rowKey,'planCd');
					document.getElementById('insertPlanningKeyResultModalAmt2').textContent = planGridList.getValue(rowKey,'edAmt');

					/* 성과수치 체크인 모달 적용*/
					document.getElementById('insertCheckInKeyResultModalStatus').value = 'C'
					document.getElementById('insertCheckInKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
					document.getElementById('insertCheckInKeyResultModalPlanCd').value = planGridList.getValue(rowKey,'planCd');
					document.getElementById('insertCheckInKeyResultModalAmt2').textContent = planGridList.getValue(rowKey,'edAmt');
				};
			}
		});

		keyResultGridList.on('click', async ev => {
			if(ev.columnName !== 'fn' && ev.targetType === 'cell'){ // 상세보기 별도 구분
				var rowKey = ev.rowKey;
				var row = keyResultGridList.getRow(rowKey);
				var detailKeyResultModalDeleteButton1 = document.getElementById('detailKeyResultModalDeleteButton1');
				var detailKeyResultModalDeleteButton2 = document.getElementById('detailKeyResultModalDeleteButton2');
				detailKeyResultModalDeleteButton1.classList.add('d-none');
				detailKeyResultModalDeleteButton2.classList.remove('d-none');
				if (row.planDivi === '02') {
					await document.getElementById('detailKeyResultModalCloseButton2').click();
					await document.getElementById('detailKeyResultModalOpenButton2').click();
					await document.getElementById('detailKeyResultModalInfoButton').click();

					/* 성과수치 계획 모달 적용*/
					document.getElementById('insertPlanningKeyResultModalStatus').value = 'C'
					document.getElementById('insertPlanningKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
					document.getElementById('insertPlanningKeyResultModalPlanCd').value = keyResultGridList.getValue(rowKey,'planCd');
					document.getElementById('insertPlanningKeyResultModalAmt2').textContent = keyResultGridList.getValue(rowKey,'edAmt');

					/* 성과수치 체크인 모달 적용*/
					document.getElementById('insertCheckInKeyResultModalStatus').value = 'C'
					document.getElementById('insertCheckInKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
					document.getElementById('insertCheckInKeyResultModalPlanCd').value = keyResultGridList.getValue(rowKey,'planCd');
					document.getElementById('insertCheckInKeyResultModalAmt2').textContent = keyResultGridList.getValue(rowKey,'edAmt');
				};
			}
		});

		planningKeyResultGridList.on('click', async ev => {
			if(ev.columnName !== 'fn' && ev.targetType === 'cell'){ // 상세보기 별도 구분

				/* 성과수치 계획 모달 적용*/

				await document.getElementById('detailKeyResultModalPlanAddButton').click();
				await edsUtil.eds_CopySheet2Form({
					sheet: planningKeyResultGridList,
					form: document.insertPlanningKeyResultModalForm,
					rowKey: ev.rowKey,
				})
				document.getElementById('insertPlanningKeyResultModalStatus').value = 'U';

				var statusDivi = document.getElementById('insertPlanningKeyResultModalStatusDivi').value;
				document.getElementsByName('insertPlanningKeyResultModalStatusDiviOption').forEach(el => {
					if(el.id.includes(statusDivi)) el.style.backgroundColor = '#efefef';
					else el.style.backgroundColor = '#fff';
					if(statusDivi.length === 0) el.style.backgroundColor = '#fff';
				});

				await document.getElementById('insertPlanningKeyResultModalSubmitButton').classList.add('d-none');
				await document.getElementById('updatePlanningKeyResultModalSubmitButton').classList.remove('d-none');
				await document.getElementById('deletePlanningKeyResultModalSubmitButton').classList.remove('d-none');
			}
		});

		checkInKeyResultGridList.on('click', async ev => {
			if(ev.columnName !== 'fn' && ev.targetType === 'cell'){ // 상세보기 별도 구분

				/* 성과수치 계획 모달 적용*/

				await document.getElementById('detailKeyResultModalCheckInAddButton').click();
				await edsUtil.eds_CopySheet2Form({
					sheet: checkInKeyResultGridList,
					form: document.insertCheckInKeyResultModalForm,
					rowKey: ev.rowKey,
				})
				document.getElementById('insertCheckInKeyResultModalStatus').value = 'U'

				var statusDivi = document.getElementById('insertCheckInKeyResultModalStatusDivi').value;
				document.getElementsByName('insertCheckInKeyResultModalStatusDiviOption').forEach(el => {
					if(el.id.includes(statusDivi)) el.style.backgroundColor = '#efefef';
					else el.style.backgroundColor = '#fff';
					if(statusDivi.length === 0) el.style.backgroundColor = '#fff';
				});

				await document.getElementById('insertCheckInKeyResultModalSubmitButton').classList.add('d-none');
				await document.getElementById('updateCheckInKeyResultModalSubmitButton').classList.remove('d-none');
				await document.getElementById('deleteCheckInKeyResultModalSubmitButton').classList.remove('d-none');
			}
		});

		orderPlanGridList.on('click', async ev => {
			if(ev.targetType === 'cell'){ // 상세보기 별도 구분
				var row = orderPlanGridList.getRow(ev.rowKey);
				if(!row._attributes.checked) orderPlanGridList.check(ev.rowKey);
				else orderPlanGridList.uncheck(ev.rowKey);
			}
		});

		function isNumber(input) {
			// 쉼표를 제거한 뒤 숫자인지 여부를 확인
			const numberString = input.replace(/,/g, '');
			if (!isNaN(numberString)) {
				// 정수인지 여부를 확인하여 반환
				return true;
			} else {
				// 입력이 숫자가 아닌 경우
				return false;
			}
		}

		planKeyResultGridList.on('afterChange', async ev => {
			var columnName = ev.changes[0].columnName
			var prevValue = ev.changes[0].prevValue
			var value = ev.changes[0].value
			var rowKey = ev.changes[0].rowKey
			if(columnName === 'applyAmt'){
				if(isNumber(value)){
					if(value === '' || value === undefined || value === '0' || value === 0 || value === null){
						new Promise((resolve, reject) => {
							planKeyResultGridList.setValue(rowKey, columnName, '');
							resolve();
						}).then((value) => {
							planKeyResultGridList.uncheck(rowKey)
							planKeyResultGridList.removeRowClassName(rowKey, 'selected')
						})
					}else{
						let data = '';
						new Promise((resolve, reject) => {
							edsUtil.formatNumberHtmlValueForDouble(value).then(result => {
								data = result
							});
							resolve();
						}).then((value) => {
							planKeyResultGridList.setValue(rowKey, columnName, data);
						}).then((value) => {
							planKeyResultGridList.check(rowKey)
							planKeyResultGridList.addRowClassName(rowKey, 'selected')
						})
					}
				}else{
					new Promise((resolve, reject) => {
						planKeyResultGridList.setValue(rowKey, columnName, '');
						resolve();
					}).then((value) => {
						planKeyResultGridList.uncheck(rowKey)
						planKeyResultGridList.removeRowClassName(rowKey, 'selected')
					})
				}
			}
		});

		planGridList.on('expand', ev => {

		});

		planGridList.on('collapse', ev => {

		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 조회 */
		await doAction("planGridList", "search");
	}
	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/
	async function doAction(sheetNm, sAction, el) {
		if (sheetNm == 'planGridList') {
			switch (sAction) {
				case "search":// o 조회
					new Promise(async (resolve, reject)=>{
						resolve();
					}).then((value)=>{
						var rowKey = planGridList.getFocusedCell().rowKey;
						doingPlanGridListFocusIndex = rowKey === null?0:rowKey;
					}).then((value)=>{
						saveBeforeScrollLocation();
					}).then((value)=>{
						planGridList.refreshLayout(); // 데이터 초기화
						planGridList.clear(); // 데이터 초기화
					}).then(async (value)=>{
						var param = {
							corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
							planNmSearch: document.getElementById('planNmSearch').value,
							searchDivi: '03' // 기본값으로 '전체 목표' 설정
						};

						var searchDivi = document.querySelector('div[id="searchDivi"] input[name="searchDivi"]:checked').id;
						switch (searchDivi) {
							case 'input01': // 내 목표만
								param.searchDivi = '01';
								param.empCd = '<c:out value="${LoginInfo.empCd}"/>';
								break;
							case 'input02': // 팀 목표만
								param.searchDivi = '02';
								param.depaCd = '<c:out value="${LoginInfo.depaCd}"/>';
								break;
						}
						await fnMkTree(edsUtil.getAjax("/WORK_LOG/selectWorkLogList", param));
					}).then((value)=>{
						planGridList.focus(doingPlanGridListFocusIndex,'planNm');
					}).then((value)=>{
						moveBeforeScrollLocation();
					})
					break;
				case "keyResultSearch":// kr 조회
					setTimeout(async ev => {
						keyResultGridList.refreshLayout(); // 데이터 초기화
						keyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd: document.getElementById('selectKeyResultModalPlanCd').value,
							periodDivi:''
						};
						await keyResultGridList.resetData(edsUtil.getAjax("/WORK_LOG/getLowKeyResults", param));
					},200);
					break;
				case "orderPlanSearch":// 월간성과기획서 조회
					setTimeout(async ev => {
						orderPlanGridList.refreshLayout(); // 데이터 초기화
						orderPlanGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							corpCd: '<c:out value="${LoginInfo.corpCd}"/>',
							ordPlanSetDt: document.getElementById('ordPlanSetDt').value};
						let data = await edsUtil.getAjax("/ORDER_PLAN_LIST/selectOrderPlanListForList", param);
						await orderPlanGridList.resetData(data); // 데이터 set
					},200);
					break;
				case "commentSearch":// comment 조회
					await displayComments();
					break;
				case "activitySearch":// activity 조회
					await displayActivitys();
					break;
				case "planningKeyResulListSearch":// 계획 리스트 조회
					setTimeout(async ev => {
						planningKeyResultGridList.refreshLayout(); // 데이터 초기화
						planningKeyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd : document.getElementById('detailKeyResultModalPlanCd').value,
						};
						await planningKeyResultGridList.resetData(edsUtil.getAjax("/WORK_LOG/selectWorkLogPlanningKeyResult", param));
					},170);
					break;
				case "planKeyResultGridListSearch":// 계획 리스트 적용 조회
					setTimeout(async ev => {
						planKeyResultGridList.refreshLayout(); // 데이터 초기화
						planKeyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd : document.getElementById('detailKeyResultModalPlanCd').value,
						};
						await planKeyResultGridList.resetData(edsUtil.getAjax("/WORK_LOG/selectWorkLogPlanKeyResult", param));
					},170);
					break;
				case "planKeyResultGridListApply":// 계획 리스트 적용
						new Promise((resolve, reject)=>{
							planKeyResultGridList.finishEditing();
							resolve();
						}).then(value => {
							return promiseThenDelay(value,100);
						}).then(value => {
							edsUtil.checksCUD('/WORK_LOG/cudWorkLogKeyResultPlanList', 'C', planKeyResultGridList, 'planGridList', 'checkInKeyResulListSearch');
						}).then(value => {
							document.getElementById('detailKeyResultModalPlanApplyCloseButton').click(); // 모달 끄기
						})
					break;
				case "planningKeyResulChartSearch":// 계획 차트 조회
					var chartStatus = Chart.getChart('detailKeyResultModalPlanChart');
					if (chartStatus !== undefined) {
						chartStatus.destroy();
					}
					var param = { //조회조건
						planCd : document.getElementById('detailKeyResultModalPlanCd').value,
					};
					var data = edsUtil.getAjax("/WORK_LOG/getWorkLogPlanningKeyResultChart", param);
					// dt와 amt 값을 분리하여 저장할 배열을 초기화합니다.
					var dtValues = [];
					var amtValues = [];
					var edAmtValues = [];

					// 데이터 배열을 순회하면서 각 객체의 dt와 amt 값을 추출하여 배열에 저장합니다.
					data.forEach(item => {
						dtValues.push(item.dt);
						amtValues.push(item.amt);
						edAmtValues.push(item.edAmt);
					});
					var ctx = document.getElementById('detailKeyResultModalPlanChart');
					new Chart(ctx, {
						type: 'line',
						data: {
							labels: dtValues,
							datasets: [
								{
									label: '계획',
									fill: true,
									data: amtValues,
									borderColor: `#fd6283`,
									backgroundColor: `#fdb0bf66`,
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
							}
						}
					});
					break;
				case "checkInKeyResulListSearch":// 체크인 리스트 조회
					setTimeout(async ev => {
						checkInKeyResultGridList.refreshLayout(); // 데이터 초기화
						checkInKeyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd : document.getElementById('detailKeyResultModalPlanCd').value,
						};
						await checkInKeyResultGridList.resetData(edsUtil.getAjax("/WORK_LOG/selectWorkLogCheckInKeyResult", param));
					},170);
					break;
				case "checkInKeyResulChartSearch":// 체크인 차트 조회
					var chartStatus = Chart.getChart('detailKeyResultModalCheckInChart');
					if (chartStatus !== undefined) {
						chartStatus.destroy();
					}
					var param = { //조회조건
						planCd : document.getElementById('detailKeyResultModalPlanCd').value,
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
					var ctx = document.getElementById('detailKeyResultModalCheckInChart');
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
					break;
				case "input":// o 신규
						await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList','','insertPlanModalForm');
						document.getElementById('insertSubPlanCloseButton').click(); // 모달 끄기
					break;
				case "keyResultInput":// kr 신규
						await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList','','insertKeyResultModalForm');
						await doAction('planGridList','keyResultSearch');
						document.getElementById('insertKeyResultModalCloseButton').click(); // 모달 끄기
					break;
				case "commentInput":// comment 신규
					var param = {};
					param.status = 'C';
					param.planCd = document.getElementById('detailKeyResultModalPlanCd').value;
					param.planNm = document.getElementById('detailKeyResultModalPlanNm').value;
					param.content = document.getElementById('detailKeyResultModalCommentContent').value;
					param.empCd = document.getElementById('detailKeyResultModalEmpCd').value;
					param.partCds = $("#detailKeyResultModalPartCds").select2("val");
					setTimeout(async ev=>{
						await edsUtil.postAjax('/WORK_LOG/cdWorkLogComment', '', param);
						await doAction('planGridList','commentSearch');
						el.value = '';
					},40)
					break;
				case "activityInput":// activity 신규
					var param = {};
					param.status = 'C';
					param.planCd = document.getElementById('detailKeyResultModalPlanCd').value;
					param.activityDt = document.getElementById('activityDt').value;
					param.planNm = document.getElementById('detailKeyResultModalPlanNm').value;
					param.content = document.getElementById('detailKeyResultModalActivityContent').value;
					param.empCd = document.getElementById('detailKeyResultModalEmpCd').value;
					param.partCds = $("#detailKeyResultModalPartCds").select2("val");
					setTimeout(async ev=>{
						await edsUtil.postAjax('/WORK_LOG/cdWorkLogActivity', '', param);
						await doAction('planGridList','activitySearch');
						el.value = '';
						document.getElementById('activityDt').value = '';
					},40)
					break;
				case "planningKeyResultInput":// kr 신규
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogPlanningKeyResult','','','insertPlanningKeyResultModalForm');
					await doAction('planGridList','planningKeyResulChartSearch');
					await doAction('planGridList','planningKeyResulListSearch');
					break;
				case "checkInKeyResultInput":// kr 신규
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogCheckInKeyResult','','','insertCheckInKeyResultModalForm');
					await doAction('planGridList','checkInKeyResulChartSearch');
					await doAction('planGridList','checkInKeyResulListSearch');
					break;
				case "orderPlanInput":// kr 신규
					await edsUtil.checkCUD('/WORK_LOG/cudWorkLogOrderPlanList','orderPlanGridList',orderPlanGridList,planGridList,'C');
					document.getElementById('selectOrderPlanModalCloseButton').click(); // 모달 끄기
					await doAction('planGridList','search');
					break;
				case "save":// o 저장
						await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList','','detailPlanModalForm');
						// document.getElementById('detailPlanModalCloseButton').click(); // 모달 끄기
					break;
				case "keyResultSave":// kr 저장
					await document.getElementById('detailKeyResultModalStatus').setAttribute('value','U')
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList','','detailKeyResultModalForm');
					break;
				case "planningKeyResultUpdate":// kr plan 저장
					await document.getElementById('insertPlanningKeyResultModalStatus').setAttribute('value','U')
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogPlanningKeyResult','','','insertPlanningKeyResultModalForm');
					await doAction('planGridList','planningKeyResulChartSearch');
					await doAction('planGridList','planningKeyResulListSearch');
					break;
				case "checkInKeyResultUpdate":// kr plan 저장
					await document.getElementById('insertCheckInKeyResultModalStatus').setAttribute('value','U')
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogCheckInKeyResult','','','insertCheckInKeyResultModalForm');
					await doAction('planGridList','checkInKeyResulChartSearch');
					await doAction('planGridList','checkInKeyResulListSearch');
					break;
				case "delete":// okr삭제
					var row = planGridList.getFocusedCell();
					var empCd = planGridList.getValue(row.rowKey, 'empCd');

					if ('<c:out value="${LoginInfo.respDivi}"/>' === '04' && empCd !== '<c:out value="${LoginInfo.empCd}"/>') {
						Swal.fire({icon: 'error', title: '실패', text: '내 목표가 아니어서 삭제할 수 없습니다.',})
					}else {
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								await planGridList.removeRow(planGridList.getFocusedCell().rowKey);
								await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList',planGridList,'') // 삭제
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					}
					break;
				case "delete2":// okr삭제
					if ('<c:out value="${LoginInfo.respDivi}"/>' === '04' && document.getElementById('detailPlanModalEmpCd').value !== '<c:out value="${LoginInfo.empCd}"/>') {
						Swal.fire({icon: 'error', title: '실패', text: '내 목표가 아니어서 삭제할 수 없습니다.',})
					}else {
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								document.getElementById('detailPlanModalStatus').value = 'D';
								await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList','','detailPlanModalForm') // 삭제
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					}
					break;
				case "keyResultDelete1":// plan KeyResult삭제
					var row = planGridList.getFocusedCell();
					var empCd = planGridList.getValue(row.rowKey, 'empCd');

					if ('<c:out value="${LoginInfo.respDivi}"/>' === '04' && empCd !== '<c:out value="${LoginInfo.empCd}"/>') {
						Swal.fire({icon: 'error', title: '실패', text: '내 목표가 아니어서 삭제할 수 없습니다.',})
					}else {
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								await planGridList.removeRow(row.rowKey);
								await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList',planGridList,'') // 삭제
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					}
					break;
				case "keyResultDelete2":// KeyResult KeyResult삭제
					var row = keyResultGridList.getFocusedCell();
					var empCd = keyResultGridList.getValue(row.rowKey, 'empCd');

					if ('<c:out value="${LoginInfo.respDivi}"/>' === '04' && empCd !== '<c:out value="${LoginInfo.empCd}"/>') {
						Swal.fire({icon: 'error', title: '실패', text: '내 목표가 아니어서 삭제할 수 없습니다.',})
					}else {
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								await keyResultGridList.removeRow(keyResultGridList.getFocusedCell().rowKey);
								await edsUtil.modalCUD('/WORK_LOG/cudWorkLogList','planGridList',keyResultGridList,''); // 삭제
								await doAction('planGridList','keyResultSearch');
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					}
					break;
				case "commentDelete":// 코멘트 삭제
					var elId = el.id.split(',')
					var param = {};
					param.status = 'D';
					param.corpCd = elId[0];
					param.planCd = elId[1];
					param.seq = elId[2];
					param.inpId = elId[3];
					setTimeout(async ev=>{
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								await edsUtil.postAjax('/WORK_LOG/cdWorkLogComment', '', param);
								await doAction('planGridList','commentSearch');
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					},40)
					break;
				case "activityDelete":// 활동 삭제
					var elId = el.id.split(',')
					var param = {};
					param.status = 'D';
					param.corpCd = elId[0];
					param.planCd = elId[1];
					param.seq = elId[2];
					param.inpId = elId[3];
					setTimeout(async ev=>{
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								await edsUtil.postAjax('/WORK_LOG/cdWorkLogActivity', '', param);
								await doAction('planGridList','activitySearch');
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					},40)
					break;
				case "planningKeyResultDelete":// kr plan 저장
					Swal.fire({
						title: "정말 삭제하시겠습니까?",
						showDenyButton: true,
						showCancelButton: false,
						confirmButtonText: "삭제",
						denyButtonText: `취소`
					}).then(async (result) => {
						/* Read more about isConfirmed, isDenied below */
						if (result.isConfirmed) {
							await document.getElementById('insertPlanningKeyResultModalStatus').setAttribute('value','D')
							await edsUtil.modalCUD('/WORK_LOG/cudWorkLogPlanningKeyResult','','','insertPlanningKeyResultModalForm');
							await doAction('planGridList','planningKeyResulChartSearch');
							await doAction('planGridList','planningKeyResulListSearch');
						} else if (result.isDenied) {
							Swal.fire("취소되었습니다.", "", "info");
						}
					});
					break;
				case "checkInKeyResultDelete":// kr plan 저장
					Swal.fire({
						title: "정말 삭제하시겠습니까?",
						showDenyButton: true,
						showCancelButton: false,
						confirmButtonText: "삭제",
						denyButtonText: `취소`
					}).then(async (result) => {
						/* Read more about isConfirmed, isDenied below */
						if (result.isConfirmed) {
							await document.getElementById('insertCheckInKeyResultModalStatus').setAttribute('value','D')
							await edsUtil.modalCUD('/WORK_LOG/cudWorkLogCheckInKeyResult','','','insertCheckInKeyResultModalForm');
							await doAction('planGridList','checkInKeyResulChartSearch');
							await doAction('planGridList','checkInKeyResulListSearch');
						} else if (result.isDenied) {
							Swal.fire("취소되었습니다.", "", "info");
						}
					});
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

	/* make treeMap for grid*/
	async function fnMkTree(data) {
		const planDict = {};
		const rootPlans = [];
		let totOAmt = 0;
		let totKRAmt = 0;

		for (const plan of data) {
			planDict[plan.planCd] = plan;
			plan.planDivi==='01'?(totOAmt=totOAmt+1):(totKRAmt=totKRAmt+1);
		}

		/* 총 목표, 핵심결과지표 설정*/
		document.getElementById('totOAmt').innerText=totOAmt;
		document.getElementById('totKRAmt').innerText=totKRAmt;


		/* 상단 nav 전체값 세팅 */
		let totStatus = {
			divi01: 0,
			divi02: 0,
			divi03: 0,
			divi04: 0,
		};
		let totRateAmt = 0;

		for (const plan of data) {
			// 총 달성률 값 설정
			totRateAmt += Number(plan.rate);

			// 체크인 총 구분 값 설정
			if(plan.statusDivis === null || plan.statusDivis === undefined) plan.statusDivis = ''
			let statusArr = plan.statusDivis.split(",")

			// todo: 내 목표 일때, 내꺼만 상태 수에 적용되도록
			// todo: 팀 목표 일때, 팀꺼만 상태 수에 적용되도록
			// todo: 전사 목표 일때, 다 상태 수에 적용되도록
			
			if(plan.planDivi === '01'){
				for (let i = 0; i < statusArr.length; i++) {
					switch (statusArr[i]) {
						case '01': totStatus.divi01 += 1; break;
						case '02': totStatus.divi02 += 1; break;
						case '03': totStatus.divi03 += 1; break;
						case '04': totStatus.divi04 += 1; break;
					}
				}
			}

			// 내O, 내KR 분개
			var isOwned = plan.empCd === '<c:out value="${LoginInfo.empCd}"/>';
			if (plan.planDivi === '01') plan['_attributes'] = { className: { row: [isOwned ? 'ownedObjective' : 'objective'] } };
			else if (plan.planDivi === '02') plan['_attributes'] = { className: { row: [isOwned ? 'ownedKeyResult' : 'keyResult'] } };

			const parePlanCd = plan.parePlanCd;
			if (!parePlanCd) {
				rootPlans.push(plan);
			} else {
				const parent = planDict[parePlanCd];
				if (parent) {
					if (!parent._children) parent._children = [];
					parent._children.push(plan);
				} else {
					rootPlans.push(plan);
				}
			}
		}

		await planGridList.resetData(rootPlans);
		await planGridList.expandAll();

		totRateAmt = Math.round(totRateAmt/data.length);
		if(isNaN(totRateAmt)){
			totRateAmt = 0;
		}
		/* 달성 nav */
		document.getElementById('range_1_num').innerText = totRateAmt+`% 달성`

		/* progress-bar nav */
		$("#progress-bar_main").css("width", totRateAmt + "%");
		$("#percent_main").text(totRateAmt + "%");
		$("#percent_main").css("right", "15px");

		/* statusDivi nav */
		document.getElementById('content-header-statusDivi-01').innerText = totStatus.divi01;
		document.getElementById('content-header-statusDivi-02').innerText = totStatus.divi02;
		document.getElementById('content-header-statusDivi-03').innerText = totStatus.divi03;
		document.getElementById('content-header-statusDivi-04').innerText = totStatus.divi04;

		/* 상위 목표 선택 함께 설정*/
		var parePlanCd = data;
		var parePlanCdArr = [
			{el:document.getElementById('insertPlanModalParePlanCd'),value:document.getElementById('insertPlanModalParePlanCd').value},
			{el:document.getElementById('detailPlanModalParePlanCd'),value:document.getElementById('detailPlanModalParePlanCd').value},
			{el:document.getElementById('insertKeyResultModalParePlanCd'),value:document.getElementById('insertKeyResultModalParePlanCd').value},
			{el:document.getElementById('detailKeyResultModalParePlanCd'),value:document.getElementById('detailKeyResultModalParePlanCd').value},
		];

		/* 초기화 */
		for (let i = 0, parePlanCdArrLength = parePlanCdArr.length; i < parePlanCdArrLength; i++) {
			parePlanCdArr[i].el.options.length = 0;

			/* 초기값 */
			var option = document.createElement("option");
			option.value = '';
			option.text = '없음';
			parePlanCdArr[i].el.add(option);

			/* 나머지값 */
			for (var k = 0; k < parePlanCd.length; k++) {
				var optionDetail = document.createElement("option");
				optionDetail.value = parePlanCd[k].planCd;
				optionDetail.text = parePlanCd[k].planNm ;
				parePlanCdArr[i].el.add(optionDetail);
			}

			// 이전 값 다시 세팅
			parePlanCdArr[i].el.value = parePlanCdArr[i].value
		}
	}

	/* modal content move */
	async function  modalContentMove (button) {
		if(button.includes('insertPlanModal')){
			var modalContent01 = document.querySelector('div[id="insertPlanModal"] div[id="insertPlanModal-modal-content-01"]');
			var modalContent02 = document.querySelector('div[id="insertPlanModal"] div[id="insertPlanModal-modal-content-02"]');
			var modalContent03 = document.querySelector('div[id="insertPlanModal"] div[id="insertPlanModal-modal-content-03"]');
			var insertPlanModalPreviousButton = document.querySelector('div[id="insertPlanModal"] button[id="insertPlanModalPreviousButton"]');
			var insertPlanModalNextButton = document.querySelector('div[id="insertPlanModal"] button[id="insertPlanModalNextButton"]');
			var insertPlanModalSubmitButton = document.querySelector('div[id="insertPlanModal"] button[id="insertPlanModalSubmitButton"]');
			switch (button) {
				case 'insertPlanModalOpenButton':
					modalContent01.className = modalContent01.className.replaceAll('fade3','');
					modalContent02.className += ' fade3';
					modalContent03.className += ' fade3';
					insertPlanModalPreviousButton.className += ' d-none';
					insertPlanModalNextButton.className = insertPlanModalNextButton.className.replaceAll('d-none','');
					insertPlanModalSubmitButton.className += ' d-none';
					break;
				case 'insertPlanModalPreviousButton':
					if(!modalContent02.className.includes('fade3')){ // 'modal-content-02' 가 활성화 되어있을 경우,
						modalContent01.className = modalContent01.className.replaceAll('fade3','');
						modalContent02.className += ' fade3';
						modalContent03.className += ' fade3';
						insertPlanModalPreviousButton.className += ' d-none';
					}else if(!modalContent03.className.includes('fade3')){ // 'modal-content-03' 이 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className = modalContent02.className.replaceAll('fade3','');
						modalContent03.className += ' fade3';
						insertPlanModalPreviousButton.className = insertPlanModalPreviousButton.className.replaceAll('fade3','');
						insertPlanModalNextButton.className = insertPlanModalPreviousButton.className.replaceAll('fade3','');
						insertPlanModalSubmitButton.className += ' d-none';
					}
					break;
				case 'insertPlanModalNextButton':
					if(!modalContent01.className.includes('fade3')){ // 'modal-content-01' 이 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className = modalContent02.className.replaceAll('fade3','');
						modalContent03.className += ' fade3';
						insertPlanModalPreviousButton.className = insertPlanModalPreviousButton.className.replaceAll('d-none','');
					}else if(!modalContent02.className.includes('fade3')){ // 'modal-content-02' 가 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className += ' fade3';
						modalContent03.className = modalContent03.className.replaceAll('fade3','');
						insertPlanModalNextButton.className += ' d-none';
						insertPlanModalSubmitButton.className = insertPlanModalSubmitButton.className.replaceAll('d-none','');
					}
					break;
			}
		}else if(button.includes('insertKeyResultModal')){
			var modalContent01 = document.querySelector('div[id="insertKeyResultModal"] div[id="insertKeyResultModal-modal-content-01"]');
			var modalContent02 = document.querySelector('div[id="insertKeyResultModal"] div[id="insertKeyResultModal-modal-content-02"]');
			var modalContent03 = document.querySelector('div[id="insertKeyResultModal"] div[id="insertKeyResultModal-modal-content-03"]');
			var modalContent04 = document.querySelector('div[id="insertKeyResultModal"] div[id="insertKeyResultModal-modal-content-04"]');
			var insertKeyResultModalPreviousButton = document.querySelector('div[id="insertKeyResultModal"] button[id="insertKeyResultModalPreviousButton"]');
			var insertKeyResultModalNextButton = document.querySelector('div[id="insertKeyResultModal"] button[id="insertKeyResultModalNextButton"]');
			var insertKeyResultModalSubmitButton = document.querySelector('div[id="insertKeyResultModal"] button[id="insertKeyResultModalSubmitButton"]');
			switch (button) {
				case 'insertKeyResultModalOpenButton':
					modalContent01.className = modalContent01.className.replaceAll('fade3','');
					modalContent02.className += ' fade3';
					modalContent03.className += ' fade3';
					modalContent04.className += ' fade3';
					insertKeyResultModalPreviousButton.className += ' d-none';
					insertKeyResultModalNextButton.className = insertKeyResultModalNextButton.className.replaceAll('d-none','');
					insertKeyResultModalSubmitButton.className += ' d-none';
					break;
				case 'insertKeyResultModalPreviousButton':
					if(!modalContent02.className.includes('fade3')){ // 'modal-content-02' 가 활성화 되어있을 경우,
						modalContent01.className = modalContent01.className.replaceAll('fade3','');
						modalContent02.className += ' fade3';
						modalContent03.className += ' fade3';
						modalContent04.className += ' fade3';
						insertKeyResultModalPreviousButton.className += ' d-none';
					}else if(!modalContent03.className.includes('fade3')){ // 'modal-content-02' 가 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className = modalContent02.className.replaceAll('fade3','');
						modalContent03.className += ' fade3';
						modalContent04.className += ' fade3';
					}else if(!modalContent04.className.includes('fade3')){ // 'modal-content-03' 이 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className += ' fade3';
						modalContent03.className = modalContent03.className.replaceAll('fade3','');
						modalContent04.className += ' fade3';
						insertKeyResultModalPreviousButton.className = insertKeyResultModalPreviousButton.className.replaceAll('fade3','');
						insertKeyResultModalNextButton.className = insertKeyResultModalPreviousButton.className.replaceAll('fade3','');
						insertKeyResultModalSubmitButton.className += ' d-none';
					}
					break;
				case 'insertKeyResultModalNextButton':
					if(!modalContent01.className.includes('fade3')){ // 'modal-content-01' 이 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className = modalContent02.className.replaceAll('fade3','');
						modalContent03.className += ' fade3';
						modalContent04.className += ' fade3';
						insertKeyResultModalPreviousButton.className = insertKeyResultModalPreviousButton.className.replaceAll('d-none','');
					}else if(!modalContent02.className.includes('fade3')){ // 'modal-content-01' 이 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className += ' fade3';
						modalContent03.className = modalContent03.className.replaceAll('fade3','');
						modalContent04.className += ' fade3';
						insertKeyResultModalPreviousButton.className = insertKeyResultModalPreviousButton.className.replaceAll('d-none','');
					}else if(!modalContent03.className.includes('fade3')){ // 'modal-content-02' 가 활성화 되어있을 경우,
						modalContent01.className += ' fade3';
						modalContent02.className += ' fade3';
						modalContent03.className += ' fade3';
						modalContent04.className = modalContent04.className.replaceAll('fade3','');
						insertKeyResultModalNextButton.className += ' d-none';
						insertKeyResultModalSubmitButton.className = insertKeyResultModalSubmitButton.className.replaceAll('d-none','');
					}
					break;
			}
		}
	}

	/* searchDivi move */
	async function  searchDiviMove (searchDiviButton) {
		switch (searchDiviButton) {
			case 'label01':
				document.querySelector('div[id="searchDivi"] label[id="label01"]').setAttribute('class', 'btn btn-primary mr-2');
				document.querySelector('div[id="searchDivi"] label[id="label02"]').setAttribute('class', 'btn btn-default mr-2');
				document.querySelector('div[id="searchDivi"] label[id="label03"]').setAttribute('class', 'btn btn-default mr-2');
				setTimeout(async ev => {
					await doAction('planGridList','search');
				}, 100);
				break;
			case 'label02':
				document.querySelector('div[id="searchDivi"] label[id="label01"]').setAttribute('class', 'btn btn-default mr-2');
				document.querySelector('div[id="searchDivi"] label[id="label02"]').setAttribute('class', 'btn btn-primary mr-2');
				document.querySelector('div[id="searchDivi"] label[id="label03"]').setAttribute('class', 'btn btn-default mr-2');
				setTimeout(async ev => {
					await doAction('planGridList','search');
				}, 100);
				break;
			case 'label03':
				document.querySelector('div[id="searchDivi"] label[id="label01"]').setAttribute('class', 'btn btn-default mr-2');
				document.querySelector('div[id="searchDivi"] label[id="label02"]').setAttribute('class', 'btn btn-default mr-2');
				document.querySelector('div[id="searchDivi"] label[id="label03"]').setAttribute('class', 'btn btn-primary mr-2');
				setTimeout(async ev => {
					await doAction('planGridList','search');
				}, 100);
				break;
			case 'insertPlanModalOpenButton': await modalContentMove('insertPlanModalOpenButton'); break;
		}
	}

	/* detailKeyResultModal button move */
	async function detailKeyResultModalButtonMove(buttonId) {
		// button, modalBody, modalFooter 처리
		const buttonIds = ['detailKeyResultModalInfoButton', 'detailKeyResultModalActivityButton', 'detailKeyResultModalCommentButton', 'detailKeyResultModalPlanButton', 'detailKeyResultModalCheckInButton'];
		for (let i = 0, length=buttonIds.length; i < length; i++) {
			let buttonEl = document.getElementById(buttonIds[i]);
			let modalBodyEl = document.getElementById(buttonIds[i].replace('Button', ''));
			let modalfooterEl = document.getElementById(buttonIds[i].replace('Button', '')+'Footer');
			if(buttonId === buttonIds[i]){
				/*button set*/
				buttonEl.style.color = '#111f94';
				modalBodyEl?modalBodyEl.classList.remove('d-none'):'';
				modalfooterEl?modalfooterEl.classList.remove('d-none'):'';
			} else {
				/*button set*/
				buttonEl.style.color = '#212529';
				modalBodyEl?modalBodyEl.classList.add('d-none'):'';
				modalfooterEl?modalfooterEl.classList.add('d-none'):'';
			}
		}
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

	// 댓글을 HTML로 변환하여 표시
	async function displayComments() {
		var param = {};
		param.planCd = document.getElementById('detailKeyResultModalPlanCd').value;
		param.content = document.getElementById('detailKeyResultModalCommentContent').value;
		// 댓글 데이터
		var data = await edsUtil.getAjax("/WORK_LOG/selectWorkLogComment", param);
		var commentList = document.getElementById("comments");
		commentList.innerHTML = ''
		for (let i = 0, length=data.length; i < length; i++) {
			const li = document.createElement("li");
			li.className = "comment";
			if(data[i].inpId === '<c:out value="${LoginInfo.empCd}"/>'){
				li.innerHTML = `
							<img src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+data[i].corpCd+`:`+data[i].inpId+`" class="profile-pic" alt="`+data[i].inpNm+`">
							<div>
								<strong>`+data[i].inpNm+`[`+data[i].depaNm+`]</strong><br>
								<span class="comment-content">`+data[i].content.replace(/\n/g, '<br>')+`</span>
								<div class="comment-time">`+data[i].inpDttm+`</div>
							</div>
							<button id="`+data[i].corpCd+`,`+data[i].planCd+`,`+data[i].seq+`,`+data[i].inpId+`" onclick="doAction('planGridList','commentDelete',this)" class="comment-delete-button"><i class="fa-solid fa-trash-can"></i></button>
							`;
			}else{
				li.innerHTML = `
							<img src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+data[i].corpCd+`:`+data[i].inpId+`" class="profile-pic" alt="`+data[i].inpNm+`">
							<div>
								<strong>`+data[i].inpNm+`[`+data[i].depaNm+`]</strong><br>
								<span class="comment-content">`+data[i].content.replace(/\n/g, '<br>')+`</span>
								<div class="comment-time">`+data[i].inpDttm+`</div>
							</div>
							`;
			}
			commentList.appendChild(li);
		}

		setTimeout(() => {
			// 메세지 세팅 후 가장 아래로 스크롤
			var detailKeyResultModalCommentMessageBox = document.getElementById('detailKeyResultModalCommentMessageBox')
			detailKeyResultModalCommentMessageBox.scrollTop = detailKeyResultModalCommentMessageBox.scrollHeight;
		}, 100);
	}

	// 댓글을 HTML로 변환하여 표시
	async function displayActivitys() {
		var param = {};
		param.planCd = document.getElementById('detailKeyResultModalPlanCd').value;
		param.content = document.getElementById('detailKeyResultModalActivityContent').value;
		// 댓글 데이터
		var data = await edsUtil.getAjax("/WORK_LOG/selectWorkLogActivity", param);
		var activityList = document.getElementById("activitys");
		activityList.innerHTML = ''
		for (let i = 0, length=data.length; i < length; i++) {
			const li = document.createElement("li");
			li.className = "activity";
			if(data[i].inpId === '<c:out value="${LoginInfo.empCd}"/>'){
				li.innerHTML = `
							<img src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+data[i].corpCd+`:`+data[i].inpId+`" class="profile-pic" alt="`+data[i].inpNm+`">
							<div>
								<strong>`+data[i].inpNm+`[`+data[i].depaNm+`]</strong><br>
								<span class="activity-content">`+data[i].content.replace(/\n/g, '<br>')+`</span>
								<div class="activity-time">`+data[i].activityDt+`</div>
							</div>
							<button id="`+data[i].corpCd+`,`+data[i].planCd+`,`+data[i].seq+`,`+data[i].inpId+`" onclick="doAction('planGridList','activityDelete',this)" class="activity-delete-button"><i class="fa-solid fa-trash-can"></i></button>
							`;
			}else{
				li.innerHTML = `
							<img src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+data[i].corpCd+`:`+data[i].inpId+`" class="profile-pic" alt="`+data[i].inpNm+`">
							<div>
								<strong>`+data[i].inpNm+`[`+data[i].depaNm+`]</strong><br>
								<span class="activity-content">`+data[i].content.replace(/\n/g, '<br>')+`</span>
								<div class="activity-time">`+data[i].activityDt+`</div>
							</div>
							`;
			}
			activityList.appendChild(li);
		}

		setTimeout(() => {
			// 메세지 세팅 후 가장 아래로 스크롤
			var detailKeyResultModalActivityMessageBox = document.getElementById('detailKeyResultModalActivityMessageBox')
			detailKeyResultModalActivityMessageBox.scrollTop = detailKeyResultModalActivityMessageBox.scrollHeight;
		}, 100);
	}

	async function synchronization() {
        /*
        * 계획
        * 1. 30초 마다 [ok]
        * 2. 연동된 데이터 업데이트
        * 3. 조회 [ok]
        */
		var param = {
			corpCd:'',
		}
		await edsUtil.postAjax('/WORK_LOG/synchronizationWorkLogList','',param)

	}

	async function modifyModalInputCheck(modalName) {

		var ajaxCondition = 1;
		var ajaxConditionColumn = [];

		switch (modalName) { // title에 이름넣기, 저장위치에 다 추가하기
			case 'insertPlanModalForm': // 목표신규, 하위목표생성
				ajaxConditionColumn = ['insertPlanModalPlanNm',
					'insertPlanModalEmpCd',
					'insertPlanModalStDt',
					'insertPlanModalEdDt'];
				break;
			case 'detailPlanModalForm': // 목표 상세
				ajaxConditionColumn = ['detailPlanModalPlanNm',
					'detailPlanModalEmpCd',
					'detailPlanModalStDt',
					'detailPlanModalEdDt'];
				break;
			case 'insertKeyResultModalForm': // 지표신규
				ajaxConditionColumn = ['insertKeyResultModalPlanNm',
					'insertKeyResultModalParePlanCd',
					'insertKeyResultModalEmpCd',
					'insertKeyResultModalUnit',
					'insertKeyResultModalStAmt',
					'insertKeyResultModalEdAmt',
					'insertKeyResultModalStDt',
					'insertKeyResultModalEdDt'];
				break;
			case 'detailKeyResultModalForm': // 지표상세
				ajaxConditionColumn = ['detailKeyResultModalPlanNm',
					'detailKeyResultModalEmpCd',
					'detailKeyResultModalUnit',
					'detailKeyResultModalStAmt',
					'detailKeyResultModalEdAmt',
					'detailKeyResultModalStDt',
					'detailKeyResultModalEdDt'];
				break;
			case 'insertPlanningKeyResultModalForm': // 지표 계획하기
				ajaxConditionColumn = ['insertPlanningKeyResultModalDt',
					'insertPlanningKeyResultModalAmt'];
				break;
			case 'insertCheckInKeyResultModalForm': // 지표 체크인
				ajaxConditionColumn = ['insertCheckInKeyResultModalDt',
					'insertCheckInKeyResultModalAmt',
					'insertCheckInKeyResultModalStatusDivi'];
				break;
			case 'detailKeyResultModalActivityForm': // 지표 체크인
				ajaxConditionColumn = ['activityDt'];
				break;
		}
		ajaxCondition = await edsUtil.checkValidationForForm(modalName, ajaxConditionColumn);
		return ajaxCondition;
	}

	function promiseThenDelay(value, ms) {
		return new Promise(resolve => {
			setTimeout(() => resolve(value), ms);
		});
	}

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>