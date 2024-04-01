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

	<script>
		var BASMA8000Sheet;
		$(document).ready(function () {
			init();

			//	이벤트
			$('form input').on('keydown', function(e) {
				if (e.which == 13) {
					doAction("BASMA8000Sheet", "search");
				}
			});
		});

		/* 초기설정 */
		function init() {

			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value =  edsUtil.getParameter('corpCd');	// 회사 코드
			document.getElementById('busiCd').value =  edsUtil.getParameter('busiCd');	// 사업장 코드
			document.getElementById('storCd').value =  edsUtil.getParameter('storCd');	// 창고 코드

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			BASMA8000Sheet = new tui.Grid({
				el: document.getElementById('BASMA8000SheetDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum'],
				header: {
					height: 40,
					minRowHeight: 40
				},
				columns:[],
				columnOptions: {
					resizable: true
				}
			});

			BASMA8000Sheet.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'창고구분',		name:'storDivi',	minWidth:100,	align:'Center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("COM008")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header:'창고코드',		name:'storCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'창고명',		name:'storNm',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			BASMA8000Sheet.disableColumn("storDivi");

			BASMA8000Sheet.on('dblclick', ev => {
				doAction("BASMA8000Sheet", "apply");
			});

			BASMA8000Sheet.on('keydown', ev => {
				if(ev.keyboardEvent.keyCode == "13"){
					doAction("BASMA8000Sheet", "apply");
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('BASMA8000').style.height = height + 'px';

			/* 조회 */
			doAction("BASMA8000Sheet", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		function doAction(sheetNm, sAction) {
			if (sheetNm == 'BASMA8000Sheet') {
				switch (sAction) {
					case "search":// 조회

						BASMA8000Sheet.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						BASMA8000Sheet.resetData(edsUtil.getAjax("/eds/erp/basma/selectBASMA8002", param)); // 데이터 set

						if(BASMA8000Sheet.getRowCount() > 0 ){
							BASMA8000Sheet.focusAt(0, 0, true);
						}

						break;
					case "apply"://선택

						var row = BASMA8000Sheet.getFocusedCell();
						var param = {};
						param.storCd = BASMA8000Sheet.getValue(row.rowKey, "storCd");
						param.storNm = BASMA8000Sheet.getValue(row.rowKey, "storNm");

						edsPopup.util.edsClosePopup(param);

						break;
					case "close":	// 닫기
						edsPopup.util.edsClosePopup();
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

		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>

<div class="row">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post"  onsubmit="return false;">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd">
						<input type="hidden" name="busiCd" id="busiCd">
						<!-- ./input hidden -->
						<div class="form-group" style="margin-left: 20px"></div>
						<div class="form-group">
							<label for="storCd">창고정보 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="storCd" id="storCd" title="창고코드">
							</div>
						</div>
					</form>
					 <!-- ./form -->
				</div>
			</div>
		</div>

		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 창고 목록
				</div>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('BASMA8000Sheet', 'search')"><i class="fa fa-search"></i> 조회</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('BASMA8000Sheet', 'apply')"><i class="fa fa-save"></i> 선택</button>
					<button type="button" class="btn btn-sm btn-primary" name="btnClose" id="btnClose" onclick="doAction('BASMA8000Sheet', 'close')"><i class="fa fa-close"></i> 닫기</button>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="BASMA8000">
				<!-- 시트가 될 DIV 객체 -->
				<div id="BASMA8000SheetDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>