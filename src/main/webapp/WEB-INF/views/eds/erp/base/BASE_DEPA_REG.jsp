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
		var baseDepaGridList;
		$(document).ready(function () {
			// 그리드 초기설정
			init();

			//	이벤트
			$('#corpCd, #busiCd, #depaNm').on('change', function(e) {
				doAction("baseDepaGridList", "search");
			});
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");

			/* 조회옵션 셋팅 */
			document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
			document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';

			/* 권한에 따라 회사, 사업장 활성화 */
			var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
			if(authDivi == "02"){
				document.getElementById('corpCd').disabled = true;
			}
			if(authDivi == "03" || authDivi == "04"){
				document.getElementById('corpCd').disabled = true;
				document.getElementById('busiCd').disabled = true;
				document.getElementById('btnBusiCd').disabled = true;
			}

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#baseDepaButtonForm"));

			/**********************************************************************
			 * Grid CustomTextEditor 영역 START
			 ***********************************************************************/

			class depaColorRenderer {
				constructor(props) {
					const el = document.createElement('input');
					el.type = 'color';
					el.style.marginLeft = '-3px'
					el.style.width = '105%';
					el.style.border = 'none';
					el.disabled = 'true';

					this.el = el;
				}

				getValue() {
					return this.el.value;
				}

				getElement() {
					return this.el;
				}
			}

			/**********************************************************************
			 * Grid CustomTextEditor 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			baseDepaGridList = new tui.Grid({
				el: document.getElementById('baseDepaGridListDIV'),
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

			baseDepaGridList.setColumns([
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'회사코드',		name:'corpCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'회사명',		name:'corpNm',		minWidth:150,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사업장코드',	name:'busiCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사업장명',		name:'busiNm',		minWidth:150,	align:'left',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'부서코드',		name:'depaCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'부서명',		name:'depaNm',		minWidth:150,	align:'left',	editor:{type:'text'},	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'색코드',		name:'depaColorCd',	minWidth:100,	align:'center'	},
				{ header:'색',			name:'depaColor',	minWidth:150,	align:'center', renderer: {type: depaColorRenderer}},
				{ header:'부서분류',		name:'depaDivi',	minWidth:100,	align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("COM002")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header:'부서설명',		name:'depaExp',		minWidth:250,	align:'left',	editor:{type:'text'},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사용여부',		name:'useYn',		minWidth:100,	align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseDepaGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='depaColorCd') {
						await edsUtil.applyColorDataToSheet(baseDepaGridList,'depaColor','depaColorCd');
					}
				}else{
					// projectGridList.finishEditing();
				}
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			document.getElementById('baseDepa').style.height = window.innerHeight - 95 + 'px';

			/* 조회 */
			doAction("baseDepaGridList", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		 async function doAction(sheetNm, sAction) {
			if (sheetNm == 'baseDepaGridList') {
				switch (sAction) {
					case "search":// 조회

						baseDepaGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						baseDepaGridList.resetData(edsUtil.getAjax("/BASE_DEPA_REG/selectDepaList", param)); // 데이터 set

						if(baseDepaGridList.getRowCount() > 0 ){
							baseDepaGridList.focusAt(0, 0, true);
						}
						setTimeout(async ev=>{
							await edsUtil.applyColorToSheet(baseDepaGridList,'depaColor','depaColorCd');
						},100);
						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = $("#searchForm #corpCd").val();
						appendedData.corpNm = $("#searchForm #corpCd").text();
						appendedData.busiCd = $("#searchForm #busiCd").val();
						appendedData.busiNm = $("#searchForm #busiNm").val();
						appendedData.useYn = '01';

						baseDepaGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/BASE_DEPA_REG/cudDepaList", "baseDepaGridList", baseDepaGridList);// 삭제
						break;
					case "delete"://삭제
						await baseDepaGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/BASE_DEPA_REG/cudDepaList", "baseDepaGridList", baseDepaGridList);// 삭제
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
		function fn_busiPopup() {
			var param = {
				corpCd: $("#searchForm #corpCd").val(),
				busiCd: document.getElementById('busiCd').value
			};
			edsPopup.util.openPopup(
					"BUSIPOPUP",
					param,
					function (value) {
						this.returnValue = value || this.returnValue;
						if (this.returnValue) {
							document.getElementById('busiCd').value = this.returnValue.busiCd;
							document.getElementById('busiNm').value = this.returnValue.busiNm;
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
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;">
						<!-- input hidden -->

						<!-- ./input hidden -->
						<div class="form-group">
							<label for="corpCd">회사명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<select type="text" class="form-control" style="width: 150px; font-size: 15px;" name="corpCd" id="corpCd" title="회사조회"></select>
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="fn_busiPopup(); return false;"><i class="fa fa-search"></i></button></span>
							</div>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="depaNm">부서명 &nbsp;</label>
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="depaNm" id="depaNm" title="부서명">
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
			<div class="col-md-12" style="height: 100%;" id="baseDepa">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseDepaGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="baseDepaButtonForm" id="baseDepaButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('baseDepaGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('baseDepaGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('baseDepaGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('baseDepaGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
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