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
		async function init() {

			/* 조회옵션 셋팅 */
			await edsIframe.setParams();

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

			class CheckboxRenderer {
				constructor(props) {
					const { grid, rowKey, columnInfo } = props;
					const el = document.createElement('input');
					el.type = 'checkbox';
					el.style.cssText = "width:20px;height:20px;margin-top:7px;";

					el.addEventListener('change', () => {
						if (el.checked) {
							grid.check(rowKey);
							grid.setValue(rowKey, columnInfo.name, Number(1));
						} else {
							grid.uncheck(rowKey);
							grid.setValue(rowKey, columnInfo.name, Number(0));
						}
					});

					this.el = el;
					this.render(props);
				}
				getElement() {
					return this.el;
				}
				render(props) {
					// const checked = Boolean(props.value);
					// this.el.checked = checked;
					if(props.value == 0){
						this.el.checked = false;
					}else if(props.value == 1){
						this.el.checked = true;
					}
				}
			}

			systemGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'메뉴 명',		name:'pgmNm',		minWidth:100,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'URL',			name:'pgmUrl',		minWidth:200,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },

				{ header:'조회권한',		name:'readAuth',		width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'추가권한',		name:'addAuth',			width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'수정권한',		name:'updAuth',			width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'삭제권한',		name:'delAuth',			width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'엑셀다운권한',	name:'excelDownAuth',	width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'마감권한',		name:'finishAuth',		width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'마감취소권한',	name:'cancelAuth',		width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'메일전송권한',	name:'emailPopupAuth',	width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },
				{ header:'인쇄권한',		name:'printAuth',		width:100,	align:'center',	renderer:{type: CheckboxRenderer,} },

				// hidden(숨김)
				{ header: "그룹 ID",		name: "groupId",		width:100,	align:'center',	hidden:true },
				{ header: "메뉴 ID",		name: "menuId",			width:100,	align:'center',	hidden:true },
				{ header: "프로그램 ID",	name: "pgmId",			width:100,	align:'center',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			systemGridList.on('click', ev => {
				var targetType = ev.targetType;
				if(targetType === 'columnHeader'){
					var cols = systemGridList.getColumns();
					var datas = systemGridList.getData();
					var cnt = [];
					for(var i=0;i<datas.length;i++){
						var data = systemGridList.getValue(i,ev.columnName)
						if(data == 0){cnt.push(data)}
					}
					if(cnt.length > 0){
						for(var i=0;i<datas.length;i++){
							systemGridList.setValue(i,ev.columnName,1)
						}
					}else if(cnt.length == 0){
						for(var i=0;i<datas.length;i++){
							systemGridList.setValue(i,ev.columnName,0)
						}
					}
				}
				if(targetType == "cell"){
					var rowKey = ev.rowKey;
					var colNm = ev.columnName;
					var state = systemGridList.getValue(rowKey,colNm);
					if(state == 0){systemGridList.setValue(rowKey,colNm,1)}
					else{systemGridList.setValue(rowKey,colNm,0)}
				}
			})

			/* 그리드생성 */

			/* 그리드생성 */
			document.getElementById('systemGridList').style.height = (innerHeight)*(1-0.12) + 'px';
			/* 조회 */
			doAction("systemGridList", "search");

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":	// 조회

						systemGridList.finishEditing(); // 조회시 수정 중인 Input Box 비활성화
						systemGridList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_GP_MENU_AUTH/selectGpMenuAuthList", param)); // 데이터 set

						if(systemGridList.getRowCount() > 0 ){
							systemGridList.focusAt(0, 0, true);
						}

						break;
					case "save":	//저장

						await edsUtil.doCUD("/SYSTEM_GP_MENU_AUTH/cudGpMenuAuthList", "systemGridList", systemGridList);

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
							<label for="groupNm">그룹명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="hidden" name="groupId" id="groupId" title="그룹아이디">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="groupNm" id="groupNm" title="그룹명" readonly>
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="menuNm">메뉴명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="hidden" name="menuId" id="menuId" title="메뉴아이디">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="menuNm" id="menuNm" title="메뉴명" readonly>
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
					<i class="fa fa-file-text-o"></i> 프로그램 목록
				</div>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-primary" id="btnSearch" onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnApply" onclick="doAction('systemGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnClose" onclick="doAction('systemGridList', 'close')"><i class="fa fa-close"></i> 닫기</button>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="systemGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="systemGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
</div>

</body>
</html>