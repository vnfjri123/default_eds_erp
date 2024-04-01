<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</head>

<body>
<div class="row" style="position:relative">
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<!-- ./input hidden -->
				<%--<div class="form-group">
					<label for="busiCd">사업장 &nbsp;</label>
					<div class="input-group-prepend">
						<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
					</div>
					<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>
					<div class="input-group-append">
						<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
					</div>
				</div>--%>
				<div class="form-group">
					<label for="stDt">조회기간 &nbsp;</label>
					<div class="input-group-prepend">
						<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="stDt" id="stDt" title="끝">
					</div>
					<span>&nbsp;~&nbsp;</span>
					<div class="input-group-append">
						<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="edDt" id="edDt" title="끝">
					</div>
				</div>
				<div class="col text-left">
					<button type="button" class="btn btn-sm btn-primary" name="btnSearch"			id="btnSearch"				onclick="doAction('carLogList', 'search')"><i class="fa fa-search"></i> 조회</button>
					<button type="button" class="btn btn-sm btn-primary" name="btnInput"			id="btnInput"				onclick="doAction('carLogList', 'input')" ><i class="fa fa-plus"></i> 신규</button>

					<button type="button" class="invisible" 			 name="btnInputPopEv"		id="btnInputPopEv"			data-toggle="modal" data-target="#modalCart"></button>
				</div>
			</form>
			<form class="form-inline" role="form" name="carLogListButtonForm" id="carLogListButtonForm" method="post" onsubmit="return false;">
				<div class="container">
					<div class="row">
					</div>
				</div>
			</form>
			<!-- ./form -->
		</div>
	</div>
	<!-- 그리드 영역 -->
	<div class="col-md-12" id="carLogList" style="height: calc(100vh - 6rem); width: 100%;">
		<!-- 시트가 될 DIV 객체 -->
		<div id="carLogListDIV" style="width:100%; height:100%;"></div>
	</div>
</div>
<div class="modal fade p-0" id="modalCart" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header bg-dark font-color" name="tabs" id="tabs" style="color: #4d4a41">
				<h4 class="modal-title">상세 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="col-md-12" style="height: 100%;" id="log">
					<form name="carLogListForm" id="carLogListForm">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
						<input type="hidden" name="carLogCd" id="carLogCd" title="운행일지코드">
						<div class="form-row">
							<div class="col-md-3 mb-3">
								<label for="carNm"><b>차량</b></label>
								<input type="hidden" name="carCd" id="carCd" title="차량코드">
								<input type="text" class="form-control text-center" id="carNm" name="carNm" placeholder="차량명" title="차량명" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3">
								<label for="empNm"><b>운전자</b></label>
								<input type="hidden" name="empCd" id="empCd" title="운전자">
								<input type="text" class="form-control text-center" id="empNm" name="empNm" placeholder="운전자" title="운전자" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3">
								<label for="depaNm"><b>부서</b></label>
								<input type="hidden" name="depaCd" id="depaCd" title="부서">
								<input type="text" class="form-control text-center" id="depaNm" name="depaNm" placeholder="부서" title="부서" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3">
								<label for="purpCd"><b>업무목적</b></label>
								<select class="form-control text-center" name="purpCd" id="purpCd" title="업무목적"></select>
							</div>
						</div>
						<div class="form-row" id="useDist">
							<div class="col-md-2 mb-3" style="z-index: 2000">
								<label for="stDatePicker"><b>시작 일시</b></label>
								<input type="text" class="form-control text-center" id="stDatePicker" aria-label="Date-Time" placeholder="시작일시" title="시작일시" readonly="readonly">
								<div id="stDatePickerDIV" style="margin-top: -1px;"></div>
							</div>
							<div class="col-md-2 mb-3" style="z-index: 2000">
								<label for="edDatePicker"><b>종료 일시</b></label>
								<input type="text" class="form-control text-center" id="edDatePicker" aria-label="Date-Time" placeholder="끝일시" title="끝일시" readonly="readonly">
								<div id="edDatePickerDIV" style="margin-top: -1px;"></div>
							</div>
							<div class="col-md-3 mb-3">
								<label for="stDist"><b>시작 거리 (Km)</b></label>
								<input type="text" class="form-control text-center" id="stDist" name="stDist" placeholder="시작 거리" title="시작 거리" oninput="edsUtil.formatNumberHtmlInputForInteger(this)">
							</div>
							<div class="col-md-2 mb-3">
								<label for="mdDist"><b>사용 거리 (Km)</b></label>
								<input type="text" class="form-control text-center" id="mdDist" name="mdDist" placeholder="사용 거리" title="사용 거리" oninput="edsUtil.formatNumberHtmlInputForInteger(this)">
							</div>
							<div class="col-md-3 mb-3">
								<label for="edDist"><b>도착 거리 (Km)</b></label>
								<input type="text" class="form-control text-center" id="edDist" name="edDist" placeholder="도착 거리" title="도착 거리" oninput="edsUtil.formatNumberHtmlInputForInteger(this)">
							</div>
							<div class="col-md-3 mb-3" style="display: none">
								<label for="stLoca"><b>시작 장소</b></label>
								<input type="text" class="form-control text-center" id="stLoca" name="stLoca" placeholder="시작 장소" title="시작 장소" readonly="readonly">
							</div>
							<div class="col-md-3 mb-3" style="display: none">
								<label for="edLoca"><b>종료 장소</b></label>
								<input type="text" class="form-control text-center" id="edLoca" name="edLoca" placeholder="종료 장소" title="종료 장소" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-12 mb-3">
								<label for="note"><b>메모</b></label>
								<textarea type="text" rows="16" class="form-control" id="note" name="note" placeholder="메모" value=""></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="carLogModalButtonForm" id="carLogModalButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnReset"	id="btnReset"	onclick="doAction('carLogList', 'reset')"><i class="fa fa-trash"></i> 초기화</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnSave"		id="btnSave"	onclick="doAction('carLogList', 'save')"><i class="fa fa-save"></i> 저장</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete"	id="btnDelete"	onclick="doAction('carLogList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose"	id="btnClose"	onclick="doAction('carLogList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
