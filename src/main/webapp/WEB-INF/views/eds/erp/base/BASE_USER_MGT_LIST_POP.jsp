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
		var baseGridList;
		$(document).ready(async function () {
			await init();

			//	이벤트
			$('form input').on('keydown', async function(e) {
				if (e.which == 13) {
					await doAction("baseGridList", "search");
				}
			});
		});

		/* 초기설정 */
		async function init() {

			/* 조회옵션 셋팅 */
			await edsIframe.setParams();

			/* 그리드 초기화 속성 설정 */
			baseGridList = new tui.Grid({
				el: document.getElementById('baseGridListDIV'),
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

			baseGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'Center',	editor:{type:'text'},	hidden:true },
				{ header:'사원코드',		name:'empCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사원명',		name:'empNm',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'아이디',		name:'empId',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'부서명',		name:'depaNm',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직책',			name:'respDiviNm',	minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'직위',			name:'posiDiviNm',	minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header:'사업장코드',	name:'busiCd',		minWidth:100,	align:'center', hidden: true},
				{ header:'사업장명',		name:'busiNm',		minWidth:100,	align:'center', hidden: true},
				{ header:'부서코드',		name:'depaCd',		minWidth:100,	align:'center', hidden: true},
			]);

			baseGridList.on('dblclick', async ev => {
				await doAction("baseGridList", "apply");
			});

			baseGridList.on('keydown', async ev => {
				if(ev.keyboardEvent.keyCode == "13"){
					await doAction("baseGridList", "apply");
				}
			});

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('baseGridList').style.height = height + 'px';

			/* 조회 */
			await doAction("baseGridList", "search");
		}

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseGridList') {
				switch (sAction) {
					case "search":	// 조회

						baseGridList.finishEditing();
						baseGridList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchFormUser")); //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_USER_MGT_LIST/selectUserMgtList", param)); // 데이터 set

						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;
					case "apply"://선택

						baseGridList.finishEditing();

						var row = baseGridList.getFocusedCell();
						var param = {};
						param.empCd = baseGridList.getValue(row.rowKey, "empCd");
						param.empNm = baseGridList.getValue(row.rowKey, "empNm");
						param.busiCd = baseGridList.getValue(row.rowKey, "busiCd");
						param.busiNm = baseGridList.getValue(row.rowKey, "busiNm");
						param.depaCd = baseGridList.getValue(row.rowKey, "depaCd");
						param.depaNm = baseGridList.getValue(row.rowKey, "depaNm");
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
					<form class="form-inline" role="form" name="searchFormUser" id="searchFormUser" method="post">
						<!-- input hidden -->
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">

						<!-- ./input hidden -->
						<div class="form-group" style="margin-left: 20px"></div>
						<div class="form-group">
							<label for="empCd">사원코드 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="empCd" id="empCd" title="사원코드">
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="empNm">사원명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="empNm" id="empNm" title="사원명">
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
					<i class="fa fa-file-text-o"></i> 사원 목록
				</div>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('baseGridList', 'apply')"><i class="fa fa-save"></i> 선택</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('baseGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="baseGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>