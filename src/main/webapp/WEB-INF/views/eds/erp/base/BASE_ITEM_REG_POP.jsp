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
		$(document).ready(function () {
			init();

			//	이벤트
			$('#searchForm #itemNm, #searchForm #useYn').on('keydown',async function(e) {
				if (e.which == 13) {
					await doAction("baseGridList", "search");

					if(baseGridList.getRowCount() > 0 ){
						baseGridList.focusAt(0, 0, true);
					}
				}
			});

			document.getElementById('itemNm').focus();
		});

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");
			// edsUtil.setForm(document.querySelector("#baseGridListForm"), "basma");

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

			baseGridList.setColumns([
				{ header:'품목코드',		name:'itemCd',		width:100,		align:'center',	defaultValue: ''	},
				{ header:'품목명',		name:'itemNm',		width:200,		align:'left',	defaultValue: ''	},
				{ header:'자재분류',		name:'mateClas',	width:100,		align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("COM004")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true }},
				{ header:'상위품목명',	name:'pareItemNm',	width:200,		align:'center',	defaultValue: ''	},
				{ header:'규격',			name:'standard',	width:150,		align:'center',	defaultValue: ''	},
				{ header:'개요',			name:'note1',		width:200,		align:'center',	defaultValue: ''	},
				{ header:'비고',			name:'note2',		minWidth:150,	align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:150,		align:'center',	hidden:true },
				{ header:'상위품목코드',	name:'pareItemCd',	width:100,		align:'center',	hidden:true },
				{ header:'기초순번',		name:'baseSeq',		width:100,		align:'center',	hidden:true },
				{ header:'부모순번',		name:'pareSeq',		width:100,		align:'center',	hidden:true },
				{ header:'깊이',			name:'depth',		width:100,		align:'center',	hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseGridList.disableColumn('mateClas');

			baseGridList.on('click', async ev => {
				baseGridList.check(ev.rowKey);
			});

			baseGridList.on('dblclick', async ev => {
				baseGridList.check(ev.rowKey);
				await doAction("baseGridList", "apply");
			});

			baseGridList.on('keydown', async ev => {
				if(ev.keyboardEvent.keyCode == "13"){
					baseGridList.check(ev.rowKey);
					await doAction("baseGridList", "apply");
				}
				if(ev.keyboardEvent.keyCode == "8"){
				    document.getElementById('itemNm').focus();
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
						baseGridList.resetData(edsUtil.getAjax("/BASE_ITEM_REG/selectItemList", param)); // 데이터 set

						break;
					case "apply"://선택

						var param = baseGridList.getCheckedRows();
						var params = {
							name: document.getElementById('name').value,
							param: param
						};
						
						await edsIframe.closePopup(params);

						break;
					case "close":	// 닫기

						var params = {
							name: document.getElementById('name').value,
						};

						await edsIframe.closePopup(params);

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
					<label for="itemNm">품목명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="itemNm" id="itemNm" title="품목명">
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
					<i class="fa fa-file-text-o"></i> 품목목록
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