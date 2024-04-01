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
		var projectGridList, projectGridPart, projectGridCost;

		$(document).ready(async function () {
			await init();

			/**
			 * 조회 엔터 기능
			 * */
			document.getElementById('searchForm').addEventListener('keyup', async ev=>{
				var id = ev.target.id;
				if(ev.keyCode === 13){
					await doAction('projectGridList', 'search');
				}
			});

			await edsUtil.setColorForSelectedRow(projectGridList);
			await edsUtil.setColorForSelectedRow(projectGridPart);
			await edsUtil.setColorForSelectedRow(projectGridCost);

			document.getElementById('myTab').addEventListener('click', async (ev) =>{
				var id = ev.target.id;
				var tagName = ev.target.tagName;
				if(tagName === "A"){
					switch (id) {
						case "part-tab": setTimeout(async ()=>{await doAction('projectGridPart','search'); },200); break;
						case "cost-tab": setTimeout(async ()=>{await doAction('projectGridCost','search'); },200); break;
					}
				}
			});
		});

		class CustomTextEditor {
			constructor(props) {
				const el = document.createElement('textarea');
				el.value = String(props.value).replace(/<br\/>/g, '\n');
				this.el = el;
			}

			getValue() {
				return this.el.value.replace(/\n/g, '<br/>');
			}

			getElement() {
				return this.el;
			}
		}

		class detailButtonRenderer {
			constructor(props) {
				const el = document.createElement('button');
				const text = document.createTextNode('상세목록');

				el.appendChild(text);
				el.setAttribute("class","btn btn-sm btn-primary");
				el.setAttribute("style","width: 78%;" +
						"padding: 0.12rem 0.5rem;");

				el.addEventListener('click', async (ev) => {

					var row = projectGridList.getFocusedCell();
					var projCd = projectGridList.getValue(row.rowKey,'projCd');
					var deadDivi = projectGridList.getValue(row.rowKey,'deadDivi');
					if(projCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '프로젝트가 없습니다.',
						});
					}else{
						if (deadDivi !=='1'){
							await doAction('projectGridList','itemPopup');
						}
					}
				});

				this.el = el;
				this.render(props);
			}

			getElement() {
				return this.el;
			}

			render(props) {
				this.el.value = String(props.value);
			}
		}

		/* 초기설정 */
		async function init() {
			/* Form 셋팅 */
			edsUtil.setForm(document.querySelector("#searchForm"), "project");
			edsUtil.setForm(document.querySelector("#projectGridListForm"), "project");

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
			await edsUtil.setButtonForm(document.querySelector("#projectGridListButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridPartButtonForm"));
			await edsUtil.setButtonForm(document.querySelector("#projectGridCostButtonForm"));

			/*********************************************************************
			 * Grid Info 영역 START
			 ***********************************************************************/

			/* 그리드 초기화 속성 설정 */
			projectGridList = new tui.Grid({
				el: document.getElementById('projectGridListDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight: 'auto',
				minRowHeight:40,
				rowHeaders: [/*'rowNum', */'checkbox'],
				header: {
					height: 56,
					minRowHeight: 56,
					complexColumns: [
						{
							header: '견적가',
							name: 'amt2',
							childNames: ['supAmt2','vatAmt2','totAmt2']
						},
						{
							header: '계약금액',
							name: 'amt3',
							childNames: ['supAmt3','vatAmt3','totAmt3']
						},
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

			projectGridList.setColumns([
				{ header:'완료코드',		name:'projCompCd',	width:100,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'성공',			name:'sccDivi',		width:40,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM026")}},	formatter: 'listItemText',	filter: { type: 'text'}},
				{ header:'구분',			name:'projDivi',	width:40,		align:'center',	defaultValue: '',	editor:{type:'select',options: {listItems:setCommCode("COM029")}},	formatter: 'listItemText',	filter: { type: 'text'}},
				{ header:'계약일자',		name:'cntDt',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'납기일자',		name:'dueDt',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'종료일자',		name:'endDt',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'프로젝트명',	name:'projNm',		width:140,		align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'거래처',		name:'custNm',		width:140,		align:'left',	defaultValue: '',	filter: { type: 'text'}},
				{ header:'공급가액',		name:'supAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	filter: { type: 'text'}},
				{ header:'부가세액',		name:'vatAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	filter: { type: 'text'}},
				{ header:'합계금액',		name:'totAmt3',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	filter: { type: 'text'}},
				{ header:'분류',			name:'clas',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'품목',			name:'item',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'결제조건',		name:'payTm',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'상세등록',		name:'detail',		width:80,		align:'center', renderer: {type: detailButtonRenderer}},
				{ header:'개요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'계약특기사항',	name:'note1',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'결재자보고내용',name:'note2',		minWidth:150,	align:'left',	defaultValue: '',	editor: {type: CustomTextEditor}},
				{ header:'부서',			name:'depaNm',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'담당자',		name:'manNm',		width:50,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'입력자',		name:'inpNm',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'수정자',		name:'updNm',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적일자',		name:'estDt',		width:80,		align:'center',	hidden:true },
				{ header:'유효기간',		name:'validDt',		width:80,		align:'center',	hidden:true },
				{ header:'마감',			name:'deadDivi',	width:55,		align:'center', hidden:true, defaultValue: '',formatter: function (value){if(value.value == 1){return 'Y'}else{return 'N'}}},
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
				{ header:'담당자코드',	name:'manCd',		width:100,		align:'center',	hidden:true },
				{ header:'공급가액',		name:'supAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'부가세액',		name:'vatAmt2',		width:100,		align:'right',	hidden:true },
				{ header:'합계금액',		name:'totAmt2',		width:100,		align:'right',	hidden:true },
			]);

			projectGridPart = new tui.Grid({
				el: document.getElementById('projectGridPartDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: [/*'rowNum',*/ 'checkbox'],
				header: {
					Height: 40,
					minRowHeight: 40,
				},
				columns:[],
				columnOptions: {
					resizable: true,
					/*frozenCount: 1,
					frozenBorderWidth: 2,*/ // 컬럼 고정 옵션
				},
			});

			projectGridPart.setColumns([
				{ header:'참여자코드',	name:'partCd',		width:80,	align:'center',		defaultValue: '', 	filter: { type: 'text'}},
				{ header:'참여자명',		name:'partNm',		width:80,	align:'center',		defaultValue: '', 	filter: { type: 'text'}},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',		defaultValue: '', 	filter: { type: 'text'}},
				{ header:'입력자',		name:'inpNm',		width:80,	align:'center',		defaultValue: '', 	filter: { type: 'text'}},
				{ header:'수정자',		name:'updNm',		width:80,	align:'center',		defaultValue: '', 	filter: { type: 'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,	align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,	align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,	align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,	align:'center',	hidden:true },
				{ header:'완료코드',		name:'projCompCd',	width:100,	align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,	align:'center',	hidden:true },
			]);

			projectGridCost = new tui.Grid({
				el: document.getElementById('projectGridCostDIV'),
				scrollX: true,
				scrollY: true,
				editingEvent: 'click',
				bodyHeight: 'fitToParent',
				rowHeight:40,
				minRowHeight:40,
				rowHeaders: ['rowNum', 'checkbox'],
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
				summary: {
					height: 35,
					position: 'bottom', // or 'top'
					align:'left',
					columnContent: {
						supAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						vatAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
						totAmt: { template: function(valueMap) { return edsUtil.addComma(valueMap.filtered.sum);}},
					}
				}
			});

			projectGridCost.setColumns([
				{ header:'일자',			name:'costDt',		width:80,		align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'지출유형',		name:'expeDivi',	width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'부서명',		name:'depaNm',		width:80,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'계정과목명',	name:'accountNm',	width:140,		align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'거래처명',		name:'custNm',		width:140,		align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'적요',			name:'note',		minWidth:150,	align:'left',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'공급가액',		name:'supAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	filter: { type: 'text'}},
				{ header:'부가세액',		name:'vatAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	filter: { type: 'text'}},
				{ header:'합계금액',		name:'totAmt',		width:100,		align:'right',	defaultValue: '',	formatter: function (value){return edsUtil.addComma(value.value);}, 	filter: { type: 'text'}},
				{ header:'입력자',		name:'inpNm',		width:60,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},
				{ header:'수정자',		name:'updNm',		width:60,		align:'center',	defaultValue: '', 	filter: { type: 'text'}},

				// hidden(숨김)
				{ header:'회사코드',		name:'corpCd',		width:100,		align:'center',	hidden:true },
				{ header:'사업장코드',	name:'busiCd',		width:100,		align:'center',	hidden:true },
				{ header:'견적코드',		name:'estCd',		width:100,		align:'center',	hidden:true },
				{ header:'프로젝트코드',	name:'projCd',		width:100,		align:'center',	hidden:true },
				{ header:'완료코드',		name:'projCompCd',	width:100,		align:'center',	hidden:true },
				{ header:'순번',			name:'seq',			width:100,		align:'center',	hidden:true },
				{ header:'카드/계좌',	name:'credCd',		width:150,		align:'left',	hidden:true },
				{ header:'계정과목코드',	name:'accountCd',	width:100,		align:'center',	hidden:true },
				{ header:'거래처코드',	name:'custCd',		width:100,		align:'center',	hidden:true },
				{ header:'부서코드',		name:'depaCd',		width:100,		align:'center',	hidden:true },
			]);

			/**********************************************************************
			 * Grid Info 영역 END
			 ***********************************************************************/

			/**********************************************************************
			 * Grid 이벤트 영역 START
			 ***********************************************************************/

			/* 컬럼 비활성화 */
			projectGridList.disableColumn('note');
			projectGridList.disableColumn('note1');
			projectGridList.disableColumn('note2');

			/*필터 이후 포커스*/
			projectGridList.on('afterFilter', async ev => {
				if(ev.instance.store.data.filteredIndex.length>0){
					projectGridList.focusAt(0,0,true)
				}
			});

			projectGridList.on('focusChange', async ev => {
				if(ev.rowKey !== ev.prevRowKey){
					if (edsUtil.getAuth("Save") === "1") {// 수정권한 체크
						if (projectGridList.getValue(ev.rowKey, "deadDivi") === '1') {
							document.getElementById('btnSave').disabled = true;
							document.getElementById('btnDelete').disabled = true;
						} else {
							document.getElementById('btnSave').disabled = false;
							document.getElementById('btnDelete').disabled = false;
						}

						// 메인 시트 마감 처리 : 다른 시트 rawData값 못불러와서 서브 시트는 따로 처리
						await edsUtil.setClosedRow(projectGridList)
					}
					await fn_CopyProjectGridList2Form();
				}
			});

			projectGridList.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='custNm') await popupHandler('cust_list','open');
					else if(colNm==='manNm') await popupHandler('user_manNm','open');
					else if(colNm==='depaNm') await popupHandler('depa','open');
					else if(colNm==='note' || colNm==='note1' || colNm==='note2') {
						await edsUtil.sheetData2Maldal(projectGridList);
					}
				}else{
					// projectGridList.finishEditing();
				}
			});

			projectGridList.on('editingFinish', ev => {

				var columnName = ev.columnName;
				var rowKey = ev.rowKey;

				/**
				 * 견적일자, 유효기간 날짜 계산
				 * */
				if(columnName === 'cntDt'){
					const validDt = new Date(projectGridList.getValue(rowKey,'cntDt'));
					validDt.setMonth(validDt.getMonth() + 1);
					projectGridList.setValue(rowKey,'validDt',validDt.toISOString().substring(0,10))
				}else if(columnName === 'validDt'){
					const estDt = new Date(projectGridList.getValue(rowKey,'validDt'));
					estDt.setMonth(estDt.getMonth() - 1);
					projectGridList.setValue(rowKey,'cntDt',estDt.toISOString().substring(0,10))
				}

				/**
				 * 매입가, 견적가 계산
				 * */
				var supAmt2 = projectGridList.getValue(rowKey, 'supAmt2');
				var vatAmt2 = projectGridList.getValue(rowKey, 'vatAmt2');
				var totAmt2 = projectGridList.getValue(rowKey, 'totAmt2');
				var supAmt2All = 0;
				var vatAmt2All = 0;
				var totAmt2All = 0;

				var supAmt3 = projectGridList.getValue(rowKey, 'supAmt3');
				var vatAmt3 = projectGridList.getValue(rowKey, 'vatAmt3');
				var totAmt3 = projectGridList.getValue(rowKey, 'totAmt3');
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
				projectGridList.setValue(rowKey, "supAmt2", supAmt2);
				projectGridList.setValue(rowKey, "vatAmt2", vatAmt2);
				projectGridList.setValue(rowKey, "totAmt2", supAmt2 + vatAmt2);

				/* 견적가 */
				supAmt3 = Math.ceil(supAmt3);  // 올림
				vatAmt3 = Math.floor(vatAmt3); // 내림
				totAmt3 = supAmt3 + vatAmt3; // 합계
				projectGridList.setValue(rowKey, "supAmt3", supAmt3);
				projectGridList.setValue(rowKey, "vatAmt3", vatAmt3);
				projectGridList.setValue(rowKey, "totAmt3", supAmt3 + vatAmt3);

				/* 매입가+견적가+계약금액 합계 적용 */
				var data = projectGridList.getFilteredData()
				var dataLen = data.length;
				for (let i = 0; i < dataLen; i++) {
					supAmt2All += Number(data[i].supAmt2);
					vatAmt2All += Number(data[i].vatAmt2);
					totAmt2All += Number(data[i].totAmt2);
					supAmt3All += Number(data[i].supAmt3);
					vatAmt3All += Number(data[i].vatAmt3);
					totAmt3All += Number(data[i].totAmt3);
				}
				projectGridList.setSummaryColumnContent('supAmt2',edsUtil.addComma(supAmt2All));
				projectGridList.setSummaryColumnContent('vatAmt2',edsUtil.addComma(vatAmt2All));
				projectGridList.setSummaryColumnContent('totAmt2',edsUtil.addComma(totAmt2All));

				projectGridList.setSummaryColumnContent('supAmt3',edsUtil.addComma(supAmt3All));
				projectGridList.setSummaryColumnContent('vatAmt3',edsUtil.addComma(vatAmt3All));
				projectGridList.setSummaryColumnContent('totAmt3',edsUtil.addComma(totAmt3All));
			});

			projectGridPart.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm ==='partNm') await popupHandler('user_partNm','open');
				}else{
					projectGridPart.finishEditing();
				}
			});

			projectGridCost.on('click', async ev => {
				var colNm = ev.columnName;
				var target = ev.targetType;
				if(target === 'cell'){
					if(colNm==='custNm') await popupHandler('cust_cost','open');
					else if(colNm==='depaNm') await popupHandler('depa_cost','open');
					else if(colNm==='accountNm') await popupHandler('account','open');
				}else{
					projectGridCost.finishEditing();
				}
			});

			projectGridCost.on('editingFinish', ev => {

				var columnName = ev.columnName;
				var rowKey = ev.rowKey;

				var supAmt = projectGridCost.getValue(rowKey, 'supAmt');
				var vatAmt = projectGridCost.getValue(rowKey, 'vatAmt');
				var totAmt = projectGridCost.getValue(rowKey, 'totAmt');
				var supAmtAll = 0;
				var vatAmtAll = 0;
				var totAmtAll = 0;

				// 별도, 포함
				switch (columnName) {
					case 'supAmt' :
						/* 매입가 */
						vatAmt = supAmt/10; // TAX
						totAmt = supAmt/1.1; // 공급가액
						break;
					case 'totAmt' :
						/* 매입가 */
						supAmt = totAmt/11*10; // 공급가액
						vatAmt = totAmt/11; // TAX
						break;
				}

				/**
				 * 권유리 과장님: 공급가액 및 부가세액 반올림처리원함
				 * */

				/* 매입가 */
				supAmt = Math.ceil(supAmt);  // 올림
				vatAmt = Math.floor(vatAmt); // 내림
				totAmt = supAmt + vatAmt; // 합계
				projectGridCost.setValue(rowKey, "supAmt", supAmt);
				projectGridCost.setValue(rowKey, "vatAmt", vatAmt);
				projectGridCost.setValue(rowKey, "totAmt", supAmt + vatAmt);

				/* 매입가+견적가+계약금액 합계 적용 */
				var data = projectGridCost.getFilteredData()
				var dataLen = data.length;
				for (let i = 0; i < dataLen; i++) {
					supAmtAll += Number(data[i].supAmt);
					vatAmtAll += Number(data[i].vatAmt);
					totAmtAll += Number(data[i].totAmt);
				}
				projectGridCost.setSummaryColumnContent('supAmt',edsUtil.addComma(supAmtAll));
				projectGridCost.setSummaryColumnContent('vatAmt',edsUtil.addComma(vatAmtAll));
				projectGridCost.setSummaryColumnContent('totAmt',edsUtil.addComma(totAmtAll));
			});

			/**********************************************************************
			 * Grid 이벤트 영역 END
			 ***********************************************************************/

			/* 그리드생성 */
			document.getElementById('projectGridList').style.height = (innerHeight)*(1-0.11) + 'px';
			document.getElementById('projectGridPart').style.height = (innerHeight)*(1-0.6) + 'px';
			document.getElementById('projectGridCost').style.height = (innerHeight)*(1-0.6) + 'px';
			doAction('projectGridList', 'search');
		}

		/**********************************************************************
		 * 화면 이벤트 영역 START
		 ***********************************************************************/

		/* 화면 이벤트 */
		async function doAction(sheetNm, sAction) {
			if (sheetNm == 'projectGridList') {
				switch (sAction) {
					case "search":// 조회

						projectGridList.finishEditing(); // 데이터 초기화
						projectGridList.clear(); // 데이터 초기화
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						projectGridList.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjCompMgtList", param)); // 데이터 set

						// if(projectGridList.getRowCount() > 0 ){
						// 	projectGridList.focusAt(0, 0, true);
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
						appendedData.cntDt = edsUtil.getToday("%Y-%m-%d");
						appendedData.projDt = edsUtil.getToday("%Y-%m-%d");

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

						projectGridList.prependRow(appendedData, { focus:true }); // 마지막 ROW 추가

						await doAction('projectGridList', 'save');

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCompMgtList", "projectGridList", projectGridList);
						break;
					case "delete"://삭제
						await projectGridList.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCompMgtList", "projectGridList", projectGridList);
						break;
					case "finish"://마감
						await edsUtil.doDeadline(
								"/PROJECT_MGT/deadLineProjMgtList",
								"projectGridList",
								projectGridList,
								'1');
						break;
					case "cancel"://마감취소
						await edsUtil.doDeadline(
								"/PROJECT_MGT/deadLineProjMgtList",
								"projectGridList",
								projectGridList,
								'0');
						break;
					case "itemPopup":// 파일업로드 팝업 보기

						console.log(123)
						var row = projectGridList.getFocusedCell();
						var projCompCd = projectGridList.getValue(row.rowKey,'projCompCd');
						if(projCompCd == null){
							return Swal.fire({
								icon: 'error',
								title: '실패',
								text: '프로젝트가 없습니다.',
							});
						}else{
							document.getElementById('btnItemPopEv').click();
							document.getElementById('cost-tab').click();
							setTimeout(ev=>{
								document.getElementById('btnSearch6').click();
							}, 300)
						}
						break;
				}
			}else if (sheetNm == 'projectGridPart') {
				switch (sAction) {
					case "search":// 조회

						projectGridPart.refreshLayout(); // 데이터 초기화
						projectGridPart.finishEditing(); // 데이터 마감
						projectGridPart.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						param.projCompCd = projectGridList.getValue(row.rowKey, 'projCompCd');
						projectGridPart.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjCompPartList", param)); // 데이터 set

						if(projectGridPart.getRowCount() > 0 ){
							projectGridPart.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');
						appendedData.projCompCd = projectGridList.getValue(row.rowKey,'projCompCd');

						projectGridPart.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCompPartList", "projectGridPart", projectGridPart);
						break;
					case "delete"://삭제
						await projectGridPart.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCompPartList", "projectGridPart", projectGridPart);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
						break;
				}
			}else if (sheetNm == 'projectGridCost') {
				switch (sAction) {
					case "search":// 조회

						projectGridCost.refreshLayout(); // 데이터 초기화
						projectGridCost.finishEditing(); // 데이터 마감
						projectGridCost.clear(); // 데이터 초기화

						var row = projectGridList.getFocusedCell();
						var param = ut.serializeObject(document.querySelector("#searchForm")); //조회조건
						param.estCd = projectGridList.getValue(row.rowKey, 'estCd');
						param.projCd = projectGridList.getValue(row.rowKey, 'projCd');
						param.projCompCd = projectGridList.getValue(row.rowKey, 'projCompCd');
						projectGridCost.resetData(edsUtil.getAjax("/PROJECT_MGT/selectProjCompCostList", param)); // 데이터 set

						if(projectGridCost.getRowCount() > 0 ){
							projectGridCost.focusAt(0, 0, true);
						}
						break;
					case "input":// 신규

						var row = projectGridList.getFocusedCell();

						var appendedData = {};
						appendedData.status = "I";
						appendedData.corpCd = projectGridList.getValue(row.rowKey,'corpCd');
						appendedData.busiCd = projectGridList.getValue(row.rowKey,'busiCd');
						appendedData.estCd = projectGridList.getValue(row.rowKey,'estCd');
						appendedData.projCd = projectGridList.getValue(row.rowKey,'projCd');
						appendedData.projCompCd = projectGridList.getValue(row.rowKey,'projCompCd');
						appendedData.costDt =  edsUtil.getToday("%Y-%m-%d");
						appendedData.expeDivi = '01';
						appendedData.supAmt = 0;
						appendedData.vatAmt = 0;
						appendedData.totAmt = 0;

						projectGridCost.appendRow(appendedData, { focus:true }); // 마지막 ROW 추가

						break;
					case "save"://저장
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCompCostList", "projectGridCost", projectGridCost);
						break;
					case "delete"://삭제
						await projectGridCost.removeCheckedRows(true);
						await edsUtil.doCUD("/PROJECT_MGT/cudProjCompCostList", "projectGridCost", projectGridCost);
						break;
					case "close"://삭제
						await doAction('projectGridList','search');
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
			var row = projectGridList.getFocusedCell();
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
						param.custNm= projectGridList.getValue(row.rowKey, 'custNm');
						param.name= name;
						await edsIframe.openPopup('CUSTPOPUP',param)
					}else{
						var sheet, col, row;
						if(names[1] === 'list') {sheet=projectGridList;col='cust';row=projectGridList.getFocusedCell();}
						else if(names[1] === 'cost'){sheet=projectGridCost;col='cust';row=projectGridCost.getFocusedCell();}
						sheet.setValue(row.rowKey,col+'Cd',callback.custCd);
						sheet.setValue(row.rowKey,col+'Nm',callback.custNm);
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

						projectGridList.setValue(row.rowKey,'projCd',callback.rows[0].projCd);
						projectGridList.setValue(row.rowKey,'projNm',callback.rows[0].projNm);
					}
					break;
				case 'depa':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.busiCd= '<c:out value="${LoginInfo.busiCd}"/>';
						param.depaNm= '';
						param.name= name;
						await edsIframe.openPopup('DEPAPOPUP',param)
					}else{
						var sheet, col, row;
						if(names[1] === 'list') {sheet=projectGridList;col='cust';row=projectGridList.getFocusedCell();}
						else if(names[1] === 'cost'){sheet=projectGridCost;col='cust';row=projectGridCost.getFocusedCell();}
						sheet.setValue(row.rowKey,'depaCd',callback.depaCd);
						sheet.setValue(row.rowKey,'depaNm',callback.depaNm);
					}
					break;
				case 'account':
					if(divi==='open'){
						var param={}
						param.corpCd= '<c:out value="${LoginInfo.corpCd}"/>';
						param.name= name;
						await edsIframe.openPopup('ACCOUNTPOPUP',param)
					}else{
						var row = projectGridCost.getFocusedCell();
						projectGridCost.setValue(row.rowKey,'accountCd',callback.accountCd);
						projectGridCost.setValue(row.rowKey,'accountNm',callback.accountNm);
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
						if(names[1] === 'manNm') {sheet=projectGridList;col='man';row=projectGridList.getFocusedCell();}
						else if(names[1] === 'partNm'){sheet=projectGridPart;col='part';row=projectGridPart.getFocusedCell();}
						sheet.setValue(row.rowKey,col+'Cd',callback.empCd);
						sheet.setValue(row.rowKey,col+'Nm',callback.empNm);
					}
					break;
				case "itemPopup":// 파일업로드 팝업 보기

					console.log(123)
					var row = projectGridList.getFocusedCell();
					var projCompCd = projectGridList.getValue(row.rowKey,'projCompCd');
					if(projCompCd == null){
						return Swal.fire({
							icon: 'error',
							title: '실패',
							text: '프로젝트가 없습니다.',
						});
					}else{
						document.getElementById('btnItemPopEv').click();
						document.getElementById('cost-tab').click();
						setTimeout(ev=>{
							document.getElementById('btnSearch6').click();
						}, 300)
					}
					break;
				case 'partPopup':
					if(divi==='open'){
						document.getElementById('btnPartPopup').click();
						setTimeout(async ev =>{
							await doAction('projectGridPart','search')
						},200)
					}else{

					}
					break;
			}
		}

		// 업로드 안된 행의 다운로드 막기
		function preventClick(e){
			e.preventDefault()
			toastrmessage("toast-bottom-center"
					, "warning"
					, "파일 저장 이후 다운로드 가능합니다.", "실패", 1500);
		}

		async function fn_CopyProjectGridList2Form(){
			var rows = projectGridList.getRowCount();
			if(rows > 0){
				var row = projectGridList.getFocusedCell();
				var param = {
					sheet: projectGridList,
					form: document.projectGridListForm,
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
							<span class="input-group-btn"><button type="button" class="btn btn-block btn-default btn-flat" name="btnBusiCd" id="btnBusiCd" onclick="popupHandler('busi','open'); return false;"><i class="fa fa-search"></i></button></span>
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
						<div class="form-group" style="margin-left: 50px"></div>
						<div class="form-group">
							<label for="projNm">프로젝트 &nbsp;</label>
							<input type="text" class="form-control" name="projNm" id="projNm" title="프로젝트명">
							<div class="form-group-append">
								<span class="input-group-btn"><button type="button" class="btn btn-block btn-primary btn-flat" name="btnProjCd" id="btnProjCd" onclick="doAction('projectGridList','search'); return false;">검색</button></span>
							</div>
						</div>
					</form>
					<!-- ./form -->
				</div>
			</div>
		</div>
		<!-- 그리드 영역 -->
		<div class="row">
			<div class="col-md-12" style="height: 100%;" id="projectGridList">
				<!-- 시트가 될 DIV 객체 -->
				<div id="projectGridListDIV" style="width:100%; height:100%;"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
				<div class="col text-center">
					<form class="form-inline" role="form" name="projectGridListButtonForm" id="projectGridListButtonForm" method="post" onsubmit="return false;">
						<div class="container">
							<div class="row">
								<div class="col text-center">
									<button type="button" class="btn btn-sm btn-primary" name="btnFinish"			id="btnFinish"				onclick="doAction('projectGridList', 'finish')"><i class="fa fa-lock"></i> 마감</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnCancel"			id="btnCancel"				onclick="doAction('projectGridList', 'cancel')"><i class="fa fa-unlock"></i> 마감취소</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSearch"			id="btnSearch"				onclick="doAction('projectGridList', 'search')"><i class="fa fa-search"></i> 조회</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnInput"			id="btnInput"				onclick="doAction('projectGridList', 'input')" ><i class="fa fa-plus"></i> 신규</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnSave"				id="btnSave"				onclick="doAction('projectGridList', 'save')"><i class="fa fa-save"></i> 저장</button>
									<button type="button" class="btn btn-sm btn-primary" name="btnDelete"			id="btnDelete"				onclick="doAction('projectGridList', 'delete')"><i class="fa fa-trash"></i> 삭제</button>

									<button type="button" class="btn btn-sm btn-primary" name="btnItemPopEv"		id="btnItemPopEv"			data-toggle="modal" data-target="#modalCart"  style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnEmailPopEv"		id="btnEmailPopEv"			data-toggle="modal" data-target="#modalCart3" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnPartPopEv"		id="btnPartPopEv"			data-toggle="modal" data-target="#modalCart4" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnFileUploadPopEv"	id="btnFileUploadPopEv"		data-toggle="modal" data-target="#modalCart5" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnCostPopEv"		id="btnCostPopEv"			data-toggle="modal" data-target="#modalCart6" style="display: none"></button>
									<button type="button" class="btn btn-sm btn-primary" name="btnMemoPopEv"		id="btnMemoPopEv"			data-toggle="modal" data-target="#modalCart7" style="display: none"></button>
								</div>
							</div>
						</div>
					</form>
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
				<h4 class="modal-title">상세 목록</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="col-md-12" style="height: 100%;">
					<form name="projectGridListForm" id="projectGridListForm">
						<div class="form-row">
							<div class="col-md-2 mb-3">
								<label for="sccDivi"><b>성공/구분</b></label>
								<div class="form-row">
									<select type="text" class="form-control text-center" style="width: 50%" name="sccDivi" id="sccDivi" title="성공" disabled></select>
									<select type="text" class="form-control text-center" style="width: 50%" name="projDivi" id="projDivi" title="구분" disabled></select>
								</div>
							</div>
							<div class="col-md-2 mb-3">
								<label for="cntDt"><b>계약일자</b></label>
								<input type="text" class="form-control text-center" id="cntDt" name="cntDt" placeholder="계약일자" value="계약일자" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="dueDt"><b>납기일자</b></label>
								<input type="text" class="form-control text-center" id="dueDt" name="dueDt" placeholder="납기일자" value="납기일자" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="endDt"><b>종료일자</b></label>
								<input type="text" class="form-control text-center" id="endDt" name="endDt" placeholder="종료일자" value="종료일자" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="depaNm"><b>부서</b></label>
								<input type="text" class="form-control text-center" id="depaNm" name="depaNm" placeholder="부서" value="부서" readonly="readonly">
							</div>
							<div class="col-md-2 mb-3">
								<label for="manNm"><b>담당자</b></label>
								<input type="text" class="form-control text-center" id="manNm" name="manNm" placeholder="담당자" value="담당자" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-6 mb-3">
								<label for="projNm"><b>프로젝트</b></label>
								<input type="text" class="form-control" id="projNm" name="projNm" placeholder="프로젝트" value="프로젝트" readonly="readonly">
							</div>
							<div class="col-md-6 mb-3">
								<label for="custNm"><b>거래처</b></label>
								<input type="text" class="form-control" id="custNm" name="custNm" placeholder="거래처" value="거래처" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-4 mb-3">
								<label for="supAmt3"><b>공급가액</b></label>
								<input type="text" class="form-control text-right" id="supAmt3" name="supAmt3" placeholder="공급가액" value="공급가액" readonly="readonly">
							</div>
							<div class="col-md-4 mb-3">
								<label for="vatAmt3"><b>부가세액</b></label>
								<input type="text" class="form-control text-right" id="vatAmt3" name="vatAmt3" placeholder="부가세액" value="부가세액" readonly="readonly">
							</div>
							<div class="col-md-4 mb-3">
								<label for="totAmt3"><b>합계금액</b></label>
								<input type="text" class="form-control text-right" id="totAmt3" name="totAmt3" placeholder="합계금액" value="합계금액" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-4 mb-3">
								<label for="clas"><b>분류</b></label>
								<input type="text" class="form-control" id="clas" name="clas" placeholder="분류" value="Mark" readonly="readonly">
							</div>
							<div class="col-md-4 mb-3">
								<label for="item"><b>품목</b></label>
								<input type="text" class="form-control" id="item" name="item" placeholder="품목" value="Mark" readonly="readonly">
							</div>
							<div class="col-md-4 mb-3">
								<label for="payTm"><b>결제조건</b></label>
								<input type="text" class="form-control" id="payTm" name="payTm" placeholder="결제조건" value="Mark" readonly="readonly">
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-12 mb-3">
								<label for="note"><b>개요</b></label>
								<textarea type="text" class="form-control" id="note" name="note" placeholder="개요" value="Mark" readonly="readonly"></textarea>
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-12 mb-3">
								<label for="note1"><b>계약특기사항</b></label>
								<textarea type="text" class="form-control" id="note1" name="note1" placeholder="계약특기사항" value="Mark" readonly="readonly"></textarea>
							</div>
						</div>
						<div class="form-row">
							<div class="col-md-12 mb-3">
								<label for="note2"><b>결재자보고내용</b></label>
								<textarea type="text" class="form-control" id="note2" name="note2" placeholder="결재자보고내용" value="Mark" readonly="readonly"></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="tab-content" id="myTabContent">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item">
						<a class="nav-link" id="part-tab" data-toggle="tab" href="#part" role="tab" aria-controls="part" aria-selected="false">참여자</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="cost-tab" data-toggle="tab" href="#cost" role="tab" aria-controls="cost" aria-selected="false">원가</a>
					</li>
				</ul>
				<div class="tab-pane fade" id="part" role="tabpanel" aria-labelledby="part-tab">
					<!--Body-->
					<div class="modal-body">
						<div class="col-md-12" style="height: 100%;" id="projectGridPart">
							<!-- 시트가 될 DIV 객체 -->
							<div id="projectGridPartDIV" style="width:100%; height:100%;"></div>
						</div>
					</div>
					<!--Footer-->
					<div class="modal-footer" style="display: block">
						<div class="row">
							<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
								<div class="col text-center">
									<form class="form-inline" role="form" name="projectGridPartButtonForm" id="projectGridPartButtonForm" method="post" onsubmit="return false;">
										<div class="container">
											<div class="row">
												<div class="col text-center">
													<button type="button" class="btn btn-sm btn-primary" name="btnSearch4"	id="btnSearch4"	onclick="doAction('projectGridPart', 'search')"><i class="fa fa-search"></i> 조회</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnInput4"	id="btnInput4"	onclick="doAction('projectGridPart', 'input')" ><i class="fa fa-plus"></i> 신규</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnSave4"	id="btnSave4"	onclick="doAction('projectGridPart', 'save')"><i class="fa fa-save"></i> 저장</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnDelete4"	id="btnDelete4"	onclick="doAction('projectGridPart', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnClose4"	id="btnClose4"	onclick="doAction('projectGridPart', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="cost" role="tabpanel" aria-labelledby="cost-tab">
					<!--Body-->
					<div class="modal-body">
						<div class="col-md-12" style="height: 100%;" id="projectGridCost">
							<!-- 시트가 될 DIV 객체 -->
							<div id="projectGridCostDIV" style="width:100%; height:100%;"></div>
						</div>
					</div>
					<!--Footer-->
					<div class="modal-footer" style="display: block">
						<div class="row">
							<div class="col-md-12" style="padding: 5px 15px 0 15px; background-color: #ebe9e4">
								<div class="col text-center">
									<form class="form-inline" role="form" name="projectGridCostButtonForm" id="projectGridCostButtonForm" method="post" onsubmit="return false;">
										<div class="container">
											<div class="row">
												<div class="col text-center">
													<button type="button" class="btn btn-sm btn-primary" name="btnSearch6"	id="btnSearch6"	onclick="doAction('projectGridCost', 'search')"><i class="fa fa-search"></i> 조회</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnInput6"	id="btnInput6"	onclick="doAction('projectGridCost', 'input')" ><i class="fa fa-plus"></i> 신규</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnSave6"	id="btnSave6"	onclick="doAction('projectGridCost', 'save')"><i class="fa fa-save"></i> 저장</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnDelete6"	id="btnDelete6"	onclick="doAction('projectGridCost', 'delete')"><i class="fa fa-trash"></i> 삭제</button>
													<button type="button" class="btn btn-sm btn-primary" name="btnClose6"	id="btnClose6"	onclick="doAction('projectGridCost', 'close')" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i> 닫기</button>
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
</div>
</body>
<%@ include file="/WEB-INF/views/comm/common-include-grid.jspf"%><%-- tui grid --%>
</html>