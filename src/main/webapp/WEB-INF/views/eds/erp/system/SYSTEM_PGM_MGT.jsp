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
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "sysma");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#systemGridListButtonForm"));

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			/* 그리드 초기화 속성 설정 */
			systemGridList = new tui.Grid({
				el: document.getElementById('systemGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum', 'checkbox'],
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
				{ header:'메뉴 ID',		name:'pgmId',		minWidth:200,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'메뉴 명',		name:'pgmNm',		minWidth:235,	align:'left',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'URL',			name:'pgmUrl',		minWidth:400,	align:'left',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'프로그램 설명',	name:'pgmExp',		minWidth:600,	align:'left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사용여부',		name:'useYn',		minWidth:100,	align:'Center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'Center',	hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('systemGridList').style.height = height + 'px';

			/* 조회 */
			doAction("systemGridList", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":// 조회

						systemGridList.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_PGM_MGT/selectPmgMgtList", param)); // 데이터 set

						if(systemGridList.getRowCount() > 0 ){
							systemGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = document.getElementById('corpCd').value;
						appendedData.useYn = '01';

						systemGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장

						await edsUtil.doCUD("/SYSTEM_PGM_MGT/cudPmgMgtList", "systemGridList", systemGridList);

						break;
					case "delete"://삭제
						var rows = systemGridList.getCheckedRows();
						await systemGridList.removeCheckedRows(true);
						await checkedMenuList("/SYSTEM_PGM_MGT/checkedMenuList", rows);
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


		async function checkedMenuList(url, param){
			$.ajax({
				url: url,
				headers: {
					'X-Requested-With': 'XMLHttpRequest'
				},
				dataType: "json",
				contentType: "application/json; charset=UTF-8",
				type: "POST",
				async: false,
				data: JSON.stringify({data:param}),
				success: async function(result){
					console.log(result)
					if(result.code === "success"){
						console.log('test')
						await edsUtil.doCUD("/SYSTEM_PGM_MGT/cudPmgMgtList", "systemGridList", systemGridList);
					}else{
						toastrmessage(	"toast-bottom-center"
								,"warning"
								,	"프로그램을 확인해 주세요.<br>" +
								"메뉴관리 > " + result.menuNm + " > " + resultpgmNm
								,"경고"
								,4000);
					}
					return result;
				}
			});
		}

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
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">

						<!-- ./input hidden -->
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
								<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="useYn" id="useYn" title="사용여부"></select>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-12">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="systemGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="systemGridListButtonForm" id="systemGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('systemGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('systemGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('systemGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>