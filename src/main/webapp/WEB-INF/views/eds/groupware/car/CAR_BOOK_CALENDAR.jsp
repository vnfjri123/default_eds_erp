<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-calendar.jspf"%><%-- 캘린더 스크립트 정의--%>
	<link rel="stylesheet" href="/css/AdminLTE_main/dist/css/adminlte.min.css">
</head>

<body>
<div class="row" style="position:relative;margin-right: 0px;margin-left: -7.5px;">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
						<div class="form-group">
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group-prepend">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
							</div>
							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>
							<div class="input-group-append">
								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<select class="form-control selectpicker" style="width: 200px;" name="carCd" id="carCd" ></select>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<select class="form-control selectpicker" style="width: 200px;" name="empCd" id="empCd" ></select>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="carBookCalendarDiv">
				<button class="button is-rounded today" id="todayBtn" name="todayBtn">오늘</button>
				<button class="button is-rounded prev" id="prevBtn" name="prevBtn">
					<img alt="prev" id="prevImg" name="prevImg" src="/tui/@toast-ui/calendar/images/ic-arrow-line-left.png">
				</button>
				<button class="button is-rounded next" id="nextBtn" name="nextBtn">
					<img alt="next" id="nextImg" name="nextImg" src="/tui/@toast-ui/calendar/images/ic-arrow-line-right.png" >
				</button>
				<span id="topCalendar"></span>
				<main id="carBookCalendar" style="height: calc(100vh - 8rem); width: 100%;"></main>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="carBookCalendarButtonForm" id="carBookCalendarButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"		id="btnSearch"		onclick="doAction('carBookCalendar', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="invisible" 			 name="btnInputPopEv"	id="btnInputPopEv"	data-toggle="modal" data-target="#modalCart"></button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalCart" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header bg-dark font-color" name="tabs" id="tabs" style="color: #4d4a41">
				<h4 class="modal-title" style="color:#4d4a41">예약하기</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-4" style="height: 100%;" id="baseGridList">
						<!-- 시트가 될 DIV 객체 -->
						<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
					</div>
					<div class="col-md-8" style="height: 100%;" id="book">
						<form name="carBookCalendarForm" id="carBookCalendarForm" onsubmit="return false;" method="post">
							<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
							<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
							<input type="hidden" name="carBookCd" id="carBookCd" title="차량예약코드">
							<div class="form-row">
								<div class="col-md-3 mb-3">
									<label for="carNm"><b>차량</b></label>
									<input type="hidden" name="carCd" id="carCd" title="차량코드">
									<input type="text" class="form-control text-center" id="carNm" name="carNm" title="차량명" placeholder="차량명" readonly="readonly" minlength="1" required>
								</div>
								<div class="col-md-3 mb-3" style="z-index: 2000">
									<label for="stDatePicker"><b>시작 일시</b></label>
									<input type="text" class="form-control text-center" id="stDatePicker" aria-label="Date-Time" title="시작일시"  placeholder="시작일시" readonly="readonly" required>
									<div id="stDatePickerDIV" style="margin-top: -1px;"></div>
								</div>
								<div class="col-md-3 mb-3" style="z-index: 2000">
									<label for="edDatePicker"><b>종료 일시</b></label>
									<input type="text" class="form-control text-center" id="edDatePicker" aria-label="Date-Time" title="끝일시"  placeholder="끝일시" readonly="readonly" required>
									<div id="edDatePickerDIV" style="margin-top: -1px;"></div>
								</div>
								<div class="col-md-3 mb-3">
									<label for="useTime"><b>시간</b></label>
									<input type="text" class="form-control text-center" id="useTime" name="useTime" title="사용시간"  placeholder="사용시간" readonly="readonly">
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-3 mb-3">
									<label for="empNm"><b>예약자</b></label>
									<input type="hidden" name="empCd" id="empCd" title="예약자">
									<input type="text" class="form-control text-center" id="empNm" name="empNm" title="예약자" placeholder="예약자"  readonly="readonly" required>
								</div>
								<div class="col-md-3 mb-3">
									<label for="depaNm"><b>부서</b></label>
									<input type="hidden" name="depaCd" id="depaCd" title="부서">
									<input type="text" class="form-control text-center" id="depaNm" name="depaNm" title="부서" placeholder="부서"  readonly="readonly" required>
								</div>
								<div class="col-md-6 mb-3">
									<label for="purpCd"><b>업무목적</b></label>
									<select class="form-control text-center" name="purpCd" id="purpCd" title="업무목적"></select>
								</div>
							</div>
							<div class="form-row">
								<div class="col-md-12 mb-3">
									<label for="note"><b>메모</b></label>
									<textarea type="text" rows="16" class="form-control" id="note" name="note" title="메모" placeholder="메모" value=""></textarea>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="carBookModalButtonForm" id="carBookModalButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" id="btnSearch1" onclick="doAction('carBookCalendar', 'carSearch')"><i class="fa fa-search"></i> 차량조회</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch5"	id="btnSearch5"	onclick="doAction('carBookCalendar', 'reset')"><i class="fa fa-trash"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnSave5"	id="btnSave5"	onclick="doAction('carBookCalendar', 'save')"><i class="fa fa-save"></i> 저장</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete5"	id="btnDelete5"	onclick="doAction('carBookCalendar', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose"	id="btnClose"	onclick="doAction('carBookCalendar', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
</body>
<%@ include file="/WEB-INF/views/comm/common-include-calendar.jspf"%><%-- tui calendar --%>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui calendar --%>
</html>

<script>
	var carBookCalendar;
	var stDatePicker, edDatePicker;
	var selectpicker;

	$(document).ready(async function () {

		await init();

		await $(".selectpicker").on('change',  async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'busiCd':
				case 'empCd':
				case 'carCd': await doAction('carBookCalendar','search');
			}
		});

		/**
		 * 캘린더 '월' 기준 이동 이벤트
		 * */
		document.getElementById('carBookCalendarDiv').addEventListener('click', async ev=>{
			var id = ev.target.id
			switch (id) {
				case 'prevBtn': case 'prevImg': await edsUtil.moveToNextOrPrevOrTodayRange(carBookCalendar, -1); break;
				case 'nextBtn': case 'nextImg': await  edsUtil.moveToNextOrPrevOrTodayRange(carBookCalendar, 1); break;
				case 'todayBtn': case 'todayImg': await  edsUtil.moveToNextOrPrevOrTodayRange(carBookCalendar, 0); break;
			}
		});

		/**
		 * 캘린더 기준 팝업 이벤트
		 * */
		document.getElementById('book').addEventListener('click', async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'empNm': await popupHandler('user_book','open'); break;
				case 'depaNm': await popupHandler('depa_book','open'); break;
			}
		});

	});

	/* 초기설정 */
	async function init() {

		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#searchForm"), "car");
		edsUtil.setForm(document.querySelector("#carBookCalendarForm"), "car");

		/* 조회옵션 셋팅 */
		document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
		document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
		document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';

		/* 권한에 따라 회사, 사업장 활성화 */
		var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
		if(authDivi === "03" || authDivi === "04"){
			document.getElementById('busiCd').disabled = true;
			document.getElementById('btnBusiCd').disabled = true;
		}

		/* Button 셋팅 */
		await edsUtil.setButtonForm(document.querySelector("#carBookCalendarButtonForm"));
		await edsUtil.setButtonForm(document.querySelector("#carBookModalButtonForm"));

		/*********************************************************************
		 * Calendar Info 영역 START
		 ***********************************************************************/

		/* 그리드 초기화 속성 설정 */
		carBookCalendar = new Calendar('#carBookCalendar',{
			defaultView: 'month', // 캘린더의 기본 뷰를 지정한다. 월간뷰, 주간뷰, 일간뷰를 지정할 수 있으며 각각 'month', 'week', 'day' 이다. 기본값은 'week'이다.
			useFormPopup: false, // 캘린더에서 기본으로 제공하는 일정 생성 팝업을 사용할지 여부를 지정한다. 기본값은 false이다.
			useDetailPopup: false, // 캘린더에서 기본으로 제공하는 일정 상세 팝업을 사용할지 여부를 지정한다. 기본값은 false이다.
			isReadOnly: false, // 캘린더를 읽기 전용으로 만들지 여부를 지정한다. 기본값은 false이며 true로 설정하면 사용자는 캘린더의 일정을 생성하거나 수정할 수 없다.
			usageStatistics: false, // Google Analytics(GA)를 위한 hostname 수집을 허용할지 여부를 지정한다. 기본값은 true이며 false로 설정하면 통계 수집을 하지 않는다.
			month: {
				dayNames: ['일', '월', '화', '수', '목', '금', '토'], // 이 옵션을 부여할 때는 반드시 일요일부터 월요일까지 모든 요일이 입력된 배열을 입력해야 한다.
				startDayOfWeek: 0, // 월간뷰에서 주의 시작 요일을 지정한다. 기본값은 0으로 일요일부터 시작한다. 0(일요일)부터 6(토요일)까지의 값을 지정할 수 있다.
				narrowWeekend: true, // 월간뷰에서 주말의 너비를 좁게(기존 너비의 1/2) 할 수 있다. 기본값은 false이며, 주말의 너비를 좁게 하려면 true로 지정한다.
				visibleWeeksCount: 0, // 월간뷰에서 보여지는 주의 개수를 지정한다. 기본값은 0이며 6주를 표시한다. 다른 주의 개수를 지정하려면 1부터 6까지의 값을 지정할 수 있다.
				isAlways6Weeks: false, // 월간 뷰에서 항상 6주 단위로 캘린더를 표시할지 여부를 결정한다. 기본값은 true이며 표시하고 있는 월의 전체 주 수와 관계 없이 6주를 표시한다.
				workweek: false, // 월간뷰에서 주말을 제외할 수 있다. 기본값은 false이며, 주말을 제외하려면 true로 지정한다.
				visibleEventCount: 8, // 월간뷰에서 각 날짜별 최대로 보여지는 일정의 갯수를 지정한다. 기본값은 6 이다. 높이가 충분하지 못할 경우 자동으로 옵션이 무시된다.
			},
			calendarSelection: { // 클릭과 더블 클릭이 둘 모두 가능하거나 불가능하게 만든다.
				enableDblClick: false,
				enableClick: true,
			},
			timezone: { // 브라우저가 구동되는 시스템의 타임존과 상관 없이 기본 타임존을 런던으로 설정
				zones: [
					{
						timezoneName: 'Asia/Seoul',
						displayLabel: 'Seoul',
						tooltip: 'Seoul Time',
					},
				],
			},
		});

		/**********************************************************************
		 * Calendar Info 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * DatePicker Info 영역 START
		 ***********************************************************************/

		/* 데이트픽커 초기 속성 설정 */
		stDatePicker = new DatePicker(['#stDatePickerDIV'], {
			language: 'ko', // There are two supporting types by default - 'en' and 'ko'.
			showAlways: false, // If true, the datepicker will not close until you call "close()".
			autoClose: true,// If true, Close datepicker when select date
			date: new Date(), // Date instance or Timestamp for initial date
			input: {
				element: ['#stDatePicker'],
				format: 'yyyy-MM-dd HH:mm'
			},
			type: 'date', // Type of picker - 'date', 'month', year'
			timePicker: {
				showMeridiem: false,
			},
		});

		edDatePicker = new DatePicker(['#edDatePickerDIV'], {
			language: 'ko',
			showAlways: false,
			autoClose: true,
			date: new Date(),
			input: {
				element: ['#edDatePicker'],
				format: 'yyyy-MM-dd HH:mm'
			},
			type: 'date',
			timePicker: {
				showMeridiem: false,
			},
		});

		/**********************************************************************
		 * DatePicker Info 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * grid info 영역 START
		 ***********************************************************************/

		baseGridList = new tui.Grid({
			el: document.getElementById('baseGridListDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight: 40,
			minRowHeight: 40,
			rowHeaders: ['rowNum'],
			header: {
				height: 40,
				minRowHeight: 40
			},
			columns: [],
			columnOptions: {
				resizable: true
			},
		});

		baseGridList.setColumns([
			{header: '상태', name: 'sStatus', width: 100, align: 'center', editor: {type: 'text'}, hidden: true},
			{header: '차량번호', name: 'carNo', width: 100, align: 'center', filter: 'text'},
			{header: '차량명', name: 'carNm', minWidth: 150, align: 'left', filter: 'text'},

			// hidden(숨김)
			{header: '회사코드', name: 'corpCd', width: 70, align: 'center', hidden: true},
			{header: '사업장코드', name: 'busiCd', width: 70, align: 'center', hidden: true},
			{header: '차량구분', name: 'carDivi', width: 70, align: 'center',	hidden:true },
			{header: '누적주행거리', name: 'cumuMile', width: 100, align: 'center',	hidden:true },
			{header: '보험만료일', name: 'insuExpiDt', width: 100, align: 'center',	hidden:true },
			{header: '차량코드', name: 'carCd', width: 70, align: 'center',	hidden:true },
			{header: '사업장명', name: 'busiNm', width: 70, align: 'center', hidden: true},
			{header: '유종', name: 'oilType', minWidth: 70, align: 'center', hidden: true},
			{header: '연비', name: 'fuelAmt', minWidth: 70, align: 'center', hidden: true},
			{header: '보험사구분', name: 'insuCorpDivi', minWidth: 70, align: 'center', hidden: true},
			{header: '구입일자', name: 'buyDt', minWidth: 70, align: 'center', hidden: true},
			{header: '구입유형', name: 'buyDivi', minWidth: 70, align: 'center', hidden: true},
			{header: '정기검사만료일', name: 'periInspExpiDt', minWidth: 70, align: 'center', hidden: true},
			{header: '비고', name: 'note', minWidth: 70, align: 'center', hidden: true},
		]);

		/**********************************************************************
		 * grid info Info 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * selectpicker 영역 START
		 ***********************************************************************/

		selectpicker =$('.selectpicker').select2({
			language: 'ko'
		});

		/*********************************************************************
		 * selectpicker 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Calendar 이벤트 영역 START
		 ***********************************************************************/

		/* 켈린더 일자 클릭 이벤트 */
		carBookCalendar.on('selectDateTime', async ev =>{
			await carBookCalendar.clearGridSelections();
			document.getElementById('stDatePicker').value = moment(ev.start).format('YYYY-MM-DD') + moment().format(' HH:mm');
			document.getElementById('edDatePicker').value = moment(ev.end).format('YYYY-MM-DD') + moment().format(' HH:mm');

			var stValue = moment(document.getElementById('stDatePicker').value)
			var edValue = moment(document.getElementById('edDatePicker').value)
			var hValue = Math.floor(edValue.diff(stValue, 'hours', true));
			var mValue = edValue.diff(stValue, 'minutes', true);
			if(mValue >= 10080){
				Swal.fire({
					icon: 'error',
					title: '실패',
					text: '7일을 경과했습니다.',
					footer: ''
				});
			}else{
				document.querySelector('form[id="carBookCalendarForm"] input[id="carBookCd"]').value = ''
				await doAction('carBookCalendar','inputPopup');
				await doAction('carBookCalendar','reset');
				await setUseTime();
			}
		});

		/* 켈린더 이벤트 클릭 이벤트 */
		carBookCalendar.on('clickEvent', async ev =>{
			await carBookCalendar.clearGridSelections();
			await doAction('carBookCalendar','inputPopup');
			await setCarBookDetail(ev);
		});

		/**********************************************************************
		 * Calendar 기본 세팅 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * DatePicker 이벤트 영역 START
		 ***********************************************************************/

		stDatePicker.on('change', async ev =>{
			var stValue = moment(document.getElementById('stDatePicker').value)
			var edValue = moment(document.getElementById('edDatePicker').value)
			var hValue = Math.floor(edValue.diff(stValue, 'hours', true));
			var mValue = edValue.diff(stValue, 'minutes', true);
			if(mValue >= 10080){
				await document.getElementById('btnClose').click();
				Swal.fire({
					icon: 'error',
					title: '실패',
					text: '7일을 경과했습니다.',
					footer: ''
				});
			}else{
				await setUseTime();
			}
		});

		edDatePicker.on('change', async ev =>{
			var stValue = moment(document.getElementById('stDatePicker').value)
			var edValue = moment(document.getElementById('edDatePicker').value)
			var hValue = Math.floor(edValue.diff(stValue, 'hours', true));
			var mValue = edValue.diff(stValue, 'minutes', true);
			if(mValue >= 10080){
				await document.getElementById('btnClose').click();
				Swal.fire({
					icon: 'error',
					title: '실패',
					text: '7일을 경과했습니다.',
					footer: ''
				});
			}else{
				await setUseTime();
			}
		});

		/**********************************************************************
		 * DatePicker 기본 세팅 영역 END
		 ***********************************************************************/

		/*********************************************************************
		 * grid 영역 START
		 ***********************************************************************/

		baseGridList.on('click', async ev=>{
			var rowKey = ev.rowKey;
			if(ev.targetType === 'cell'){
				document.querySelector('form[id="carBookCalendarForm"] input[id="carCd"]').value = baseGridList.getValue(rowKey,'carCd');
				document.querySelector('form[id="carBookCalendarForm"] input[id="carNm"]').value = baseGridList.getValue(rowKey,'carNo') + ' ' + baseGridList.getValue(rowKey,'carNm');
			}
		});

		/*********************************************************************
		 * grid 영역 END
		 ***********************************************************************/

		/* 캘린더 높이 셋팅 */
		// document.getElementById('carBookCalendar').style.height = (innerHeight)*(1-0.145) + 'px';
		// document.getElementById('carBookCalendarForm').style.height = (innerHeight)*(1-0.3) + 'px';

		/* grid 높이 셋팅 */
		document.getElementById('baseGridList').style.height = (innerHeight)*(1-0.3) + 'px';

		/* 현재 날짜 셋팅 */
		document.getElementById('topCalendar').innerText = moment(carBookCalendar.getDate().d.d).format('YYYY-MM');

		/* 초기 조회 셋팅 */
		await doAction('carBookCalendar','search');

		/**********************************************************************
		 * Calendar 기본 세팅 영역 END
		 ***********************************************************************/
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm === 'carBookCalendar') {
			switch (sAction) {
				case "carSearch":// 조회

					baseGridList.refreshLayout(); // 데이터 초기화
					baseGridList.finishEditing(); // 데이터 마감
					baseGridList.clear(); // 데이터 초기화

					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.corpCd = document.getElementById('corpCd').value;
						param.stDt = document.getElementById('stDatePicker').value;
						param.edDt = document.getElementById('edDatePicker').value;
						var data = edsUtil.getAjax("/BASE_CAR_MGT_LIST/selectCarMgtUseList", param);
					baseGridList.resetData(data); // 데이터 set

					if(baseGridList.getRowCount() > 0 ){
						baseGridList.focusAt(0, 0, true);
					}

					break;
				case "search":// 조회

					carBookCalendar.clearGridSelections(); // 현재 캘린더에 표시된 모든 날짜/시간 선택 엘리먼트를 제거
					carBookCalendar.clear(); // 캘린더 인스턴스에 저장된 모든 이벤트를 제거

					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.date = document.getElementById('topCalendar').innerText;
						param.carCd = document.querySelector('form[id="searchForm"] select[id="carCd"]').selectedOptions[0].value??"";
						param.empCd = document.querySelector('form[id="searchForm"] select[id="empCd"]').selectedOptions[0].value??"";

					var data = edsUtil.getAjax("/CAR_BOOK/selectCarBookList", param);
					carBookCalendar.createEvents(data);

					break;

				case "reset":// 초기화

					var condition = document.querySelector('form[id="carBookCalendarForm"] input[id="carBookCd"]').value;

					if(!condition){
						document.querySelector('form[id="carBookCalendarForm"] input[id="carBookCd"]').value = '';
					}else{

					}

					document.querySelector('form[id="carBookCalendarForm"] input[id="corpCd"]').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.querySelector('form[id="carBookCalendarForm"] input[id="busiCd"]').value = '<c:out value="${LoginInfo.busiCd}"/>';
					document.querySelector('form[id="carBookCalendarForm"] input[id="carCd"]').value = '';
					document.querySelector('form[id="carBookCalendarForm"] input[id="carNm"]').value = '';
					document.querySelector('form[id="carBookCalendarForm"] input[id="useTime"]').value = '';
					document.querySelector('form[id="carBookCalendarForm"] input[id="empCd"]').value = '<c:out value="${LoginInfo.empCd}"/>';
					document.querySelector('form[id="carBookCalendarForm"] input[id="empNm"]').value = '<c:out value="${LoginInfo.empNm}"/>';
					document.querySelector('form[id="carBookCalendarForm"] input[id="depaCd"]').value = '<c:out value="${LoginInfo.depaCd}"/>';
					document.querySelector('form[id="carBookCalendarForm"] input[id="depaNm"]').value = '<c:out value="${LoginInfo.depaNm}"/>';
					document.querySelector('form[id="carBookCalendarForm"] select[id="purpCd"]').value = '';
					document.querySelector('form[id="carBookCalendarForm"] textarea[id="note"]').value = '';

					await setUseTime();

					break;
				case "save"://저장
					var param = {};
					var condition = document.querySelector('form[id="carBookCalendarForm"] input[id="carBookCd"]').value;

					if(!condition){
						param.status = 'C';
						param.corpCd = document.querySelector('form[id="searchForm"] input[id="corpCd"]').value;
						param.busiCd = document.querySelector('form[id="searchForm"] input[id="busiCd"]').value;
					}else{
						param.status = 'U';
						param.corpCd = document.querySelector('form[id="carBookCalendarForm"] input[id="corpCd"]').value;
						param.busiCd = document.querySelector('form[id="carBookCalendarForm"] input[id="busiCd"]').value;
						param.carBookCd = condition;
					}

					param.carCd = document.querySelector('form[id="carBookCalendarForm"] input[id="carCd"]').value;
					param.stDt = document.querySelector('form[id="carBookCalendarForm"] input[id="stDatePicker"]').value;
					param.edDt = document.querySelector('form[id="carBookCalendarForm"] input[id="edDatePicker"]').value;
					param.useTime = document.querySelector('form[id="carBookCalendarForm"] input[id="useTime"]').value;
					param.empCd = document.querySelector('form[id="carBookCalendarForm"] input[id="empCd"]').value;
					param.depaCd = document.querySelector('form[id="carBookCalendarForm"] input[id="depaCd"]').value;
					param.purpCd = document.querySelector('form[id="carBookCalendarForm"] select[id="purpCd"]').value;
					param.note = document.querySelector('form[id="carBookCalendarForm"] textarea[id="note"]').value;

					/**
					 * 캘린더 inputModal Form 기준 validation 체크
					 * */
					var ajaxCondition = await edsUtil.checkValidationForForm('carBookCalendarForm',['carNm','stDatePicker','edDatePicker','empNm','depaNm','purpCd']);
					if(!ajaxCondition) { // 저장
						await edsUtil.postAjax('/CAR_BOOK/cudCarBookList', carBookCalendar, param);
						await document.getElementById('btnClose').click();
					}else{ // 미저장

					}

					break;
				case "delete"://삭제

					var param = {};
					param.status = 'D';
					param.corpCd = document.querySelector('form[id="carBookCalendarForm"] input[id="corpCd"]').value;
					param.busiCd = document.querySelector('form[id="carBookCalendarForm"] input[id="busiCd"]').value;
					param.carBookCd = document.querySelector('form[id="carBookCalendarForm"] input[id="carBookCd"]').value;

					await edsUtil.postAjax('/CAR_BOOK/cudCarBookList', carBookCalendar, param);
					await document.getElementById('btnClose').click();

					break;
				case "inputPopup":// 입력 팝업 보기

					document.getElementById('btnInputPopEv').click();

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

	// 사업장 팝업
	function fn_busiPopup(){
		var param = {
			corpCd: $("#searchForm #corpCd").val(),
			busiCd: document.getElementById('busiCd').value
		};
		edsPopup.util.openPopup(
				"BUSIPOPUP",
				param,
				function (value) {
					this.returnValue = value||this.returnValue;
					if(this.returnValue){
						document.getElementById('busiCd').value = this.returnValue.busiCd;
						document.getElementById('busiNm').value = this.returnValue.busiNm;
					}
				},
				false,
				true
		);
	}

	async function popupHandler(name,divi,callback){
		var names = name.split('_');
		switch (names[0]) {
			case 'user': // 사원팝업
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
					param.name= name;
					await edsIframe.openPopup('USERPOPUP',param)
				}else{
					document.querySelector('form[id="carBookCalendarForm"] input[id="empCd"]').value = callback.empCd??'';
					document.querySelector('form[id="carBookCalendarForm"] input[id="empNm"]').value = callback.empNm??'';
				}
				break;
			case 'depa': // 부서팝업
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
					param.depaNm= '';
					param.name= name;
					await edsIframe.openPopup('DEPAPOPUP',param)
				}else{
					document.querySelector('form[id="carBookCalendarForm"] input[id="depaCd"]').value = callback.depaCd??'';
					document.querySelector('form[id="carBookCalendarForm"] input[id="depaNm"]').value = callback.depaNm??'';
				}	
				break;
			case 'busi':
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.name= name;
					await edsIframe.openPopup('BUSIPOPUP',param)
				}else{
					document.getElementById('busiCd').value=callback.busiCd;
					document.getElementById('busiNm').value=callback.busiNm;

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

	async function setCarBookDetail(ev){

		var param = {}; //조회조건
		param.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
		param.date = document.getElementById('topCalendar').innerText;
		param.carBookCd = ev.event.id;

		var data = edsUtil.getAjax("/CAR_BOOK/selectCarBookList", param);

		document.querySelector('form[id="carBookCalendarForm"] input[id="corpCd"]').value = data[0].corpCd;
		document.querySelector('form[id="carBookCalendarForm"] input[id="busiCd"]').value = data[0].busiCd;
		document.querySelector('form[id="carBookCalendarForm"] input[id="carBookCd"]').value = data[0].carBookCd;
		document.querySelector('form[id="carBookCalendarForm"] input[id="carCd"]').value = data[0].carCd;
		document.querySelector('form[id="carBookCalendarForm"] input[id="carNm"]').value = data[0].carNm;
		document.querySelector('form[id="carBookCalendarForm"] input[id="stDatePicker"]').value = data[0].stDt;
		document.querySelector('form[id="carBookCalendarForm"] input[id="edDatePicker"]').value = data[0].edDt;
		document.querySelector('form[id="carBookCalendarForm"] input[id="useTime"]').value = data[0].useTime;
		document.querySelector('form[id="carBookCalendarForm"] input[id="empCd"]').value = data[0].empCd;
		document.querySelector('form[id="carBookCalendarForm"] input[id="empNm"]').value = data[0].empNm;
		document.querySelector('form[id="carBookCalendarForm"] input[id="depaCd"]').value = data[0].depaCd;
		document.querySelector('form[id="carBookCalendarForm"] input[id="depaNm"]').value = data[0].depaNm;
		document.querySelector('form[id="carBookCalendarForm"] select[id="purpCd"]').value = data[0].purpCd;
		document.querySelector('form[id="carBookCalendarForm"] textarea[id="note"]').value = data[0].note;

	}

	async function setUseTime(){
		var stValue = moment(document.getElementById('stDatePicker').value)
		var edValue = moment(document.getElementById('edDatePicker').value)
		var hValue = Math.floor(edValue.diff(stValue, 'hours', true));
		var mValue = edValue.diff(stValue, 'minutes', true)%60;
		var useTime = hValue + ' : ' + mValue;
		document.getElementById('useTime').value = useTime;
		setTimeout(async ev=>{
			await doAction('carBookCalendar','carSearch')
		},300);
	}

	/**********************************************************************
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>