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
		var baseGridList
		$(document).ready(async function () {
			await init();

			//	이벤트
			$('#searchForm #accountNm, #searchForm #useYn').on('keydown', async function(e) {
				if (e.which == 13) {
					await doAction("baseGridList", "search");

					if(baseGridList.getRowCount() > 0 ){
						baseGridList.focusAt(0, 0, true);
					}
				}
			});

			document.getElementById('accountNm').focus();
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
				// data: treeData,
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
				{ header:'계정코드',		name:'accountCd',		width:100,		align:'center',	defaultValue: ''},
				{ header:'계정과목명',		name:'accountNm',		width:200,		align:'left',	defaultValue: ''},
				{ header:'재무재표코드',	name:'financialCd',	width:150,		align:'center',	defaultValue: '',	},
				{ header:'재무재표명',		name:'financialNm',		width:200,		align:'center',	defaultValue: ''},
				{ header:'사용구분',		name:'useYn',	width:100,		align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true }},
				{ header: '적요',			name:'note1',		minWidth:150,	align:'center',	defaultValue: '',	},
				{ header:'비고',			name:'note2',		minWidth:150,	align:'center',	defaultValue: '',	},	
				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
				{ header:'상위계정코드',	name:'pareAccountCd',	width:100,		align:'center',	hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			baseGridList.disableColumn('useYn');
			baseGridList.on('dblclick', async ev => {
				await doAction("baseGridList", "apply");
			});

			baseGridList.on('keydown', async ev => {
				if(ev.keyboardEvent.keyCode == "13"){
					await doAction("baseGridList", "apply");
				}
				if(ev.keyboardEvent.keyCode == "8"){
				    document.getElementById('accountNm').focus();
				}
			});
			$(document).keydown(function(e) {
			if (e.key == 'Escape') {
				doAction("baseGridList", "close")
				}
			})

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			document.getElementById('baseGridList').style.height = window.innerHeight - 90 + 'px';

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

						baseGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_ACCOUNT_REG/selectAccountList", param)); // 데이터 set

						break;
					case "apply"://선택

						var row = baseGridList.getFocusedCell();
						var param = {};
						param.accountCd = baseGridList.getValue(row.rowKey, "accountCd");
						param.accountNm = baseGridList.getValue(row.rowKey, "accountNm");
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
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="name" id="name" title="구분값">
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<!-- ./input hidden -->
				<div class="form-group">
					<label for="accountNm">계정과목명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="accountNm" id="accountNm" title="계정명">
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
	<div class="col-md-12">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 계정과목목록
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