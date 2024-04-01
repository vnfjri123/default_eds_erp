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
		$(document).ready(function () {
			init();

			//	이벤트
			$('#corpCd, #searchForm #busiNm, #searchForm #useYn').on('change', function(e) {
				doAction("baseGridList", "search");
			});
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");
			edsUtil.setForm(document.querySelector("#baseGridListForm"), "basma");
            $('[data-mask]').inputmask();
			/* 조회옵션 셋팅 */

			/* 권한에 따라 회사, 사업장 활성화 */
			var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
			if(authDivi == "02" || authDivi == "03" || authDivi == "04"){
				document.getElementById('corpCd').disabled = true;
			}

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#baseGridListButtonForm"));

			/* 이벤트 셋팅 */
			edsUtil.addChangeEvent("baseGridListForm", fn_CopyForm2baseGridList);

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
				{ header:'상태',			name:'sStatus',		minWidth:100,	align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사업장명',		name:'busiNm',		minWidth:200,	align:'left',	validation:{required:true},	filter: { type: 'text', showApplyBtn: true, showClearBtn: true } },
				{ header:'사용여부',		name:'useYn',		minWidth:100,	align:'center',	formatter: 'listItemText',
					editor: {
						type: 'select',
						options: {
							listItems:setCommCode("SYS001")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },

				// hidden(숨김)
				{ header: "회사코드",		name: "corpCd",		minWidth:100,	align:'center',	hidden:true },
				{ header: "사업자등록번호",	name: "corpNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "법인등록번호",		name: "corpRegNo",	minWidth:100,	align:'center',	hidden:true },
				{ header: "대표자명",		name: "ownerNm",	minWidth:100,	align:'center',	hidden:true },
				{ header: "우편번호",		name: "zipNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "주소",			name: "addr",		minWidth:100,	align:'center',	hidden:true },
				{ header: "주소상세",		name: "addrDetail",	minWidth:100,	align:'center',	hidden:true },
				{ header: "전화번호",		name: "telNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "팩스번호",		name: "faxNo",		minWidth:100,	align:'center',	hidden:true },
				{ header: "업태",			name: "busiType",	minWidth:100,	align:'center',	hidden:true },
				{ header: "종목",			name: "busiItem",	minWidth:100,	align:'center',	hidden:true },
				{ header: "개업일자",		name: "openDt",	    minWidth:70, 	align:'center', hidden:true },
				{ header: "폐업일자",		name: "clupDt",	    minWidth:70, 	align:'center', hidden:true },
			]);
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			baseGridList.disableColumn('useYn');

			baseGridList.on('focusChange', async ev => {
				if(ev.rowKey != ev.prevRowKey){
					await fn_CopyForm2baseGridList();
					await fn_CopybaseGridList2Form();
				}
			});

			baseGridList.on('afterChange', ev => {
				for (var i = 0; i < ev.changes.length; i++) {
					$('#baseGridListForm #' + ev.changes[i].columnName).val(ev.changes[i].value);
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			document.getElementById('BASMA1000').style.height = height + 'px';

			/* 조회 */
			doAction("baseGridList", "search");
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
						baseGridList.resetData(edsUtil.getAjax("/BASE_BUSI_REG/selectBusiList", param)); // 데이터 set

						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						/*if(baseGridList.getRowCount() > 0 ){
							toastrmessage("toast-bottom-center", "error", "하나의 회사만 등록할 수 입니다.", "실패", 1500); return;
						}*/

						var appendedData = {};
						appendedData.sStatus = "I";
						appendedData.corpCd = $("#searchForm #corpCd").val();
						appendedData.useYn = '01';

						baseGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						await fn_CopybaseGridList2Form();

						break;
					case "save"://저장

						await edsUtil.doCUD("/BASE_BUSI_REG/cudBusiList", "baseGridList", baseGridList);// 저장

						break;
					case "delete"://삭제
						await baseGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/BASE_BUSI_REG/cudBusiList", "baseGridList", baseGridList);// 삭제

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
		async function fn_CopyForm2baseGridList(){
			var rows = baseGridList.getRowCount();
			if(rows > 0){
				var row = baseGridList.getFocusedCell();
				var param = {
					sheet: baseGridList,
					form: document.baseGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopyForm2Sheet(param);// Form -> Sheet복사
			}
		}

		async function fn_CopybaseGridList2Form(){
			var rows = baseGridList.getRowCount();
			if(rows > 0){
				var row = baseGridList.getFocusedCell();
				var param = {
					sheet: baseGridList,
					form: document.baseGridListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
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

				<!-- ./input hidden -->
				<%--<div class="form-group" style="margin-left: 20px"></div>--%>
				<div class="form-group">
					<label for="corpCd">회사명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<select type="text" class="form-control" style="width: 150px; font-size: 15px;" name="corpCd" id="corpCd" title="회사조회"></select>
					</div>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<label for="busiNm" style="margin-bottom:0px;vertical-align: middle">사업장명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="busiNm" id="busiNm" title="사업장명">
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
	<div class="col-md-4">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 사업장 목록
				</div>
				<div class="btn-group float-right">

				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="BASMA1000">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
	<div class="col-md-8">
		<!-- Form 영역 -->
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="float-left" style="padding: 5px 0 0 5px">
					<i class="fa fa-file-text-o"></i> 사업장 목록 상세
				</div>
				<div class="btn-group float-right">
					<form class="form-inline" role="form" name="baseGridListButtonForm" id="baseGridListButtonForm" method="post" onsubmit="return false;">
						<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnInput" id="btnInput" onclick="doAction('baseGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnSave" id="btnSave" onclick="doAction('baseGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
						<button type="button" class="btn btn-sm btn-primary" name="btnDelete" id="btnDelete" onclick="doAction('baseGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="height: 100%;">
				<!-- form start -->
				<form class="form-inline" role="form" name="baseGridListForm" id="baseGridListForm" method="post" onsubmit="return false;">
					<table class="table table-bordered table-sm">
						<tr>
							<td class="table-active" style="width: 15%"><span class="IBRequired">&nbsp;</span>사업장명</td>
							<td><input type="text" name="busiNm" id="busiNm"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">사업자등록번호</td>
							<td><input type="text" name="corpNo" id="corpNo"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">법인등록번호</td>
							<td><input type="text" name="corpRegNo" id="corpRegNo"  style="width: 100%;"></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">대표자명</td>
							<td><input type="text" name="ownerNm" id="ownerNm"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active">주소&nbsp;<a onclick="edsUtil.showMapPopup(baseGridList)" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
							<td colspan="3">
								<input type="text" name="addr" id="addr" style="width: 100%">
							</td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">전화번호</td>
							<td><input type="text" name="telNo" id="telNo"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">팩스번호</td>
							<td><input type="text" name="faxNo" id="faxNo"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">업태</td>
							<td><input type="text" name="busiType" id="busiType"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">종목</td>
							<td><input type="text" name="busiItem" id="busiItem"  style="width: 100%;" ></td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">개업 일자</td>
							<td>
								<input type="date" class="form-control"  style="width: 100%;"  name="openDt" id="openDt" title="개업일자">
							</td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">폐업 일자</td>
							<td>
								<input type="date" class="form-control"  style="width: 100%;"  name="clupDt" id="clupDt" title="폐업일자">
							</td>
						</tr>
						<tr>
							<td class="table-active" style="width: 15%">사용여부</td>
							<td><select name="useYn" id="useYn" title="사용여부"></select></td>
						</tr>
					</table>
				</form>
				<!-- ./form -->
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f33ae425cff3acf7aca4a7233d929cb2&libraries=services"></script>
</body>
</html>