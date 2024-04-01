<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>

	<script>
		var systemGridList;

		$(document).ready(async function () {
			// document.body.style.zoom = "80%";
			await init();
		});

		/* 초기설정 */
		async function init() {

			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "system");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
			document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';
			document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';

			/* 권한에 따라 회사, 사업장 활성화 */
			var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
			if(authDivi === "03" || authDivi === "04"){
				document.getElementById('busiCd').disabled = true;
				document.getElementById('btnBusiCd').disabled = true;
			}

			/* Button 셋팅 */
			await edsUtil.setButtonForm(document.querySelector("#systemGridListButtonForm"));

			/**********************************************************************
			 * editor 영역 START
			 ***********************************************************************/

			// editor.getMarkdown();
			/**********************************************************************
			 * editor 영역 END
			 ***********************************************************************/

			/*********************************************************************
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
					Height: 40,
					minRowHeight: 40,
					complexColumns: [

					],
				},
				columns:[],
				columnOptions: {
					resizable: true,
					/*frozenCount: 1,
					frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
				},
			});

			systemGridList.setColumns([
				{ header:'다운로드일시',	name:'inpDttm',		width:150,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'사용자',		name:'inpNm',		width:80,	align:'center',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'메뉴경로',		name:'menuPath',	width:200,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'파일명',		name:'origNm',		width:450,	align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'저장경로',		name:'saveRoot',	minWidth:350,	align:'left',	defaultValue: '',	filter: { type: 'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpcd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busicd',		width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
				{ header:'입력자아이디',	name:'inpid',		width:80,	align:'center',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			/*필터 이후 포커스*/
			systemGridList.on('afterFilter', async ev => {
				if(ev.instance.store.data.filteredIndex.length>0){
					systemGridList.focusAt(0,0,true)
				}
			});
			
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			document.getElementById('systemGridList').style.height = (innerHeight)*(1-0.11) + 'px';
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'systemGridList') {
				switch (sAction) {
					case "search":// 조회

						systemGridList.finishEditing(); // 데이터 초기화
						systemGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						systemGridList.resetData(edsUtil.getAjax("/SYSTEM_MGT/selectFileDownloadHistory", param)); // 데이터 set

						if(systemGridList.getRowCount() > 0 ){
							systemGridList.focusAt(0, 0, true);
						}
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
		function fn_busiPopup(){
			var param = {
				corpCd: $("#searchForm #corpCd").val(),
				busiCd: document.getElementById('busiCd').value
			};
			edsPopup.util.openPopup(
					"BUSIPOPUP",
					param,
					function (value) {
						this.returnValue = value||this.returnValue;
						if(this.returnValue){
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

		async function popupHandler(name,divi,callback){
			var row = systemGridList.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'cust':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.custNm= systemGridList.getValue(row.rowKey, 'custNm');
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						systemGridList.setValue(row.rowKey,'custCd',callback.custCd);
						systemGridList.setValue(row.rowKey,'custNm',callback.custNm);
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.depaNm= systemGridList.getValue(row.rowKey, 'depaNm')??'';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						systemGridList.setValue(row.rowKey,'depaCd',callback.depaCd);
						systemGridList.setValue(row.rowKey,'depaNm',callback.depaNm);
					}
					break;
				case 'user':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.empCd= '<c:out value="${LoginInfo.empCd}"/>';
						param.name= name;
						await edsIframe.openPopup('USERPOPUP',param)
					}else{
						systemGridList.setValue(row.rowKey,'manCd',callback.empCd);
						systemGridList.setValue(row.rowKey,'manNm',callback.empNm);
					}
					break;
			}
		}
		/**********************************************************************
		 * 화면 함수 영역 END
		 ***********************************************************************/
	</script>
</head>

<body>
<div class="row" style="position:relative">
	<div class="col-md-12">
		<!-- 검색조건 영역 -->
		<div class="row">
			<div class="col-md-12" style="background-color: #ebe9e4;">
				<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
					<!-- form start -->
					<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onSubmit="return false;">
						<!-- input hidden -->
						<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
						<!-- ./input hidden -->
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
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
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
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"		id="btnSearch"		onclick="doAction('systemGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
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
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>