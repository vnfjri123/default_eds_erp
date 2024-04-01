<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>

	<script>
		var baseGridList;
		$(document).ready(function () {

			init();

			//	이벤트
			$('#empState, #searchForm #carNm').on('change', function(e) {
				doAction("baseGridList", "search");
			});
		});

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */

			/* 조회옵션 셋팅 */
			await edsIframe.setParams();

			/**********************************************************************
			 * Grid Info 영역 START
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
				}
			});

			baseGridList.setColumns([
				{header: '상태', name: 'sStatus', width: 100, align: 'center', editor: {type: 'text'}, hidden: true},
				{
					header: '차량구분',
					name: 'carDivi',
					width: 100,
					align: 'center',
					editor: {type: 'select', options: {listItems: setCommCode("COM001")}},
					formatter: 'listItemText',
					filter: 'text'
				},
				{header: '차량번호', name: 'carNo', width: 100, align: 'center', filter: 'text'},
				{header: '차량명', name: 'carNm', minWidth: 150, align: 'left', filter: 'text'},
				{header: '누적주행거리', name: 'cumuMile', width: 100, align: 'center', filter: 'text'},
				{header: '보험만료일', name: 'insuExpiDt', width: 100, align: 'center', filter: 'text'},

				// hidden(숨김)
				{header: '회사코드', name: 'corpCd', width: 70, align: 'center', hidden: true},
				{header: '사업장코드', name: 'busiCd', width: 70, align: 'center', hidden: true},
				{header: '차량코드', name: 'carCd', width: 70, align: 'center'/*,	hidden:true */},
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
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseGridList.disableColumn('carDivi');

			baseGridList.on('dblclick', async ev => {
				await doAction("baseGridList", "apply");
			});

			baseGridList.on('keydown', async ev => {
				if (ev.keyboardEvent.keyCode == "13") {
					await doAction("baseGridList", "apply");
				}
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('baseGridList').style.height = height + 'px';

			/* 조회 */
			await doAction("baseGridList", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseGridList') {
				switch (sAction) {
					case "search":// 조회

						baseGridList.refreshLayout(); // 데이터 초기화
						baseGridList.finishEditing(); // 데이터 마감
						baseGridList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_CAR_MGT_LIST/selectCarMgtUseList", param)); // 데이터 set

						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;
					case "apply"://선택

						var row = baseGridList.getFocusedCell();
						var param = {};
						param.carCd = baseGridList.getValue(row.rowKey, "carCd");
						param.carNm = baseGridList.getValue(row.rowKey, "carNo")+' - '+baseGridList.getValue(row.rowKey, "carNm");
						param.name = document.getElementById('name').value;

						await edsIframe.closePopup(param);

						break;
					case "close":	// 닫기

						var param = {};
						param.name = document.getElementById('name').value;

						await edsIframe.closePopup(param);

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
		async function fn_busiPopup(){
			var param = {
				corpCd: $("#baseGridListForm #corpCd").val(),
				busiCd: ''
			};
			edsPopup.util.openPopup(
					"BUSIPOPUP",
					param,
					function (value) {
						var row = baseGridList.getFocusedCell();
						this.returnValue = value||this.returnValue;
						if(this.returnValue){
							baseGridList.setValue(row.rowKey, 'busiCd', this.returnValue.busiCd);
							baseGridList.setValue(row.rowKey, 'busiNm', this.returnValue.busiNm);
							// document.getElementById('busiCd').value = this.returnValue.busiCd;
							// document.getElementById('busiNm').value = this.returnValue.busiNm;
						}
					},
					false,
					true
			);
		}

		/**********************************************************************
		 * 화면 팝업 이벤트 영역 END
		 ***********************************************************************/

		/**********************************************************************
		 * 화면 함수 영역 START
		 ***********************************************************************/

		async function popupHandler(name,divi,callback){
			var row = baseGridList.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'busi':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiNm= baseGridList.getValue(row.rowKey, 'busiNm');
						param.name= name;
						await edsIframe.openPopup('BUSIPOPUP',param)
					}else{
						baseGridList.setValue(row.rowKey,'busiCd',callback.busiCd);
						baseGridList.setValue(row.rowKey,'busiNm',callback.busiNm);
					}
					break;
			}
		}

		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>
<div class="row">
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="name" id="name" title="구분값">
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<input type="hidden" name="stDt" id="stDt" title="시작일시">
				<input type="hidden" name="edDt" id="edDt" title="종료일시">

				<!-- ./input hidden -->
				<div class="form-group">
					<label for="empState">차량구분 &nbsp;</label>
					<div class="input-group input-group-sm">
						<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="empState" id="empState" title="재직상태"></select>
					</div>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<label for="carNm">차량명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="carNm" id="carNm" title="차량명">
					</div>
				</div>
			</form>
			<!-- ./form -->
		</div>
	</div>
	<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
		<div class="float-left" style="padding: 5px 0 0 5px">
			<i class="fa fa-file-text-o"></i> 차량목록
		</div>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
			<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('baseGridList', 'apply')"><i class="fa fa-save"></i> 선택</button>
			<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('baseGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
		</div>
	</div>
	<div class="col-md-12">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="baseGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>
</body>
<%--<script type="text/javascript" src='/dropzone/min/dropzoneInit.js'></script>--%>
</html>