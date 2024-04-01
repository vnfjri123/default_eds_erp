<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<script type="text/javascript" src='/js/com/eds.edms.js'></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="/AdminLTE_main/dist/css/adminlte.min.css">
	<link rel="stylesheet" href="/css/edms/edms.css">
	<script>

		var edmsSubmitReqGridList;
		$(document).ready(function () {
			init();
		});
		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");

            /* 조회옵션 셋팅 */
            document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
            document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
			document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#edmsSubmitReqGridListButtonForm"));

			/* 이벤트 셋팅 */
			//edsUtil.addChangeEvent("edmsSubmitReqGridListForm", fn_CopyForm2edmsSubmitReqGridList);
			await edsIframe.setParams();

			/**********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/
			edmsSubmitReqGridList = new tui.Grid({
				el: document.getElementById('edmsSubmitReqGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:'auto',
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
			edmsSubmitReqGridList.setColumns([
				{ header:'문서종류',		name:'docDivi',minWidth:100,	align:'center',	formatter: 'listItemText',defaultValue: '01',
					editor: {
						type: 'select',
						options: 
						{
							listItems:setCommCode("COM027")
						}
					},
					filter: { type: 'select', showApplyBtn: true, showClearBtn: true } },
				{ header:'문서명',		name:'submitNm',		minWidth:100,	align:'center',	filter: { type: 'text', showApplyBtn: true, showClearBtn: true },validation: {required:true} },
				{ header:'신청일',		name:'submitDt',		minWidth:80,	align:'center',	defaultValue: '',	editor:{type:'datePicker',options:{format:'yyyy-MM-dd'}}},
				{ header:'입력자',		name:'inpNm',		minWidth:80,	align:'center',	defaultValue: ''},
				{ header:'상신단계',		name:'submitApprover',		minWidth:80,	align:'center',	defaultValue: ''},
				// hidden(숨김)
				{ header:'상태구분',	 name:'statusDivi',		width:100,	align:'center',	hidden:true },
				{ header:'회사코드',	 name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	 name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:"기안상신코드", name: "submitCd",		minWidth:100,	align:'center',	hidden:true },
			]);
			//disabled 셋팅
			edmsSubmitReqGridList.disableColumn('docDivi');
			edmsSubmitReqGridList.disableColumn('submitDt');
			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/
			edmsSubmitReqGridList.on('focusChange', async ev => {
				if(ev.rowKey != ev.prevRowKey){
					const docDivi=edmsSubmitReqGridList.getRow(ev.rowKey).docDivi;
					setTimeout(async function(){
						await lnitIframe(docDivi);
					}, 100);
				}
			});
			edmsSubmitReqGridList.on('afterChange', ev => {
				const changeData=ev.changes[0];
				if(changeData.columnName=="docDivi"&&changeData.prevValue!=changeData.value)
				{
					const docDivi=changeData.value;
					setTimeout(async function(){
						await lnitIframe(docDivi);
					}, 100);
				}
			});
			edmsSubmitReqGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				var focusDataNm=edmsSubmitReqGridList.getFocusedCell().columnName;
				if((focusDataNm === 'docDivi')){
					edmsSubmitReqGridList.finishEditing();
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			/* 조회 */
			doAction("edmsSubmitReqGridList", "search");
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'edmsSubmitReqGridList') {
				switch (sAction) {
					case "search":// 조회
						edmsSubmitReqGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						await edmsSubmitReqGridList.resetData(edsUtil.getAjax("/EDMS_SUBMIT_LIST/selectSubmitReqList", param)); // 데이터 set
						if(edmsSubmitReqGridList.getRowCount() > 0 ){
							edmsSubmitReqGridList.focusAt(0, 0, true);
						}
						break;
			
				}
			}
		}
		//ifram 로딩완료 후 데이터 전달 이벤트 생성
		$("#iframSubmit").ready(function() {
			//수신 이벤트 발생
			window.addEventListener("message", function(message) {
				if(message.data=='complete')
				{
					var row = edmsSubmitReqGridList.getFocusedCell();
					const data= edmsSubmitReqGridList.getRow(row.rowKey);//그리드 기준 조회조건
					//const data= ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					data.messageDivi='select';
					document.getElementById("iframSubmit").contentWindow.postMessage(data);
				}
			})
			document.getElementById("btnApprove").addEventListener("click", async function(message) {
				const validate= await validateCheck();
				if(!validate) return;
				edmsSubmitReqGridList.finishEditing();
				const rowKey=edmsSubmitReqGridList.getFocusedCell().rowKey;
				const data=edmsSubmitReqGridList.getRow(rowKey);
				data.messageDivi='Approve';
				edsEdms.approveSubmit([data]);
			})
			document.getElementById("btnReject").addEventListener("click",  async function(message) {
				const validate= await validateCheck();
				if(!validate) return;
				edmsSubmitReqGridList.finishEditing();
				const rowKey=edmsSubmitReqGridList.getFocusedCell().rowKey;
				const data=edmsSubmitReqGridList.getRow(rowKey);
				data.messageDivi='Reject';
				data.submitDivi='04'//반려
				document.getElementById("iframSubmit").contentWindow.postMessage(data);
			})
		})
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
		 async function lnitIframe(docDivi){
			var rows = edmsSubmitReqGridList.getRowCount();
			if(rows > 0){
				let url="";
				if(docDivi=='01')url="/EDMS_EST_REPORT_VIEW"
				else if(docDivi=='02')url="/EDMS_PROJECT_REPORT_VIEW"
				else url="/EDMS_EST_REPORT_VIEW"
				document.searchForm.action =url;
				document.searchForm.submit();
			}
		}
		async function validateCheck(){
			// 유효성 검사
			var validate = await edmsSubmitReqGridList.validate();
			for(var i=0; i<validate.length; i++) {
				if(validate[i].errors.length != 0) {
					for (var r = 0; r < validate[i].errors.length; r++) {
						if (validate[i].errors[r].errorCode == "REQUIRED") {
							await edmsSubmitReqGridList.focus(validate[i].rowKey,validate[i].errors[r].columnName); // 빈 필수 값 포커스
							alert('필수값을 입력해 주세요.')
							return false;
						}
					}
				}
			}
			return true;
		}
		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>
	
	<div class="row"style="margin: 0;height: 100vh">
		<div class="col-md-12 templateTop">
			<div class="float-left" style="padding: 3px">
				<!-- form start -->
				<form class="form-inline" name="searchForm" id="searchForm" method="POST" target="iframSubmit">
					<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
					<input type="hidden" name="submitCd" id="submitCd" title="기안상신코드">	
					<div class="form-row" >
						<div class="form-group">
							<label for="busiCd">사업장 &nbsp;</label>
							<div class="input-group-prepend">
								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">
							</div>
							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="fn_busiPopup(); return false;"><i class="fa fa-search"></i></button></span>
							<div class="input-group-append">
								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>
							</div>
						</div>
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="stDt">조회기간 &nbsp;</label>
							<div class="input-group-prepend">
								<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="stDt" id="stDt" title="끝">
							</div>
							<span>&nbsp;~&nbsp;</span>
							<div class="input-group-append">
								<input type="date" class="form-control" style="width: 150px; font-size: 15px;border-radius: 3px;" name="edDt" id="edDt" title="끝">
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="btn-group float-right" style="padding: 3px;">
				<form class="form-inline" role="form" name="edmsSubmitReqGridListButtonForm" id="edmsSubmitReqGridListButtonForm" method="post" onsubmit="return false;">
					<button type="button" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" onclick="doAction('edmsSubmitReqGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
				</form>
			</div>
		</div>
		<div class="col-md-4" style="height: calc(100% - 50px);">
			<div id="edmsSubmitReqGridList" style="height: 100%;">
				<!-- 시트가 될 DIV 객체 -->
				<div id="edmsSubmitReqGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="col-md-8" style="height: calc(100% - 50px)">
			<div style="height: calc(100% - 46px);">
				<iframe class="iframe-mode" scrolling="auto" id="iframSubmit" class="embed-responsive-item" name="iframSubmit" style="min-height:300px; width: 100%; border: 0;height: 100%;"  allowfullscreen></iframe>
			</div>
			<div class="col text-center"style="padding: 7.5px; background-color: #ebe9e4">
				<form class="form-inline" role="form" name="edmsEstGridItemButtonForm" id="edmsEstGridItemButtonForm" method="post" onsubmit="return false;">
					<div class="container">
							<div class="col text-center">
								<button type="button" class="btn btn-sm btn-success" name="btnAppSave" id="btnApprove" ><i class="fa fa-user-plus"></i> 승인</button>
								<button type="button" class="btn btn-sm btn-danger" name="btnReferSave" id="btnReject" ><i class="fa fa-user-plus"></i> 반려</button>	
								<button type="button" class="btn btn-sm btn-warning" name="btnTempSave" id="btnTempSave" ><i class="fa fa-plus"></i> 검토</button>
							</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>