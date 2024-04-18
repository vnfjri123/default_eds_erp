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

		/************************
		* swal2 css END
		*************************/
		.swal2-title,
		.swal2-icon-content{
			font-size: 1.1rem !important;
		}
		/************************
		* swal2 css END
		*************************/
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
		.tui-grid-scrollbar-right-bottom,
		.tui-grid-scrollbar-right-top,
		.tui-grid-scrollbar-y-inner-border,
		.tui-grid-scrollbar-y-outer-border,
		.tui-grid-scrollbar-left-bottom,
		.tui-grid-border-line-bottom{
			display: none;
		}

		/***************************
		* grid custom css End
		***************************/

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

		/***************************
		* chartJs css Start
		***************************/


		/*canvas[id='orderPlanModalKeyResultListPlanChart'],*/
		/*canvas[id='orderPlanModalKeyResultListCheckInChart']*/
		/*{position:inherit; z-index:2500;}*/

		/***************************
		* chartJs css End
		***************************/

		/************************
        * comment css END
        *************************/
		.comment-list,
		.active-list
		{
			list-style: none;
			padding: 0;
			overflow-y: auto;
		}
		.comment,
		.active
		{
			margin-bottom: 10px;
			display: flex;
			align-items: flex-start; /* 항목을 시작점에 맞추어 정렬 */
		}
		.profile-pic
		{
			width: 40px;
			height: 40px;
			border-radius: 50%;
			margin-right: 10px;
		}
		.comment-content,
		.active-content {
			margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
			font-size: 14px;
		}
		.comment-time,
		.active-time {
			font-size: 12px;
			color: #666;
		}
		.comment-delete-button,
		.active-delete-button {
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

		/***************************
		* commen css START
		***************************/


		/* 스크롤바 숨기기 */
		/*#planningKeyResultGridListDIV *::-webkit-scrollbar,*/
		/*#checkInKeyResultGridListDIV *::-webkit-scrollbar*/
		/*{*/
		/*	display: none; !* Chrome, Safari, Opera*!*/
		/*}*/

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

		/* bootstrap4.6 col에 스크롤 가능하게함 */
		.scrollable-div {
			overflow-y: auto; /* 세로 스크롤 활성화 */
			scroll-behavior: smooth; /* 부드러운 스크롤 효과 적용 */
		}

		/* 드래그 막기 */
		body {
			user-select: none; /* 드래그 막기 */
		}

		#orderPlanModalKeyResultListActiveWrapper::-webkit-scrollbar,
		#orderPlanModalKeyResultListActiveList::-webkit-scrollbar,
		#orderPlanModalKeyResultListActiveMessageBox::-webkit-scrollbar,

		#orderPlanModalKeyResultListCommentWrapper::-webkit-scrollbar,
		#orderPlanModalKeyResultListCommentList::-webkit-scrollbar,
		#orderPlanModalKeyResultListCommentMessageBox::-webkit-scrollbar,

		#orderPlanModalKeyResultListPlanList::-webkit-scrollbar,

		#orderPlanModalKeyResultListCheckInList::-webkit-scrollbar

		{
			display: none; /* Chrome, Safari, Opera */
		}

		@media (max-width: 783px) {
			.carousel-item .col-12.col-md-5.scrollable-div{
				height: 20vh;
			}
			.carousel-item .col-12.col-md-7.scrollable-div.d-flex.flex-column{
				height: 60vh;
			}
			#orderPlanModalKeyResultListActiveList,
			#orderPlanModalKeyResultListCommentList,
			#orderPlanModalKeyResultListPlanList,
			#orderPlanModalKeyResultListCheckInList
			{
				height: 60vh !important;
			}
		}
		/***************************
		* commen css END
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
				<i style="float: left;font-size:1.2rem !important;"> 연간성과진행현황</i>
				<i style="float: left;font-size:1.2rem !important; margin-left: 10px;"> (단위 : 백 만원)</i>
				<button type="button" class="btn btn-sm btn-primary mr-1 float-right" name="btnAddRow" id="btnAddRow" onclick="doAction('orderPlanGrid','addCol')"><i class="fa fa-solid fa-share"></i> 추가</button>
				<button type="button" class="btn btn-sm btn-primary mr-1 float-right" name="btnSearch" id="btnSearch" onclick="doAction('orderPlanGrid','search')"><i class="fa fa-solid fa-share"></i> 조회</button>
				<button type="button" class="invisible" 			 name="btnInputPopEv"		id="btnInputPopEv"			data-toggle="modal" data-target="#orderPlanModal"></button>
			</div>
		</div>
		<div class="row" id="contentObjective">
			<div id="orderPlanGridDIV">
				<div class="col-sm-12" id="orderPlanGrid"></div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="orderPlanModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header font-color p-0" name="orderPlanModalTabs" id="orderPlanModalTabs" style="color: #4d4a41">
				<div class="col-md-10 p-1">
					<div class="row text-center vertical-middle p-1">
						<div class="col col-md p-1" role="button" style="font-size: 1rem !important; border-right: 2px solid #f6f5f8;" data-target="#carouselOrderPlanModalTabsCaptions" data-slide-to="0" class="active" id="orderPlanModalTabsInfoButton" name="orderPlanModalTabsInfoButton">상세</div>
						<div class="col col-md p-1" role="button" style="font-size: 1rem !important; border-right: 2px solid #f6f5f8;" data-target="#carouselOrderPlanModalTabsCaptions" data-slide-to="1" id="orderPlanModalTabsCommentButton" name="orderPlanModalTabsCommentButton">코멘트</div>
						<div class="col col-md p-1" role="button" style="font-size: 1rem !important; border-right: 2px solid #f6f5f8;" data-target="#carouselOrderPlanModalTabsCaptions" data-slide-to="2" id="orderPlanModalTabsActiveButton" name="orderPlanModalTabsActiveButton">활동</div>
						<div class="col col-md p-1" role="button" style="font-size: 1rem !important; border-right: 2px solid #f6f5f8;" data-target="#carouselOrderPlanModalTabsCaptions" data-slide-to="3" id="orderPlanModalTabsPlanButton" name="orderPlanModalTabsPlanButton">계획</div>
						<div class="col col-md p-1" role="button" style="font-size: 1rem !important;" data-target="#carouselOrderPlanModalTabsCaptions" data-slide-to="4" id="orderPlanModalTabsCheckInButton" name="orderPlanModalTabsCheckInButton">체크인</div>
					</div>
				</div>
				<div class="col-md-2 p-2 text-right">
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#insertPlanningKeyResultModal" data-toggle="modal" id="orderPlanModalTabsPlanAddButton" name="orderPlanModalTabsPlanAddButton" title="계획추가버튼">추가</button>
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#insertCheckInKeyResultModal" data-toggle="modal" id="orderPlanModalTabsCheckInAddButton" name="detailKeyResultModalCheckInAddButton" title="체크인추가버튼">추가</button>
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#applyPlanKeyResultModal" data-toggle="modal" onclick="doAction('applyPlanKeyResultModal','planKeyResultGridListSearch','')" id="orderPlanModalTabsPlanApplyOpenButton" name="orderPlanModalTabsPlanApplyOpenButton" title="계획열기버튼">계획</button>
					<button type="button" class="btn btn-default d-none" style="background-color: #000 !important; color:#fff !important;" data-target="#applyPlanKeyResultModal" data-toggle="modal" id="orderPlanModalTabsPlanApplyCloseButton" name="orderPlanModalTabsPlanApplyCloseButton" title="계획닫기버튼">계획</button>
					<button type="button" class="btn btn-default" style="background-color: #000 !important; color:#fff !important;" data-dismiss="modal" data-toggle="modal" id="orderPlanModalTabsCloseButton" name="orderPlanModalTabsCloseButton" title="핵심결과지표내역나가기역버튼">닫기</button>
				</div>
			</div>
			<div id="carouselOrderPlanModalTabsCaptions" class="carousel slide" data-interval="false" data-ride="carousel">
				<div class="carousel-inner scrollable-div">
					<div class="carousel-item active" style="height: 80vh;">
						<div class="modal-body">
							<div class="col-md-12 " style="height: 100%;" id="log">
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
									</div>
									<div class="row">
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
									</div>
									<div class="row">
										<div class="col-md-4 p-2" style="z-index: 1052;">
											<label for="ordPlanDt"><b>계획날짜</b></label>
											<input type="text" class="form-control text-center" id="ordPlanDt" aria-label="Date-Time" title="계획날짜"  placeholder="계획날짜" required>
											<div id="ordPlanDtDIV" style="margin-top: -1px;"></div>
										</div>
									</div>
									<div class="row">
										<div class="col-12 col-md-12 p-2">
											<label for="ordPlanEmpCd"><b>담당자</b></label>
											<select class="form-control selectpicker" id="ordPlanEmpCd" name="ordPlanEmpCd" required></select>
										</div>
									</div>
									<div class="row">
										<div class="col-6 col-md-6 p-2">
											<label for="ordPlanBusiCd"><b>사업장</b></label>
											<select class="form-control selectpicker" id="ordPlanBusiCd" name="ordPlanBusiCd" required disabled></select>
										</div>
										<div class="col-6 col-md-6 p-2">
											<label for="ordPlanDepaCd"><b>부서</b></label>
											<select class="form-control selectpicker" id="ordPlanDepaCd" name="ordPlanDepaCd" required disabled></select>
										</div>
									</div>
									<div class="row">
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
					<div class="carousel-item" style="height: 80vh;">
						<div class="row flex-grow-1">
							<div class="col-12 col-md-5 scrollable-div" style="border-right: 0.3rem solid #e0e0e0;" id="orderPlanModalKeyResultListCommentWrapper" style="height: 80vh;">
							</div>

							<div class="col-12 col-md-7 scrollable-div d-flex flex-column" style="height: 80vh;" id="orderPlanModalKeyResultListCommentList">
								<div class="row flex-grow-1" style="height: calc(100% - 3rem) !important">
									<!-- 메세지 박스-->
									<div class="col-12 col-md-12 h-100" style="overflow: auto;" id="orderPlanModalKeyResultListCommentMessageBox" name="orderPlanModalKeyResultListCommentMessageBox">
										<ul id="comments" class="comment-list scrollable-div pr-2">
											<li>

											</li>
										</ul>
									</div>
								</div>
								<!-- 메세지 박스-->
								<div class="row">
									<div class="col-12 col-md-12">
										<div class="input-group pr-2">
											<div class="input-group-prepend d-flex justify-content-center align-items-center">
												<img class="img-circle img-sm float-left mr-2"
													 style="height: 2rem;width: 2rem;"
													 src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/${LoginInfo.corpCd}:${LoginInfo.empCd}"
													 alt="사용자 이미지">
											</div>
											<textarea class="form-control" style="resize: unset" rows="1" placeholder="코멘트.." disabled id="orderPlanModalKeyResultListCommentTextArea" name="orderPlanModalKeyResultListCommentTextArea"></textarea>
											<div class="input-group-append d-flex justify-content-center align-items-center">
												<i class="fa-solid fa-circle-up ml-2" style="font-size: 1.5rem !important;" role="button" id="orderPlanModalKeyResultListCommentTextAreaSubmit" name="orderPlanModalKeyResultListCommentTextAreaSubmit"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="carousel-item" style="height: 80vh;">
						<div class="row flex-grow-1">
							<div class="col-12 col-md-5 scrollable-div" style="border-right: 0.3rem solid #e0e0e0;" id="orderPlanModalKeyResultListActiveWrapper" style="height: 80vh;">
							</div>
							<div class="col-12 col-md-7 scrollable-div d-flex flex-column" style="height: 80vh;" id="orderPlanModalKeyResultListActiveList">
								<div class="row flex-grow-1" style="height: calc(100% - 3rem) !important">
									<!-- 메세지 박스-->
									<div class="col-12 col-md-12 h-100" style="overflow: auto;" id="orderPlanModalKeyResultListActiveMessageBox" name="orderPlanModalKeyResultListActiveMessageBox">
										<ul id="actives" class="active-list scrollable-div pr-2" >
											<li>

											</li>
										</ul>
									</div>
								</div>
								<!-- 메세지 박스-->
								<div class="row">
									<div class="col-12 col-md-12">
										<div class="input-group fixed-bottom-input pr-2">
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
											<textarea class="form-control" style="resize: unset" rows="1" placeholder="코멘트.." disabled id="orderPlanModalKeyResultListActiveTextArea" name="orderPlanModalKeyResultListActiveTextArea"></textarea>
											<div class="input-group-append d-flex justify-content-center align-items-center">
												<i class="fa-solid fa-circle-up ml-2" style="font-size: 1.5rem !important;" role="button" id="orderPlanModalKeyResultListActiveTextAreaSubmit" name="orderPlanModalKeyResultListActiveTextAreaSubmit"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="carousel-item" style="height: 80vh;">
						<div class="row flex-grow-1">
							<div class="col-12 col-md-5 scrollable-div" style="border-right: 0.3rem solid #e0e0e0;" id="orderPlanModalKeyResultListPlanWrapper">
							</div>
							<div class="col-12 col-md-7 scrollable-div d-flex flex-column" id="orderPlanModalKeyResultListPlanDetails">
								<div class="row">
									<div class="col-md-12 p-2" style="padding-right: 4px !important;">
										<canvas id="orderPlanModalKeyResultListPlanChart"></canvas>
									</div>
								</div>

								<div class="row scrollable-div" style="height: 500px;">
									<div class="col-md-12 p-2" id="planningKeyResult" style="padding-right: 4px !important;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="planningKeyResultGridListDIV" style="width:100%;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="carousel-item" style="height: 80vh;">
						<div class="row flex-grow-1">
							<div class="col-12 col-md-5 scrollable-div" style="border-right: 0.3rem solid #e0e0e0;" id="orderPlanModalKeyResultListCheckInWrapper">
							</div>
							<div class="col-12 col-md-7 scrollable-div d-flex flex-column" id="orderPlanModalKeyResultListCheckInDetails">
								<div class="row">
									<div class="col-md-12 p-2" style="padding-right: 4px !important;">
										<canvas id="orderPlanModalKeyResultListCheckInChart"></canvas>
									</div>
								</div>
								<div class="row scrollable-div" style="height: 500px;">
									<div class="col-md-12 p-2" id="checkInKeyResult" style="padding-right: 4px !important;">
										<!-- 시트가 될 DIV 객체 -->
										<div id="checkInKeyResultGridListDIV" style="width:100%;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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
						<div class="col-md-12 p-2" style="padding-right: 4px !important;">
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
<script>
	var orderPlanGrid, planningKeyResultGridList, planKeyResultGridList;
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
		 * orderPlanModal click-set START
		 * **********************************/
		document.getElementById('orderPlanModal').addEventListener('click', ev => {
			const targetId = ev.target.id;
			const buttonIds = ['orderPlanModalTabsInfoButton', 'orderPlanModalTabsCommentButton', 'orderPlanModalTabsActiveButton', 'orderPlanModalTabsPlanButton', 'orderPlanModalTabsCheckInButton'];
			const ordPlanCd = document.getElementById('ordPlanCd').value
			if (buttonIds.includes(targetId)) detailKeyResultModalButtonMove(targetId, buttonIds);
			switch (true) {
				case targetId.includes('orderPlanModalTabs'):
					if(targetId.includes('Info')){ // 상세
						new Promise((resolve, reject) => {
							//#region KR 추가 함수
							document.getElementById('orderPlanModalTabsPlanAddButton').classList.add('d-none');
							document.getElementById('orderPlanModalTabsPlanApplyOpenButton').classList.add('d-none');
							//#endregion KR 추가 함수
							resolve();
						}).then(value => {
							//#region 추가 가능
							//#endregion KR 추가 함수
						});

					}else if(targetId.includes('CommentButton')){ // 코멘트
						new Promise((resolve, reject) => {
							//#region KR 추가 함수
							document.getElementById('orderPlanModalKeyResultListCommentTextArea').disabled = true;
							document.getElementById('orderPlanModalKeyResultListCommentTextAreaSubmit').classList.add('d-none');
							displayOrderPlanModalKeyResultList(ordPlanCd,'Comment');
							displayComments('');
							//#endregion KR 추가 함수
							resolve();
						}).then(value => {
							//#region 추가 가능
							document.getElementById('orderPlanModalTabsPlanAddButton').classList.add('d-none');
							document.getElementById('orderPlanModalTabsPlanApplyOpenButton').classList.add('d-none');
							//#endregion KR 추가 함수
						});
					}else if(targetId.includes('ActiveButton')){ // 활동
						new Promise((resolve, reject) => {
							//#region KR 추가 함수
							document.getElementById('orderPlanModalKeyResultListActiveTextArea').disabled = true;
							document.getElementById('orderPlanModalKeyResultListActiveTextAreaSubmit').classList.add('d-none');
							document.getElementById('activityDt').disabled = true;
							displayOrderPlanModalKeyResultList(ordPlanCd,'Active');
							displayActives('');
							//#endregion KR 추가 함수
							resolve();
						}).then(value => {
							//#region 추가 가능
							document.getElementById('orderPlanModalTabsPlanAddButton').classList.add('d-none');
							document.getElementById('orderPlanModalTabsPlanApplyOpenButton').classList.add('d-none');
							//#endregion KR 추가 함수
						});
					}else if(targetId.includes('PlanButton')){ // 계획
						new Promise((resolve, reject) => {
							//#region KR 추가 함수
							displayOrderPlanModalKeyResultList(ordPlanCd,'Plan');
							//#endregion KR 추가 함수
							resolve();
						}).then(value => {
							//#region 그래프 초기화 가능
							var chartStatus = Chart.getChart('orderPlanModalKeyResultListPlanChart');
							if (chartStatus !== undefined) {
								chartStatus.destroy();
							}
							//#endregion KR 추가 함수
						}).then(value => {
							//#region 그리드 초기화 가능
							planningKeyResultGridList.refreshLayout(); // 데이터 초기화
							planningKeyResultGridList.clear(); // 데이터 초기화
							//#endregion KR 추가 함수
						}).then(value => {
							//#region 그리드 초기화 가능
							document.getElementById('orderPlanModalTabsPlanAddButton').classList.add('d-none');
							document.getElementById('orderPlanModalTabsPlanApplyOpenButton').classList.add('d-none');
							//#endregion KR 추가 함수
						});
					}else if(targetId.includes('CheckInButton')){ // 체크인
						new Promise((resolve, reject) => {
							//#region KR 추가 함수
							displayOrderPlanModalKeyResultList(ordPlanCd,'CheckIn');
							//#endregion KR 추가 함수
							resolve();
						}).then(value => {
							//#region 그래프 초기화 가능
							var chartStatus = Chart.getChart('orderPlanModalKeyResultListCheckInChart');
							if (chartStatus !== undefined) {
								chartStatus.destroy();
							}
							//#endregion KR 추가 함수
						}).then(value => {
							//#region 그리드 초기화 가능
							checkInKeyResultGridList.refreshLayout(); // 데이터 초기화
							checkInKeyResultGridList.clear(); // 데이터 초기화
							//#endregion KR 추가 함수
						}).then(value => {
							//#region 그리드 초기화 가능
							document.getElementById('orderPlanModalTabsPlanAddButton').classList.add('d-none');
							document.getElementById('orderPlanModalTabsPlanApplyOpenButton').classList.add('d-none');
							//#endregion KR 추가 함수
						});
					}else if(targetId.includes('PlanAddButton')){ // 계획 추가 버튼
						console.log('여기니')
						new Promise((resolve, reject) => {
							//#region KR 추가 함수
							document.getElementById('insertPlanningKeyResultModalSubmitButton').classList.remove('d-none');
							document.getElementById('updatePlanningKeyResultModalSubmitButton').classList.add('d-none');
							document.getElementById('deletePlanningKeyResultModalSubmitButton').classList.add('d-none');
							//#endregion KR 추가 함수
							resolve();
						}).then(value => {
							//#region 성과수치 계획 모달 초기화 가능
							document.getElementById('insertPlanningKeyResultModalStatus').value = 'C'
							document.getElementById('insertPlanningKeyResultModalCorpCd').value = '<c:out value="${LoginInfo.corpCd}"/>'
							document.getElementById('insertPlanningKeyResultModalPlanCd').value = document.querySelectorAll('div[id="orderPlanModalKeyResultListPlanWrapper"] div[name="orderPlanModalKeyResultListBodyPlan"].color-fill')[0].id.split('-')[1];
							document.getElementById('insertPlanningKeyResultModalSeq').value = '';
							document.getElementById('insertPlanningKeyResultModalCheckInDivi').value = '01';
							document.getElementById('insertPlanningKeyResultModalDt').value = moment().format('YYYY-MM-DD');
							document.getElementById('insertPlanningKeyResultModalAmt').value = '';
							document.getElementById('insertPlanningKeyResultModalStatusDivi').value = '';
							document.getElementById('insertPlanningKeyResultModalNote').value = '';
							//#endregion KR 추가 함수
						});
					}
					break;
				case targetId.includes('orderPlanModalKeyResultList'):
					let orderPlanModalKeyResultListDiv;
					let orderPlanModalKeyResultListPlanCd = targetId.split('-')[1];

					/** @type {HTMLElement} KR 클릭 타겟 */
					let orderPlanModalKeyResultList;

					/** @type {NodeListOf<Element>} Kr 모든 타겟 */
					let orderPlanModalKeyResultListBodyArr = [];
					/** @type {number} Kr 모든 타겟 수*/
					let orderPlanModalKeyResultListBodyArrLength = 0;

					if(targetId.includes('orderPlanModalKeyResultListCommentTextArea') ||
							targetId.includes('orderPlanModalKeyResultListActiveTextArea')) { // 코멘트 공간 예외처리
						if(targetId.includes('TextAreaSubmit')){ // 코멘트 버튼 예외처리
							if(targetId.includes('Comment')){ // 코멘트
								doAction('orderPlanModal','commentInput');
							}else if(targetId.includes('Active')){ // 활동
								doAction('orderPlanModal','activeInput');
							}
						}else{ // 나머지 클릭 시 초기화
						}
					}else{

						// 0. Wrapper, MessageBox, Details 클릭 시, 아무런 이벤트도 안일어 나도록 처리
						if (targetId.includes('Wrapper') || targetId.includes('MessageBox') || targetId.includes('Details')) return;

						// 1. 각 섹션 구분 필요
						var modalDiv = targetId.replaceAll('orderPlanModalKeyResultList','').replaceAll('Wrapper','').replaceAll('MessageBox','').split('-')[0]
						new Promise((resolve, reject) => {
							// 2. 각 섹션 구분에 대한 kr 리스트 세팅
							displayComments(orderPlanModalKeyResultListPlanCd);
							resolve();
						}).then(value => {
							// 3. 각 섹션 구분 값 및 css 적용
							switch (true) {
								case modalDiv.endsWith('Comment'):
									orderPlanModalKeyResultListDiv = 'Comment';
									document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'TextAreaSubmit').classList.add('d-none');
									break;
								case modalDiv.endsWith('Active'):
									orderPlanModalKeyResultListDiv = 'Active';
									document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'TextAreaSubmit').classList.add('d-none');
									break;
								case modalDiv.endsWith('Plan'):
									orderPlanModalKeyResultListDiv = 'Plan';
									break;
								case modalDiv.endsWith('CheckIn'):
									orderPlanModalKeyResultListDiv = 'CheckIn';
									break;
							}
						}).then(value => {
							// 4. 각 섹션 구분에 대한 kr 버튼 초기화 css 적용
							orderPlanModalKeyResultList = document.getElementById('orderPlanModalKeyResultListBody'+orderPlanModalKeyResultListDiv+'-'+orderPlanModalKeyResultListPlanCd);
							orderPlanModalKeyResultListBodyArr = document.querySelectorAll('div[name="orderPlanModalKeyResultListBody'+orderPlanModalKeyResultListDiv+'"]');
							orderPlanModalKeyResultListBodyArrLength = orderPlanModalKeyResultListBodyArr.length;
							for(let i=0; i<orderPlanModalKeyResultListBodyArrLength;i++){
								orderPlanModalKeyResultListBodyArr[i].classList.remove('color-fill');
								orderPlanModalKeyResultListBodyArr[i].classList.add('color-revert');
							}
						}).then(value => {
							// 5. 각 섹션 구분에 대한 kr 클릭 css 적용
							if(orderPlanModalKeyResultList){
								orderPlanModalKeyResultList.classList.remove('color-revert');
								orderPlanModalKeyResultList.classList.add('color-fill');
							}
						}).then(value => {
							// 6. 선택한 kr에 대한 우측 상세목록 처리
							switch (true) {
								case modalDiv.endsWith('Comment'):
									displayComments(orderPlanModalKeyResultListPlanCd);
									document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'TextArea').disabled = false;
									document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'TextAreaSubmit').classList.remove('d-none');
									break;
								case modalDiv.endsWith('Active'):
									displayActives(orderPlanModalKeyResultListPlanCd);
									document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'TextArea').disabled = false;
									document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'TextAreaSubmit').classList.remove('d-none');
									document.getElementById('activityDt').disabled = false;
									break;
								case modalDiv.endsWith('Plan'):
									new Promise((resolve, reject) => {
										doAction('orderPlanModal', 'planningKeyResulChartSearch', '');
										resolve();
									}).then(value => {
										doAction('orderPlanModal', 'planningKeyResulListSearch', '');
									}).then(value => {
										document.getElementById('orderPlanModalTabsPlanAddButton').classList.remove('d-none');
									});
									break;
								case modalDiv.endsWith('CheckIn'):
									new Promise((resolve, reject) => {
										doAction('orderPlanModal', 'checkInKeyResulChartSearch', '');
										resolve();
									}).then(value => {
										doAction('orderPlanModal', 'checkInKeyResulListSearch', '');
									}).then(value => {
										document.getElementById('orderPlanModalTabsPlanApplyOpenButton').classList.remove('d-none');
									});
									break;
							}
						});
					}
					break;
			}
		});
		/*************************************
		 * orderPlanModal click-set END
		 * **********************************/

		/*************************************
		 * orderPlanModal keydown-set START
		 * **********************************/
		document.getElementById('orderPlanModal').addEventListener('keydown', ev => {
			const targetId = ev.target.id;
			const keyCode = ev.code;
			const shiftKey = ev.shiftKey;
			switch (true) {
				case targetId.includes('orderPlanModalKeyResultList'):
					if (keyCode === "Enter" && !shiftKey && !ev.isComposing) {
						if (targetId.includes('orderPlanModalKeyResultListCommentTextArea')) {
							new Promise((resolve, reject) => {
								ev.preventDefault(); // 기본 Enter 동작 (줄바꿈) 방지
								resolve();
							}).then(value => {
								doAction('orderPlanModal','commentInput')
							})
						}else if (targetId.includes('orderPlanModalKeyResultListActiveTextArea')) {
							new Promise((resolve, reject) => {
								ev.preventDefault(); // 기본 Enter 동작 (줄바꿈) 방지
								resolve();
							}).then(value => {
								doAction('orderPlanModal','activeInput')
							})
						}
					}
					break;
			}
		});
		/*************************************
		 * orderPlanModal keydown-set END
		 * **********************************/

		/*************************************
		 * insertPlanningKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('insertPlanningKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			if (targetId === 'insertPlanningKeyResultModalSubmitButton') {
				var ajaxCondition = await modifyModalInputCheck('insertPlanningKeyResultModalForm');
				if (!ajaxCondition) { // 저장
					await doAction('insertPlanningKeyResultModal', 'planningKeyResultInput');
					await document.getElementById('insertPlanningKeyResultModalCloseButton').click(); // 여기
				}
			}
			else if (targetId === 'updatePlanningKeyResultModalSubmitButton') {
				await doAction('insertPlanningKeyResultModal', 'planningKeyResultUpdate');
			}
			else if (targetId === 'deletePlanningKeyResultModalSubmitButton') {
				await doAction('insertPlanningKeyResultModal', 'planningKeyResultDelete');
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
					await doAction('insertCheckInKeyResultModal', 'checkInKeyResultInput');
					await document.getElementById('insertCheckInKeyResultModalCloseButton').click();
				}
			}
			else if (targetId === 'updateCheckInKeyResultModalSubmitButton') {
				await doAction('insertCheckInKeyResultModal', 'checkInKeyResultUpdate')
			}
			else if (targetId === 'deleteCheckInKeyResultModalSubmitButton') {
				await doAction('insertCheckInKeyResultModal', 'checkInKeyResultDelete')
			};
		})
		/*************************************
		 * insertCheckInKeyResultModal click ev set END
		 * **********************************/

		/*************************************
		 * applyPlanKeyResultModal click ev set START
		 * **********************************/
		document.getElementById('applyPlanKeyResultModal').addEventListener('click', async ev =>{
			const targetId = ev.target.id;
			switch (targetId) {
				case 'selectPlanKeyResultModalButton': await doAction('applyPlanKeyResultModal','planKeyResultGridListSearch'); break;
				case 'applyPlanKeyResultModalButton': await doAction('applyPlanKeyResultModal','planKeyResultGridListApply'); break;
			}
		})
		/*************************************
		 * applyPlanKeyResultModal click ev set END
		 * **********************************/


		/*************************************
		 * carousel-set START
		 * **********************************/
		$('.carousel').carousel({
			interval: false,
		})
		/*************************************
		 * carousel-set END
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
		 * Grid Class 영역 START
		 ***********************************************************************/
		class CustomSliderRenderer {
			constructor(props) {

				const rowKey = props.rowKey;
				const value = props.value;
				var divi = props.grid.el.id.includes('planningKeyResultGridListDIV')?'planningKeyResultGridListDIV'
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
		// planning key result
		planningKeyResultGridList = new tui.Grid({
			el: document.getElementById('planningKeyResultGridListDIV'),
			// data: treeData,
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'auto',
			rowHeight:'auto',
			minRowHeight:30,
			rowHeaders: [/*'rowNum', 'checkbox'*/],
			header: {
				height: 30,
				minRowHeight: 30
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		planningKeyResultGridList.setColumns([
			{ header:'계획마감일자',	name:'dt',			width:85,	align:'center'},
			{ header:'상세설명란',	name:'note',		minWidth:250,		align:'left',	whiteSpace:'pre-line'},
			{ header:'계획수치',		name:'amt',			width:50,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + ev.row.unit;
				},
				whiteSpace:'pre-line'
			},
			{ header:'누적률',		name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:'상태',			name:'statusDivi',	width:50,		align:'center',
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

		planningKeyResultGridList.on('click', async ev => {
			if(ev.columnName !== 'fn' && ev.targetType === 'cell'){ // 상세보기 별도 구분

				/* 성과수치 계획 모달 적용*/

				await document.getElementById('orderPlanModalTabsPlanAddButton').click();
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
		// check in key result
		checkInKeyResultGridList = new tui.Grid({
			el: document.getElementById('checkInKeyResultGridListDIV'),
			// data: treeData,
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'auto',
			rowHeight:'auto',
			rowHeaders: [/*'rowNum', 'checkbox'*/],
			header: {
				height: 30,
				minRowHeight: 30
			},
			columns:[],
			columnOptions: {
				resizable: true
			}
		});

		checkInKeyResultGridList.setColumns([
			{ header:'체크인마감일자',	name:'dt',			width:85,	align:'center'},
			{ header:'상세설명란',		name:'note',		minWidth:250,	align:'left',	whiteSpace:'pre-line'},
			{ header:'체크인수치',		name:'amt',			width:50,		align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + ev.row.unit;
				},
				whiteSpace:'pre-line'
			},
			{ header:'누적률',		name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:'상태',			name:'statusDivi',	width:50,		align:'center',
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

		checkInKeyResultGridList.on('click', async ev => {
			if(ev.columnName !== 'fn' && ev.targetType === 'cell'){ // 상세보기 별도 구분

				/* 성과수치 계획 모달 적용*/

				await document.getElementById('orderPlanModalTabsCheckInAddButton').click();
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
			{ header:'계획마감일자',	name:'dt',			width:85,	align:'center'},
			{ header:'상세설명란',	name:'note',		minWidth:250,		align:'left',	whiteSpace:'pre-line'},
			{ header:'계획수치',		name:'amt',			width:50,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + ev.row.unit;
				},
				whiteSpace:'pre-line'
			},
			{ header:'체크인수치',	name:'applyTotAmt',	width:50,	align:'right',
				formatter:function (ev) {
					return edsUtil.addComma(ev.value) + ' ' + ev.row.unit;
				},
				whiteSpace:'pre-line'
			},
			{ header:'적용수치',		name:'applyAmt',	width:50,	align:'right',	whiteSpace:'pre-line', editor:{type: 'text'}},
			{ header:'적용률',		name:'rate',		width:100,		align:'center', renderer: {type: CustomSliderRenderer,}},
			{ header:'상태',			name:'statusDivi',	width:50,		align:'center',
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

				new Promise((resolve, reject) => {
					document.getElementById('btnInputPopEv').click();
					resolve();
				}).then(value => {
					document.getElementById('orderPlanModalTabsInfoButton').click();
				}).then(value => {// button el
					document.getElementById('orderPlanModalTabsCommentButton').classList.remove('d-none');
					document.getElementById('orderPlanModalTabsActiveButton').classList.remove('d-none');
					document.getElementById('orderPlanModalTabsPlanButton').classList.remove('d-none');
					document.getElementById('orderPlanModalTabsCheckInButton').classList.remove('d-none');

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
				})
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
	async function doAction(sheet, name, el){
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
						Swal.fire({
							title: "정말 삭제하시겠습니까?",
							showDenyButton: true,
							showCancelButton: false,
							confirmButtonText: "삭제",
							denyButtonText: `취소`
						}).then(async (result) => {
							/* Read more about isConfirmed, isDenied below */
							if (result.isConfirmed) {
								await edsUtil.modalCUD('/ORDER_PLAN_LIST/cuOrderPlanList','orderPlanGrid',orderPlanGrid,'orderPlanGridForm')
								await document.getElementById('btnClose').click();
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					}, 100);
				break;
				case "resetAll":// 초기화
					// button el
					document.getElementById('orderPlanModalTabsCommentButton').classList.add('d-none');
					document.getElementById('orderPlanModalTabsActiveButton').classList.add('d-none');
					document.getElementById('orderPlanModalTabsPlanButton').classList.add('d-none');
					document.getElementById('orderPlanModalTabsCheckInButton').classList.add('d-none');
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
		}else if(sheet === 'orderPlanModal'){
			switch (name) {
				case "commentInput":// comment 신규
					if(document.querySelectorAll('div[id="orderPlanModalKeyResultListCommentWrapper"] div[name="orderPlanModalKeyResultListBodyComment"].color-fill').length < 1) return;
					var param = {};
					param.status = 'C';
					param.planCd = document.querySelectorAll('div[id="orderPlanModalKeyResultListCommentWrapper"] div[name="orderPlanModalKeyResultListBodyComment"].color-fill')[0].id.split('-')[1];
					param.planNm = document.querySelectorAll('div[id="orderPlanModalKeyResultListCommentWrapper"] div[name="orderPlanModalKeyResultListBodyComment"].color-fill div[name="orderPlanModalKeyResultListPlanNmComment"]')[0].innerText;
					param.content = document.getElementById('orderPlanModalKeyResultListCommentTextArea').value;
					param.empCd = '';
					param.partCds = '';
					setTimeout(async ev=>{
						new Promise((resolve, reject) => {
							edsUtil.postAjax('/WORK_LOG/cdWorkLogComment', '', param);
							resolve();
						}).then(value => {
							document.querySelectorAll('div[id="orderPlanModalKeyResultListCommentWrapper"] div[name="orderPlanModalKeyResultListBodyComment"].color-fill')[0].click();
							document.getElementById('orderPlanModalKeyResultListCommentTextArea').value = '';
						})
					},40)
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
								new Promise((resolve, reject) => {
									edsUtil.postAjax('/WORK_LOG/cdWorkLogComment', '', param);
									resolve();
								}).then(value => {
									document.querySelectorAll('div[id="orderPlanModalKeyResultListCommentWrapper"] div[name="orderPlanModalKeyResultListBodyComment"].color-fill')[0].click();
								})
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					},40)
					break;
				case "activeInput":// active 신규
					if(document.querySelectorAll('div[id="orderPlanModalKeyResultListActiveWrapper"] div[name="orderPlanModalKeyResultListBodyActive"].color-fill').length < 1) return;
					var param = {};
					param.status = 'C';
					param.planCd = document.querySelectorAll('div[id="orderPlanModalKeyResultListActiveWrapper"] div[name="orderPlanModalKeyResultListBodyActive"].color-fill')[0].id.split('-')[1];
					param.planNm = document.querySelectorAll('div[id="orderPlanModalKeyResultListActiveWrapper"] div[name="orderPlanModalKeyResultListBodyActive"].color-fill div[name="orderPlanModalKeyResultListPlanNmActive"]')[0].innerText;
					param.activityDt = document.getElementById('activityDt').value;
					param.content = document.getElementById('orderPlanModalKeyResultListActiveTextArea').value;
					param.empCd = '';
					param.partCds = '';
					setTimeout(async ev=>{
						new Promise((resolve, reject) => {
							edsUtil.postAjax('/WORK_LOG/cdWorkLogActive', '', param);
							resolve();
						}).then(value => {
							document.querySelectorAll('div[id="orderPlanModalKeyResultListActiveWrapper"] div[name="orderPlanModalKeyResultListBodyActive"].color-fill')[0].click();
							document.getElementById('orderPlanModalKeyResultListActiveTextArea').value = '';
						})
					},40)
					break;
				case "activeDelete":// 코멘트 삭제
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
								new Promise((resolve, reject) => {
									edsUtil.postAjax('/WORK_LOG/cdWorkLogActive', '', param);
									resolve();
								}).then(value => {
									document.querySelectorAll('div[id="orderPlanModalKeyResultListActiveWrapper"] div[name="orderPlanModalKeyResultListBodyActive"].color-fill')[0].click();
								})
							} else if (result.isDenied) {
								Swal.fire("취소되었습니다.", "", "info");
							}
						});
					},40)
					break;
				case "planningKeyResulChartSearch":// 계획 차트 조회
					var chartStatus = Chart.getChart('orderPlanModalKeyResultListPlanChart');
					if (chartStatus !== undefined) {
						chartStatus.destroy();
					}
					var param = { //조회조건
						planCd : document.querySelectorAll('div[id="orderPlanModalKeyResultListPlanWrapper"] div[name="orderPlanModalKeyResultListBodyPlan"].color-fill')[0].id.split('-')[1],
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

					// 차트 생성
					var ctx = document.getElementById('orderPlanModalKeyResultListPlanChart');
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
								},
							},
						}
					});

					// 추가, 수정 모달에 최종 계획, 목표 값 적용
					document.getElementById('insertPlanningKeyResultModalAmt1').textContent = Number(data[data.length - 1].amt);
					document.getElementById('insertPlanningKeyResultModalAmt2').textContent = Number(data[data.length - 1].edAmt);
					document.getElementById('insertPlanningKeyResultModalUnit1').textContent = data[data.length - 1].unit;
					document.getElementById('insertPlanningKeyResultModalUnit2').textContent = data[data.length - 1].unit;
					document.getElementById('insertPlanningKeyResultModalUnit3').textContent = data[data.length - 1].unit;
					break;
				case "planningKeyResulListSearch":// 계획 리스트 조회
					setTimeout(async ev => {
						planningKeyResultGridList.refreshLayout(); // 데이터 초기화
						planningKeyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd : document.querySelectorAll('div[id="orderPlanModalKeyResultListPlanWrapper"] div[name="orderPlanModalKeyResultListBodyPlan"].color-fill')[0].id.split('-')[1],
						};
						await planningKeyResultGridList.resetData(edsUtil.getAjax("/WORK_LOG/selectWorkLogPlanningKeyResult", param));
					},170);
					break;
				case "checkInKeyResulChartSearch":// 체크인 차트 조회
					var chartStatus = Chart.getChart('orderPlanModalKeyResultListCheckInChart');
					if (chartStatus !== undefined) {
						chartStatus.destroy();
					}
					var param = { //조회조건
						planCd : document.querySelectorAll('div[id="orderPlanModalKeyResultListCheckInWrapper"] div[name="orderPlanModalKeyResultListBodyCheckIn"].color-fill')[0].id.split('-')[1],
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

					var ctx = document.getElementById('orderPlanModalKeyResultListCheckInChart');
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
									display: true,
									beginAtZero: true
								},
								y: {
									display: true,
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

					// 추가, 수정 모달에 최종 계획, 목표 값 적용
					document.getElementById('insertCheckInKeyResultModalAmt1').textContent = Number(data[data.length - 1].ckeckInamt);
					document.getElementById('insertCheckInKeyResultModalAmt2').textContent = Number(data[data.length - 1].edAmt);
					document.getElementById('insertCheckInKeyResultModalUnit1').textContent = data[data.length - 1].unit;
					document.getElementById('insertCheckInKeyResultModalUnit2').textContent = data[data.length - 1].unit;
					document.getElementById('insertCheckInKeyResultModalUnit3').textContent = data[data.length - 1].unit;
					break;
				case "checkInKeyResulListSearch":// 체크인 리스트 조회
					setTimeout(async ev => {
						checkInKeyResultGridList.refreshLayout(); // 데이터 초기화
						checkInKeyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd : document.querySelectorAll('div[id="orderPlanModalKeyResultListCheckInWrapper"] div[name="orderPlanModalKeyResultListBodyCheckIn"].color-fill')[0].id.split('-')[1],
						};
						await checkInKeyResultGridList.resetData(edsUtil.getAjax("/WORK_LOG/selectWorkLogCheckInKeyResult", param));
					},170);
					break;
			}
		}else if(sheet === 'insertPlanningKeyResultModal'){
			/*
			* todo: 계획의 추가 수정 기능과 체크인의 수정과 계획 기능 연동만하면 끝
			* */
			switch (name) {
				case "planningKeyResultInput":// kr 신규
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogPlanningKeyResult','','','insertPlanningKeyResultModalForm');
					await doAction('orderPlanModal','planningKeyResulChartSearch');
					await doAction('orderPlanModal','planningKeyResulListSearch');
					break;
				case "planningKeyResultUpdate":// kr plan 저장
					await document.getElementById('insertPlanningKeyResultModalStatus').setAttribute('value','U')
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogPlanningKeyResult','','','insertPlanningKeyResultModalForm');
					await doAction('orderPlanModal','planningKeyResulChartSearch');
					await doAction('orderPlanModal','planningKeyResulListSearch');
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
							await doAction('orderPlanModal','planningKeyResulChartSearch');
							await doAction('orderPlanModal','planningKeyResulListSearch');
						} else if (result.isDenied) {
							Swal.fire("취소되었습니다.", "", "info");
						}
					});
					break;
			}
		}else if(sheet === 'insertCheckInKeyResultModal'){
			/*
			* todo: 계획의 추가 수정 기능과 체크인의 수정과 계획 기능 연동만하면 끝
			* */
			switch (name) {
				case "checkInKeyResultInput":// kr 신규
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogCheckInKeyResult','','','insertCheckInKeyResultModalForm');
					await doAction('orderPlanModal','checkInKeyResulChartSearch');
					await doAction('orderPlanModal','checkInKeyResulListSearch');
					break;
				case "checkInKeyResultUpdate":// kr plan 저장
					await document.getElementById('insertCheckInKeyResultModalStatus').setAttribute('value','U')
					await edsUtil.modalCUD('/WORK_LOG/cudWorkLogCheckInKeyResult','','','insertCheckInKeyResultModalForm');
					await doAction('orderPlanModal','checkInKeyResulChartSearch');
					await doAction('orderPlanModal','checkInKeyResulListSearch');
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
							await doAction('orderPlanModal','checkInKeyResulChartSearch');
							await doAction('orderPlanModal','checkInKeyResulListSearch');
						} else if (result.isDenied) {
							Swal.fire("취소되었습니다.", "", "info");
						}
					});
					break;
			}
		}else if(sheet === 'applyPlanKeyResultModal'){
			/*
			* todo: 계획의 추가 수정 기능과 체크인의 수정과 계획 기능 연동만하면 끝
			* */
			switch (name) {
				case "planKeyResultGridListSearch":// 계획 리스트 적용 조회
					setTimeout(async ev => {
						planKeyResultGridList.refreshLayout(); // 데이터 초기화
						planKeyResultGridList.clear(); // 데이터 초기화
						var param = { //조회조건
							planCd : document.querySelectorAll('div[id="orderPlanModalKeyResultListCheckInWrapper"] div[name="orderPlanModalKeyResultListBodyCheckIn"].color-fill')[0].id.split('-')[1],
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
						edsUtil.checksCUD('/WORK_LOG/cudWorkLogKeyResultPlanList', 'C', planKeyResultGridList, 'orderPlanModal', 'checkInKeyResulListSearch');
					}).then(value => {
						document.getElementById('orderPlanModalTabsPlanApplyCloseButton').click(); // 모달 끄기
					})
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

	//#region KR 추가 함수
	/**
	 * parePlanCd에 따른 차트 세팅
	 * @param {string} rootPlanCd - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function displayOrderPlanModalKeyResultList(ordPlanCd,orderPlanModalKeyResultListDiv){
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
		let orderPlanModalKeyResultList;

		new Promise((resolve, reject)=>{
			//#region 1. 조회 조건 세팅
			param.ordPlanCd = ordPlanCd;
			param.dateDiv = '';
			param.OkrDiv = '02';
			//#endregion
			resolve();
		}).then(value => {
			//#region 3. 조회 값 세팅
			dbData = edsUtil.getAjax("/WORK_LOG/getLowKeyResultsForOrderPlanList", param);
			dbDataLength = dbData.length;
			//#endregion
		}).then(value => {
			//#region 4. 디테일 kr 초기화
			orderPlanModalKeyResultList = document.getElementById('orderPlanModalKeyResultList'+orderPlanModalKeyResultListDiv+'Wrapper');
			orderPlanModalKeyResultList.replaceChildren();
			//#endregion
		}).then(value => {
			//#region 5. KR 리스트 세팅
			for (let i = 0; i < dbDataLength; i++) {
				planCds.push(dbData[i].planCd)

				/** @type {HTMLElement} div */
				let div01Tag = document.createElement('div');
				div01Tag.setAttribute('class','col-md-12 p-1 fade-in-slide-down');

				/** @type {HTMLElement} div */
				let div02Tag = document.createElement('div');
				div02Tag.setAttribute('class','card w-100 p-0');
				div02Tag.setAttribute('style','background: '+ dbData[i].cntColor);
				div02Tag.setAttribute('id','orderPlanModalKeyResultListTransition'+orderPlanModalKeyResultListDiv+'-'+dbData[i].planCd);
				div02Tag.setAttribute('name','orderPlanModalKeyResultListTransition'+orderPlanModalKeyResultListDiv);

				/** @type {HTMLElement} div */
				let div03Tag = document.createElement('div');
				div03Tag.setAttribute('class','card-body color-revert p-1 orderPlanModalKeyResultListBody'+orderPlanModalKeyResultListDiv);
				div03Tag.setAttribute('id','orderPlanModalKeyResultListBody'+orderPlanModalKeyResultListDiv+'-'+dbData[i].planCd);
				div03Tag.setAttribute('name','orderPlanModalKeyResultListBody'+orderPlanModalKeyResultListDiv);

				/** @type {HTMLElement} div */
				let div04Tag = document.createElement('div');
				div04Tag.setAttribute('class','row');

				//#region 5-1. KR명 세팅
				/** @type {HTMLElement} div */
				let div05Tag = document.createElement('div');
				div05Tag.setAttribute('class','col-12 h4 mb-0 pb-1');
				div05Tag.setAttribute('id','orderPlanModalKeyResultListPlanNm'+orderPlanModalKeyResultListDiv+'-'+dbData[i].planCd);
				div05Tag.setAttribute('name','orderPlanModalKeyResultListPlanNm'+orderPlanModalKeyResultListDiv);
				div05Tag.setAttribute('style','font-size: 1.0rem !important');
				div05Tag.textContent = dbData[i].planNm;
				//#endregion

				//#region 5-1. 목표명 세팅
				/** @type {HTMLElement} div */
				let div06Tag = document.createElement('div');
				div06Tag.setAttribute('class','col-12 h4 mb-0 pb-1');
				div06Tag.setAttribute('id','orderPlanModalKeyResultListSubPlanNm'+orderPlanModalKeyResultListDiv+'-'+dbData[i].planCd);
				div06Tag.setAttribute('name','orderPlanModalKeyResultListSubPlanNm'+orderPlanModalKeyResultListDiv);
				div06Tag.setAttribute('style','font-size: 0.8rem !important');
				div06Tag.textContent = dbData[i].subPlanNm;
				//#endregion

				//#region 5-3. 리더 세팅
				/** @type {HTMLElement} div */
				let div07Tag = document.createElement('div');
				div07Tag.setAttribute('class','col-12 pb-1');
				div07Tag.setAttribute('id','orderPlanModalKeyResultListPartCds'+orderPlanModalKeyResultListDiv+'-'+dbData[i].planCd);
				div07Tag.setAttribute('name','orderPlanModalKeyResultListPartCds'+orderPlanModalKeyResultListDiv);
				div07Tag.setAttribute('style','font-size: 0.8rem !important');
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
				orderPlanModalKeyResultList.appendChild(div01Tag);
				//#endregion
			}
			//#endregion
		})
	}
	//#endregion

	//#region detailKeyResultModal button move 함수
	async function detailKeyResultModalButtonMove(targetId) {
		// button, modalBody, modalFooter 처리
		const buttonIds = ['orderPlanModalTabsInfoButton', 'orderPlanModalTabsCommentButton', 'orderPlanModalTabsActiveButton', 'orderPlanModalTabsPlanButton', 'orderPlanModalTabsCheckInButton'];
		for (let i = 0, length=buttonIds.length; i < length; i++) {
			let buttonEl = document.getElementById(buttonIds[i]);
			let modalBodyEl = document.getElementById(buttonIds[i].replace('Button', ''));
			let modalfooterEl = document.getElementById(buttonIds[i].replace('Button', '')+'Footer');
			if(targetId === buttonIds[i]){
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
	//#endregion

	//#region 댓글을 HTML로 변환하여 표시 함수
	/**
	 * orderPlanModalKeyResultListPlanCd에 따른 차트 세팅
	 * @param {string} orderPlanModalKeyResultListPlanCd - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function displayComments(orderPlanModalKeyResultListPlanCd) {
		var param = {};
		param.planCd = orderPlanModalKeyResultListPlanCd;
		param.content = document.getElementById('orderPlanModalKeyResultListCommentTextArea').value;
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
							<button id="`+data[i].corpCd+`,`+data[i].planCd+`,`+data[i].seq+`,`+data[i].inpId+`" onclick="doAction('orderPlanModal','commentDelete',this)" class="comment-delete-button"><i class="fa-solid fa-trash-can"></i></button>
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
			var orderPlanModalKeyResultListCommentMessageBox = document.getElementById('orderPlanModalKeyResultListCommentMessageBox')
			orderPlanModalKeyResultListCommentMessageBox.scrollTop = orderPlanModalKeyResultListCommentMessageBox.scrollHeight;
		}, 100);
	}
	//#endregion

	//#region 댓글을 HTML로 변환하여 표시 함수
	/**
	 * orderPlanModalKeyResultListPlanCd에 따른 차트 세팅
	 * @param {string} orderPlanModalKeyResultListPlanCd - 첫번째 변수 나타낼 데이터 구분 값(main: 최상위 목표 세팅, sub: 하위 목표세팅, kr: 하위 목표세팅, active: 활동내역 세팅)
	 */
	async function displayActives(orderPlanModalKeyResultListPlanCd) {
		var param = {};
		param.planCd = orderPlanModalKeyResultListPlanCd;
		param.content = document.getElementById('orderPlanModalKeyResultListActiveTextArea').value;
		// 댓글 데이터
		var data = await edsUtil.getAjax("/WORK_LOG/selectWorkLogActive", param);
		var activeList = document.getElementById("actives");
		activeList.innerHTML = ''
		for (let i = 0, length=data.length; i < length; i++) {
			const li = document.createElement("li");
			li.className = "active";
			if(data[i].inpId === '<c:out value="${LoginInfo.empCd}"/>'){
				li.innerHTML = `
							<img src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+data[i].corpCd+`:`+data[i].inpId+`" class="profile-pic" alt="`+data[i].inpNm+`">
							<div>
								<strong>`+data[i].inpNm+`[`+data[i].depaNm+`]</strong><br>
								<span class="active-content">`+data[i].content.replace(/\n/g, '<br>')+`</span>
								<div class="active-time">`+data[i].activityDt+`</div>
							</div>
							<button id="`+data[i].corpCd+`,`+data[i].planCd+`,`+data[i].seq+`,`+data[i].inpId+`" onclick="doAction('orderPlanModal','activeDelete',this)" class="active-delete-button"><i class="fa-solid fa-trash-can"></i></button>
							`;
			}else{
				li.innerHTML = `
							<img src="/BASE_USER_MGT_LIST/selectUserFaceImageEdms/`+data[i].corpCd+`:`+data[i].inpId+`" class="profile-pic" alt="`+data[i].inpNm+`">
							<div>
								<strong>`+data[i].inpNm+`[`+data[i].depaNm+`]</strong><br>
								<span class="active-content">`+data[i].content.replace(/\n/g, '<br>')+`</span>
								<div class="active-time">`+data[i].activityDt+`</div>
							</div>
							`;
			}
			activeList.appendChild(li);
		}

		setTimeout(() => {
			// 메세지 세팅 후 가장 아래로 스크롤
			var orderPlanModalKeyResultListActiveMessageBox = document.getElementById('orderPlanModalKeyResultListActiveMessageBox')
			orderPlanModalKeyResultListActiveMessageBox.scrollTop = orderPlanModalKeyResultListActiveMessageBox.scrollHeight;
		}, 100);
	}
	//#endregion

	//#region 댓글을 HTML로 변환하여 표시 함수
	/**
	 * input 따른 숫자
	 * @param {string} input - 숫자
	 */
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
	//#endregion

	//#region 댓글을 HTML로 변환하여 표시 함수
	/**
	 * 필수 값 체크 기능
	 * @param {string} modalName - 필수값 id
	 */
	async function modifyModalInputCheck(modalName) {
		var ajaxCondition = 1;
		var ajaxConditionColumn = [];

		switch (modalName) { // title에 이름넣기, 저장위치에 다 추가하기
			case 'insertPlanningKeyResultModalForm': // 지표 계획하기
				ajaxConditionColumn = ['insertPlanningKeyResultModalDt',
					'insertPlanningKeyResultModalAmt'];
				break;
			case 'insertCheckInKeyResultModalForm': // 지표 체크인
				ajaxConditionColumn = ['insertCheckInKeyResultModalDt',
					'insertCheckInKeyResultModalAmt',
					'insertCheckInKeyResultModalStatusDivi'];
				break;
		}
		ajaxCondition = await edsUtil.checkValidationForForm(modalName, ajaxConditionColumn);
		return ajaxCondition;
	}
	//#endregion

	//#region promiseThen 딜레이 함수
	/**
	 * 딜레이 기능
	 * @param {string} modalName - 필수값 id
	 */
	function promiseThenDelay(value, ms) {
		return new Promise(resolve => {
			setTimeout(() => resolve(value), ms);
		});
	}
	//#endregion
	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>
<script type="text/javascript" src="/AdminLTE_main/plugins/select2/js/select2.full.min.js"></script>
</body>
</html>