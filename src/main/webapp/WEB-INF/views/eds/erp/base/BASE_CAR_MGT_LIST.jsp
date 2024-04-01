<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/comm/common-include-doctype.jspf"%><%-- DOCTYPE 및 태그라이브러리정의 --%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/comm/common-include-head.jspf"%><%-- 공통헤드 --%>
	<%@ include file="/WEB-INF/views/comm/common-include-js.jspf"%><%-- 공통 스크립트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-css.jspf"%><%-- 공통 스타일시트 정의--%>
	<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>

	<script>
		var baseGridList, baseExpeList, baseExpeFileList;
		$(document).ready(function () {

			init();

			//	이벤트
			$('#empState, #searchForm #carNm').on('change', function(e) {
				doAction("baseGridList", "search");
			});

			document.getElementById('myTab').addEventListener('click', async (ev) =>{
				var id = ev.target.id;
				var tagName = ev.target.tagName;
				if(tagName === "A"){
					switch (id) {
						case "info-tab": setTimeout(async ()=>{await doAction('baseGridList','search'); },200); break;
						case "expe-tab": setTimeout(async ()=>{await doAction('baseExpeList','search'); },200); break;
						case "file-tab": setTimeout(async ()=>{await doAction('','search'); },200); break;
					}
				}
			});

			document.getElementById('files').addEventListener('change', async (ev)=> {

				// file 가져오기
				var file = $('#files'); // input type file tag

				// formData 생성
				var clonFile = file.clone();

				var newForm = $('<form></form>');
				newForm.attr("method", "post");
				newForm.attr("enctype","multipart/form-data");
				newForm.append(clonFile);

				// 추가적 데이터 입력
				/* 저장시 필요한 파라미터*/
				var formData = new FormData(newForm[0]);
				var row = baseExpeList.getFocusedCell();
				formData.append("carCd",		baseExpeList.getValue(row.rowKey,'carCd'));
				formData.append("expeCd",		baseExpeList.getValue(row.rowKey,'expeCd'));

				$.ajax({
					url: "/BASE_CAR_MGT_LIST/cCarExpeFileList",
					type: "POST",
					data: formData,
					enctype: 'multipart/form-data',
					processData: false,
					contentType: false,
					cache: false,
					success: async function (rst) {
						var status = rst.status;
						var note = rst.note;
						var exc = rst.exc;
						if(status === 'success'){
							await doAction('baseExpeFileList','search');
							Swal.fire({
								icon: 'success',
								title: '성공',
								text: note,
								footer: exc
							})
						}else{
							console.log(exc);
							Swal.fire({
								icon: 'error',
								title: '실패',
								text: note,
								footer: exc
							})
						}
					},
				});
			})
		});

		/* 초기설정 */
		function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "basma");
			edsUtil.setForm(document.querySelector("#baseGridListForm"), "basma");
			edsUtil.setForm(document.querySelector("#baseExpeListForm"), "basma");
			$('[data-mask]').inputmask();

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
			document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';

			/* Button 셋팅 */
			edsUtil.setButtonForm(document.querySelector("#baseGridListButtonForm"));
			edsUtil.setButtonForm(document.querySelector("#baseExpeListButtonForm"));
			edsUtil.setButtonForm(document.querySelector("#baseExpeFileListButtonForm"));

			/* 이벤트 셋팅 */
			edsUtil.addChangeEvent("baseGridListForm", fn_CopyForm2baseGridList);
			edsUtil.addChangeEvent("baseExpeListForm", fn_CopyForm2baseExpeList);

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
				{ header:'상태',			name:'sStatus',		width:100,			align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'차량구분',		name:'carDivi',		width:100,			align:'center',	editor:{type:'select',options: {listItems:setCommCode("COM001")}},	formatter: 'listItemText',	filter: 'text'},
				{ header:'차량번호',		name:'carNo',		width:100,			align:'center',	filter: 'text' },
				{ header:'차량명',		name:'carNm',		minWidth:150,		align:'left',	filter: 'text' },
				{ header:'누적주행거리',	name:'sumCumuMile',	width:100,			align:'center',	filter: 'text',	formatter: function (value){return edsUtil.addComma(value.value);}},
				{ header:'보험만료일',	name:'insuExpiDt',	width:100,			align:'center',	filter: 'text' },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:70,			align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:70,			align:'center',	hidden:true },
				{ header:'차량코드',		name:'carCd',		width:70,			align:'center',	hidden:true },
				{ header:'사업장명',		name:'busiNm',		width:70,			align:'center',	hidden:true },
				{ header:'기초주행거리',	name:'cumuMile',	width:100,			align:'center',	hidden:true },
				{ header:'유종',			name:'oilType',		minWidth:70,		align:'center',	hidden:true },
				{ header:'연비',			name:'fuelAmt',		minWidth:70,		align:'center',	hidden:true },
				{ header:'보험사구분',	name:'insuCorpDivi',minWidth:70,		align:'center',	hidden:true },
				{ header:'구입일자',		name:'buyDt',		minWidth:70,		align:'center',	hidden:true },
				{ header:'구입유형',		name:'buyDivi',		minWidth:70,		align:'center',	hidden:true },
				{ header:'정기검사만료일',	name:'periInspExpiDt',	minWidth:70,	align:'center',	hidden:true },
				{ header:'비고',			name:'note',		minWidth:70,		align:'center',	hidden:true },
			]);

			baseExpeList = new tui.Grid({
				el: document.getElementById('baseExpeListDIV'),
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

			baseExpeList.setColumns([
				{ header:'상태',			name:'sStatus',		width:100,			align:'center',	editor:{type:'text'},	hidden:true },
				{ header:'승인구분',		name:'apprDivi',	width:70,			align:'center',	editor:{type:'select',options: {listItems:setCommCode("COM037")}},	formatter: 'listItemText',	filter: 'text'},
				{ header:'지출일자',		name:'expeDt',		width:100,			align:'center',	filter: 'text' },
				{ header:'계정과목명',	name:'accountNm',	width:100,			align:'center',	filter: 'text' },
				{ header:'지출구분',		name:'expeDivi',	width:100,			align:'center',	editor:{type:'select',options: {listItems:setCommCode("COM038")}},	formatter: 'listItemText',	filter: 'text'},
				{ header:'금액',			name:'expeAmt',		width:100,			align:'left',	filter: 'text' },
				{ header:'사진',			name:'qty',			width:100,			align:'center',	filter: 'text' },
				{ header:'메모',			name:'note',		minWidth:100,		align:'center',	filter: 'text' },

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:70,			align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:70,			align:'center',	hidden:true },
				{ header:'차량코드',		name:'carCd',		width:70,			align:'center',	hidden:true },
				{ header:'계정과목코드',	name:'accountCd',	width:100,			align:'center',	hidden:true },
				{ header:'지출코드',		name:'expeCd',		width:70,			align:'center',	hidden:true },
				{ header:'사용자코드',	name:'empCd',		width:70,			align:'center',	hidden:true },
				{ header:'사용자명',		name:'empNm',		width:70,			align:'center',	hidden:true },
				{ header:'결제수단',		name:'payDivi',		width:70,			align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:70,			align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:70,			align:'center',	hidden:true },
			]);

			baseExpeFileList = new tui.Grid({
				el: document.getElementById('baseExpeFileListDIV'),
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

			baseExpeFileList.setColumns([
				{ header:'파일명',		name:'origNm',		width:300,		align:'left',	defaultValue: ''	},
				{ header:'다운로드',		name:'fileDownLoad',width:60,		align:'Center',	formatter:function(){return "<i class='fa fa-download'></i>";},},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor:{type:'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'차량코드',		name:'carCd',		width:100,		align:'center',	hidden:true },
				{ header:'지출코드',		name:'expeCd',		width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'저장명',		name:'saveNm',		width:100,		align:'center',	hidden:true },
				{ header:'저장경로',		name:'saveRoot',	width:100,		align:'center',	hidden:true },
				{ header:'확장자',		name:'ext',			width:100,		align:'center',	hidden:true },
				{ header:'크기',			name:'size',		width:100,		align:'center',	hidden:true },
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	hidden:true },
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	hidden:true },
				{ header:'입력일자',		name:'inpDttm',		width:100,		align:'center',	hidden:true },
				{ header:'수정일자',		name:'updDttm',		width:100,		align:'center',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			baseGridList.disableColumn('carDivi');
			baseExpeList.disableColumn('apprDivi');
			baseExpeList.disableColumn('expeDivi');

			baseGridList.on('focusChange', async ev => {

				var targetType = ev.targetType;

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

			baseExpeList.on('focusChange', async ev => {

				var targetType = ev.targetType;

				if(ev.rowKey != ev.prevRowKey){
					await fn_CopyForm2baseExpeList();
					await fn_CopybaseExpeList2Form();
				}
			});

			baseExpeList.on('afterChange', ev => {
				for (var i = 0; i < ev.changes.length; i++) {
					$('#baseExpeListForm #' + ev.changes[i].columnName).val(ev.changes[i].value);
				}
			});

			baseExpeFileList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				var rowKey = ev.rowKey;
				if(target === 'cell'){
					if(colNm==='fileDownLoad') await edsUtil.fileDownLoad(baseExpeFileList);
					else if(colNm==='accountNm') await popupHandler('account','open');
				}else{
					baseExpeFileList.finishEditing();
				}
			});

			baseExpeFileList.on('focusChange', async ev => {

				var targetType = ev.targetType;

				if(ev.rowKey != ev.prevRowKey){

					console.log('첸지')
					/* 미리보기 세팅 */
					var rowKey = ev.rowKey;
					var params = baseExpeFileList.getValue(rowKey, "saveRoot").replaceAll("/",":").replaceAll("\\",":");
					$('#carImg').attr("src", "/BASE_CAR_MGT_LIST/selectCarExpeImage/" + params);
					// $('#carImg').attr("onclick", "window.open(this.src)");
				}
			});
			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			var height = window.innerHeight - 90;
			// document.getElementById('baseGridList').style.height = height + 'px';

			var height = window.innerHeight - 90;
			document.getElementById('baseExpeList').style.height = 300 + 'px';

			document.getElementById('baseExpeFileList').style.height = (innerHeight)*(1-0.25) + 'px';

			/* 자동차 사진 프레임 설정 */
			document.getElementById('carImgPlcae').style.height = (innerHeight)*(1-0.25) + 'px';

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

						baseGridList.refreshLayout(); // 데이터 초기화
						baseGridList.finishEditing(); // 데이터 마감
						baseGridList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						baseGridList.resetData(edsUtil.getAjax("/BASE_CAR_MGT_LIST/selectCarMgtList", param)); // 데이터 set

						if(baseGridList.getRowCount() > 0 ){
							baseGridList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = '<c:out value="${LoginInfo.corpCd}"/>';
						appendedData.busiCd = '<c:out value="${LoginInfo.busiCd}"/>';
						appendedData.carDivi = "01";
						appendedData.OilType = "01";
						appendedData.insuCorpDivi = "01";
						appendedData.buyDivi = "01";
						appendedData.fuelAmt = 0;
						appendedData.cumuMile = 0;

						baseGridList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						await fn_CopybaseGridList2Form();

						break;
					case "save"://저장

						await edsUtil.doCUD("/BASE_CAR_MGT_LIST/cudCarMgtList", "baseGridList", baseGridList);// 저장

						break;
					case "delete"://삭제
							await baseGridList.removeCheckedRows(true);
							await edsUtil.doCUD("/BASE_CAR_MGT_LIST/cudCarMgtList", "baseGridList", baseGridList);
						break;
				}
			}else if (sheetNm == 'baseExpeList') {
				switch (sAction) {
					case "search":// 조회

						baseExpeList.refreshLayout(); // 데이터 초기화
						baseExpeList.finishEditing(); // 데이터 마감
						baseExpeList.clear(); // 데이터 초기화

						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
							param.carCd = baseGridList.getValue(baseGridList.getFocusedCell().rowKey, 'carCd')
						baseExpeList.resetData(edsUtil.getAjax("/BASE_CAR_MGT_LIST/selectCarExpeList", param)); // 데이터 set

						if(baseExpeList.getRowCount() > 0 ){
							baseExpeList.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						var row = baseGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = baseGridList.getValue(row.rowKey, 'corpCd');
						appendedData.busiCd = baseGridList.getValue(row.rowKey, 'busiCd');
						appendedData.carCd = baseGridList.getValue(row.rowKey, 'carCd');
						appendedData.empCd = '<c:out value="${LoginInfo.empCd}"/>';
						appendedData.empNm = '<c:out value="${LoginInfo.empNm}"/>';
						appendedData.depaCd = '<c:out value="${LoginInfo.depaCd}"/>';
						appendedData.depaNm = '<c:out value="${LoginInfo.depaNm}"/>';
						appendedData.expeAmt = 0;
						appendedData.expeDivi = "01";
						appendedData.apprDivi = "01";
						appendedData.payDivi = "01";

						baseExpeList.appendRow (appendedData, { focus:true }); // 마지막 ROW 추가

						await fn_CopybaseExpeList2Form();

						break;
					case "save"://저장

						await edsUtil.doCUD("/BASE_CAR_MGT_LIST/cudCarExpeList", "baseExpeList", baseExpeList);// 저장

						break;
					case "delete"://삭제
							await baseExpeList.removeCheckedRows(true);
							await edsUtil.doCUD("/BASE_CAR_MGT_LIST/cudCarExpeList", "baseExpeList", baseExpeList);
						break;
				}
			}else if (sheetNm == 'baseExpeFileList') {
				switch (sAction) {
					case "search":// 조회

						baseExpeFileList.refreshLayout(); // 데이터 초기화
						baseExpeFileList.finishEditing(); // 데이터 마감
						baseExpeFileList.clear(); // 데이터 초기화

						var row = baseExpeList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.carCd = baseExpeList.getValue(row.rowKey, 'carCd');
						param.expeCd = baseExpeList.getValue(row.rowKey, 'expeCd');
						baseExpeFileList.resetData(edsUtil.getAjax("/BASE_CAR_MGT_LIST/selectCarExpeFileList", param)); // 데이터 set

						document.getElementById('carImg').style.height = document.getElementById('carImgPlcae').clientHeight + 'px';
						document.getElementById('carImg').style.width = document.getElementById('carImgPlcae').clientWidth + 'px';

						if(baseExpeFileList.getRowCount() > 0 ){
							baseExpeFileList.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = baseExpeList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = baseExpeList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = baseExpeList.getValue(row.rowKey,'busiCd');
						appendedData.carCd = baseExpeList.getValue(row.rowKey,'carCd');
						appendedData.expeCd = baseExpeList.getValue(row.rowKey,'expeCd');

						baseExpeFileList.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/BASE_CAR_MGT_LIST/udCarExpeFileList", "baseExpeFileList", baseExpeFileList);
						break;
					case "delete"://삭제
						await baseExpeFileList.removeCheckedRows(true);
						await edsUtil.doCUD("/BASE_CAR_MGT_LIST/udCarExpeFileList", "baseExpeFileList", baseExpeFileList);
						break;
					case "close"://삭제
						await doAction('baseExpeList','search');
						break;
					case "imgPopOpne":// 사진 팝업

						var row = baseExpeList.getFocusedCell();
						var expeCd = baseExpeList.getValue(row.rowKey,'expeCd');
						if(expeCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '차량지출이 없습니다.',
							});
						}else{
							document.getElementById('btnImgPopEv').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch5').click();
							}, 300)
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
				corpCd: $("#baseGridListForm #corpCd").val(),
				busiCd: ''
			};
			edsPopup.util.openPopup(
					"BUSIPOPUP",
					param,
					function (value) {
						var row = baseGridList.getFocusedCell();
						this.returnValue = value||this.returnValue;
						if(this.returnValue){
							baseGridList.setValue(row.rowKey, 'busiCd', this.returnValue.busiCd);
							baseGridList.setValue(row.rowKey, 'busiNm', this.returnValue.busiNm);
							// document.getElementById('busiCd').value = this.returnValue.busiCd;
							// document.getElementById('busiNm').value = this.returnValue.busiNm;
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
		async function fn_CopyForm2baseExpeList(){
			var rows = baseExpeList.getRowCount();
			if(rows > 0){
				var row = baseExpeList.getFocusedCell();
				var param = {
					sheet: baseExpeList,
					form: document.baseExpeListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopyForm2Sheet(param);// Form -> Sheet복사
			}
		}

		async function fn_CopybaseExpeList2Form(){
			var rows = baseExpeList.getRowCount();
			if(rows > 0){
				var row = baseExpeList.getFocusedCell();
				var param = {
					sheet: baseExpeList,
					form: document.baseExpeListForm,
					rowKey: row.rowKey
				};
				edsUtil.eds_CopySheet2Form(param);// Sheet복사 -> Form
			}
		}

		async function popupHandler(name,divi,callback){
			var row = baseGridList.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'busi':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiNm= baseGridList.getValue(row.rowKey, 'busiNm');
						param.name= name;
						await edsIframe.openPopup('BUSIPOPUP',param)
					}else{
						baseGridList.setValue(row.rowKey,'busiCd',callback.busiCd);
						baseGridList.setValue(row.rowKey,'busiNm',callback.busiNm);
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						baseGridList.setValue(row.rowKey,'busiCd',callback.busiCd);
						baseGridList.setValue(row.rowKey,'busiNm',callback.busiNm);
						baseGridList.setValue(row.rowKey,'depaCd',callback.depaCd);
						baseGridList.setValue(row.rowKey,'depaNm',callback.depaNm);
					}
					break;
				case 'account':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ACCOUNTPOPUP',param)
					}else{
						var row = baseExpeList.getFocusedCell();
						baseExpeList.setValue(row.rowKey,'accountCd',callback.accountCd);
						baseExpeList.setValue(row.rowKey,'accountNm',callback.accountNm);
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
						var row = baseExpeList.getFocusedCell();
						baseExpeList.setValue(row.rowKey,'empCd',callback.empCd);
						baseExpeList.setValue(row.rowKey,'empNm',callback.empNm);
					}
					break;
				case 'proj':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.name= name;
						await edsIframe.openPopup('PROJPOPUP',param);
					}else{
						var row = baseExpeList.getFocusedCell();
						baseExpeList.setValue(row.rowKey,'projCd',callback.rows[0].projCd);
						baseExpeList.setValue(row.rowKey,'projNm',callback.rows[0].projNm);
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
<div class="row" style="height: calc(100vh - 6rem); width: 100%;">
	<div class="col-md-12" style="background-color: #ebe9e4;">
		<div style="background-color: #faf9f5;border: 1px solid #dedcd7;margin-top: 5px;margin-bottom: 5px;padding: 3px;">
			<!-- form start -->
			<form class="form-inline" role="form" name="searchForm" id="searchForm" method="post" onsubmit="return false;">
				<!-- input hidden -->
				<input type="hidden" name="corpCd" id="corpCd" title="회사코드">
				<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">

				<!-- ./input hidden -->
				<div class="form-group">
					<label for="empState">차량구분 &nbsp;</label>
					<div class="input-group input-group-sm">
						<select type="text" class="form-control" style="width: 100px; font-size: 15px;" name="empState" id="empState" title="재직상태"></select>
					</div>
				</div>
				<div class="form-group" style="margin-left: 50px"></div>
				<div class="form-group">
					<label for="carNm">자동차명 &nbsp;</label>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 150px; font-size: 15px;" name="carNm" id="carNm" title="자동차명">
					</div>
				</div>
			</form>
			<!-- ./form -->
		</div>
	</div>
	<div class="col-md-5">
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" id="baseGridList" style="height: calc(100vh - 6rem); width: 100%;">
				<!-- 시트가 될 DIV 객체 -->
				<div id="baseGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
	</div>
	<div class="col-md-7" style="background-color: #e9e7e2"><div class="tab-content" id="myTabContent">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="info-tab" data-toggle="tab" href="#info" role="tab" aria-controls="info" aria-selected="true">차량상세</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="expe-tab" data-toggle="tab" href="#expe" role="tab" aria-controls="expe" aria-selected="false">차량지출</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="file-tab" data-toggle="tab" href="#file" role="tab" aria-controls="file" aria-selected="false">차량정비</a>
			</li>
		</ul>
		<div class="tab-pane fade show active" id="info" role="tabpanel" aria-labelledby="info-tab">
			<!--Body-->
			<div class="row">
				<div class="col-md-12" style="height: 100%;">
					<!-- form start -->
					<form class="form-inline" role="form" name="baseGridListForm" id="baseGridListForm" method="post">
						<table class="table table-bordered table-sm" style="margin: unset;">
							<tr>
								<td class="table-active" style="width: 12%"><span class="IBRequired"></span>차량번호</td>
								<td style="background-color:#fdfdfd;">
									<input type="text" name="carNo" id="carNo" style="width: 100%" placeholder="12가1234" title="차량번호">
								</td>
								<td class="table-active" style="width: 12%"><span class="IBRequired">&nbsp</span>차량명</td>
								<td style="background-color:#fdfdfd;"><input type="text" name="carNm" id="carNm" style="width: 100%"placeholder="차량명" title="차량명"></td>
								<td class="table-active" style="width: 12%">차량구분</td>
								<td style="background-color:#fdfdfd;"><select name="carDivi" id="carDivi" title="차량구분" rows="14" cols="33" style="width: 100%;"></select></td>
							</tr>
							<tr>
								<td class="table-active">유종</td>
								<td style="background-color:#fdfdfd;" placeholder="12가1234"><select name="oilType" id="oilType" title="유종" rows="14" cols="33" style="width: 100%;"></select></td>
								<td class="table-active">보험사구분</td>
								<td style="background-color:#fdfdfd;"><select name="insuCorpDivi" id="insuCorpDivi" title="보험사구분" rows="14" cols="33" style="width: 100%;"></select></td>
								<td class="table-active">구입유형</td>
								<td style="background-color:#fdfdfd;"><select name="buyDivi" id="buyDivi" title="구입유형" rows="14" cols="33" style="width: 100%;"></select></td>
							</tr>
							<tr>
								<td class="table-active">정기검사만료</td>
								<td style="background-color:#fdfdfd;"><input type="date" name="periInspExpiDt" id="periInspExpiDt" class="form-control" style="width: 100%; border-radius: 3px;" title="정기검사만료" data-inputmask="'mask': '9999-99-99'" data-mask></td>
								<td class="table-active">보험만료일</td>
								<td style="background-color:#fdfdfd;"><input type="date" name="insuExpiDt" id="insuExpiDt" class="form-control" style="width: 100%; border-radius: 3px;" title="보험만료일" data-inputmask="'mask': '9999-99-99'" data-mask></td>
								<td class="table-active">구입일자</td>
								<td style="background-color:#fdfdfd;"><input type="date" name="buyDt" id="buyDt" class="form-control" style="width: 100%; border-radius: 3px;" title="구입일자" data-inputmask="'mask': '9999-99-99'" data-mask></td>
							</tr>
							<tr>
								<td class="table-active">연비</td>
								<td style="background-color:#fdfdfd;"><input type="text" name="fuelAmt" id="fuelAmt" style="width: 100%" title="연비" oninput="edsUtil.formatNumberHtmlInputForDouble(this)"></td>
								<td class="table-active">기초주행거리</td>
								<td style="background-color:#fdfdfd;"><input type="text" name="cumuMile" id="cumuMile" style="width: 100%" title="기초주행거리" oninput="edsUtil.formatNumberHtmlInputForInteger(this)"></td>
								<td class="table-active">부서&nbsp;<a onclick="popupHandler('depa','open'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
								<td style="background-color:#fdfdfd;">
									<input type="hidden" name="busiCd" id="busiCd" title="사업장코드">
									<input type="hidden" name="depaCd" id="depaCd" title="부서코드">
									<input name="depaNm" id="depaNm" title="부서명" readonly>
								</td>
							</tr>
							<tr>
								<td class="table-active">메모</td>
								<td colspan="5" style="background-color:#fdfdfd;"><textarea name="note" id="note" rows="21" cols="33" style="width: 100%;resize: none;" title="메모" placeholder="메모"></textarea></td>
							</tr>
						</table>
					</form>
					<!-- ./form -->
				</div>
			</div>
			<!--Footer-->
			<div class="row">
				<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
					<div class="col text-center">
						<form class="form-inline" role="form" name="baseGridListButtonForm" id="baseGridListButtonForm" method="post" onsubmit="return false;">
							<div class="container">
								<div class="row">
									<div class="col text-center">
										<button type="button" class="btn btn-sm btn-primary" name="btnSearch"	id="btnSearch"	onclick="doAction('baseGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnInput" 	id="btnInput"	onclick="doAction('baseGridList', 'input')"><i class="fa fa-plus"></i> 신규</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnSave" 	id="btnSave"	onclick="doAction('baseGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnDelete"	id="btnDelete"	onclick="doAction('baseGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="tab-pane fade" id="expe" role="tabpanel" aria-labelledby="expe-tab">
			<!--Body-->
			<div class="row">
				<div class="col-md-12" style="height: 100%;">
					<!-- 그리드 영역 -->
					<div class="row">
						<div class="col-md-12" id="baseExpeList" style="height: calc(36vh); width: 100%;">
							<!-- 시트가 될 DIV 객체 -->
							<div id="baseExpeListDIV" style="width:100%; height:100%;"></div>
						</div>
					</div>
					<!-- form start -->
					<form class="form-inline" role="form" name="baseExpeListForm" id="baseExpeListForm" method="post">
						<table class="table table-bordered table-sm" style="margin: unset;" id="carExpeTable">
							<tr>
								<td class="table-active" style="width: 12%"><span class="IBRequired"></span>승인구분</td>
								<td style="background-color:#fdfdfd;"><select name="apprDivi" id="apprDivi" title="승인구분" rows="14" cols="33" style="width: 100%;"></select></td>
								<td class="table-active">지출일자</td>
								<td style="background-color:#fdfdfd;"><input type="date" name="expeDt" id="expeDt" class="form-control" style="width: 100%; border-radius: 3px;" title="지출일자" data-inputmask="'mask': '9999-99-99'" data-mask></td>
								<td class="table-active">사용자&nbsp;<a onclick="popupHandler('user','open'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
								<td style="background-color:#fdfdfd;"><input type="hidden" name="empCd" id="empCd" title="사용자코드"><input name="empNm" id="empNm" title="사용자명" placeholder="사용자명" readonly></td>
							</tr>
							<tr>
								<td class="table-active">프로젝트&nbsp;<a onclick="popupHandler('proj','open'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
								<td colspan="5" style="background-color:#fdfdfd;"><input type="hidden" name="projCd" id="projCd" title="프로젝트코드"><input name="projNm" id="projNm" style="width: 100%;"title="프로젝트명" placeholder="프로젝트명" readonly></td>
							</tr>
							<tr>
								<td class="table-active">계정과목&nbsp;<a onclick="popupHandler('account','open'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
								<td style="background-color:#fdfdfd;"><input type="hidden" name="accountCd" id="accountCd" title="계정과목코드"><input name="accountNm" id="accountNm" title="계정과목명" placeholder="계정과목명" readonly></td>
								<td class="table-active" style="width: 12%"><span class="IBRequired"></span>지출구분</td>
								<td style="background-color:#fdfdfd;"><select name="expeDivi" id="expeDivi" title="지출구분" rows="14" cols="33" style="width: 100%;"></select></td>
								<td class="table-active" style="width: 12%"><span class="IBRequired"></span>결제수단</td>
								<td style="background-color:#fdfdfd;"><select name="payDivi" id="payDivi" title="결제수단" rows="14" cols="33" style="width: 100%;"></select></td>
							</tr>
							<tr>
								<td class="table-active">금액</td>
								<td style="background-color:#fdfdfd;"><input type="text" name="expeAmt" id="expeAmt" style="width: 100%" title="금액" placeholder="금액"></td>
																<td class="table-active">사진&nbsp;<a onclick="doAction('baseExpeFileList','imgPopOpne'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a></td>
								<td style="background-color:#fdfdfd;"><input type="text" name="qty" id="qty" style="width: 100%" title="사진" placeholder="사진" readonly></td>
								<td class="table-active">부서&nbsp;<%--<a onclick="popupHandler('depa','open'); return false;" style="cursor:pointer;"><i class="fa fa-search"></i></a>--%></td>
								<td style="background-color:#fdfdfd;"><input type="hidden" name="depaCd" id="depaCd" title="부서코드"><input name="depaNm" id="depaNm" title="부서명" placeholder="부서명" readonly></td>
							</tr>
							<tr>
								<td class="table-active">메모</td>
								<td colspan="5" style="background-color:#fdfdfd;"><textarea name="note" id="note" rows="9" cols="33" style="width: 100%;resize: none;" title="메모" placeholder="메모"></textarea></td>
							</tr>
						</table>
					</form>
					<!-- ./form -->
				</div>
			</div>
			<!--Footer-->
			<div class="row">
				<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
					<div class="col text-center">
						<form class="form-inline" role="form" name="baseExpeListButtonForm" id="baseExpeListButtonForm" method="post" onsubmit="return false;">
							<div class="container">
								<div class="row">
									<div class="col text-center">
										<button type="button" class="btn btn-sm btn-primary" name="btnSearch1"		id="btnSearch1"	onclick="doAction('baseExpeList', 'search')"><i class="fa fa-search"></i> 조회</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnInput1" 		id="btnInput1"	onclick="doAction('baseExpeList', 'input')"><i class="fa fa-plus"></i> 신규</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnSave1" 		id="btnSave1"	onclick="doAction('baseExpeList', 'save')"><i class="fa fa-save"></i> 저장</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnDelete1"		id="btnDelete1"	onclick="doAction('baseExpeList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
										<button type="button" class="btn btn-sm btn-primary" name="btnImgPopEv"		id="btnImgPopEv"	data-toggle="modal" data-target="#modalCart"  style="display: none"></button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<div class="modal fade" id="modalCart" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header bg-dark font-color" name="tabs" id="tabs" style="color: #4d4a41">
				<h4 class="modal-title">사진</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
				<div class="col-md-7" style="height: 100%;" id="baseExpeFileList">
					<!-- 시트가 될 DIV 객체 -->
					<div id="baseExpeFileListDIV" style="width:100%; height:100%;"></div>
				</div>
				<div class="col-md-5" style="height: 100%;"  name="carImgPlcae" id="carImgPlcae">
					<!-- 시트가 될 DIV 객체 -->

					<style>
						.wrap{
							position: absolute;
							top: 0;
							left: 0;
							width: 100%;
							height: 100%;
							text-align: center;
						}

						.target {
							position: relative;
							width: 100%;
							height: 100%;
							overflow: hidden;
							margin: 0 auto;
						}

						.photo {
							position: absolute;
							top: 0;
							left: 0;
							width: 100%;
							height: 100%;
							background-repeat: no-repeat;
							background-position: center;
							background-size: cover;
							transition: transform .5s ease-out;
						}
					</style>
					<div class="wrap">
						<div class="target" data-scale="3.5">
							<img class="photo" style="object-fit: scale-down" id="carImg" name="carImg">
						</div>
					</div>
					<script>
						window.onload = function () {
							$('.target')
									.on('mouseover', function () {
										$(this).children('.photo').css({
											'transform': 'scale(' + $(this).attr('data-scale') + ')'
										});
									})
									.on('mouseout', function () {
										$(this).children('.photo').css({
											'transform': 'scale(1)'
										});
									})
									.on('mousemove', function (e) {
										$(this).children('.photo').css({
											'transform-origin': ((e.pageX - $(this).offset().left) / $(this).width()) * 100 + '% ' + ((e.pageY - $(this).offset().top) / $(this).height()) * 100 + '%'
										});
									})
						};
					</script>
				</div>
				</div>
			</div>
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; /*background-color: #ebe9e4*/">
						<div class="col text-center">
							<form class="form-inline" role="form" name="baseExpeFileListButtonForm" id="baseExpeFileListButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch5"	id="btnSearch5"	onclick="doAction('baseExpeFileList', 'search')"><i class="fa fa-search"></i> 조회</button>
											<input type="file" id="files" name="files" multiple style="display: none">
											<label for="files" type="button" class="btn btn-sm btn-primary" name="btnInput5"	id="btnInput5"	style="width:fit-content;display: inline;" ><i class="fa fa-plus"></i> 신규</label>
											<button type="button" class="btn btn-sm btn-primary" name="btnSave5"	id="btnSave5"	onclick="doAction('baseExpeFileList', 'save')"><i class="fa fa-save"></i> 저장</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete5"	id="btnDelete5"	onclick="doAction('baseExpeFileList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose5"	id="btnClose5"	onclick="doAction('baseExpeFileList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>

</body>
<%--<script type="text/javascript" src='/dropzone/min/dropzoneInit.js'></script>--%>
</html>