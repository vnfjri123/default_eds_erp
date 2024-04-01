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
		var guMaeGridList, gumaeGridEmail;
		var gumaeEditor;

		$(document).ready(function () {
			init();
			/**
			 * 조회 엔터 기능
			 * */
			document.getElementById('searchForm').addEventListener('keyup', async ev=>{
				var id = ev.target.id;
				if(ev.keyCode === 13){
					await doAction('guMaeGridList', 'search');
				}
			});
		});

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "gumae");

			/* 조회옵션 셋팅 */
			document.getElementById('corpCd').value = '<c:out value="${LoginInfo.corpCd}"/>';
			<%--document.getElementById('busiCd').value = '<c:out value="${LoginInfo.busiCd}"/>';--%>
			<%--document.getElementById('busiNm').value = '<c:out value="${LoginInfo.busiNm}"/>';--%>

			/* 권한에 따라 회사, 사업장 활성화 */
			var authDivi = '<c:out value="${LoginInfo.authDivi}"/>';
			if(authDivi === "03" || authDivi === "04"){
				document.getElementById('busiCd').disabled = true;
				document.getElementById('btnBusiCd').disabled = true;
			}

			/* Button 셋팅 */
			await edsUtil.setButtonForm(document.querySelector("#guMaeGridListButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#baseEmailForm"));
			await edsUtil.setButtonForm(document.querySelector("#gumaeEmailButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#gumaePrintButtonForm"));

			/**********************************************************************
			 * editor 영역 START
			 ***********************************************************************/
			gumaeEditor = new toastui.Editor({
				el: document.querySelector('#note'),
				height: '400px',
				language: 'ko',
				initialEditType: 'wysiwyg',
				theme: 'dark',
				hooks: {
					async addImageBlobHook(blob, callback) {
						// console.log(blob)
						await edsUtil.beforeUploadImageFile(blob, callback, 'collect')
					},
				}
			});

			// editor.getMarkdown();
			/**********************************************************************
			 * editor 영역 END
			 ***********************************************************************/

			/*********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/

			/* 그리드 초기화 속성 설정 */
			guMaeGridList = new tui.Grid({
				el: document.getElementById('guMaeGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum', */'checkbox'],
				header: {
					height: 40,
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
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						supAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt2: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						supAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt3: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			guMaeGridList.setColumns([
				{ header:'수금일',		name:'colDt',		width:80,		align:'center',	defaultValue: '',	editor:{type:'datePicker',options:{format:'yyyy-MM-dd'}},	sortable: true},
				{ header:'수금구분',		name:'colDivi',		width:210,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM032")}},	formatter: 'listItemText',	filter: { type: 'text'},	sortable: true},
				{ header:'사업장',		name:'busiNm',		width:140,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'프로젝트명',	name:'projNm',		width:140,		align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'거래처',		name:'custNm',		width:140,		align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'공급가액',		name:'supAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'부가세액',		name:'vatAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'}},
				{ header:'합계금액',		name:'totAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);},	editor:{type:'text'},	sortable: true},
				{ header:'적요',			name:'note1',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'결재자보고내용',name:'note2',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'부서',			name:'depaNm',		width:80,		align:'center',	defaultValue: ''	},
				{ header:'담당자',		name:'manNm',		width:50,		align:'center',	defaultValue: ''	},
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: ''	},
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'수금코드',		name:'colCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적일자',		name:'estDt',		width:80,		align:'center',	hidden:true },
				{ header:'유효기간',		name:'validDt',		width:80,		align:'center',	hidden:true },
				{ header:'계약일자',		name:'cntDt',		width:80,		align:'center',	hidden:true },
				{ header:'납기일자',		name:'dueDt',		width:80,		align:'center',	hidden:true },
				{ header:'종료일자',		name:'endDt',		width:80,		align:'center',	hidden:true },
				{ header:'성공',			name:'sccDivi',		width:40,		align:'center',	hidden:true },
				{ header:'구분',			name:'projDivi',	width:40,		align:'center',	hidden:true },
				{ header:'마감',			name:'deadDivi',	width:55,		align:'center',	hidden:true },
				{ header:'분류',			name:'clas',		width:80,		align:'center',	hidden:true },
				{ header:'품목',			name:'item',		width:80,		align:'center',	hidden:true },
				{ header:'결제조건',		name:'payTm',		width:80,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'담당자코드',	name:'manCd',		width:100,		align:'center',	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,		align:'right',	hidden:true },
			]);

			gumaeGridEmail = new tui.Grid({
				el: document.getElementById('gumaeGridEmailDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ 'checkbox'],
				header: {
					height: 40,
					minRowHeight: 40,
				},
				columns:[],
				columnOptions: {
					resizable: true,
					/*frozenCount: 1,
					frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
				},
			});

			gumaeGridEmail.setColumns([
				{ header:'보낸일시',		name:'inpDttm',		minWidth:150,	align:'left',	defaultValue: ''	},
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',	defaultValue: ''	},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'수금코드',		name:'colCd',		width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
				{ header:'구분',			name:'divi',		width:100,	align:'center',	hidden:true },
				{ header:'보내는주소',	name:'setForm',		width:100,	align:'center',	hidden:true },
				{ header:'받는주소',		name:'toAddr',		width:100,	align:'center',	hidden:true },
				{ header:'참조주소',		name:'ccAddr',		width:100,	align:'center',	hidden:true },
				{ header:'숨은참조주소',	name:'bccAddr',		width:100,	align:'center',	hidden:true },
				{ header:'제목',			name:'setSubject',	width:100,	align:'center',	hidden:true },
				{ header:'내용',			name:'note',		width:100,	align:'center',	hidden:true },
				{ header:'수정자',		name:'updNm',		width:100,	align:'center',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			/*필터 이후 포커스*/
			guMaeGridList.on('afterFilter', async ev => {
				if(ev.instance.store.data.filteredIndex.length>0){
					guMaeGridList.focusAt(0,0,true)
				}
			});

			guMaeGridList.on('focusChange', async ev => {
				if(ev.rowKey !== ev.prevRowKey){
					if (edsUtil.getAuth("Save") === "1") {// 수정권한 체크
						if (guMaeGridList.getValue(ev.rowKey, "deadDivi") === '1') {
							document.getElementById('btnSave').disabled = true;
							document.getElementById('btnDelete').disabled = true;
							document.getElementById('btnPrint').disabled = true;
							document.getElementById('btnEmailPopup').disabled = true;
						} else {
							document.getElementById('btnSave').disabled = false;
							document.getElementById('btnDelete').disabled = false;
							document.getElementById('btnPrint').disabled = false;
							document.getElementById('btnEmailPopup').disabled = false;
						}
						// 메인 시트 마감 처리 : 다른 시트 rawData값 못불러와서 서브 시트는 따로 처리
						// await edsUtil.setClosedRow(guMaeGridList)
					}
				}
			});

			guMaeGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='custNm') await popupHandler('cust_list','open');
					else if(colNm==='manNm') await popupHandler('user_manNm','open');
					else if(colNm==='depaNm') await popupHandler('depa','open');
					else if(colNm==='projNm') await popupHandler('proj','open');
					else if(colNm==='note1' || colNm==='note2') {
						await edsUtil.sheetData2Maldal(guMaeGridList);
					}
				}else{
					// guMaeGridList.finishEditing();
				}
			});

			guMaeGridList.on('editingFinish', ev => {

				var columnName = ev.columnName;
				var rowKey = ev.rowKey;

				/**
				 * 견적일자, 유효기간 날짜 계산
				 * */
				if(columnName === 'estDt'){
					const validDt = new Date(guMaeGridList.getValue(rowKey,'estDt'));
					validDt.setMonth(validDt.getMonth() + 1);
					guMaeGridList.setValue(rowKey,'validDt',validDt.toISOString().substring(0,10))
				}else if(columnName === 'validDt'){
					const estDt = new Date(guMaeGridList.getValue(rowKey,'validDt'));
					estDt.setMonth(estDt.getMonth() - 1);
					guMaeGridList.setValue(rowKey,'estDt',estDt.toISOString().substring(0,10))
				}

				/**
				 * 매입가, 견적가 계산
				 * */
				var supAmt2 = guMaeGridList.getValue(rowKey, 'supAmt2');
				var vatAmt2 = guMaeGridList.getValue(rowKey, 'vatAmt2');
				var totAmt2 = guMaeGridList.getValue(rowKey, 'totAmt2');
				var supAmt2All = 0;
				var vatAmt2All = 0;
				var totAmt2All = 0;

				var supAmt3 = guMaeGridList.getValue(rowKey, 'supAmt3');
				var vatAmt3 = guMaeGridList.getValue(rowKey, 'vatAmt3');
				var totAmt3 = guMaeGridList.getValue(rowKey, 'totAmt3');
				var supAmt3All = 0;
				var vatAmt3All = 0;
				var totAmt3All = 0;

				// 별도, 포함
				switch (columnName) {
					case 'supAmt2' :
						/* 매입가 */
						vatAmt2 = supAmt2/10; // TAX
						totAmt2 = supAmt2/1.1; // 공급가액
						break;
					case 'supAmt3' :
						/* 견적가 */
						vatAmt3 = supAmt3/10; // TAX
						totAmt3 = supAmt3/1.1; // 공급가액
						break;
					case 'totAmt2' :
						/* 매입가 */
						supAmt2 = totAmt2/11*10; // 공급가액
						vatAmt2 = totAmt2/11; // TAX
						break;
					case 'totAmt3' :
						/* 견적가 */
						supAmt3 = totAmt3/11*10; // 공급가액
						vatAmt3 = totAmt3/11; // TAX
						break;
				}

				/**
				 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
				 * */

				/* 매입가 */
				supAmt2 = Math.ceil(supAmt2);  // 올림
				vatAmt2 = Math.floor(vatAmt2); // 내림
				totAmt2 = supAmt2 + vatAmt2; // 합계
				guMaeGridList.setValue(rowKey, "supAmt2", supAmt2);
				guMaeGridList.setValue(rowKey, "vatAmt2", vatAmt2);
				guMaeGridList.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

				/* 견적가 */
				supAmt3 = Math.ceil(supAmt3);  // 올림
				vatAmt3 = Math.floor(vatAmt3); // 내림
				totAmt3 = supAmt3 + vatAmt3; // 합계
				guMaeGridList.setValue(rowKey, "supAmt3", supAmt3);
				guMaeGridList.setValue(rowKey, "vatAmt3", vatAmt3);
				guMaeGridList.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

				/* 매입가+견적가+계약금액 합계 적용 */
				var data = guMaeGridList.getFilteredData()
				var dataLen = data.length;
				for (let i = 0; i < dataLen; i++) {
					supAmt2All += Number(data[i].supAmt2);
					vatAmt2All += Number(data[i].vatAmt2);
					totAmt2All += Number(data[i].totAmt2);
					supAmt3All += Number(data[i].supAmt3);
					vatAmt3All += Number(data[i].vatAmt3);
					totAmt3All += Number(data[i].totAmt3);
				}
				guMaeGridList.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmt2All));
				guMaeGridList.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmt2All));
				guMaeGridList.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmt2All));

				guMaeGridList.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmt3All));
				guMaeGridList.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmt3All));
				guMaeGridList.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmt3All));
			});

			gumaeGridEmail.on('focusChange', async ev => {
				if(ev.rowKey !== ev.prevRowKey){

					var rowKey = ev.rowKey;
					var data = gumaeGridEmail.getRow(rowKey);
					var keys = Object.keys(data);

					/* 이메일 내역 세팅*/
					for (let i = 0; i < keys.length; i++) {
						var key = keys[i];
						var doc = document.getElementById(key);
						if(doc){ // input
							// console.log(key + ' is exist');
							if(key==='note'){
								gumaeEditor.setHTML(data[key], true);
							}else{
								doc.value = data[key];
							}
						}else{ // note
							// console.log(key + ' is not exist');
						}
					}

					/* 이메일 첨부파일 조회 및 세팅*/
					var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
					param.colCd = gumaeGridEmail.getValue(rowKey, 'colCd');
					param.emailSeq = gumaeGridEmail.getValue(rowKey, 'seq');
					param.divi = 'collect';
					var emailFileInfo = edsUtil.getAjax("/EMAIL_MGT/selectSendEmailFileInfo", param); // 데이터 set

					let files = emailFileInfo;
					let filesLength = files.length;
					let filesName = '';
					for (let i = 0; i < filesLength; i++) {
						if(filesLength === 1 || filesLength === i + 1){
							filesName += (files[i].origNm+'.'+files[i].ext);
						}else{
							filesName += ((files[i].origNm+'.'+files[i].ext) + ', ');
						}
					}
					/**
					 * 파일 초기화
					 * */
					await edsUtil.resetFileForm(document.getElementById('emailFile'));
					document.querySelector('label[for="emailFile"]').innerText = filesName;
				}
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			// document.getElementById('guMaeGridList').style.height = (innerHeight)*(1-0.11) + 'px';
			// document.getElementById('gumaeGridEmail').style.height = (innerHeight)*(1-0.25) + 'px';
			doAction('guMaeGridList', 'search');
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'guMaeGridList') {
				switch (sAction) {
					case "search":// 조회

						guMaeGridList.finishEditing(); // 데이터 초기화
						guMaeGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						guMaeGridList.resetData(edsUtil.getAjax("/GUMAE_COL_MGT/selectColMgtList", param)); // 데이터 set

						// if(guMaeGridList.getRowCount() > 0 ){
						// 	guMaeGridList.focusAt(0, 0, true);
						// }
						break;
					case "input":// 신규

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = $("#searchForm #corpCd").val();
						appendedData.busiCd = $("#searchForm #busiCd").val();
						appendedData.estCd = '1234';
						appendedData.projCd = '1234';
						appendedData.closeYn = '0';
						appendedData.colDt = edsUtil.getToday("%Y-%m-%d");

						/* 견적일자로부터 1달*/
						const newDate = new Date(edsUtil.getToday("%Y-%m-%d"));
						newDate.setMonth(newDate.getMonth() + 1);
						appendedData.validDt = edsUtil.getToday(newDate.toISOString().substring(0,10));

						appendedData.supAmt2 = 0;
						appendedData.vatAmt2 = 0;
						appendedData.totAmt2 = 0;
						appendedData.supAmt3 = 0;
						appendedData.vatAmt3 = 0;
						appendedData.totAmt3 = 0;

						guMaeGridList.prependRow(appendedData, { focus:true }); // 마지막 ROW 추가

						// await doAction('guMaeGridList', 'save');

						break;
					case "save"://저장
						await edsUtil.doCUD("/GUMAE_COL_MGT/cudColMgtList", "guMaeGridList", guMaeGridList);
						break;
					case "delete"://삭제
						await guMaeGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/GUMAE_COL_MGT/cudColMgtList", "guMaeGridList", guMaeGridList);
						break;
					case "finish"://마감
						await edsUtil.doDeadline(
								"/GUMAE_COL_MGT/deadLineColMgtList",
								"guMaeGridList",
								guMaeGridList,
								'1');
						break;
					case "cancel"://마감취소
						await edsUtil.doDeadline(
								"/GUMAE_COL_MGT/deadLineColMgtList",
								"guMaeGridList",
								guMaeGridList,
								'0');
						break;
					case "print"://인쇄
						var chk = guMaeGridList.getCheckedRows();

						if(chk.length === 0 ){
							Swal.fire({
								icon: 'error',
								title: '실패',
								text: "인쇄할 내용이 없습니다.",
							})
							return;
						}else{
							document.querySelector('input[value="prints1"]').setAttribute('checked', 'checked');
							document.getElementById('btnPrint3').style.display = 'inline';
							document.getElementById('btnPrint2').click();
						}

						break;
					case "print2":// 수금 선택

						// document.getElementById('btnPrint3').style.display = 'block';

						break;
					case "print3"://인쇄
						var chk = guMaeGridList.getCheckedRows();
						var printKind = document.querySelector('input[name="prints"]:checked').value
						var param = new Array();
						for(var i=0;i<chk.length;i++){
							var num = chk[i].totAmt2;
							var num2han = await edsUtil.num2han(num);
							var element = {
								corpCd : '<c:out value="${LoginInfo.corpCd}"/>',
								busiCd : '<c:out value="${LoginInfo.busiCd}"/>',
								colCd : chk[i].colCd,
								num : edsUtil.addComma(num),
								num2han : num2han,
								printKind : printKind,
							};
							param.push(element)
						}
						jr.open(param, 'gumae_gyesanseo');
						break;
					case "emailPopup":// 이메일 팝업 보기

						var row = guMaeGridList.getFocusedCell();
						var colCd = guMaeGridList.getValue(row.rowKey,'colCd');
						if(colCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '수금전표가 없습니다.',
							});
						}else{
							document.getElementById('btnEmailPopEv').click();
							document.getElementById('setFrom').value = '<c:out value="${LoginInfo.empNm}"/>'+' <'+'<c:out value="${LoginInfo.email}"/>'+'>';
							setTimeout(ev=>{
								document.getElementById('btnSearch3').click();
							}, 300)
						}
						break;
					case "apply"://저장
						await popupHandler('apply_col','open');
						break;
				}
			}else if (sheetNm == 'gumaeGridEmail') {
				switch (sAction) {
					case "search":// 조회

						gumaeGridEmail.refreshLayout(); // 데이터 초기화
						gumaeGridEmail.finishEditing(); // 데이터 마감
						gumaeGridEmail.clear(); // 데이터 초기화

						/* 이메일 조회 */
						var row = guMaeGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = guMaeGridList.getValue(row.rowKey, 'estCd');
						param.projCd = guMaeGridList.getValue(row.rowKey, 'projCd');
						param.colCd = guMaeGridList.getValue(row.rowKey, "colCd");
						param.divi = 'collect';
						gumaeGridEmail.resetData(edsUtil.getAjax("/EMAIL_MGT/selectSendEmailInfo", param)); // 데이터 set

						if(gumaeGridEmail.getRowCount() > 0 ){
							gumaeGridEmail.focusAt(0, 0, true);
						}

						break;
					case "input":// 신규

						/**
						 * input 초기화
						 * */
						document.getElementById('setFrom').value = "";
						document.getElementById('toAddr').value = "";
						document.getElementById('ccAddr').value = "";
						document.getElementById('bccAddr').value = "";
						document.getElementById('setSubject').value = "";
						/**
						 * 파일 초기화
						 * */
						await edsUtil.resetFileForm(document.getElementById('emailFile'));
						document.querySelector('label[for="emailFile"]').innerText = "";
						/**
						 * 에디터 초기화
						 * */
						gumaeEditor.reset();

						break;
					case "delete"://삭제
						await gumaeGridEmail.removeCheckedRows(true);
						await edsUtil.doCUD("/GUMAE_COL_MGT/cudColEmailList", "gumaeGridEmail", gumaeGridEmail);
						break;
					case "print4":// 수금 선택

							document.getElementById('btnPrint3').style.display = 'none';

						break;
					case "emailSend":// 보내기

						var printKind = '';// document.querySelector('input[name="prints"]:checked')
						// if(!printKind){
						// 	return Swal.fire({
						// 		icon: 'error',
						// 		title: '실패',
						// 		text: '수금 버튼을 누르고 인감 분류를 체크하세요.',
						// 	});
						// }

						// file 가져오기
						var file = $('#emailFile'); // input type file tag

						// formData 생성
						var clonFile = file.clone();

						var newForm = $('<form></form>');
						newForm.attr("method", "post");
						newForm.attr("enctype","multipart/form-data");
						newForm.append(clonFile);

						// 추가적 데이터 입력
						/* 메세지 파라미터*/
						var formData = new FormData(newForm[0]);
						formData.append("divi",			'collect');
						formData.append("sendDivi",		'send');
						var row = guMaeGridList.getFocusedCell();
						var estCd = guMaeGridList.getValue(row.rowKey,'estCd');
						var projCd = guMaeGridList.getValue(row.rowKey,'projCd');
						var colCd = guMaeGridList.getValue(row.rowKey,'colCd');
						var busiCd = guMaeGridList.getValue(row.rowKey,'busiCd');
						formData.append("estCd",		estCd);
						formData.append("projCd",		projCd);
						formData.append("colCd",		colCd);
						formData.append("setFrom",		document.getElementById('setFrom').value);
						formData.append("toAddr",		document.getElementById('toAddr').value);
						formData.append("ccAddr",		document.getElementById('ccAddr').value);
						formData.append("bccAddr",		document.getElementById('bccAddr').value);
						formData.append("setSubject",	document.getElementById('setSubject').value);
						formData.append("html",			gumaeEditor.getHTML());

						/* 기존 이메일 순번*/
						var row = gumaeGridEmail.getFocusedCell();
						var beforeEmailSeq = gumaeGridEmail.getValue(row.rowKey,'seq');
						formData.append("beforeEmailSeq",beforeEmailSeq);

						/* 수금 파라미터*/
						var row = guMaeGridList.getFocusedCell();
						var num = guMaeGridList.getValue(row.rowKey,'totAmt2');
						var num2han = await edsUtil.num2han(num);
						formData.append("id",			'gumae_gyesanseo');
						formData.append("busiCd",		busiCd);
						formData.append("num",			edsUtil.addComma(num));
						formData.append("num2han",		num2han);
						formData.append("printKind",	printKind.value);

						$.ajax({
							url: "/EMAIL_MGT/sendEmail",
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
									await doAction('gumaeGridEmail','search');
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
			var row = guMaeGridList.getFocusedCell();
			var names = name.split('_');
			switch (names[0]) {
				case 'adress':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('EMAILADRESSPOPUP',param);
					}else{
						/**
						 * name = adress_documentId => documentId setting
						 * */
						var returnName = name.split('_');
						var input = document.getElementById(returnName[1]);

						/**
						 * inputArr + callbackArr and remove duplicates
						 * */
						var inputArr = [...new Set(input.value.split(',').concat(callback.adress))]

						/**
						 * 보내는 사람일 경우 첫번째 선택한 사람 적용
						 * */
						if(returnName[1] === 'setFrom'){
							input.value = (inputArr[1]==undefined?input.value:inputArr[1]);
						}else{
							/**
							 * 보내는 사람일 외 경우 빈값 처리 후 적용
							 * */
							for (let i = 0; i < inputArr.length; i++) {
								if(inputArr[i] === ''){
									inputArr.splice(i, 1);
									i--;
								}
							}
							input.value = inputArr;
						}

					}
					break;
				case 'busi':
					if(divi==='open'){
						var param={}
						param.corpCd= $("#searchForm #corpCd").val(),
								param.busiCd= document.getElementById('busiCd').value
						param.name= name;
						await edsIframe.openPopup('BUSIPOPUP',param)
						document.querySelector('form[id="searchForm"] input[id="busiCd"]').value = '';
						document.querySelector('form[id="searchForm"] input[id="busiNm"]').value = '';
					}else{
						document.querySelector('form[id="searchForm"] input[id="busiCd"]').value = callback.busiCd;
						document.querySelector('form[id="searchForm"] input[id="busiNm"]').value = callback.busiNm;
					}
					break;
				case 'cust':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.custNm= guMaeGridList.getValue(row.rowKey, 'custNm');
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						var sheet, col, row;
						if(names[1] === 'list') {sheet=guMaeGridList;col='cust';row=guMaeGridList.getFocusedCell();}
						sheet.setValue(row.rowKey,col+'Cd',callback.custCd);
						sheet.setValue(row.rowKey,col+'Nm',callback.custNm);
					}
					break;
				case 'apply':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						// await edsIframe.openPopup('PROJPOPUP',param);
						await edsIframe.openPopup('RECPOPUP',param);
					}else{
						if(names[1] === 'col') {
							if(callback.rows === undefined) return;
							await edsUtil.doApply("/GUMAE_COL_MGT/aRecMgtList", callback.rows);
							await doAction('guMaeGridList','search');
						}
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
						if(callback.rows === undefined) return;

						guMaeGridList.setValue(row.rowKey,'projCd',callback.rows[0].projCd);
						guMaeGridList.setValue(row.rowKey,'projNm',callback.rows[0].projNm);
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.depaNm= guMaeGridList.getValue(row.rowKey, 'depaNm')??'';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						guMaeGridList.setValue(row.rowKey,'depaCd',callback.depaCd);
						guMaeGridList.setValue(row.rowKey,'depaNm',callback.depaNm);
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
						var sheet, col, row;
						if(names[1] === 'manNm') {sheet=guMaeGridList;col='man';row=guMaeGridList.getFocusedCell();}
						sheet.setValue(row.rowKey,col+'Cd',callback.empCd);
						sheet.setValue(row.rowKey,col+'Nm',callback.empNm);
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
							<label >사업장 &nbsp;</label>
							<div class="input-group-prepend" style="min-width: 15rem;">
								<select class="form-control select2" style="width: 100%;" name="busiCd" id="busiCd">
								</select>
							</div>
<%--							<label for="busiCd">사업장 &nbsp;</label>--%>
<%--							<div class="input-group-prepend">--%>
<%--								<input type="text" class="form-control" style="width: 100px; font-size: 15px;" name="busiCd" id="busiCd" title="사업장코드">--%>
<%--							</div>--%>
<%--							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>--%>
<%--							<div class="input-group-append">--%>
<%--								<input type="text" class="form-control" name="busiNm" id="busiNm" title="사업장명" disabled>--%>
<%--							</div>--%>
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
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="projNm">프로젝트 &nbsp;</label>
							<input type="text" class="form-control" name="projNm" id="projNm" title="프로젝트명">
							<div class="form-group-append">
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-primary btn-flat" name="btnProjCd" id="btnProjCd" onclick="doAction('guMaeGridList','search'); return false;">검색</button></span>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" id="guMaeGridList" style="height: calc(100vh - 6rem); width: 100%;">
				<!-- 시트가 될 DIV 객체 -->
				<div id="guMaeGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="guMaeGridListButtonForm" id="guMaeGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnFinish"			id="btnFinish"				onclick="doAction('guMaeGridList', 'finish')"><i class="fa fa-lock"></i> 마감</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnCancel"			id="btnCancel"				onclick="doAction('guMaeGridList', 'cancel')"><i class="fa fa-unlock"></i> 마감취소</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"			id="btnSearch"				onclick="doAction('guMaeGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput"			id="btnInput"				onclick="doAction('guMaeGridList', 'input')" hidden><i class="fa fa-plus"></i> 신규</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSave"				id="btnSave"				onclick="doAction('guMaeGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete"			id="btnDelete"				onclick="doAction('guMaeGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnPrint"			id="btnPrint"				onclick="doAction('guMaeGridList', 'print')" style="display: none"><i class="fa fa-print"></i> 인쇄</button>

									<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopup"		id="btnEmailPopup"			onclick="doAction('guMaeGridList', 'emailPopup')"><i class="fa fa-envelope"></i> 메일전송</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnApply"			id="btnApply"				onclick="doAction('guMaeGridList', 'apply')"><i class="fa fa-cloud-download"></i> 미수채권적용</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopEv"		id="btnEmailPopEv"		data-toggle="modal" data-target="#modalCart3" style="display: none"></button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalCart3" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header">
				<h4 class="modal-title">이메일 전송</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<div class="row">
					<div class="col-md-5" style="height: 100%;">
						<div class="row">
							<div class="col-md-12" id="gumaeGridEmail" style="height: calc(71vh); width: 100%;">
								<div id="gumaeGridEmailDIV" style="width:100%; height:100%;"></div>
							</div>
						</div>
					</div>
					<div class="col-md-7" style="height: 100%;">
						<div class="row">
							<div class="col-md-12" style="height: 100%;">
								<!-- form start -->
								<form class="form-inline" role="form" name="baseEmailForm" id="baseEmailForm" method="post" onsubmit="return false;">
									<table class="table table-bordered table-sm">
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">보내는 사람</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="setFrom" id="setFrom"/>
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button" onclick="popupHandler('adress_setFrom','open'); return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">받는 사람</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="toAddr" id="toAddr">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_toAddr','open'); return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">참조</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="ccAddr" id="ccAddr">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_ccAddr','open');  return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">숨은 참조</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="bccAddr" id="bccAddr">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button"  onclick="popupHandler('adress_bccAddr','open');  return false;"><i class="fa fa-search"></i></button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">제목</td>
											<td style="padding: 0">
												<div class="input-group">
													<input type="text" class="form-control" name="setSubject" id="setSubject">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table-active" style="width: 25%; text-align: center">파일 첨부</td>
											<td style="padding: 0">
												<div class="input-group">
													<div class="custom-file">
														<input style="text-align: left" type="file" class="custom-file-input" name="emailFile" id="emailFile" aria-describedby="emailFile" multiple>
														<label class="custom-file-label" for="emailFile">파일을 선택하세요</label>
													</div>
													<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" name="btnPrint4" id="btnPrint4" onclick="doAction('gumaeGridEmail', 'print4')" data-target="#modalCart2" style="display: none"><i class="fa fa-print"></i> 수금</button>
													<script>
														document.getElementById('emailFile').addEventListener('change', (ev) =>{
															let files = ev.target.files;
															let filesLength = files.length;


															let filesName = '';
															for (let i = 0; i < filesLength; i++) {
																if(filesLength === 1 || filesLength === i + 1){
																	filesName += files[i].name;
																}else{
																	filesName += (files[i].name + ', ');
																}
															}
															document.querySelector('label[for="emailFile"]').innerText = filesName;
														});
													</script>
												</div>
											</td>
										</tr>
									</table>
								</form>
								<!-- ./form -->
								<div id="note" ></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="gumaeEmailButtonForm" id="gumaeEmailButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary" name="btnSearch3"		id="btnSearch3"		onclick="doAction('gumaeGridEmail', 'search')"><i class="fa fa-search"></i> 조회</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnInput3"		id="btnInput3"		onclick="doAction('gumaeGridEmail', 'input')" ><i class="fa fa-plus"></i> 신규</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnEmailSend"	id="btnEmailSend"	onclick="doAction('gumaeGridEmail', 'emailSend')"><i class="fa fa-print"></i> 전송</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnDelete3"		id="btnDelete3"		onclick="doAction('gumaeGridEmail', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose3"		id="btnClose3"		onclick="doAction('gumaeGridEmail', 'btnClose')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
<div class="modal fade" id="modalCart2" tabindex="-1" role="dialog"
	 aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<!--Header-->
			<div class="modal-header">
				<h4 class="modal-title">수금 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<!--Body-->
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12" style="height: 100%;">
						<!-- form start -->
						<form class="form-inline" role="form" name="baseGridListForm" id="baseGridListForm" method="post" onsubmit="return false;">
							<table class="table table-bordered table-sm">
								<tr>
									<th class="table-active" style="width: 30%; text-align: center">사업장</th>
									<th class="table-active" style="text-align: center">법인대표인감</th>
									<th class="table-active" style="text-align: center">법인사용인감</th>
								</tr>
								<tr>
									<td class="table-active">이디에스(주)</td>
									<td><input type="radio" name="prints" value="prints1"  style="width: 100%;" ></td>
									<td style="text-align: center">-</td>
								</tr>
								<tr>
									<td class="table-active">(주)토마토아이앤에스</td>
									<td><input type="radio" name="prints" value="prints2"  style="width: 100%;" ></td>
									<td><input type="radio" name="prints" value="prints3"  style="width: 100%;" ></td>
								</tr>
								<tr>
									<td class="table-active" title="주식회사 티엠티">이디에스(주) (청주)</td>
									<td><input type="radio" name="prints" value="prints4"  style="width: 100%;" ></td>
									<td><input type="radio" name="prints" value="prints5"  style="width: 100%;" ></td>
								</tr>
							</table>
						</form>
						<!-- ./form -->
					</div>
				</div>
			</div>
			<!--Footer-->
			<div class="modal-footer" style="display: block">
				<div class="row">
					<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
						<div class="col text-center">
							<form class="form-inline" role="form" name="gumaePrintButtonForm" id="gumaePrintButtonForm" method="post" onsubmit="return false;">
								<div class="container">
									<div class="row">
										<div class="col text-center">
											<button type="button" class="btn btn-sm btn-primary d-none" name="btnPrint2"		id="btnPrint2"	onclick="doAction('gumaeGridEmail', 'print2')" data-toggle="modal" data-target="#modalCart2" style="display: none"></button>
											<button type="button" class="btn btn-sm btn-primary" name="btnPrint3"		id="btnPrint3"	onclick="doAction('guMaeGridList', 'print3')"><i class="fa fa-print"></i> 인쇄</button>
											<button type="button" class="btn btn-sm btn-primary" name="btnClose2"		id="btnClose2"	onclick="doAction('guMaeGridList', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
</body>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>