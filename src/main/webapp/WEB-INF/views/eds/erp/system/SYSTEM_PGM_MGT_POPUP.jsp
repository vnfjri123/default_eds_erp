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
		var systemGridList;
		$(document).ready(function () {
			init();

			//	이벤트
			$('form input').on('keydown', function(e) {
				if (e.which == 13) {
					doAction("systemGridList", "search");
				}
			});
		});

		/* 초기설정 */
		function init() {

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value =  edsUtil.getParameter('corpCd');	// 회사 코드

			/* 그리드 초기화 속성 설정 */
			systemGridList = new tui.Grid({
				el: document.getElementById('systemGridListDIV'),
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

			systemGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
				{ header:'메뉴 ID',		name:'pgmId',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'메뉴 명',		name:'pgmNm',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'URL',			name:'pgmUrl',		minWidth:300,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'프로그램 설명',	name:'pgmExp',		minWidth:300,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
			]);

			systemGridList.on('dblclick', ev => {
				doAction("systemGridList", "apply");
			});

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('systemGrid').style.height = height + 'px';

			/* 조회 */
			doAction("systemGridList", "search");
		}

		/* 화면 이벤트 */
		function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":// 조회

						systemGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_PGM_MGT_POPUP/selectPmgMgtListPopup", param)); // 데이터 set

						break;
					case "apply"://선택

						var row = systemGridList.getFocusedCell();
						var param = {};
						param.pgmId = systemGridList.getValue(row.rowKey, "pgmId");
						param.pgmNm = systemGridList.getValue(row.rowKey, "pgmNm");

						edsPopup.util.edsClosePopup(param);

						break;
					case "close":	// 닫기
						edsPopup.util.edsClosePopup();
						break;
				}
			}
		}
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
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">

						<!-- ./input hidden -->
						<div class="form-group" style="margin-left: 20px"></div>
						<div class="form-group">
							<label for="pgmNm">프로그램명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="pgmNm" id="pgmNm" title="프로그램명">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="pgmUrl">URL &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="pgmUrl" id="pgmUrl" title="URL">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="useYn">사용유무 &nbsp;</label>
							<div class="input-group input-group-sm">
								<select name="useYn" id="useYn" class="select form line4" title="공통코드조회">
									<option value="">전체</option>
									<option value="01">사용</option>
									<option value="00">미사용</option>
								</select>
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
					<i class="fa fa-file-text-o"></i> 프로그램관리
				</div>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('systemGridList', 'apply')"><i class="fa fa-save"></i> 선택</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('systemGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="systemGrid">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>