</html>
<script>
	var carLogList;
	var stDatePicker, edDatePicker;

	$(document).ready(function () {
		init();

		document.getElementById('searchForm').addEventListener('change', async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'busiCd':
				case 'empCd':
				case 'carCd': await doAction('carLogList','search'); break;
			}
		});

		document.getElementById('useDist').addEventListener('change', async ev=>{
			var id = ev.target.id;
			var targetData = ev.target.value;
			if(id ==='stDist'||id ==='mdDist'||id ==='edDist'){
				var stDist = document.getElementById('stDist').value
				var mdDist = document.getElementById('mdDist').value
				var edDist = document.getElementById('edDist').value

				targetData = Number(targetData.replace(/,/g, ''));
				stDist = Number(stDist.replace(/,/g, ''));
				edDist = Number(edDist.replace(/,/g, ''));

				switch (id) {
					case 'stDist': document.getElementById('mdDist').value = edsUtil.addComma(edDist - targetData); break;
					case 'mdDist': document.getElementById('edDist').value = edsUtil.addComma(stDist + targetData); break;
					case 'edDist': document.getElementById('mdDist').value = edsUtil.addComma(targetData - stDist); break;
				}
			}
		});

		document.getElementById('carLogListDIV').addEventListener('click',ev=>{
			var id = ev.target.id
			switch (id) {
				case 'prevBtn': case 'prevImg': edsUtil.moveToNextOrPrevOrTodayRange(carLogList, -1); break;
				case 'nextBtn': case 'nextImg': edsUtil.moveToNextOrPrevOrTodayRange(carLogList, 1); break;
				case 'todayBtn': case 'todayImg': edsUtil.moveToNextOrPrevOrTodayRange(carLogList, 0); break;
			}
		});

		document.getElementById('log').addEventListener('click', async ev=>{
			var id = ev.target.id;
			switch (id) {
				case 'carNm': await popupHandler('car_book','open'); break;
				case 'empNm': await popupHandler('user_book','open'); break;
				case 'depaNm': await popupHandler('depa_book','open'); break;
				case 'stLoca':
				case 'edLoca':
					edsUtil.showMapPopup2Modal(id,'modalCart');
					break;
			}
		});
	});

	/* 초기설정 */
	async function init() {

		class detailButtonRenderer {
			constructor(props) {
				const el = document.createElement('button');
				const text = document.createTextNode('수정하기');

				el.appendChild(text);
				el.setAttribute("class","btn btn-sm btn-primary");
				el.setAttribute("style","width: 78%;" +
						"padding: 0.12rem 0.5rem;");

				el.addEventListener('click', async (ev) => {

					var row = carLogList.getFocusedCell();
					var carLogCd = carLogList.getValue(row.rowKey,'carLogCd');
					if(carLogCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '내역이 없습니다.',
						});
					}else{
						await doAction('carLogList','inputPopup');
						await doAction('carLogList','reset');

						document.querySelector('form[id="carLogListForm"] input[id="corpCd"]').value = carLogList.getValue(row.rowKey, 'corpCd');
						document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value = carLogList.getValue(row.rowKey, 'carLogCd');
						document.querySelector('form[id="carLogListForm"] input[id="carCd"]').value = carLogList.getValue(row.rowKey, 'carCd');
						document.querySelector('form[id="carLogListForm"] input[id="carNm"]').value = carLogList.getValue(row.rowKey, 'carNm');
						document.querySelector('form[id="carLogListForm"] input[id="empCd"]').value = carLogList.getValue(row.rowKey, 'empCd');
						document.querySelector('form[id="carLogListForm"] input[id="empNm"]').value = carLogList.getValue(row.rowKey, 'empNm');
						document.querySelector('form[id="carLogListForm"] input[id="depaCd"]').value = carLogList.getValue(row.rowKey, 'depaCd');
						document.querySelector('form[id="carLogListForm"] input[id="depaNm"]').value = carLogList.getValue(row.rowKey, 'depaNm');
						document.querySelector('form[id="carLogListForm"] input[id="stDatePicker"]').value = carLogList.getValue(row.rowKey, 'stDt');
						document.querySelector('form[id="carLogListForm"] input[id="edDatePicker"]').value = carLogList.getValue(row.rowKey, 'edDt');
						document.querySelector('form[id="carLogListForm"] input[id="stLoca"]').value = carLogList.getValue(row.rowKey, 'stLoca');
						document.querySelector('form[id="carLogListForm"] input[id="edLoca"]').value = carLogList.getValue(row.rowKey, 'edLoca');
						document.querySelector('form[id="carLogListForm"] input[id="stDist"]').value = carLogList.getValue(row.rowKey, 'stDist');
						document.querySelector('form[id="carLogListForm"] input[id="mdDist"]').value = carLogList.getValue(row.rowKey, 'mdDist');
						document.querySelector('form[id="carLogListForm"] input[id="edDist"]').value = carLogList.getValue(row.rowKey, 'edDist');
						document.querySelector('form[id="carLogListForm"] select[id="purpCd"]').value = carLogList.getValue(row.rowKey, 'purpCd');
						document.querySelector('form[id="carLogListForm"] textarea[id="note"]').value = carLogList.getValue(row.rowKey, 'note');
					}
				});

				this.el = el;
				this.render(props);
			}

			getElement() {
				return this.el;
			}

			render(props) {
				this.el.value = String(props.value);
			}
		}

		/* Form 셋팅 */
		edsUtil.setForm(document.querySelector("#searchForm"), "car");
		edsUtil.setForm(document.querySelector("#carLogListForm"), "car");

		/* 조회옵션 셋팅 */
		document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';

		/* 권한에 따라 회사, 사업장 활성화 */
		var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
		if(authDivi === "03" || authDivi === "04"){
			document.getElementById('busiCd').disabled = true;
			document.getElementById('btnBusiCd').disabled = true;
		}

		/* Button 셋팅 */
		await edsUtil.setButtonForm(document.querySelector("#searchForm"));
		await edsUtil.setButtonForm(document.querySelector("#carLogModalButtonForm"));

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
		 * Grid Info 영역 START
		 ***********************************************************************/

		/* 그리드 초기화 속성 설정 */
		carLogList = new tui.Grid({
			el: document.getElementById('carLogListDIV'),
			scrollX: true,
			scrollY: true,
			editingEvent: 'click',
			bodyHeight: 'fitToParent',
			rowHeight:40,
			minRowHeight:40,
			rowHeaders: ['rowNum', /*'checkbox'*/],
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
		});

		carLogList.setColumns([
			{ header:'시작일시',			name:'stDt',		width:130,		align:'center',	defaultValue: '',sortable:true},
			{ header:'종료일시',			name:'edDt',		width:130,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'운행목적',		name:'purpCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	editor:{type:'select',options: {listItems:setCommCode("COM040")}},	formatter: 'listItemText'},
			{ header:'차량명',		name:'carNm',		width:150,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'시작거리',		name:'stDist',		width:100,		align:'right',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'중간거리',		name:'mdDist',		width:100,		align:'right',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'도착거리',		name:'edDist',		width:100,		align:'right',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'운전자',		name:'empNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'부서',			name:'depaNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},
			{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: '',	filter: { type: 'text'}},

			// hidden(숨김)
			{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'운행일지코드',	name:'carLogCd',	width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'차량코드',		name:'carCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'담당자코드',	name:'empCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'상세등록',		name:'detail',		width:80,		align:'center', renderer: {type: detailButtonRenderer},	hidden:true},
			{ header:'위치',			name:'stLoca',		width:200,		align:'left',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
			{ header:'위치',			name:'edLoca',		width:200,		align:'left',	defaultValue: '',	filter: { type: 'text'},	hidden:true },
		]);

		/**********************************************************************
		 * Grid Info 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * DatePicker 이벤트 영역 START
		 ***********************************************************************/

		stDatePicker.on('change', async ev =>{

		});

		edDatePicker.on('change', async ev =>{

		});

		/**********************************************************************
		 * DatePicker 기본 세팅 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * Grid 이벤트 영역 START
		 ***********************************************************************/
		carLogList.disableColumn('purpCd');

		/*필터 이후 포커스*/
		carLogList.on('afterFilter', async ev => {
			if(ev.instance.store.data.filteredIndex.length>0){
				carLogList.focusAt(0,0,true)
			}
		});

		carLogList.on('focusChange', async ev => {
			if(ev.rowKey !== ev.prevRowKey){
				if (edsUtil.getAuth("Save") === "1") {// 수정권한 체크
					if (carLogList.getValue(ev.rowKey, "deadDivi") === '1') {
						document.getElementById('btnSave').disabled = true;
						document.getElementById('btnDelete').disabled = true;
					} else {
						document.getElementById('btnSave').disabled = false;
						document.getElementById('btnDelete').disabled = false;
					}

					// 메인 시트 마감 처리 : 다른 시트 rawData값 못불러와서 서브 시트는 따로 처리
					await edsUtil.setClosedRow(carLogList)
				}
			}
		});

		/* 더블클릭 시, 상세목록 */
		carLogList.on('dblclick', async ev => {
			if(ev.targetType === 'cell'){
				await doAction('carLogList','setPopup');
			}
		});

		/**********************************************************************
		 * Grid 이벤트 영역 END
		 ***********************************************************************/

		/* 그리드생성 */
		// document.getElementById('carLogList').style.height = (innerHeight)*(1-0.11) + 'px';

		/* 초기 조회 셋팅 */
		await doAction('carLogList','search');
	}

	/**********************************************************************
	 * 화면 이벤트 영역 START
	 ***********************************************************************/

	/* 화면 이벤트 */
	async function doAction(sheetNm, sAction) {
		if (sheetNm == 'carLogList') {
			switch (sAction) {
				case "search":// 조회

					carLogList.finishEditing(); // 데이터 초기화
					carLogList.clear(); // 데이터 초기화
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					carLogList.resetData(edsUtil.getAjax("/CAR_LOG/selectCarLogList", param)); // 데이터 set

					if(carLogList.getRowCount() > 0 ){
						carLogList.focusAt(0, 0, true);
					}
					break;

				case "reset":// 초기화

					var condition = document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value;

					if(!condition){
						document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value = '';
					}else{

					}

					document.querySelector('form[id="carLogListForm"] input[id="corpCd"]').value = '<c:out value="${LoginInfo.corpCd}"/>';
					document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value = '';
					document.querySelector('form[id="carLogListForm"] input[id="carCd"]').value = '';
					document.querySelector('form[id="carLogListForm"] input[id="carNm"]').value = '';
					document.querySelector('form[id="carLogListForm"] input[id="empCd"]').value = '<c:out value="${LoginInfo.empCd}"/>';
					document.querySelector('form[id="carLogListForm"] input[id="empNm"]').value = '<c:out value="${LoginInfo.empNm}"/>';
					document.querySelector('form[id="carLogListForm"] input[id="depaCd"]').value = '<c:out value="${LoginInfo.depaCd}"/>';
					document.querySelector('form[id="carLogListForm"] input[id="depaNm"]').value = '<c:out value="${LoginInfo.depaNm}"/>';
					document.querySelector('form[id="carLogListForm"] input[id="stDatePicker"]').value = moment().format('YYYY-MM-DD HH:mm');
					document.querySelector('form[id="carLogListForm"] input[id="edDatePicker"]').value = moment().format('YYYY-MM-DD HH:mm');
					document.querySelector('form[id="carLogListForm"] input[id="stLoca"]').value = '';
					document.querySelector('form[id="carLogListForm"] input[id="edLoca"]').value = '';
					document.querySelector('form[id="carLogListForm"] input[id="stDist"]').value = 0;
					document.querySelector('form[id="carLogListForm"] input[id="mdDist"]').value = 0;
					document.querySelector('form[id="carLogListForm"] input[id="edDist"]').value = 0;
					document.querySelector('form[id="carLogListForm"] select[id="purpCd"]').value = '';
					document.querySelector('form[id="carLogListForm"] textarea[id="note"]').value = '';

					break;
				case "input":// 신규

					await doAction('carLogList','inputPopup');
					await doAction('carLogList','reset');

					break;
				case "save"://저장
					var param = {};
					var condition = document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value;

					if(!condition){
						param.status = 'C';
						param.corpCd = document.querySelector('form[id="searchForm"] input[id="corpCd"]').value;
					}else{
						param.status = 'U';
						param.corpCd = document.querySelector('form[id="carLogListForm"] input[id="corpCd"]').value;
						param.carLogCd = condition;
					}

					param.carCd = document.querySelector('form[id="carLogListForm"] input[id="carCd"]').value;
					param.carNm = document.querySelector('form[id="carLogListForm"] input[id="carNm"]').value;
					param.empCd = document.querySelector('form[id="carLogListForm"] input[id="empCd"]').value;
					param.empNm = document.querySelector('form[id="carLogListForm"] input[id="empNm"]').value;
					param.depaCd = document.querySelector('form[id="carLogListForm"] input[id="depaCd"]').value;
					param.depaNm = document.querySelector('form[id="carLogListForm"] input[id="depaNm"]').value;
					param.stDt = document.querySelector('form[id="carLogListForm"] input[id="stDatePicker"]').value;
					param.edDt = document.querySelector('form[id="carLogListForm"] input[id="edDatePicker"]').value;
					param.stLoca = document.querySelector('form[id="carLogListForm"] input[id="stLoca"]').value;
					param.edLoca = document.querySelector('form[id="carLogListForm"] input[id="edLoca"]').value;
					param.stDist = document.querySelector('form[id="carLogListForm"] input[id="stDist"]').value;
					param.mdDist = document.querySelector('form[id="carLogListForm"] input[id="mdDist"]').value;
					param.edDist = document.querySelector('form[id="carLogListForm"] input[id="edDist"]').value;
					param.purpCd = document.querySelector('form[id="carLogListForm"] select[id="purpCd"]').value;
					param.note = document.querySelector('form[id="carLogListForm"] textarea[id="note"]').value;

					/**
					 * 그리드 inputModal Form 기준 validation 체크
					 * */
					var ajaxCondition = await edsUtil.checkValidationForForm('carLogListForm',['carNm','empNm','depaNm','purpCd','stDatePicker','edDatePicker'/*,'stLoca','edLoca'*/,'stDist','mdDist','edDist']);
					if(!ajaxCondition) { // 저장
						await edsUtil.postAjax('/CAR_LOG/cudCarLogList', carLogList, param);
						await document.getElementById('btnClose').click();
					}else{ // 미저장

					}

					break;
				case "delete"://삭제

					var param = {};
					param.status = 'D';
					param.corpCd = document.querySelector('form[id="carLogListForm"] input[id="corpCd"]').value;
					param.carLogCd = document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value;

					await edsUtil.postAjax('/CAR_LOG/cudCarLogList', carLogList, param);
					await document.getElementById('btnClose').click();

					break;
				case "inputPopup":// 입력 팝업 보기

					document.getElementById('btnInputPopEv').click();

					break;
				case "setPopup":// 입력 팝업 보기

					var row = carLogList.getFocusedCell();
					var carLogCd = carLogList.getValue(row.rowKey,'carLogCd');
					await doAction('carLogList','inputPopup');
					await doAction('carLogList','reset');

					document.querySelector('form[id="carLogListForm"] input[id="corpCd"]').value = carLogList.getValue(row.rowKey, 'corpCd');
					document.querySelector('form[id="carLogListForm"] input[id="carLogCd"]').value = carLogList.getValue(row.rowKey, 'carLogCd');
					document.querySelector('form[id="carLogListForm"] input[id="carCd"]').value = carLogList.getValue(row.rowKey, 'carCd');
					document.querySelector('form[id="carLogListForm"] input[id="carNm"]').value = carLogList.getValue(row.rowKey, 'carNm');
					document.querySelector('form[id="carLogListForm"] input[id="empCd"]').value = carLogList.getValue(row.rowKey, 'empCd');
					document.querySelector('form[id="carLogListForm"] input[id="empNm"]').value = carLogList.getValue(row.rowKey, 'empNm');
					document.querySelector('form[id="carLogListForm"] input[id="depaCd"]').value = carLogList.getValue(row.rowKey, 'depaCd');
					document.querySelector('form[id="carLogListForm"] input[id="depaNm"]').value = carLogList.getValue(row.rowKey, 'depaNm');
					document.querySelector('form[id="carLogListForm"] input[id="stDatePicker"]').value = carLogList.getValue(row.rowKey, 'stDt');
					document.querySelector('form[id="carLogListForm"] input[id="edDatePicker"]').value = carLogList.getValue(row.rowKey, 'edDt');
					document.querySelector('form[id="carLogListForm"] input[id="stLoca"]').value = carLogList.getValue(row.rowKey, 'stLoca');
					document.querySelector('form[id="carLogListForm"] input[id="edLoca"]').value = carLogList.getValue(row.rowKey, 'edLoca');
					document.querySelector('form[id="carLogListForm"] input[id="stDist"]').value = carLogList.getValue(row.rowKey, 'stDist');
					document.querySelector('form[id="carLogListForm"] input[id="mdDist"]').value = carLogList.getValue(row.rowKey, 'mdDist');
					document.querySelector('form[id="carLogListForm"] input[id="edDist"]').value = carLogList.getValue(row.rowKey, 'edDist');
					document.querySelector('form[id="carLogListForm"] select[id="purpCd"]').value = carLogList.getValue(row.rowKey, 'purpCd');
					document.querySelector('form[id="carLogListForm"] textarea[id="note"]').value = carLogList.getValue(row.rowKey, 'note');

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

	async function popupHandler(name,divi,callback){
		var row = carLogList.getFocusedCell();
		var names = name.split('_');
		switch (names[0]) {
			case 'car': // 사용가능차량팝업
				if(divi==='open'){
					var param={}
					param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
					param.carNm= '';
					param.name= name;
					await edsIframe.openPopup('CARPOPUP',param);
				}else{
					document.querySelector('form[id="carLogListForm"] input[id="carCd"]').value = callback.carCd??'';
					document.querySelector('form[id="carLogListForm"] input[id="carNm"]').value = callback.carNm??'';
					document.querySelector('form[id="carLogListForm"] input[id="stDist"]').value = callback.sumCumuMile??'0';
					document.querySelector('form[id="carLogListForm"] input[id="edDist"]').value = callback.sumCumuMile??'0';
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
					document.querySelector('form[id="carLogListForm"] input[id="empCd"]').value = callback.empCd??'';
					document.querySelector('form[id="carLogListForm"] input[id="empNm"]').value = callback.empNm??'';
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
					document.querySelector('form[id="carLogListForm"] input[id="depaCd"]').value = callback.depaCd??'';
					document.querySelector('form[id="carLogListForm"] input[id="depaNm"]').value = callback.depaNm??'';
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
	 * 화면 함수 영역 END
	 ***********************************************************************/
</script>