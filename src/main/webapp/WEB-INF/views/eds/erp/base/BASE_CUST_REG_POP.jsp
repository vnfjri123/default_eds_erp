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
			$('#searchForm #custCd').on('keydown', async function(e) {
				if (e.which == 13) {
					await doAction("baseGridList", "search");

					if(baseGridList.getRowCount() > 0 ){
						baseGridList.focusAt(0, 0, true);
					}
				}
			});
			document.getElementById('custCd').focus();
		});

		/* 초기설정 */
		async function init() {

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
				{ header:'상태',			name:'sStatus',		width:80,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'거래처명',		name:'custNm',		width:200,		align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사업자등록번호',name:'corpNo',		width:110,		align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true }
					,formatter: function (value){
						return edsUtil.corpNoFormatter(value.value);
					}
				},
				{ header:'대표자명',		name:'ownerNm',		width:110,		align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'비고',			name:'remark',		minWidth:150,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header:'전화번호',			name:'telNo',		minWidth:150,	align:'left', hidden:true},
				{ header:'폰번호',			name:'phnNo',		minWidth:150,	align:'left', hidden:true},
				{ header:'팩스번호',			name:'faxNo',		minWidth:150,	align:'left', hidden:true},
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			baseGridList.on('dblclick', async ev => {
				await doAction("baseGridList", "apply");
			});

			baseGridList.on('keydown', async ev => {
				if(ev.keyboardEvent.keyCode == "13"){
					await doAction("baseGridList", "apply");
				}
				if(ev.keyboardEvent.keyCode == "8"){
				    document.getElementById('custCd').focus();
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

						baseGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_CUST_REG/selectCustPopList", param)); // 데이터 set

						break;
					case "apply"://선택

						var row = baseGridList.getFocusedCell();
						var param = {};
						param.custCd = baseGridList.getValue(row.rowKey, "custCd");
						param.custNm = baseGridList.getValue(row.rowKey, "custNm");
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
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post">
						<!-- input hidden -->
						<input type="hidden" name="name" id="name" title="구분값">
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
						<div class="form-group" style="margin-left: 20px"></div>
						<div class="form-group">
							<label for="custCd">거래처 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="custCd" id="custCd" title="거래처">
							</div>
						</div>
						<div style="display: none">
							<div class="form-group" style="margin-left: 50px"></div>
							<div class="form-group">
								<label for="custNm">거래처명 &nbsp;</label>
								<div class="input-group input-group-sm">
									<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="custNm" id="custNm" title="사업장명">
								</div>
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
					<i class="fa fa-file-text-o"></i> 거래처 목록
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
